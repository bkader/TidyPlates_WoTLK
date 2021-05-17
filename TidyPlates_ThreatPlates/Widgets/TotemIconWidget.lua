---------------
-- Totem Icon Widget
---------------

local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\"
local L = TidyPlates.L

local function TotemName(SpellID, suffix)
	local name = (select(1, GetSpellInfo(SpellID)))
	if suffix then name = name .. " "..suffix end
	return name
end

TPtotemList = {
	--Air Totems
	[TotemName(8177)] = "A1", -- Grounding Totem
	[TotemName(10595, "I")] = "A2", -- Nature Resistance Totem I
	[TotemName(10600, "II")] = "A2", -- Nature Resistance Totem II
	[TotemName(10601, "III")] = "A2", -- Nature Resistance Totem III
	[TotemName(25574, "IV")] = "A2", -- Nature Resistance Totem IV
	[TotemName(58746, "V")] = "A2", -- Nature Resistance Totem V
	[TotemName(58749, "VI")] = "A2", -- Nature Resistance Totem VI
	[TotemName(6495)] = "A3", -- Sentry Totem
	[TotemName(8512)] = "A4", -- Windfury Totem
	[TotemName(3738)] = "A5", -- Wrath of Air Totem
	--Earth Totems
	[TotemName(2062)] = "E1", -- Earth Elemental Totem
	[TotemName(2484)] = "E2", -- Earthbind Totem
	[TotemName(5730, "I")] = "E3", -- Stoneclaw Totem I
	[TotemName(6390, "II")] = "E3", -- Stoneclaw Totem II
	[TotemName(6391, "III")] = "E3", -- Stoneclaw Totem III
	[TotemName(6392, "IV")] = "E3", -- Stoneclaw Totem IV
	[TotemName(10427, "V")] = "E3", -- Stoneclaw Totem V
	[TotemName(10428, "VI")] = "E3", -- Stoneclaw Totem VI
	[TotemName(25525, "VII")] = "E3", -- Stoneclaw Totem VII
	[TotemName(58580, "VIII")] = "E3", -- Stoneclaw Totem VIII
	[TotemName(58581, "IX")] = "E3", -- Stoneclaw Totem IX
	[TotemName(58582, "X")] = "E3", -- Stoneclaw Totem X
	[TotemName(8071, "I")] = "E4", -- Stoneskin Totem I -- Faction Champs
	[TotemName(8154, "II")] = "E4", -- Stoneskin Totem II
	[TotemName(8155, "III")] = "E4", -- Stoneskin Totem III
	[TotemName(10406, "IV")] = "E4", -- Stoneskin Totem IV
	[TotemName(10407, "V")] = "E4", -- Stoneskin Totem V
	[TotemName(10408, "VI")] = "E4", -- Stoneskin Totem VI
	[TotemName(25508, "VII")] = "E4", -- Stoneskin Totem VII
	[TotemName(25509, "VIII")] = "E4", -- Stoneskin Totem VIII
	[TotemName(58751, "IX")] = "E4", -- Stoneskin Totem IX
	[TotemName(58753, "X")] = "E4", -- Stoneskin Totem X
	[TotemName(8075, "I")] = "E5", -- Strength of Earth Totem I -- Faction Champs
	[TotemName(8160, "II")] = "E5", -- Strength of Earth Totem II
	[TotemName(8161, "III")] = "E5", -- Strength of Earth Totem III
	[TotemName(10442, "IV")] = "E5", -- Strength of Earth Totem IV
	[TotemName(25361, "V")] = "E5", -- Strength of Earth Totem V
	[TotemName(25528, "VI")] = "E5", -- Strength of Earth Totem VI
	[TotemName(57622, "VII")] = "E5", -- Strength of Earth Totem VII
	[TotemName(58643, "VIII")] = "E5", -- Strength of Earth Totem VIII
	[TotemName(8143)] = "E6", -- Tremor Totem
	--Fire Totems
	[TotemName(2894)] = "F1", -- Fire Elemental Totem
	[TotemName(8227, "I")] = "F2", -- Flametongue Totem I -- Faction Champs
	[TotemName(8249, "II")] = "F2", -- Flametongue Totem II
	[TotemName(10526, "III")] = "F2", -- Flametongue Totem III
	[TotemName(16387, "IV")] = "F2", -- Flametongue Totem IV
	[TotemName(25557, "V")] = "F2", -- Flametongue Totem V
	[TotemName(58649, "VI")] = "F2", -- Flametongue Totem VI
	[TotemName(58652, "VII")] = "F2", -- Flametongue Totem VII
	[TotemName(58656, "VIII")] = "F2", -- Flametongue Totem VIII
	[TotemName(8181, "I")] = "F3", -- Frost Resistance Totem I
	[TotemName(10478, "II")] = "F3", -- Frost Resistance Totem II
	[TotemName(10479, "III")] = "F3", -- Frost Resistance Totem III
	[TotemName(25560, "IV")] = "F3", -- Frost Resistance Totem IV
	[TotemName(58741, "V")] = "F3", -- Frost Resistance Totem V
	[TotemName(58745, "VI")] = "F3", -- Frost Resistance Totem VI
	[TotemName(8190, "I")] = "F4", -- Magma Totem I
	[TotemName(10585, "II")] = "F4", -- Magma Totem II
	[TotemName(10586, "III")] = "F4", -- Magma Totem III
	[TotemName(10587, "IV")] = "F4", -- Magma Totem IV
	[TotemName(25552, "V")] = "F4", -- Magma Totem V
	[TotemName(58731, "VI")] = "F4", -- Magma Totem VI
	[TotemName(58734, "VII")] = "F4", -- Magma Totem VII
	[TotemName(3599, "I")] = "F5", -- Searing Totem I -- Faction Champs
	[TotemName(6363, "II")] = "F5", -- Searing Totem II
	[TotemName(6364, "III")] = "F5", -- Searing Totem III
	[TotemName(6365, "IV")] = "F5", -- Searing Totem IV
	[TotemName(10437, "V")] = "F5", -- Searing Totem V
	[TotemName(10438, "VI")] = "F5", -- Searing Totem VI
	[TotemName(25533, "VII")] = "F5", -- Searing Totem VII
	[TotemName(58699, "VIII")] = "F5", -- Searing Totem VIII
	[TotemName(58703, "IX")] = "F5", -- Searing Totem IX
	[TotemName(58704, "X")] = "F5", -- Searing Totem X
	[TotemName(30706, "I")] = "F6", -- Totem of Wrath I
	[TotemName(57720, "II")] = "F6", -- Totem of Wrath II
	[TotemName(57721, "III")] = "F6", -- Totem of Wrath III
	[TotemName(57722, "IV")] = "F6", -- Totem of Wrath IV
	--Water Totems
	[TotemName(8170)] = "W1", -- Cleansing Totem
	[TotemName(8184, "I")] = "W2", -- Fire Resistance Totem I
	[TotemName(10537, "II")] = "W2", -- Fire Resistance Totem II
	[TotemName(10538, "III")] = "W2", -- Fire Resistance Totem III
	[TotemName(25563, "IV")] = "W2", -- Fire Resistance Totem IV
	[TotemName(58737, "V")] = "W2", -- Fire Resistance Totem V
	[TotemName(58739, "VI")] = "W2", -- Fire Resistance Totem VI
	[TotemName(5394, "I")] = "W3", -- Healing Stream Totem I -- Faction Champs
	[TotemName(6375, "II")] = "W3", -- Healing Stream Totem II
	[TotemName(6377, "III")] = "W3", -- Healing Stream Totem III
	[TotemName(10462, "IV")] = "W3", -- Healing Stream Totem IV
	[TotemName(10463, "V")] = "W3", -- Healing Stream Totem V
	[TotemName(25567, "VI")] = "W3", -- Healing Stream Totem VI
	[TotemName(58755, "VII")] = "W3", -- Healing Stream Totem VII
	[TotemName(58756, "VIII")] = "W3", -- Healing Stream Totem VIII
	[TotemName(58757, "IX")] = "W3", -- Healing Stream Totem IX
	[TotemName(5675, "I")] = "W4", -- Mana Spring Totem I
	[TotemName(10495, "II")] = "W4", -- Mana Spring Totem II
	[TotemName(10496, "III")] = "W4", -- Mana Spring Totem III
	[TotemName(10497, "IV")] = "W4", -- Mana Spring Totem IV
	[TotemName(25570, "V")] = "W4", -- Mana Spring Totem V
	[TotemName(58771, "VI")] = "W4", -- Mana Spring Totem VI
	[TotemName(58773, "VII")] = "W4", -- Mana Spring Totem VII
	[TotemName(58774, "VIII")] = "W4", -- Mana Spring Totem VIII
	[TotemName(16190)] = "W5" -- Mana Tide Totem
}

local TotemNameFallback = TidyPlatesUtility.TotemNameFallback
local function UpdateTotemIconWidget(self, unit)
	local totem = TPtotemList[unit.name] or TPtotemList[TotemNameFallback(unit.name)]
	local db = TidyPlatesThreat.db.profile
	if totem and db.totemWidget.ON and db.totemSettings[totem][3] then
		self.Icon:SetTexture(path .. db.totemSettings[totem][7] .. "\\" .. totem)
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