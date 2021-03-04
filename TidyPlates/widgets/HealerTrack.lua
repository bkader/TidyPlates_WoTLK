local TidyPlates = _G.TidyPlates
local TidyPlatesUtility = _G.TidyPlatesUtility
--[[
	The Tidy Plates Healer Tracking system uses two concurrent methods:
		1. Direct query of the Battleground Scoreboard for Talent Specialization
		2. Active monitoring of the combat log for Healer-Only spells

		Q: Why do I use TWO methods?
			A: Querying the Battleground Scoreboard is the most accurate method,
		but it doesn't always work.  In addition, there are PvP encounters where
		you're not in a battleground.

--]]
local RoleList = {}
local HealerListByGUID = {}
local HealerListByName = {}

local function ParseName(identifier)
    local _, _, name, server = strfind(identifier, "([^-]+)-?(.*)")
    return name, server
end

--[[
Detection Method 1:
Direct query of the Battleground Scoreboard for Talent Specialization
--]]
-- Class talent specs
local ClassRoles = {
    ["Death Knight"] = {
        ["Blood"] = "Tank",
        ["Frost"] = "Melee",
        ["Unholy"] = "Melee"
    },
    ["Druid"] = {
        ["Balance"] = "Ranged",
        ["Guardian"] = "Tank",
        ["Feral Combat"] = "Melee",
        ["Feral"] = "Melee",
        ["Restoration"] = "Healer"
    },
    ["Hunter"] = {
        ["Beast Mastery"] = "Ranged",
        ["Marksmanship"] = "Ranged",
        ["Survival"] = "Ranged"
    },
    ["Mage"] = {
        ["Arcane"] = "Ranged",
        ["Fire"] = "Ranged",
        ["Frost"] = "Ranged"
    },
    ["Paladin"] = {
        ["Holy"] = "Healer",
        ["Protection"] = "Tank",
        ["Retribution"] = "Melee"
    },
    ["Priest"] = {
        ["Discipline"] = "Healer",
        ["Holy"] = "Healer",
        ["Shadow"] = "Ranged"
    },
    ["Rogue"] = {
        ["Assassination"] = "Melee",
        ["Combat"] = "Melee",
        ["Subtlety"] = "Melee"
    },
    ["Shaman"] = {
        ["Elemental"] = "Ranged",
        ["Enhancement"] = "Melee",
        ["Restoration"] = "Healer"
    },
    ["Warlock"] = {
        ["Affliction"] = "Ranged",
        ["Demonology"] = "Ranged",
        ["Destruction"] = "Ranged"
    },
    ["Warrior"] = {
        ["Arms"] = "Melee",
        ["Fury"] = "Melee",
        ["Protection"] = "Tank"
    }
}

local NextUpdate = 0
local function UpdateRolesViaScoreboard()
    local now = GetTime()

    if now > NextUpdate then
        NextUpdate = now + 3 -- Throttles update frequency to every 3 seconds.
    else
        return
    end

    --print("Scoreboard Update", now)

    local UpdateIsNeeded = false
    local NumScores = GetNumBattlefieldScores()

    -- SetBattlefieldScoreFaction(DisplayFaction) -- faction 0=Horde, 1=Alliance

    if NumScores > 0 then
        for i = 1, NumScores do
            local name, _, _, _, _, faction, _, class, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)
            if name and class and talentSpec then
                local Role = ClassRoles[class][talentSpec]

                if RoleList[name] ~= Role then
                    RoleList[name] = Role
                    --if Role == "Healer" then print(name, Role, faction) end
                    UpdateIsNeeded = true
                end
            end
        end
        if UpdateIsNeeded then
            TidyPlates:RequestDelegateUpdate()
        end
    end
end

local HealerSpells = {
    -- Priest
    ----------
    [10060] = "PRIEST", -- Power Infusion
    [14751] = "PRIEST", -- Inner Focus
    [33206] = "PRIEST", -- Pain Suppression
    [34861] = "PRIEST", -- Circle of Healing
    [47540] = "PRIEST", -- Penance
    [47788] = "PRIEST", -- Guardian Spirit
    [724] = "PRIEST", -- Lightwell
    -- Druid
    ---------
    [17116] = "DRUID", -- Nature's Swiftness
    [18562] = "DRUID", -- Swiftmend
    [33891] = "DRUID", -- Tree of Life
    [48438] = "DRUID", -- Wild Growth
    -- Shaman
    ---------
    [16188] = "SHAMAN", -- Nature's Swiftness
    [16190] = "SHAMAN", -- Mana Tide Totem
    [61295] = "SHAMAN", -- Riptide
    [974] = "SHAMAN", -- Earth Shield
    -- Paladin
    ----------
    [20473] = "PALADIN", -- Holy Shock
    [31821] = "PALADIN", -- Aura Mastery
    [31842] = "PALADIN", -- Divine Favor
    [53563] = "PALADIN", -- Beacon of Light
}

local SpellEvents = {
    ["SPELL_HEAL"] = true,
    ["SPELL_AURA_APPLIED"] = true,
    ["SPELL_CAST_START"] = true,
    ["SPELL_CAST_SUCCESS"] = true,
    ["SPELL_PERIODIC_HEAL"] = true
}

local function IsEnemyPlayer(flags)
    if (bit.band(flags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) and (bit.band(flags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) then
        return true
    end
end

local function WipeLists()
    RoleList = wipe(RoleList)
    HealerListByGUID = wipe(HealerListByGUID)
    HealerListByName = wipe(HealerListByName)
end

local Events = {}

function Events.PLAYER_ENTERING_WORLD()
    WipeLists()
    return
end

function Events.UPDATE_BATTLEFIELD_SCORE()
    UpdateRolesViaScoreboard()
    return
end

function Events.COMBAT_LOG_EVENT_UNFILTERED(...)
    -- Combat Log Unfiltered
    local timestamp, combatevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid = ...

    if IsEnemyPlayer(sourceFlags) and sourceGUID then -- Filter: Only Enemy Players
        if SpellEvents[combatevent] then -- Filter: Specific spell events
            if HealerSpells[spellid] then -- Filter: Known Healing Spells
                local rawName = strsplit("-", sourceName) -- Strip server name
                if RoleList[rawName] ~= "Healer" then
                    RoleList[rawName] = "Healer"
                    TidyPlates:RequestDelegateUpdate()
                end
            end
        end
    end
end

local function CombatEventHandler(frame, event, ...)
    local handler = Events[event]
    if handler then handler(...) end
end

local HealerTrackWatcher = CreateFrame("Frame")

local function Enable()
    HealerTrackWatcher:SetScript("OnEvent", CombatEventHandler)
    HealerTrackWatcher:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    HealerTrackWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
    HealerTrackWatcher:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
    WipeLists()
end

local function Disable()
    HealerTrackWatcher:SetScript("OnEvent", nil)
    HealerTrackWatcher:UnregisterAllEvents()
    WipeLists()
end

local HealerClasses = {
    ["DRUID"] = true,
    ["SHAMAN"] = true,
    ["PALADIN"] = true,
    ["PRIEST"] = true
}

local function IsHealer(name, class)
    if name then
        local Role = RoleList[name]
        if Role == nil then
        else
            return Role == "Healer"
        end
    end
end

TidyPlatesUtility.EnableHealerTrack = Enable
TidyPlatesUtility.DisableHealerTrack = Disable
TidyPlatesUtility.IsHealer = IsHealer