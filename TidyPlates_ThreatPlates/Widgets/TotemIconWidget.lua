---------------
-- Totem Icon Widget
---------------

local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\"

function tL(number)
	return select(1, GetSpellInfo(number))
end

TPtotemList = {
	--Air Totems
	[tL(8177)] = "A1", -- Grounding Totem
	[tL(10595)] = "A2", -- Nature Resistance Totem I
	[tL(10600)] = "A2", -- Nature Resistance Totem II
	[tL(10601)] = "A2", -- Nature Resistance Totem III
	[tL(25574)] = "A2", -- Nature Resistance Totem IV
	[tL(58746)] = "A2", -- Nature Resistance Totem V
	[tL(58749)] = "A2", -- Nature Resistance Totem VI
	[tL(6495)] = "A3", -- Sentry Totem
	[tL(8512)] = "A4", -- Windfury Totem
	[tL(3738)] = "A5", -- Wrath of Air Totem
	--Earth Totems
	[tL(2062)] = "E1", -- Earth Elemental Totem
	[tL(2484)] = "E2", -- Earthbind Totem
	[tL(5730)] = "E3", -- Stoneclaw Totem I
	[tL(6390)] = "E3", -- Stoneclaw Totem II
	[tL(6391)] = "E3", -- Stoneclaw Totem III
	[tL(6392)] = "E3", -- Stoneclaw Totem IV
	[tL(10427)] = "E3", -- Stoneclaw Totem V
	[tL(10428)] = "E3", -- Stoneclaw Totem VI
	[tL(25525)] = "E3", -- Stoneclaw Totem VII
	[tL(58580)] = "E3", -- Stoneclaw Totem VIII
	[tL(58581)] = "E3", -- Stoneclaw Totem IX
	[tL(58582)] = "E3", -- Stoneclaw Totem X
	[tL(8071)] = "E4", -- Stoneskin Totem I -- Faction Champs
	[tL(8154)] = "E4", -- Stoneskin Totem II
	[tL(8155)] = "E4", -- Stoneskin Totem III
	[tL(10406)] = "E4", -- Stoneskin Totem IV
	[tL(10407)] = "E4", -- Stoneskin Totem V
	[tL(10408)] = "E4", -- Stoneskin Totem VI
	[tL(25508)] = "E4", -- Stoneskin Totem VII
	[tL(25509)] = "E4", -- Stoneskin Totem VIII
	[tL(58751)] = "E4", -- Stoneskin Totem IX
	[tL(58753)] = "E4", -- Stoneskin Totem X
	[tL(8075)] = "E5", -- Strength of Earth Totem I -- Faction Champs
	[tL(8160)] = "E5", -- Strength of Earth Totem II
	[tL(8161)] = "E5", -- Strength of Earth Totem III
	[tL(10442)] = "E5", -- Strength of Earth Totem IV
	[tL(25361)] = "E5", -- Strength of Earth Totem V
	[tL(25528)] = "E5", -- Strength of Earth Totem VI
	[tL(57622)] = "E5", -- Strength of Earth Totem VII
	[tL(58643)] = "E5", -- Strength of Earth Totem VIII
	[tL(8143)] = "E6", -- Tremor Totem
	--Fire Totems
	[tL(2894)] = "F1", -- Fire Elemental Totem
	[tL(8227)] = "F2", -- Flametongue Totem I -- Faction Champs
	[tL(8249)] = "F2", -- Flametongue Totem II
	[tL(10526)] = "F2", -- Flametongue Totem III
	[tL(16387)] = "F2", -- Flametongue Totem IV
	[tL(25557)] = "F2", -- Flametongue Totem V
	[tL(58649)] = "F2", -- Flametongue Totem VI
	[tL(58652)] = "F2", -- Flametongue Totem VII
	[tL(58656)] = "F2", -- Flametongue Totem VIII
	[tL(8181)] = "F3", -- Frost Resistance Totem I
	[tL(10478)] = "F3", -- Frost Resistance Totem II
	[tL(10479)] = "F3", -- Frost Resistance Totem III
	[tL(25560)] = "F3", -- Frost Resistance Totem IV
	[tL(58741)] = "F3", -- Frost Resistance Totem V
	[tL(58745)] = "F3", -- Frost Resistance Totem VI
	[tL(8190)] = "F4", -- Magma Totem I
	[tL(10585)] = "F4", -- Magma Totem II
	[tL(10586)] = "F4", -- Magma Totem III
	[tL(10587)] = "F4", -- Magma Totem IV
	[tL(25552)] = "F4", -- Magma Totem V
	[tL(58731)] = "F4", -- Magma Totem VI
	[tL(58734)] = "F4", -- Magma Totem VII
	[tL(3599)] = "F5", -- Searing Totem I -- Faction Champs
	[tL(6363)] = "F5", -- Searing Totem II
	[tL(6364)] = "F5", -- Searing Totem III
	[tL(6365)] = "F5", -- Searing Totem IV
	[tL(10437)] = "F5", -- Searing Totem V
	[tL(10438)] = "F5", -- Searing Totem VI
	[tL(25533)] = "F5", -- Searing Totem VII
	[tL(58699)] = "F5", -- Searing Totem VIII
	[tL(58703)] = "F5", -- Searing Totem IX
	[tL(58704)] = "F5", -- Searing Totem X
	[tL(30706)] = "F6", -- Totem of Wrath I
	[tL(57720)] = "F6", -- Totem of Wrath II
	[tL(57721)] = "F6", -- Totem of Wrath III
	[tL(57722)] = "F6", -- Totem of Wrath IV
	--Water Totems
	[tL(8170)] = "W1", -- Cleansing Totem
	[tL(8184)] = "W2", -- Fire Resistance Totem I
	[tL(10537)] = "W2", -- Fire Resistance Totem II
	[tL(10538)] = "W2", -- Fire Resistance Totem III
	[tL(25563)] = "W2", -- Fire Resistance Totem IV
	[tL(58737)] = "W2", -- Fire Resistance Totem V
	[tL(58739)] = "W2", -- Fire Resistance Totem VI
	[tL(5394)] = "W3", -- Healing Stream Totem I -- Faction Champs
	[tL(6375)] = "W3", -- Healing Stream Totem II
	[tL(6377)] = "W3", -- Healing Stream Totem III
	[tL(10462)] = "W3", -- Healing Stream Totem IV
	[tL(10463)] = "W3", -- Healing Stream Totem V
	[tL(25567)] = "W3", -- Healing Stream Totem VI
	[tL(58755)] = "W3", -- Healing Stream Totem VII
	[tL(58756)] = "W3", -- Healing Stream Totem VIII
	[tL(58757)] = "W3", -- Healing Stream Totem IX
	[tL(5675)] = "W4", -- Mana Spring Totem I
	[tL(10495)] = "W4", -- Mana Spring Totem II
	[tL(10496)] = "W4", -- Mana Spring Totem III
	[tL(10497)] = "W4", -- Mana Spring Totem IV
	[tL(25570)] = "W4", -- Mana Spring Totem V
	[tL(58771)] = "W4", -- Mana Spring Totem VI
	[tL(58773)] = "W4", -- Mana Spring Totem VII
	[tL(58774)] = "W4", -- Mana Spring Totem VIII
	[tL(16190)] = "W5" -- Mana Tide Totem
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