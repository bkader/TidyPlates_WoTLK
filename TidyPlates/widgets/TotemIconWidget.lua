--------------------
-- Totem Icon Widget
--------------------
local classWidgetPath = "Interface\\Addons\\TidyPlates\\widgets\\ClassWidget\\"

local function TotemName(SpellID)
	local name = (select(1, GetSpellInfo(SpellID)))
	return name
end

local function TotemIcon(SpellID)
	local icon = (select(3, GetSpellInfo(SpellID)))
	return icon
end

local Totem_InfoTable = {
	-- Air Totems
	[TotemName(8177)] = {TotemIcon(8177), 1}, -- Grounding Totem
	[TotemName(8512)] = {TotemIcon(8512), 1}, -- Windfury Totem
	[TotemName(3738)] = {TotemIcon(3738), 1}, -- Wrath of Air Totem
	-- Earth Totems
	[TotemName(2062)] = {TotemIcon(2062), 2}, -- Earth Elemental Totem
	[TotemName(2484)] = {TotemIcon(2484), 2}, -- Earthbind Totem
	[TotemName(5730)] = {TotemIcon(5730), 2}, -- Stoneclaw Totem
	[TotemName(8071)] = {TotemIcon(8071), 2}, -- Stoneskin Totem
	[TotemName(8075)] = {TotemIcon(8075), 2}, -- Strength of Earth Totem
	[TotemName(8143)] = {TotemIcon(8143), 2}, -- Tremor Totem
	-- Fire Totems
	[TotemName(2894)] = {TotemIcon(2894), 3}, -- Fire Elemental Totem
	[TotemName(8227)] = {TotemIcon(8227), 3}, -- Flametongue Totem
	[TotemName(8190)] = {TotemIcon(8190), 3}, -- Magma Totem
	[TotemName(3599)] = {TotemIcon(3599), 3}, -- Searing Totem
	-- Water Totems
	[TotemName(8184)] = {TotemIcon(8184), 4}, -- Elemental Resistance Totem
	[TotemName(5394)] = {TotemIcon(5394), 4}, -- Healing Stream Totem
	[TotemName(5675)] = {TotemIcon(5675), 4}, -- Mana Spring Totem
	[TotemName(16190)] = {TotemIcon(16190), 4} -- Mana Tide Totem
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