--[[
Two Components:
	- Healer List
	- Who's Casting a Heal on My Target?

Graphics?
	"Interface\\LFGFrame\\UI-LFG-ICON-ROLES"
	TexCoord		.25,.5,0,.25
--]]

local HealerClasses = {
	DRUID = true,
	PRIEST = true,
	SHAMAN = true,
	PALADIN = true,
	Druid = true,
	Priest = true,
	Paladin = true,
	Shaman = true
}
local function IsHealerClass(guid)
	local _, engClass, _, _, _ = GetPlayerInfoByGUID(guid)
	if engClass then
		return HealerClasses[engClass]
	end
end

--[[
-- Not sure if this is important, but I started a list
local HealingSpells = {}
HealingSpells["Flash Heal"] = true
HealingSpells["Heal"] = true
HealingSpells["Greater Heal"] = true
HealingSpells["Regrowth"] = true
HealingSpells["Nourish"] = true
HealingSpells["Healing Touch"] = true
HealingSpells["Flash of Light"] = true
HealingSpells["Holy Light"] = true
HealingSpells["Lesser Healing Wave"] = true
HealingSpells["Healing Wave"] = true
HealingSpells["Greater Healing Wave"] = true
HealingSpells["Power Word: Shield"] = true
HealingSpells["Power Word: Barrier"] = true
HealingSpells["Sacred Shield"] = true
HealingSpells["Earth Shield"] = true
HealingSpells["Chain Heal"] = true
HealingSpells["Healing Rain"] = true
HealingSpells["Prayer of Mending"] = true
HealingSpells["Circle of Healing"] = true
HealingSpells["Holy Nova"] = true
HealingSpells["Prayer of Healing"] = true
HealingSpells["Healing Hands"] = true
HealingSpells["Wild Growth"] = true
HealingSpells["Renew"] = true
HealingSpells["Rejuvenation"] = true
HealingSpells["Lifebloom"] = true
HealingSpells["Holy Shock"] = true
HealingSpells["Riptide"] = true
HealingSpells["Beacon of Light"] = true
--]]
local function IsHostile(sourceFlags)
	if sourceFlags then
		return (bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0)
	end
end

local function IsHealingSpellEvent(event, spellName, ...)
	if event and ((event == "SPELL_HEAL") or (event == "SPELL_PERIODIC_HEAL")) then
		return true
	end
end

-- Healer List
local EnemyHealerList = {}

local PlayerFactionIndex
if UnitFactionGroup("player") == "Alliance" then
	PlayerFactionIndex = 1
else
	PlayerFactionIndex = 0
end

local function UPDATE_BATTLEFIELD_SCORE()
	local HealerListIsUpdated = false
	for scoreIndex = 1, GetNumBattlefieldScores() do
		local unitName, _, _, _, _, unitFaction, _, _, classToken, damageDone, healingDone =
			GetBattlefieldScore(scoreIndex)

		if PlayerFactionIndex ~= unitFaction then
			if (healingDone > damageDone) and HealerClasses[classToken] then
				-- Add Healer
				if not EnemyHealerList[unitName] then
					HealerListIsUpdated = true
					EnemyHealerList[unitName] = true
				end
			else
				-- Remove Healer
				if EnemyHealerList[unitName] then
					HealerListIsUpdated = true
					EnemyHealerList[unitName] = nil
				end
			end
		end
		-- End For/Do Loop
	end
	if HealerListIsUpdated then
		TidyPlates:Update()
	end
end

-- Who's Healing My Target?
local CurrentTargetHealers = {}

local function COMBAT_LOG_EVENT_UNFILTERED(frame, timestamp, combatEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, ...)
	local TargetName = tostring(UnitName("target"))
	local IsEnemy = not UnitIsFriend("player", "target")

	if IsEnemy and (destName == TargetName) and IsHealerClass(sourceGUID) and (sourceGUID ~= destGUID) then
		if IsHealingSpellEvent(combatEvent, spellName, ...) then
			CurrentTargetHealers[sourceName] = true
		end
	end
end

local function PLAYER_TARGET_CHANGED()
	wipe(CurrentTargetHealers)
end

local function PLAYER_REGEN_DISABLED()
	RequestBattlefieldScoreData()
end

local function PLAYER_REGEN_ENABLED()
	RequestBattlefieldScoreData()
end

local function PLAYER_ENTERING_WORLD()
	RequestBattlefieldScoreData()
end

-- Event Handler
local Events = {}
Events.COMBAT_LOG_EVENT_UNFILTERED = COMBAT_LOG_EVENT_UNFILTERED
Events.PLAYER_TARGET_CHANGED = PLAYER_TARGET_CHANGED
Events.UPDATE_BATTLEFIELD_SCORE = UPDATE_BATTLEFIELD_SCORE
Events.PLAYER_REGEN_ENABLED = PLAYER_REGEN_ENABLED
Events.PLAYER_REGEN_DISABLED = PLAYER_REGEN_DISABLED
Events.PLAYER_ENTERING_WORLD = PLAYER_ENTERING_WORLD

-- Watcher Frame
local WatcherFrame
local NextUpdate = 0
local UpdateInterval = 10

local function OnEvent(frame, event, ...)
	if Events[event] then
		Events[event](...)
	end
end

local function Enable()
	if not WatcherFrame then
		WatcherFrame = CreateFrame("Frame", nil, WorldFrame)
	end
	WatcherFrame:SetScript("OnEvent", OnEvent)
	for eventName in pairs(Events) do
		WatcherFrame:RegisterEvent(eventName)
	end
end

local function Disable()
	if WatcherFrame then
		WatcherFrame:SetScript("OnEvent", nil)
	end
end

TidyPlatesUtility.EnableHealerDetection = Enable
TidyPlatesUtility.DisableHealerDetection = Disable
TidyPlatesUtility.CurrentTargetHealers = CurrentTargetHealers
TidyPlatesUtility.EnemyHealerList = EnemyHealerList