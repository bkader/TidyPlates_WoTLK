--------------------
-- Totem Icon Widget
--------------------
local classWidgetPath = "Interface\\Addons\\TidyPlates\\widgets\\ClassWidget\\"

local function TotemName(SpellID, suffix)
	local name = (select(1, GetSpellInfo(SpellID)))
	if suffix then
		name = name .. " " .. suffix
	end
	return name
end

local function TotemIcon(SpellID)
	return (select(3, GetSpellInfo(SpellID)))
end

local Totem_InfoTable = {
	--Air Totems
	[TotemName(8177)] = {TotemIcon(8177), 1, "Grounding Totem"},
	[TotemName(10595, "I")] = {TotemIcon(10595), 1, "Nature Resistance Totem I"},
	[TotemName(10600, "II")] = {TotemIcon(10600), 1, "Nature Resistance Totem II"},
	[TotemName(10601, "III")] = {TotemIcon(10601), 1, "Nature Resistance Totem III"},
	[TotemName(25574, "IV")] = {TotemIcon(25574), 1, "Nature Resistance Totem IV"},
	[TotemName(58746, "V")] = {TotemIcon(58746), 1, "Nature Resistance Totem V"},
	[TotemName(58749, "VI")] = {TotemIcon(58749), 1, "Nature Resistance Totem VI"},
	[TotemName(6495)] = {TotemIcon(6495), 1, "Sentry Totem"},
	[TotemName(8512)] = {TotemIcon(8512), 1, "Windfury Totem"},
	[TotemName(3738)] = {TotemIcon(3738), 1, "Wrath of Air Totem"},
	--Earth Totems
	[TotemName(2062)] = {TotemIcon(2062), 2, "Earth Elemental Totem"},
	[TotemName(2484)] = {TotemIcon(2484), 2, "Earthbind Totem"},
	[TotemName(5730, "I")] = {TotemIcon(5730), 2, "Stoneclaw Totem I"},
	[TotemName(6390, "II")] = {TotemIcon(6390), 2, "Stoneclaw Totem II"},
	[TotemName(6391, "III")] = {TotemIcon(6391), 2, "Stoneclaw Totem III"},
	[TotemName(6392, "IV")] = {TotemIcon(6392), 2, "Stoneclaw Totem IV"},
	[TotemName(10427, "V")] = {TotemIcon(10427), 2, "Stoneclaw Totem V"},
	[TotemName(10428, "VI")] = {TotemIcon(10428), 2, "Stoneclaw Totem VI"},
	[TotemName(25525, "VII")] = {TotemIcon(25525), 2, "Stoneclaw Totem VII"},
	[TotemName(58580, "VIII")] = {TotemIcon(58580), 2, "Stoneclaw Totem VIII"},
	[TotemName(58581, "IX")] = {TotemIcon(58581), 2, "Stoneclaw Totem IX"},
	[TotemName(58582, "X")] = {TotemIcon(58582), 2, "Stoneclaw Totem X"},
	[TotemName(8071, "I")] = {TotemIcon(8071), 2, "Stoneskin Totem I"},
	[TotemName(8154, "II")] = {TotemIcon(8154), 2, "Stoneskin Totem II"},
	[TotemName(8155, "III")] = {TotemIcon(8155), 2, "Stoneskin Totem III"},
	[TotemName(10406, "IV")] = {TotemIcon(10406), 2, "Stoneskin Totem IV"},
	[TotemName(10407, "V")] = {TotemIcon(10407), 2, "Stoneskin Totem V"},
	[TotemName(10408, "VI")] = {TotemIcon(10408), 2, "Stoneskin Totem VI"},
	[TotemName(25508, "VII")] = {TotemIcon(25508), 2, "Stoneskin Totem VII"},
	[TotemName(25509, "VIII")] = {TotemIcon(25509), 2, "Stoneskin Totem VIII"},
	[TotemName(58751, "IX")] = {TotemIcon(58751), 2, "Stoneskin Totem IX"},
	[TotemName(58753, "X")] = {TotemIcon(58753), 2, "Stoneskin Totem X"},
	[TotemName(8075, "I")] = {TotemIcon(8075), 2, "Strength of Earth Totem I"},
	[TotemName(8160, "II")] = {TotemIcon(8160), 2, "Strength of Earth Totem II"},
	[TotemName(8161, "III")] = {TotemIcon(8161), 2, "Strength of Earth Totem III"},
	[TotemName(10442, "IV")] = {TotemIcon(10442), 2, "Strength of Earth Totem IV"},
	[TotemName(25361, "V")] = {TotemIcon(25361), 2, "Strength of Earth Totem V"},
	[TotemName(25528, "VI")] = {TotemIcon(25528), 2, "Strength of Earth Totem VI"},
	[TotemName(57622, "VII")] = {TotemIcon(57622), 2, "Strength of Earth Totem VII"},
	[TotemName(58643, "VIII")] = {TotemIcon(58643), 2, "Strength of Earth Totem VIII"},
	[TotemName(8143)] = {TotemIcon(8143), 2},
	--Fire Totems
	[TotemName(2894)] = {TotemIcon(2894), 3, "Fire Elemental Totem"},
	[TotemName(8227, "I")] = {TotemIcon(8227), 3, "Flametongue Totem I"},
	[TotemName(8249, "II")] = {TotemIcon(8249), 3, "Flametongue Totem II"},
	[TotemName(10526, "III")] = {TotemIcon(10526), 3, "Flametongue Totem III"},
	[TotemName(16387, "IV")] = {TotemIcon(16387), 3, "Flametongue Totem IV"},
	[TotemName(25557, "V")] = {TotemIcon(25557), 3, "Flametongue Totem V"},
	[TotemName(58649, "VI")] = {TotemIcon(58649), 3, "Flametongue Totem VI"},
	[TotemName(58652, "VII")] = {TotemIcon(58652), 3, "Flametongue Totem VII"},
	[TotemName(58656, "VIII")] = {TotemIcon(58656), 3, "Flametongue Totem VIII"},
	[TotemName(8181, "I")] = {TotemIcon(8181), 3, "Frost Resistance Totem I"},
	[TotemName(10478, "II")] = {TotemIcon(10478), 3, "Frost Resistance Totem II"},
	[TotemName(10479, "III")] = {TotemIcon(10479), 3, "Frost Resistance Totem III"},
	[TotemName(25560, "IV")] = {TotemIcon(25560), 3, "Frost Resistance Totem IV"},
	[TotemName(58741, "V")] = {TotemIcon(58741), 3, "Frost Resistance Totem V"},
	[TotemName(58745, "VI")] = {TotemIcon(58745), 3, "Frost Resistance Totem VI"},
	[TotemName(8190, "I")] = {TotemIcon(8190), 3, "Magma Totem I"},
	[TotemName(10585, "II")] = {TotemIcon(10585), 3, "Magma Totem II"},
	[TotemName(10586, "III")] = {TotemIcon(10586), 3, "Magma Totem III"},
	[TotemName(10587, "IV")] = {TotemIcon(10587), 3, "Magma Totem IV"},
	[TotemName(25552, "V")] = {TotemIcon(25552), 3, "Magma Totem V"},
	[TotemName(58731, "VI")] = {TotemIcon(58731), 3, "Magma Totem VI"},
	[TotemName(58734, "VII")] = {TotemIcon(58734), 3, "Magma Totem VII"},
	[TotemName(3599, "I")] = {TotemIcon(3599), 3, "Searing Totem I"},
	[TotemName(6363, "II")] = {TotemIcon(6363), 3, "Searing Totem II"},
	[TotemName(6364, "III")] = {TotemIcon(6364), 3, "Searing Totem III"},
	[TotemName(6365, "IV")] = {TotemIcon(6365), 3, "Searing Totem IV"},
	[TotemName(10437, "V")] = {TotemIcon(10437), 3, "Searing Totem V"},
	[TotemName(10438, "VI")] = {TotemIcon(10438), 3, "Searing Totem VI"},
	[TotemName(25533, "VII")] = {TotemIcon(25533), 3, "Searing Totem VII"},
	[TotemName(58699, "VIII")] = {TotemIcon(58699), 3, "Searing Totem VIII"},
	[TotemName(58703, "IX")] = {TotemIcon(58703), 3, "Searing Totem IX"},
	[TotemName(58704, "X")] = {TotemIcon(58704), 3, "Searing Totem X"},
	[TotemName(30706, "I")] = {TotemIcon(30706), 3, "Totem of Wrath I"},
	[TotemName(57720, "II")] = {TotemIcon(57720), 3, "Totem of Wrath II"},
	[TotemName(57721, "III")] = {TotemIcon(57721), 3, "Totem of Wrath III"},
	[TotemName(57722, "IV")] = {TotemIcon(57722), 3, "Totem of Wrath IV"},
	--Water Totems
	[TotemName(8170)] = {TotemIcon(8170), 4, "Cleansing Totem"},
	[TotemName(8184, "I")] = {TotemIcon(8184), 4, "Fire Resistance Totem I"},
	[TotemName(10537, "II")] = {TotemIcon(10537), 4, "Fire Resistance Totem II"},
	[TotemName(10538, "III")] = {TotemIcon(10538), 4, "Fire Resistance Totem III"},
	[TotemName(25563, "IV")] = {TotemIcon(25563), 4, "Fire Resistance Totem IV"},
	[TotemName(58737, "V")] = {TotemIcon(58737), 4, "Fire Resistance Totem V"},
	[TotemName(58739, "VI")] = {TotemIcon(58739), 4, "Fire Resistance Totem VI"},
	[TotemName(5394, "I")] = {TotemIcon(5394), 4, "Healing Stream Totem I"},
	[TotemName(6375, "II")] = {TotemIcon(6375), 4, "Healing Stream Totem II"},
	[TotemName(6377, "III")] = {TotemIcon(6377), 4, "Healing Stream Totem III"},
	[TotemName(10462, "IV")] = {TotemIcon(10462), 4, "Healing Stream Totem IV"},
	[TotemName(10463, "V")] = {TotemIcon(10463), 4, "Healing Stream Totem V"},
	[TotemName(25567, "VI")] = {TotemIcon(25567), 4, "Healing Stream Totem VI"},
	[TotemName(58755, "VII")] = {TotemIcon(58755), 4, "Healing Stream Totem VII"},
	[TotemName(58756, "VIII")] = {TotemIcon(58756), 4, "Healing Stream Totem VIII"},
	[TotemName(58757, "IX")] = {TotemIcon(58757), 4, "Healing Stream Totem IX"},
	[TotemName(5675, "I")] = {TotemIcon(5675), 4, "Mana Spring Totem I"},
	[TotemName(10495, "II")] = {TotemIcon(10495), 4, "Mana Spring Totem II"},
	[TotemName(10496, "III")] = {TotemIcon(10496), 4, "Mana Spring Totem III"},
	[TotemName(10497, "IV")] = {TotemIcon(10497), 4, "Mana Spring Totem IV"},
	[TotemName(25570, "V")] = {TotemIcon(25570), 4, "Mana Spring Totem V"},
	[TotemName(58771, "VI")] = {TotemIcon(58771), 4, "Mana Spring Totem VI"},
	[TotemName(58773, "VII")] = {TotemIcon(58773), 4, "Mana Spring Totem VII"},
	[TotemName(58774, "VIII")] = {TotemIcon(58774), 4, "Mana Spring Totem VIII"},
	[TotemName(16190)] = {TotemIcon(16190), 4, "Mana Tide Totem"}
}

