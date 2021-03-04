local TidyPlates = _G.TidyPlates
local TidyPlatesWidgets = _G.TidyPlatesWidgets

local function SpellCastWatcherEvents(self, event, unit, other)
    print("Spell Event", self, event, unit, other)
    if unit == "target" then
        TidyPlates:ForceUpdate()
    end
end

local SpellCastWatcher = CreateFrame("Frame")
SpellCastWatcher:RegisterEvent("UNIT_SPELLCAST_START")
SpellCastWatcher:RegisterEvent("UNIT_SPELLCAST_STOP")

local function UpdateCastWidget(self, unit)
    if unit.isTarget then
        local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo("target")
        if spell then
            self.Text:SetText(spell)
            self:Show()
        else
            self:Hide()
        end
    else
        self:Hide()
    end
end

---------------
-- Note Widget
---------------

local notefont = "FONTS\\arialn.ttf"
local art = "Interface\\Addons\\TidyPlates\\Widgets\\NoteWidget\\NoteBackground"

NoteWidgetNames = {
    -- Marrowgar
    [" Bone Spike"] = "|cFFFFC600Priority Kill",

    -- Deathwhisper
    ["Cult Adherent"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Physical Damage",
    ["Reanimated Adherent"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Physical Damage",
    ["Cult Fanatic"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Magic Damage",
    ["Reanimated Fanatic"] = "|cFFFFC600Priority Kill |n |cFF80491C Use Magic Damage",
    ["Deformed Fanatic"] = "|cFFFFC600Kite |n |cFF80491C Use Magic Damage",

    -- Saurfang
    ["Blood Beast"] = "|cFFFFC600Don't Tank/Melee |n |cFF80491C Kill/Kite at range",

    -- Rotface
    ["Little Ooze"] = "|cFFFFC600Kite |n |cFF80491C Kite to Big Ooze",
    ["Big Ooze"] = "|cFFFFC600Kite |n |cFF80491C Hits hard",

    -- Professor Putricide
    ["Professor Putricide"] = "|cFFFFC600 Tank till 35%, then.. |n |cFF80491C Tanks taunt, 2x Mutated Plague",
    ["Volatile Slime"] = "|cFFFFC600Snare and Kill  |n |cFF80491C Use Slime, Stack on Target",
    ["Gas Cloud"] = "|cFFFFC600Snare, Kite and Kill |n |cFF80491C Use Slime, Avoid Target",
}

local function UpdateNoteWidget(self, unit)
    local text = NoteWidgetNames[unit.name]

    if text then --and unit.type == "PLAYER" then
        self.Text:SetText(text)
        self:Show()
    else
        self:Hide()
    end
end

local function CreateNoteWidget(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(16)
    frame:SetHeight(16)
    -- Image
    frame.Texture = frame:CreateTexture(nil, "OVERLAY")
    frame.Texture:SetPoint("CENTER")
    frame.Texture:SetWidth(256)
    frame.Texture:SetHeight(64)
    frame.Texture:SetTexture(art)

    -- Target Text
    frame.Text = frame:CreateFontString(nil, "OVERLAY")
    frame.Text:SetFont(notefont, 14, "None")

    frame.Text:SetPoint("CENTER", 0, 7)
    frame.Text:SetShadowOffset(1, -1)
    frame.Text:SetShadowColor(0, 0, 0, 1)
    frame.Text:SetWidth(260)
    frame.Text:SetHeight(40)
    --frame.Text:SetText("|cFFFFC600Priority Kill |n |cFF80491C High Damage Caster")

    -- Vars and Mech
    frame:Hide()
    frame.Update = UpdateNoteWidget
    return frame
end

TidyPlatesWidgets.CreateNoteWidget = CreateNoteWidget

local function CreateCastWidget(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(16)
    frame:SetHeight(16)
    -- Image
    frame.Texture = frame:CreateTexture(nil, "OVERLAY")
    frame.Texture:SetPoint("CENTER")
    frame.Texture:SetWidth(256)
    frame.Texture:SetHeight(64)
    frame.Texture:SetTexture(art)

    -- Target Text
    frame.Text = frame:CreateFontString(nil, "OVERLAY")
    frame.Text:SetFont(notefont, 14, "None")

    frame.Text:SetPoint("CENTER", 0, 7)
    frame.Text:SetShadowOffset(1, -1)
    frame.Text:SetShadowColor(0, 0, 0, 1)
    frame.Text:SetWidth(260)
    frame.Text:SetHeight(40)

    -- Vars and Mech
    frame:Hide()
    frame.Update = UpdateCastWidget
    return frame
end

TidyPlatesWidgets.CreateCastWidget = CreateCastWidget