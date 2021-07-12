TidyPlatesThreat = LibStub("AceAddon-3.0"):NewAddon("TidyPlatesThreat", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TidyPlatesThreat", false)

local PlayerClass = select(2, UnitClass("player"))
local Active = function()
	return GetActiveTalentGroup()
end
local HEX_CLASS_COLOR = {
	SHAMAN = "2459FF",
	MAGE = "69CCF0",
	WARLOCK = "9482C9",
	HUNTER = "ABD473",
	ROGUE = "FFF569",
	PRIEST = "FFFFFF",
	DRUID = "FF7D0A",
	DEATHKNIGHT = "C41F3B",
	WARRIOR = "C79C6E",
	PALADIN = "F58CBA"
}
local tankRole = L["|cff00ff00tanking|r"]
local dpsRole = L["|cffff0000dpsing / healing|r"]
--

TidyPlatesThemeList = TidyPlatesThemeList or {}
TidyPlatesThemeList["Threat Plates"] = {}

-- Callback Functions
function TidyPlatesThreat:ProfChange()
	TidyPlatesThreat:ConfigRefresh()
end

-- Dual Spec Functions
local currentSpec = {}
function TidyPlatesThreat:currentRoleBool(number)
	currentSpec[1] = TidyPlatesThreat.db.char.spec.primary
	currentSpec[2] = TidyPlatesThreat.db.char.spec.secondary
	if currentSpec[number] then
		return currentSpec[number]
	end
end
function TidyPlatesThreat:setSpecTank(number)
	local specIs = {}
	specIs[1] = "primary"
	specIs[2] = "secondary"
	TidyPlatesThreat.db.char.spec[specIs[number]] = true
end
function TidyPlatesThreat:setSpecDPS(number)
	local specIs = {}
	specIs[1] = "primary"
	specIs[2] = "secondary"
	TidyPlatesThreat.db.char.spec[specIs[number]] = false
end

function TidyPlatesThreat:dualSpec()
	currentSpec[3] = ""
	if Active() == 1 then
		currentSpec[3] = L["primary"]
	elseif Active() == 2 then
		currentSpec[3] = L["secondary"]
	else
		currentSpec[3] = L["unknown"]
	end
	return currentSpec[3]
end

function TidyPlatesThreat:roleText()
	if Active() == 1 then
		if TidyPlatesThreat.db.char.spec.primary then
			return tankRole
		else
			return dpsRole
		end
	elseif Active() == 2 then
		if TidyPlatesThreat.db.char.spec.secondary then
			return tankRole
		else
			return dpsRole
		end
	end
end

function TidyPlatesThreat:specName()
	local Spec = TidyPlatesThreat.db.char.specName
	local t = TidyPlatesThreat.db.char.specInfo[Active()]
	local spentTotal = t[1] + t[2] + t[3]
	if t[1] > t[2] and t[1] > t[3] then
		return Spec[1]
	elseif t[2] > t[1] and t[2] > t[3] then
		return Spec[2]
	elseif t[3] > t[1] and t[3] > t[2] then
		return Spec[3]
	else
		return (spentTotal < 1) and L["Undetermined"] or ""
	end
end
--

function TidyPlatesThreat:OnInitialize()
	local defaults = {
		char = {
			welcome = false,
			specInfo = {
				[1] = {[1] = 0, [2] = 0, [3] = 0},
				[2] = {[1] = 0, [2] = 0, [3] = 0}
			},
			threat = {tanking = true},
			spec = {primary = true, secondary = false},
			specName = {[1] = nil, [2] = nil, [3] = nil},
			stances = {
				ON = false,
				[0] = false, -- No Stance
				[1] = false, -- Battle Stance
				[2] = true, -- Defensive Stance
				[3] = false -- Berserker Stance
			},
			shapeshifts = {
				ON = false,
				[0] = false, -- Caster Form
				[1] = true, -- Bear Form
				[2] = false, -- Aquatic Form
				[3] = false, -- Cat Form
				[4] = false, -- Travel Form
				[5] = false, -- Moonkin Form, Tree of Life, (Swift) Flight Form
				[6] = false -- Flight Form (if moonkin or tree spec'd)
			},
			presences = {
				ON = false,
				[0] = false, -- No Presence
				[1] = true, -- Blood
				[2] = false, -- Frost
				[3] = false -- Unholy
			},
			auras = {
				ON = false,
				[0] = false, -- No Aura
				[1] = true, -- Devotion Aura
				[2] = false, -- Retribution Aura
				[3] = false, -- Concentration Aura
				[4] = false, -- Resistance Aura
				[5] = false -- Crusader Aura
			}
		},
		profile = {
			cache = {},
			OldSetting = true,
			verbose = true,
			blizzFade = {toggle = true, amount = -0.3},
			healthColorChange = false,
			customColor = false,
			allowClass = false,
			friendlyClass = false,
			friendlyNameOnly = false,
			friendlyClassIcon = false,
			cacheClass = false,
			castbarColor = {toggle = true, r = 1, g = 0.56, b = 0.06, a = 1},
			castbarColorShield = {toggle = true, r = 1, g = 0, b = 0, a = 1},
			aHPbarColor = {r = 0, g = 1, b = 0},
			bHPbarColor = {r = 1, g = 0, b = 0},
			fHPbarColor = {r = 1, g = 1, b = 1},
			nHPbarColor = {r = 1, g = 1, b = 1},
			HPbarColor = {r = 1, g = 1, b = 1},
			tHPbarColor = {r = 0, g = 0.5, b = 1},
			totemSettings = {
				hideHealthbar = false,
				-- Air Totems
				["A1"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.67, g = 1, b = 1}},
				["A2"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.67, g = 1, b = 1}},
				["A3"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.67, g = 1, b = 1}},
				["A4"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.67, g = 1, b = 1}},
				["A5"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.67, g = 1, b = 1}},
				["A6"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.67, g = 1, b = 1}},
				-- Earth Totems
				["E1"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.7, b = 0.12}},
				["E2"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.7, b = 0.12}},
				["E3"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.7, b = 0.12}},
				["E4"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.7, b = 0.12}},
				["E5"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.7, b = 0.12}},
				["E6"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.7, b = 0.12}},
				-- Fire Totems
				["F1"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.4, b = 0.4}},
				["F2"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.4, b = 0.4}},
				["F3"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.4, b = 0.4}},
				["F4"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.4, b = 0.4}},
				["F5"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.4, b = 0.4}},
				["F6"] = {true, true, true, nil, nil, nil, "normal", color = {r = 1, g = 0.4, b = 0.4}},
				-- Water Totems
				["W1"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.58, g = 0.72, b = 1}},
				["W2"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.58, g = 0.72, b = 1}},
				["W3"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.58, g = 0.72, b = 1}},
				["W4"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.58, g = 0.72, b = 1}},
				["W5"] = {true, true, true, nil, nil, nil, "normal", color = {r = 0.58, g = 0.72, b = 1}}
			},
			uniqueSettings = {
				list = {},
				["**"] = {
					name = "",
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "",
					scale = 1,
					alpha = 1,
					color = {r = 1, g = 1, b = 1}
				},
				[1] = {
					name = L["Shadow Fiend"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U1",
					scale = 0.45,
					alpha = 1,
					color = {r = 0.61, g = 0.40, b = 0.86}
				},
				[2] = {
					name = L["Spirit Wolf"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U2",
					scale = 0.45,
					alpha = 1,
					color = {r = 0.32, g = 0.7, b = 0.89}
				},
				[3] = {
					name = L["Ebon Gargoyle"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U3",
					scale = 0.45,
					alpha = 1,
					color = {r = 1, g = 0.71, b = 0}
				},
				[4] = {
					name = L["Water Elemental"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U4",
					scale = 0.45,
					alpha = 1,
					color = {r = 0.33, g = 0.72, b = 0.44}
				},
				[5] = {
					name = L["Treant"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U5",
					scale = 0.45,
					alpha = 1,
					color = {r = 1, g = 0.71, b = 0}
				},
				[6] = {
					name = L["Viper"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U6",
					scale = 0.45,
					alpha = 1,
					color = {
						r = 0.39,
						g = 1,
						b = 0.11
					}
				},
				[7] = {
					name = L["Venomous Snake"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U6",
					scale = 0.45,
					alpha = 1,
					color = {r = 0.75, g = 0, b = 0.02}
				},
				[8] = {
					name = L["Army of the Dead Ghoul"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U7",
					scale = 0.45,
					alpha = 1,
					color = {r = 0.87, g = 0.78, b = 0.88}
				},
				[9] = {
					name = L["Shadowy Apparition"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U8",
					scale = 1,
					alpha = 1,
					color = {r = 0.62, g = 0.19, b = 1}
				},
				[10] = {
					name = L["Shambling Horror"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U9",
					scale = 1,
					alpha = 1,
					color = {r = 0.69, g = 0.26, b = 0.25}
				},
				[11] = {
					name = L["Web Wrap"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U10",
					scale = 0.75,
					alpha = 1,
					color = {r = 1, g = 0.39, b = 0.96}
				},
				[12] = {
					name = L["Immortal Guardian"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U11",
					scale = 1,
					alpha = 1,
					color = {r = 0.33, g = 0.33, b = 0.33}
				},
				[13] = {
					name = L["Marked Immortal Guardian"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U12",
					scale = 1,
					alpha = 1,
					color = {r = 0.75, g = 0, b = 0.02}
				},
				[14] = {
					name = L["Empowered Adherent"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U13",
					scale = 1,
					alpha = 1,
					color = {r = 0.29, g = 0.11, b = 1}
				},
				[15] = {
					name = L["Deformed Fanatic"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U14",
					scale = 1,
					alpha = 1,
					color = {r = 0.55, g = 0.7, b = 0.29}
				},
				[16] = {
					name = L["Reanimated Adherent"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U15",
					scale = 1,
					alpha = 1,
					color = {r = 1, g = 0.88, b = 0.61}
				},
				[17] = {
					name = L["Reanimated Fanatic"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U15",
					scale = 1,
					alpha = 1,
					color = {r = 1, g = 0.88, b = 0.61}
				},
				[18] = {
					name = L["Bone Spike"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U16",
					scale = 1,
					alpha = 1,
					color = {r = 1, g = 1, b = 1}
				},
				[19] = {
					name = L["Onyxian Whelp"],
					showNameplate = false,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U17",
					scale = 1,
					alpha = 1,
					color = {r = 0.33, g = 0.28, b = 0.71}
				},
				[20] = {
					name = L["Gas Cloud"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U18",
					scale = 1,
					alpha = 1,
					color = {r = 0.96, g = 0.56, b = 0.07}
				},
				[21] = {
					name = L["Volatile Ooze"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U19",
					scale = 1,
					alpha = 1,
					color = {r = 0.36, g = 0.95, b = 0.33}
				},
				[22] = {
					name = L["Darnavan"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U20",
					scale = 1,
					alpha = 1,
					color = {r = 0.78, g = 0.61, b = 0.43}
				},
				[23] = {
					name = L["Val'kyr Shadowguard"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U21",
					scale = 1,
					alpha = 1,
					color = {r = 0.47, g = 0.89, b = 1}
				},
				[24] = {
					name = L["Kinetic Bomb"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U22",
					scale = 1,
					alpha = 1,
					color = {r = 0.91, g = 0.71, b = 0.1}
				},
				[25] = {
					name = L["Lich King"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U23",
					scale = 1,
					alpha = 1,
					color = {r = 0.77, g = 0.12, b = 0.23}
				},
				[26] = {
					name = L["Raging Spirit"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U24",
					scale = 1,
					alpha = 1,
					color = {r = 0.77, g = 0.27, b = 0}
				},
				[27] = {
					name = L["Drudge Ghoul"],
					showNameplate = true,
					showIcon = false,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U25",
					scale = 0.85,
					alpha = 1,
					color = {r = 0.43, g = 0.43, b = 0.43}
				},
				[28] = {
					name = L["Living Inferno"],
					showNameplate = true,
					showIcon = true,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U27",
					scale = 1,
					alpha = 1,
					color = {r = 0, g = 1, b = 0}
				},
				[29] = {
					name = L["Living Ember"],
					showNameplate = true,
					showIcon = false,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\UniqueIconWidget\\U28",
					scale = 0.60,
					alpha = 0.75,
					color = {r = 0.25, g = 0.25, b = 0.25}
				},
				[30] = {
					name = L["Fanged Pit Viper"],
					showNameplate = false,
					showIcon = false,
					useStyle = true,
					useColor = true,
					allowMarked = true,
					overrideScale = false,
					overrideAlpha = false,
					icon = "",
					scale = 0,
					alpha = 0,
					color = {r = 1, g = 1, b = 1}
				},
				[31] = {},
				[32] = {},
				[33] = {},
				[34] = {},
				[35] = {},
				[36] = {},
				[37] = {},
				[38] = {},
				[39] = {},
				[40] = {},
				[41] = {},
				[42] = {},
				[43] = {},
				[44] = {},
				[45] = {},
				[46] = {},
				[47] = {},
				[48] = {},
				[49] = {},
				[50] = {}
			},
			text = {
				amount = true,
				percent = true,
				full = false,
				max = false,
				deficit = false,
				truncate = true
			},
			totemWidget = {
				ON = true,
				scale = 35,
				x = 0,
				y = 35,
				level = 1,
				anchor = "CENTER"
			},
			debuffWidget = {
				ON = true,
				x = 18,
				y = 32,
				mode = "whitelist",
				scale = 1,
				anchor = "CENTER",
				filter = {}
			},
			uniqueWidget = {
				ON = true,
				scale = 35,
				x = 0,
				y = 35,
				level = 1,
				anchor = "CENTER"
			},
			classWidget = {
				ON = true,
				scale = 22,
				x = -74,
				y = -7,
				theme = "default",
				anchor = "CENTER"
			},
			targetWidget = {
				ON = true,
				theme = "default",
				width = 30,
				height = 30,
				r = 1,
				g = 1,
				b = 1,
				a = 1
			},
			threatWidget = {
				ON = false,
				x = 0,
				y = 26,
				anchor = "CENTER"
			},
			tankedWidget = {
				ON = false,
				scale = 16,
				x = 65,
				y = 6,
				anchor = "CENTER"
			},
			comboWidget = {
				ON = false,
				scale = 64,
				x = 0,
				y = -8
			},
			eliteWidget = {
				ON = true,
				theme = "default",
				scale = 15,
				x = 64,
				y = 9,
				anchor = "CENTER"
			},
			socialWidget = {
				ON = false,
				scale = 16,
				x = 65,
				y = 6,
				anchor = "CENTER"
			},
			settings = {
				frame = {
					y = 0
				},
				highlight = {
					texture = "TP_HealthBarHighlight"
				},
				elitehealthborder = {
					texture = "TP_HealthBarEliteOverlay",
					show = true
				},
				healthborder = {
					texture = "TP_HealthBarOverlay",
					backdrop = "",
					show = true
				},
				threatborder = {
					show = true
				},
				healthbar = {
					texture = "ThreatPlatesBar",
					width = 120,
					height = 10
				},
				castnostop = {
					texture = "TP_CastBarLock",
					x = 0,
					y = -15,
					show = true
				},
				castborder = {
					texture = "TP_CastBarOverlay",
					x = 0,
					y = -15,
					show = true
				},
				castbar = {
					texture = "ThreatPlatesBar",
					x = 0,
					y = -15,
					show = true
				},
				name = {
					typeface = "Accidental Presidency",
					width = 116,
					height = 14,
					size = 14,
					x = 0,
					y = 13,
					align = "CENTER",
					vertical = "CENTER",
					shadow = true,
					flags = "NONE",
					color = {
						r = 1,
						g = 1,
						b = 1
					},
					show = true
				},
				level = {
					typeface = "Accidental Presidency",
					size = 12,
					width = 20,
					height = 14,
					x = 50,
					y = 0,
					align = "RIGHT",
					vertical = "TOP",
					shadow = true,
					flags = "NONE",
					show = true
				},
				eliteicon = {
					show = true,
					theme = "default",
					scale = 15,
					x = 64,
					y = 9,
					level = 22,
					anchor = "CENTER"
				},
				customtext = {
					typeface = "Accidental Presidency",
					size = 12,
					width = 110,
					height = 14,
					x = 0,
					y = 1,
					align = "CENTER",
					vertical = "CENTER",
					shadow = true,
					flags = "NONE",
					show = true
				},
				spelltext = {
					typeface = "Accidental Presidency",
					size = 12,
					width = 110,
					height = 14,
					x = 0,
					y = -13,
					align = "CENTER",
					vertical = "CENTER",
					shadow = true,
					flags = "NONE",
					show = true
				},
				raidicon = {
					scale = 20,
					x = 0,
					y = 27,
					anchor = "CENTER",
					hpColor = true,
					show = true,
					hpMarked = {
						STAR = {r = 0.85, g = 0.81, b = 0.27},
						MOON = {r = 0.60, g = 0.75, b = 0.85},
						CIRCLE = {r = 0.93, g = 0.51, b = 0.06},
						SQUARE = {r = 0, g = 0.64, b = 1},
						DIAMOND = {r = 0.7, g = 0.06, b = 0.84},
						CROSS = {r = 0.82, g = 0.18, b = 0.18},
						TRIANGLE = {r = 0.14, g = 0.66, b = 0.14},
						SKULL = {r = 0.89, g = 0.83, b = 0.74}
					}
				},
				spellicon = {
					scale = 20,
					x = 75,
					y = -7,
					anchor = "CENTER",
					show = true
				},
				customart = {
					scale = 22,
					x = -74,
					y = -7,
					anchor = "CENTER",
					show = true
				},
				skullicon = {
					scale = 16,
					x = 55,
					y = 0,
					anchor = "CENTER",
					show = true
				},
				unique = {
					threatcolor = {
						LOW = {r = 0, g = 0, b = 0, a = 0},
						MEDIUM = {r = 0, g = 0, b = 0, a = 0},
						HIGH = {r = 0, g = 0, b = 0, a = 0}
					}
				},
				totem = {
					threatcolor = {
						LOW = {r = 0, g = 0, b = 0, a = 0},
						MEDIUM = {r = 0, g = 0, b = 0, a = 0},
						HIGH = {r = 0, g = 0, b = 0, a = 0}
					}
				},
				normal = {
					threatcolor = {
						LOW = {r = 1, g = 1, b = 1, a = 1},
						MEDIUM = {r = 1, g = 1, b = 0, a = 1},
						HIGH = {r = 1, g = 0, b = 0, a = 1}
					}
				},
				dps = {
					threatcolor = {
						LOW = {r = 0, g = 1, b = 0, a = 1},
						MEDIUM = {r = 1, g = 1, b = 0, a = 1},
						HIGH = {r = 1, g = 0, b = 0, a = 1}
					}
				},
				tank = {
					threatcolor = {
						LOW = {r = 1, g = 0, b = 0, a = 1},
						MEDIUM = {r = 1, g = 1, b = 0, a = 1},
						HIGH = {r = 0, g = 1, b = 0, a = 1}
					}
				}
			},
			threat = {
				ON = true,
				nonCombat = true,
				hideNonCombat = false,
				useType = true,
				useScale = true,
				useAlpha = true,
				useHPColor = true,
				art = {
					ON = true,
					theme = "default"
				},
				scaleType = {
					["Normal"] = -0.2,
					["Elite"] = 0,
					["Boss"] = 0.2
				},
				toggle = {
					["Boss"] = true,
					["Elite"] = true,
					["Normal"] = true,
					["Neutral"] = true
				},
				dps = {
					scale = {
						LOW = 0.8,
						MEDIUM = 0.9,
						HIGH = 1.25
					},
					alpha = {
						LOW = 1,
						MEDIUM = 1,
						HIGH = 1
					}
				},
				tank = {
					scale = {
						LOW = 1.25,
						MEDIUM = 0.9,
						HIGH = 0.8
					},
					alpha = {
						LOW = 1,
						MEDIUM = 0.85,
						HIGH = 0.75
					}
				},
				marked = {
					alpha = false,
					art = false,
					scale = false
				}
			},
			nameplate = {
				toggle = {
					["Boss"] = true,
					["Elite"] = true,
					["Normal"] = true,
					["Neutral"] = true
				},
				scale = {
					["Totem"] = 0.75,
					["Boss"] = 1.1,
					["Elite"] = 1.04,
					["Normal"] = 1,
					["Target"] = 1,
					["Neutral"] = 0.9,
					["Marked"] = 1
				},
				alpha = {
					["Totem"] = 1,
					["Boss"] = 1,
					["Elite"] = 1,
					["Normal"] = 1,
					["Neutral"] = 1,
					["Marked"] = 1
				}
			}
		}
	}
	local db = LibStub("AceDB-3.0"):New("ThreatPlatesDB", defaults, "Default")
	self.db = db

	local RegisterCallback = db.RegisterCallback

	RegisterCallback(self, "OnProfileChanged", "ProfChange")
	RegisterCallback(self, "OnProfileCopied", "ProfChange")
	RegisterCallback(self, "OnProfileReset", "ProfChange")

	self:SetUpInitialOptions()
end

local TotemNameFallback = TidyPlatesUtility.TotemNameFallback
-- Unit Classification
function TPTP_UnitType(unit)
	local db = TidyPlatesThreat.db.profile
	local unitRank
	local totem = TPtotemList[unit.name] or TPtotemList[TotemNameFallback(unit.name)]
	local unique = tContains(db.uniqueSettings.list, unit.name)
	if totem then
		unitRank = "Totem"
	elseif unique then
		for k_c, k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				if db.uniqueSettings[k_c].useStyle then
					unitRank = "Unique"
				else
					if (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						unitRank = "Boss"
					elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						unitRank = "Elite"
					elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
						unitRank = "Normal"
					elseif unit.reaction == "NEUTRAL" then
						unitRank = "Neutral"
					end
				end
			end
		end
	elseif (unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
		unitRank = "Boss"
	elseif (unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
		unitRank = "Elite"
	elseif (not unit.isElite and not unit.isDangerous and (unit.reaction == "FRIENDLY" or unit.reaction == "HOSTILE")) then
		unitRank = "Normal"
	elseif unit.reaction == "NEUTRAL" then
		unitRank = "Neutral"
	else
		unitRank = "Normal"
	end
	return unitRank
end

function SetStyleThreatPlates(unit)
	local db = TidyPlatesThreat.db.profile
	local T = TPTP_UnitType(unit)
	if T == "Totem" then
		local tS = db.totemSettings[TPtotemList[unit.name] or TPtotemList[TotemNameFallback(unit.name)]]
		if tS[1] then
			if db.totemSettings.hideHealthbar then
				return "etotem"
			else
				return "totem"
			end
		else
			return "empty"
		end
	elseif T == "Unique" then
		for k_c, k_v in pairs(db.uniqueSettings.list) do
			if k_v == unit.name then
				if db.uniqueSettings[k_c].showNameplate then
					return "unique"
				else
					return "empty"
				end
			end
		end
	elseif T then
		if unit.reaction == "HOSTILE" or unit.reaction == "NEUTRAL" then
			if db.nameplate.toggle[T] then
				if db.threat.toggle[T] and db.threat.ON and unit.class == "UNKNOWN" and InCombatLockdown() then
					if db.threat.nonCombat then
						if unit.isInCombat or (unit.health < unit.healthmax) then
							if TidyPlatesThreat.db.char.threat.tanking then
								return "tank"
							else
								return "dps"
							end
						else
							if not db.threat.hideNonCombat then
								return "normal"
							else
								return "empty"
							end
						end
					else
						if TidyPlatesThreat.db.char.threat.tanking then
							return "tank"
						else
							return "dps"
						end
					end
				else
					return "normal"
				end
			else
				return "empty"
			end
		elseif unit.reaction == "FRIENDLY" then
			if TidyPlatesThreat.db.profile.friendlyNameOnly then
				return "text"
			elseif db.nameplate.toggle[T] then
				return "normal"
			else
				return "empty"
			end
		else
			return "empty"
		end
	else
		return "empty"
	end
end

local function ShowConfigPanel()
	TidyPlatesThreat:OpenOptions()
end
------------
-- EVENTS --
------------
function TidyPlatesThreat:specInfo()
	for i = 1, GetNumTalentGroups() do
		for z = 1, GetNumTalentTabs() do
			local name, _, pointsSpent, _, _ = GetTalentTabInfo(z, false, false, i)
			TidyPlatesThreat.db.char.specInfo[i][z] = pointsSpent
			TidyPlatesThreat.db.char.specName[z] = name
		end
	end
end

function TidyPlatesThreat:StartUp()
	TidyPlatesThreat:specInfo()
	local t = self.db.char.specInfo[Active()]
	-- Welcome
	local Welcome = L["|cff89f559Welcome to |rTidy Plates: |cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] .. HEX_CLASS_COLOR[PlayerClass] .. TidyPlatesThreat:specName() .. " " .. UnitClass("player") .. ": " .. t[1] .. "/" .. t[2] .. "/" .. t[3] .. "|r|cff89F559.|r\n"
	-- Body
	local NotTank = Welcome .. L["|cff89f559Your dual spec's have been set to |r"] .. dpsRole .. "|cff89f559.|r"
	local CurrentlyDPS = Welcome .. L["|cff89f559You are currently in your "] .. dpsRole .. L["|cff89f559 role.|r"]
	local CurrentlyTank = Welcome .. L["|cff89f559You are currently in your "] .. tankRole .. L["|cff89f559 role.|r"]
	local Undetermined = Welcome .. L["|cff89f559Your role can not be determined.\nPlease set your dual spec preferences in the |rThreat Plates|cff89f559 options.|r"]
	-- End
	local Conclusion = L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"]

	-- Welcome Setup / Display
	if not self.db.char.welcome then
		self.db.char.welcome = true
		if ((TidyPlatesOptions.primary ~= "Threat Plates") and (TidyPlatesOptions.secondary ~= "Threat Plates")) then
			local spec = TidyPlatesThreat:dualSpec()
			StaticPopupDialogs["SetToThreatPlates"] = {
				text = GetAddOnMetadata("TidyPlates_ThreatPlates", "title") .. L[":\n----------\nWould you like to \nset your theme to |cff89F559Threat Plates|r?\n\nClicking '|cff00ff00Yes|r' will set you to Threat Plates & reload UI. \n Clicking '|cffff0000No|r' will open the Tidy Plates options."],
				button1 = YES,
				button2 = CANCEL,
				button3 = NO,
				timeout = 0,
				whileDead = 1,
				hideOnEscape = 1,
				OnAccept = function()
					TidyPlatesOptions.primary = "Threat Plates"
					TidyPlatesOptions.secondary = "Threat Plates"
					ReloadUI()
				end,
				OnAlt = function()
					InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
				end,
				OnCancel = function()
					if TidyPlatesThreat.db.profile.verbose then
						print(L["-->>|cffff0000Activate Threat Plates from the Tidy Plates options!|r<<--"])
					end
				end
			}
			StaticPopup_Show("SetToThreatPlates")
		end
		if
			PlayerClass == "SHAMAN" or PlayerClass == "MAGE" or PlayerClass == "HUNTER" or PlayerClass == "ROGUE" or
				PlayerClass == "PRIEST" or
				PlayerClass == "WARLOCK"
		 then
			if TidyPlatesThreat.db.profile.verbose then
				print(NotTank)
			end
			for i = 1, GetNumTalentGroups() do
				TidyPlatesThreat:setSpecDPS(i)
			end
		elseif PlayerClass == "WARRIOR" then
			if t[3] > t[2] and t[3] > t[1] then -- Detects protection spec
				if TidyPlatesThreat.db.profile.verbose then
					print(CurrentlyTank)
				end
			else
				if TidyPlatesThreat.db.profile.verbose then
					print(CurrentlyDPS)
				end
			end
			for i = 1, GetNumTalentGroups() do
				local z = self.db.char.specInfo[i]
				if z[3] > z[2] and z[3] > z[1] then -- Detects protection spec
					TidyPlatesThreat:setSpecTank(i)
				else
					TidyPlatesThreat:setSpecDPS(i)
				end
			end
		elseif PlayerClass == "PALADIN" then
			if t[2] > t[1] and t[2] > t[3] then -- Detects protection spec
				if TidyPlatesThreat.db.profile.verbose then
					print(CurrentlyTank)
				end
			else
				if TidyPlatesThreat.db.profile.verbose then
					print(CurrentlyDPS)
				end
			end
			for i = 1, GetNumTalentGroups() do
				local z = self.db.char.specInfo[i]
				if z and z[2] > z[1] and z[2] > z[3] then -- Detects protection spec
					TidyPlatesThreat:setSpecTank(i)
				else
					TidyPlatesThreat:setSpecDPS(i)
				end
			end
		elseif PlayerClass == "DRUID" then
			if (t[2] > t[1]) and (t[2] > t[3]) then
				if TidyPlatesThreat.db.profile.verbose then
					print(Undetermined)
				end
			else
				if TidyPlatesThreat.db.profile.verbose then
					print(CurrentlyDPS)
				end
			end
			for i = 1, GetNumTalentGroups() do
				local z = self.db.char.specInfo[i]
				if z and z[2] > z[1] and z[2] > z[3] then -- Detects feral spec
					TidyPlatesThreat:setSpecTank(i)
				else
					TidyPlatesThreat:setSpecDPS(i)
				end
			end
		elseif PlayerClass == "DEATHKNIGHT" then
			if TidyPlatesThreat.db.profile.verbose then
				print(Undetermined)
			end
		else
			if TidyPlatesThreat.db.profile.verbose then
				print(Welcome)
			end
		end
		if TidyPlatesThreat.db.profile.verbose then
			print(Conclusion)
		end
		self.db.char.threat.tanking = TidyPlatesThreat:currentRoleBool(Active()) -- Aligns tanking role with current spec on log in, post setup.
		if GetCVar("ShowVKeyCastbar") == "1" then
			TidyPlatesThreat.db.profile.settings.castbar.show = true
		else
			TidyPlatesThreat.db.profile.settings.castbar.show = false
		end
	end
end
--
local f = CreateFrame("Frame")
local function EventHandler(self, event, ...)
	local DB = TidyPlatesThreat.db.profile
	local CharDB = TidyPlatesThreat.db.char
	local arg1, arg2 = ...
	if event == "ADDON_LOADED" then
		if arg1 == "TidyPlates_ThreatPlates" then
			local setup = {
				SetStyle = SetStyleThreatPlates,
				SetScale = TidyPlatesThreat.SetScale,
				SetAlpha = TidyPlatesThreat.SetAlpha,
				SetCustomText = TidyPlatesThreat.SetCustomText,
				SetNameColor = TidyPlatesThreat.SetNameColor,
				SetThreatColor = TidyPlatesThreat.SetThreatColor,
				SetCastbarColor = TidyPlatesThreat.SetCastbarColor,
				SetHealthbarColor = TidyPlatesThreat.SetHealthbarColor,
				ShowConfigPanel = ShowConfigPanel
			}
			TidyPlatesThemeList["Threat Plates"] = setup
		end
		f:UnregisterEvent("ADDON_LOADED")
	elseif event == "PLAYER_LOGIN" then
		TidyPlatesThreat:StartUp()
		CharDB.threat.tanking = TidyPlatesThreat:currentRoleBool(Active()) -- Aligns tanking role with current spec on log in.
		if GetCVar("nameplateShowEnemyTotems") == "1" then
			DB.nameplate.toggle["Totem"] = true
		else
			DB.nameplate.toggle["Totem"] = false
		end
		SetCVar("ShowClassColorInNameplate", 1)

		if CharDB.welcome and ((TidyPlatesOptions.primary == "Threat Plates") or (TidyPlatesOptions.secondary == "Threat Plates")) and DB.verbose then
			print(L["|cff89f559Threat Plates:|r Welcome back |cff"] .. HEX_CLASS_COLOR[PlayerClass] .. UnitName("player") .. "|r!!")
		end

		-- Enable Stances / Shapeshifts and Create Options Tables
		if PlayerClass == "WARRIOR" or PlayerClass == "DRUID" or PlayerClass == "DEATHKNIGHT" or PlayerClass == "PALADIN" then
			f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		local iType = select(2, IsInInstance())
		if iType == "arena" or iType == "pvp" then
			DB.threat.ON = false
		elseif iType == "party" or iType == "raid" or iType == "none" then
			DB.threat.ON = DB.OldSetting
		end
		DB.cache = {}
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	elseif event == "PLAYER_LEAVING_WORLD" then
		self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
		local t = CharDB.specInfo[Active()]
		CharDB.threat.tanking = TidyPlatesThreat:currentRoleBool(Active())
		if ((TidyPlatesOptions.primary == "Threat Plates") or (TidyPlatesOptions.secondary == "Threat Plates")) and DB.verbose then
			print(L["|cff89F559Threat Plates|r: Player spec change detected: |cff"] .. HEX_CLASS_COLOR[PlayerClass] .. TidyPlatesThreat:specName() .. ": (" .. t[1] .. "/" .. t[2] .. "/" .. t[3] .. L[")|r, you are now in your |cff89F559"] .. TidyPlatesThreat:dualSpec() .. L["|r spec and are now in your "] .. TidyPlatesThreat:roleText() .. L[" role."])
		end
		TidyPlates:ForceUpdate()
	elseif event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
		if DB.threat.ON and (GetCVar("threatWarning") ~= 3) then
			SetCVar("threatWarning", 3)
		elseif not DB.threat.ON and (GetCVar("threatWarning") ~= 0) then
			SetCVar("threatWarning", 0)
		end
	elseif event == "PLAYER_LOGOUT" then
		DB.cache = {}
	elseif event == "RAID_TARGET_UPDATE" then
		TidyPlates:Update()
	elseif event == "UPDATE_SHAPESHIFT_FORM" then
		TidyPlatesThreat.ShapeshiftUpdate()
	end
end
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_LEAVING_WORLD")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_LOGOUT")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("RAID_TARGET_UPDATE")
f:SetScript("OnEvent", EventHandler)