local function IsTotem(name)
	if name then
		return (Totem_InfoTable[name] ~= nil)
	end
end
local function TotemSlot(name)
	if name then
		if IsTotem(name) then
			return Totem_InfoTable[name][2]
		end
	end
end

local function TotemNameFallback(totem)
	for name, tbl in pairs(Totem_InfoTable) do
		if (tbl[3] and tbl[3] == totem) then
			return name
		end
	end
end

local function UpdateTotemIconWidget(self, unit)
	local icon = Totem_InfoTable[unit.name]
	icon = icon or Totem_InfoTable[TotemNameFallback(unit.name)]
	if icon then
		self.Icon:SetTexture(icon[1])
		self:Show()
	else
		self:Hide()
	end
end

local function CreateTotemIconWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(19)
	frame:SetHeight(18)

	frame.Overlay = frame:CreateTexture(nil, "OVERLAY")
	frame.Overlay:SetPoint("CENTER", frame, 1, -1)
	frame.Overlay:SetWidth(24)
	frame.Overlay:SetHeight(24)
	frame.Overlay:SetTexture(classWidgetPath .. "_BORDER")

	frame.Icon = frame:CreateTexture(nil, "ARTWORK")
	frame.Icon:SetPoint("CENTER", frame)
	frame.Icon:SetTexCoord(.07, 1 - .07, .07, 1 - .07) -- obj:SetTexCoord(left,right,top,bottom)
	frame.Icon:SetAllPoints(frame)

	frame:Hide()
	frame.Update = UpdateTotemIconWidget
	return frame
end

TidyPlatesWidgets.CreateTotemIconWidget = CreateTotemIconWidget
TidyPlatesUtility.TotemTable = Totem_InfoTable
TidyPlatesUtility.TotemNameFallback = TotemNameFallback
TidyPlatesUtility.TotemSlot = TotemSlot
TidyPlatesUtility.TotemSlot = TotemSlot