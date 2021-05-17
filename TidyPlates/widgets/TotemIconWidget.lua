--------------------
-- Totem Icon Widget
--------------------
local classWidgetPath = "Interface\\Addons\\TidyPlates\\widgets\\ClassWidget\\"
local L = TidyPlates.L

local function TotemName(SpellID)
	return (select(1, GetSpellInfo(SpellID)))
end

local function TotemIcon(SpellID)
	return (select(3, GetSpellInfo(SpellID)))
end

local Totem_InfoTable = {
	--Air Totems
	[TotemName(8177)] = {TotemIcon(8177), 1},
	[L["Nature Resistance Totem I"]] = {TotemIcon(10595), 1},
	[L["Nature Resistance Totem II"]] = {TotemIcon(10600), 1},
	[L["Nature Resistance Totem III"]] = {TotemIcon(10601), 1},
	[L["Nature Resistance Totem IV"]] = {TotemIcon(25574), 1},
	[L["Nature Resistance Totem V"]] = {TotemIcon(58746), 1},
	[L["Nature Resistance Totem VI"]] = {TotemIcon(58749), 1},
	[TotemName(6495)] = {TotemIcon(6495), 1},
	[TotemName(8512)] = {TotemIcon(8512), 1},
	[TotemName(3738)] = {TotemIcon(3738), 1},
	--Earth Totems
	[TotemName(2062)] = {TotemIcon(2062), 2},
	[TotemName(2484)] = {TotemIcon(2484), 2},
	[L["Stoneclaw Totem I"]] = {TotemIcon(5730), 2},
	[L["Stoneclaw Totem II"]] = {TotemIcon(6390), 2},
	[L["Stoneclaw Totem III"]] = {TotemIcon(6391), 2},
	[L["Stoneclaw Totem IV"]] = {TotemIcon(6392), 2},
	[L["Stoneclaw Totem V"]] = {TotemIcon(10427), 2},
	[L["Stoneclaw Totem VI"]] = {TotemIcon(10428), 2},
	[L["Stoneclaw Totem VII"]] = {TotemIcon(25525), 2},
	[L["Stoneclaw Totem VIII"]] = {TotemIcon(58580), 2},
	[L["Stoneclaw Totem IX"]] = {TotemIcon(58581), 2},
	[L["Stoneclaw Totem X"]] = {TotemIcon(58582), 2},
	[L["Stoneskin Totem I"]] = {TotemIcon(8071), 2},
	[L["Stoneskin Totem II"]] = {TotemIcon(8154), 2},
	[L["Stoneskin Totem III"]] = {TotemIcon(8155), 2},
	[L["Stoneskin Totem IV"]] = {TotemIcon(10406), 2},
	[L["Stoneskin Totem V"]] = {TotemIcon(10407), 2},
	[L["Stoneskin Totem VI"]] = {TotemIcon(10408), 2},
	[L["Stoneskin Totem VII"]] = {TotemIcon(25508), 2},
	[L["Stoneskin Totem VIII"]] = {TotemIcon(25509), 2},
	[L["Stoneskin Totem IX"]] = {TotemIcon(58751), 2},
	[L["Stoneskin Totem X"]] = {TotemIcon(58753), 2},
	[L["Strength of Earth Totem I"]] = {TotemIcon(8075), 2},
	[L["Strength of Earth Totem II"]] = {TotemIcon(8160), 2},
	[L["Strength of Earth Totem III"]] = {TotemIcon(8161), 2},
	[L["Strength of Earth Totem IV"]] = {TotemIcon(10442), 2},
	[L["Strength of Earth Totem V"]] = {TotemIcon(25361), 2},
	[L["Strength of Earth Totem VI"]] = {TotemIcon(25528), 2},
	[L["Strength of Earth Totem VII"]] = {TotemIcon(57622), 2},
	[L["Strength of Earth Totem VIII"]] = {TotemIcon(58643), 2},
	[TotemName(8143)] = {TotemIcon(8143), 2},
	--Fire Totems
	[TotemName(2894)] = {TotemIcon(2894), 3},
	[L["Flametongue Totem I"]] = {TotemIcon(8227), 3},
	[L["Flametongue Totem II"]] = {TotemIcon(8249), 3},
	[L["Flametongue Totem III"]] = {TotemIcon(10526), 3},
	[L["Flametongue Totem IV"]] = {TotemIcon(16387), 3},
	[L["Flametongue Totem V"]] = {TotemIcon(25557), 3},
	[L["Flametongue Totem VI"]] = {TotemIcon(58649), 3},
	[L["Flametongue Totem VII"]] = {TotemIcon(58652), 3},
	[L["Flametongue Totem VIII"]] = {TotemIcon(58656), 3},
	[L["Frost Resistance Totem I"]] = {TotemIcon(8181), 3},
	[L["Frost Resistance Totem II"]] = {TotemIcon(10478), 3},
	[L["Frost Resistance Totem III"]] = {TotemIcon(10479), 3},
	[L["Frost Resistance Totem IV"]] = {TotemIcon(25560), 3},
	[L["Frost Resistance Totem V"]] = {TotemIcon(58741), 3},
	[L["Frost Resistance Totem VI"]] = {TotemIcon(58745), 3},
	[L["Magma Totem I"]] = {TotemIcon(8190), 3},
	[L["Magma Totem II"]] = {TotemIcon(10585), 3},
	[L["Magma Totem III"]] = {TotemIcon(10586), 3},
	[L["Magma Totem IV"]] = {TotemIcon(10587), 3},
	[L["Magma Totem V"]] = {TotemIcon(25552), 3},
	[L["Magma Totem VI"]] = {TotemIcon(58731), 3},
	[L["Magma Totem VII"]] = {TotemIcon(58734), 3},
	[L["Searing Totem I"]] = {TotemIcon(3599), 3},
	[L["Searing Totem II"]] = {TotemIcon(6363), 3},
	[L["Searing Totem III"]] = {TotemIcon(6364), 3},
	[L["Searing Totem IV"]] = {TotemIcon(6365), 3},
	[L["Searing Totem V"]] = {TotemIcon(10437), 3},
	[L["Searing Totem VI"]] = {TotemIcon(10438), 3},
	[L["Searing Totem VII"]] = {TotemIcon(25533), 3},
	[L["Searing Totem VIII"]] = {TotemIcon(58699), 3},
	[L["Searing Totem IX"]] = {TotemIcon(58703), 3},
	[L["Searing Totem X"]] = {TotemIcon(58704), 3},
	[L["Totem of Wrath I"]] = {TotemIcon(30706), 3},
	[L["Totem of Wrath II"]] = {TotemIcon(57720), 3},
	[L["Totem of Wrath III"]] = {TotemIcon(57721), 3},
	[L["Totem of Wrath IV"]] = {TotemIcon(57722), 3},
	--Water Totems
	[TotemName(8170)] = {TotemIcon(8170), 4},
	[L["Fire Resistance Totem I"]] = {TotemIcon(8184), 4},
	[L["Fire Resistance Totem II"]] = {TotemIcon(10537), 4},
	[L["Fire Resistance Totem III"]] = {TotemIcon(10538), 4},
	[L["Fire Resistance Totem IV"]] = {TotemIcon(25563), 4},
	[L["Fire Resistance Totem V"]] = {TotemIcon(58737), 4},
	[L["Fire Resistance Totem VI"]] = {TotemIcon(58739), 4},
	[L["Healing Stream Totem I"]] = {TotemIcon(5394), 4},
	[L["Healing Stream Totem II"]] = {TotemIcon(6375), 4},
	[L["Healing Stream Totem III"]] = {TotemIcon(6377), 4},
	[L["Healing Stream Totem IV"]] = {TotemIcon(10462), 4},
	[L["Healing Stream Totem V"]] = {TotemIcon(10463), 4},
	[L["Healing Stream Totem VI"]] = {TotemIcon(25567), 4},
	[L["Healing Stream Totem VII"]] = {TotemIcon(58755), 4},
	[L["Healing Stream Totem VIII"]] = {TotemIcon(58756), 4},
	[L["Healing Stream Totem IX"]] = {TotemIcon(58757), 4},
	[L["Mana Spring Totem I"]] = {TotemIcon(5675), 4},
	[L["Mana Spring Totem II"]] = {TotemIcon(10495), 4},
	[L["Mana Spring Totem III"]] = {TotemIcon(10496), 4},
	[L["Mana Spring Totem IV"]] = {TotemIcon(10497), 4},
	[L["Mana Spring Totem V"]] = {TotemIcon(25570), 4},
	[L["Mana Spring Totem VI"]] = {TotemIcon(58771), 4},
	[L["Mana Spring Totem VII"]] = {TotemIcon(58773), 4},
	[L["Mana Spring Totem VIII"]] = {TotemIcon(58774), 4},
	[TotemName(16190)] = {TotemIcon(16190), 4}
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

local function UpdateTotemIconWidget(self, unit)
	local icon = Totem_InfoTable[unit.name]
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
TidyPlatesUtility.IsTotem = IsTotem
TidyPlatesUtility.TotemSlot = TotemSlot