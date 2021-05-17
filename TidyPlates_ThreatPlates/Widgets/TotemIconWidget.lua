---------------
-- Totem Icon Widget
---------------

local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\"
local L = TidyPlates.L

local function TotemName(SpellID)
	return (select(1, GetSpellInfo(SpellID)))
end

TPtotemList = {
	--Air Totems
	[TotemName(8177)] = "A1", -- Grounding Totem
	[L["Nature Resistance Totem I"]] = "A2", -- Nature Resistance Totem I
	[L["Nature Resistance Totem II"]] = "A2", -- Nature Resistance Totem II
	[L["Nature Resistance Totem III"]] = "A2", -- Nature Resistance Totem III
	[L["Nature Resistance Totem IV"]] = "A2", -- Nature Resistance Totem IV
	[L["Nature Resistance Totem V"]] = "A2", -- Nature Resistance Totem V
	[L["Nature Resistance Totem VI"]] = "A2", -- Nature Resistance Totem VI
	[TotemName(6495)] = "A3", -- Sentry Totem
	[TotemName(8512)] = "A4", -- Windfury Totem
	[TotemName(3738)] = "A5", -- Wrath of Air Totem
	--Earth Totems
	[TotemName(2062)] = "E1", -- Earth Elemental Totem
	[TotemName(2484)] = "E2", -- Earthbind Totem
	[L["Stoneclaw Totem I"]] = "E3", -- Stoneclaw Totem I
	[L["Stoneclaw Totem II"]] = "E3", -- Stoneclaw Totem II
	[L["Stoneclaw Totem III"]] = "E3", -- Stoneclaw Totem III
	[L["Stoneclaw Totem IV"]] = "E3", -- Stoneclaw Totem IV
	[L["Stoneclaw Totem V"]] = "E3", -- Stoneclaw Totem V
	[L["Stoneclaw Totem VI"]] = "E3", -- Stoneclaw Totem VI
	[L["Stoneclaw Totem VII"]] = "E3", -- Stoneclaw Totem VII
	[L["Stoneclaw Totem VIII"]] = "E3", -- Stoneclaw Totem VIII
	[L["Stoneclaw Totem IX"]] = "E3", -- Stoneclaw Totem IX
	[L["Stoneclaw Totem X"]] = "E3", -- Stoneclaw Totem X
	[L["Stoneskin Totem I"]] = "E4", -- Stoneskin Totem I -- Faction Champs
	[L["Stoneskin Totem II"]] = "E4", -- Stoneskin Totem II
	[L["Stoneskin Totem III"]] = "E4", -- Stoneskin Totem III
	[L["Stoneskin Totem IV"]] = "E4", -- Stoneskin Totem IV
	[L["Stoneskin Totem V"]] = "E4", -- Stoneskin Totem V
	[L["Stoneskin Totem VI"]] = "E4", -- Stoneskin Totem VI
	[L["Stoneskin Totem VII"]] = "E4", -- Stoneskin Totem VII
	[L["Stoneskin Totem VIII"]] = "E4", -- Stoneskin Totem VIII
	[L["Stoneskin Totem IX"]] = "E4", -- Stoneskin Totem IX
	[L["Stoneskin Totem X"]] = "E4", -- Stoneskin Totem X
	[L["Strength of Earth Totem I"]] = "E5", -- Strength of Earth Totem I -- Faction Champs
	[L["Strength of Earth Totem II"]] = "E5", -- Strength of Earth Totem II
	[L["Strength of Earth Totem III"]] = "E5", -- Strength of Earth Totem III
	[L["Strength of Earth Totem IV"]] = "E5", -- Strength of Earth Totem IV
	[L["Strength of Earth Totem V"]] = "E5", -- Strength of Earth Totem V
	[L["Strength of Earth Totem VI"]] = "E5", -- Strength of Earth Totem VI
	[L["Strength of Earth Totem VII"]] = "E5", -- Strength of Earth Totem VII
	[L["Strength of Earth Totem VIII"]] = "E5", -- Strength of Earth Totem VIII
	[TotemName(8143)] = "E6", -- Tremor Totem
	--Fire Totems
	[TotemName(2894)] = "F1", -- Fire Elemental Totem
	[L["Flametongue Totem I"]] = "F2", -- Flametongue Totem I -- Faction Champs
	[L["Flametongue Totem II"]] = "F2", -- Flametongue Totem II
	[L["Flametongue Totem III"]] = "F2", -- Flametongue Totem III
	[L["Flametongue Totem IV"]] = "F2", -- Flametongue Totem IV
	[L["Flametongue Totem V"]] = "F2", -- Flametongue Totem V
	[L["Flametongue Totem VI"]] = "F2", -- Flametongue Totem VI
	[L["Flametongue Totem VII"]] = "F2", -- Flametongue Totem VII
	[L["Flametongue Totem VIII"]] = "F2", -- Flametongue Totem VIII
	[L["Frost Resistance Totem I"]] = "F3", -- Frost Resistance Totem I
	[L["Frost Resistance Totem II"]] = "F3", -- Frost Resistance Totem II
	[L["Frost Resistance Totem III"]] = "F3", -- Frost Resistance Totem III
	[L["Frost Resistance Totem IV"]] = "F3", -- Frost Resistance Totem IV
	[L["Frost Resistance Totem V"]] = "F3", -- Frost Resistance Totem V
	[L["Frost Resistance Totem VI"]] = "F3", -- Frost Resistance Totem VI
	[L["Magma Totem I"]] = "F4", -- Magma Totem I
	[L["Magma Totem II"]] = "F4", -- Magma Totem II
	[L["Magma Totem III"]] = "F4", -- Magma Totem III
	[L["Magma Totem IV"]] = "F4", -- Magma Totem IV
	[L["Magma Totem V"]] = "F4", -- Magma Totem V
	[L["Magma Totem VI"]] = "F4", -- Magma Totem VI
	[L["Magma Totem VII"]] = "F4", -- Magma Totem VII
	[L["Searing Totem I"]] = "F5", -- Searing Totem I -- Faction Champs
	[L["Searing Totem II"]] = "F5", -- Searing Totem II
	[L["Searing Totem III"]] = "F5", -- Searing Totem III
	[L["Searing Totem IV"]] = "F5", -- Searing Totem IV
	[L["Searing Totem V"]] = "F5", -- Searing Totem V
	[L["Searing Totem VI"]] = "F5", -- Searing Totem VI
	[L["Searing Totem VII"]] = "F5", -- Searing Totem VII
	[L["Searing Totem VIII"]] = "F5", -- Searing Totem VIII
	[L["Searing Totem IX"]] = "F5", -- Searing Totem IX
	[L["Searing Totem X"]] = "F5", -- Searing Totem X
	[L["Totem of Wrath I"]] = "F6", -- Totem of Wrath I
	[L["Totem of Wrath II"]] = "F6", -- Totem of Wrath II
	[L["Totem of Wrath III"]] = "F6", -- Totem of Wrath III
	[L["Totem of Wrath IV"]] = "F6", -- Totem of Wrath IV
	--Water Totems
	[TotemName(8170)] = "W1", -- Cleansing Totem
	[L["Fire Resistance Totem I"]] = "W2", -- Fire Resistance Totem I
	[L["Fire Resistance Totem II"]] = "W2", -- Fire Resistance Totem II
	[L["Fire Resistance Totem III"]] = "W2", -- Fire Resistance Totem III
	[L["Fire Resistance Totem IV"]] = "W2", -- Fire Resistance Totem IV
	[L["Fire Resistance Totem V"]] = "W2", -- Fire Resistance Totem V
	[L["Fire Resistance Totem VI"]] = "W2", -- Fire Resistance Totem VI
	[L["Healing Stream Totem I"]] = "W3", -- Healing Stream Totem I -- Faction Champs
	[L["Healing Stream Totem II"]] = "W3", -- Healing Stream Totem II
	[L["Healing Stream Totem III"]] = "W3", -- Healing Stream Totem III
	[L["Healing Stream Totem IV"]] = "W3", -- Healing Stream Totem IV
	[L["Healing Stream Totem V"]] = "W3", -- Healing Stream Totem V
	[L["Healing Stream Totem VI"]] = "W3", -- Healing Stream Totem VI
	[L["Healing Stream Totem VII"]] = "W3", -- Healing Stream Totem VII
	[L["Healing Stream Totem VIII"]] = "W3", -- Healing Stream Totem VIII
	[L["Healing Stream Totem IX"]] = "W3", -- Healing Stream Totem IX
	[L["Mana Spring Totem I"]] = "W4", -- Mana Spring Totem I
	[L["Mana Spring Totem II"]] = "W4", -- Mana Spring Totem II
	[L["Mana Spring Totem III"]] = "W4", -- Mana Spring Totem III
	[L["Mana Spring Totem IV"]] = "W4", -- Mana Spring Totem IV
	[L["Mana Spring Totem V"]] = "W4", -- Mana Spring Totem V
	[L["Mana Spring Totem VI"]] = "W4", -- Mana Spring Totem VI
	[L["Mana Spring Totem VII"]] = "W4", -- Mana Spring Totem VII
	[L["Mana Spring Totem VIII"]] = "W4", -- Mana Spring Totem VIII
	[TotemName(16190)] = "W5" -- Mana Tide Totem
}

local function UpdateTotemIconWidget(self, unit)
	local totem = TPtotemList[unit.name]
	local db = TidyPlatesThreat.db.profile
	if totem and db.totemWidget.ON and db.totemSettings[totem][3] then
		self.Icon:SetTexture(path .. db.totemSettings[totem][7] .. "\\" .. TPtotemList[unit.name])
		self:Show()
	else
		self:Hide()
	end
end

local function CreateTotemIconWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(64)
	frame:SetHeight(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetPoint("CENTER", frame)
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateTotemIconWidget
	return frame
end

ThreatPlatesWidgets.CreateTotemIconWidget = CreateTotemIconWidget