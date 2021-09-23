local TidyPlatesThreat = LibStub("AceAddon-3.0"):GetAddon("TidyPlatesThreat")
local L = LibStub("AceLocale-3.0"):GetLocale("TidyPlatesThreat")
local class = select(2, UnitClass("Player"))

TidyPlatesThreat.title = GetAddOnMetadata("TidyPlates_ThreatPlates", "title") .. " v" .. GetAddOnMetadata("TidyPlates_ThreatPlates", "version")
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Media\\Artwork\\"
local db

-- Reference Tables
local themeList = {"normal", "tank", "dps", "totem", "unique", "text"}
local FullAlign = {
	TOPLEFT = "TOPLEFT",
	TOP = "TOP",
	TOPRIGHT = "TOPRIGHT",
	LEFT = "LEFT",
	CENTER = "CENTER",
	RIGHT = "RIGHT",
	BOTTOMLEFT = "BOTTOMLEFT",
	BOTTOM = "BOTTOM",
	BOTTOMRIGHT = "BOTTOMRIGHT"
}
local AlignH = {LEFT = "LEFT", CENTER = "CENTER", RIGHT = "RIGHT"}
local AlignV = {BOTTOM = "BOTTOM", CENTER = "CENTER", TOP = "TOP"}
local FontStyle = {
	NONE = L["None"],
	OUTLINE = L["Outline"],
	THICKOUTLINE = L["Thick Outline"],
	["NONE, MONOCHROME"] = L["No Outline, Monochrome"],
	["OUTLINE, MONOCHROME"] = L["Outline, Monochrome"],
	["THICKOUTLINE, MONOCHROME"] = L["Thick Outline, Monochrome"]
}
local DebuffMode = {
	["whitelist"] = L["White List"],
	["blacklist"] = L["Black List"],
	["whitelistMine"] = L["White List (Mine)"],
	["blacklistMine"] = L["Black List (Mine)"],
	["all"] = L["All Debuffs"],
	["allMine"] = L["All Debuffs (Mine)"]
}
local totemID = {
	[1] = {8177, "A1", "b8d1ff"},
	[2] = {10595, "A2", "b8d1ff"},
	[3] = {10600, "A2", "b8d1ff"},
	[4] = {10601, "A2", "b8d1ff"},
	[5] = {25574, "A2", "b8d1ff"},
	[6] = {58746, "A2", "b8d1ff"},
	[7] = {58749, "A2", "b8d1ff"},
	[8] = {6495, "A3", "b8d1ff"},
	[9] = {8512, "A4", "b8d1ff"},
	[10] = {3738, "A5", "b8d1ff"},
	[11] = {2062, "E1", "ffb31f"},
	[12] = {2484, "E2", "ffb31f"},
	[13] = {5730, "E3", "ffb31f"},
	[14] = {6390, "E3", "ffb31f"},
	[15] = {6391, "E3", "ffb31f"},
	[16] = {6392, "E3", "ffb31f"},
	[17] = {10427, "E3", "ffb31f"},
	[18] = {10428, "E3", "ffb31f"},
	[19] = {25525, "E3", "ffb31f"},
	[20] = {58580, "E3", "ffb31f"},
	[21] = {58581, "E3", "ffb31f"},
	[22] = {58582, "E3", "ffb31f"},
	[23] = {8071, "E4", "ffb31f"},
	[24] = {8154, "E4", "ffb31f"},
	[25] = {8155, "E4", "ffb31f"},
	[26] = {10406, "E4", "ffb31f"},
	[27] = {10407, "E4", "ffb31f"},
	[28] = {10408, "E4", "ffb31f"},
	[29] = {25508, "E4", "ffb31f"},
	[30] = {25509, "E4", "ffb31f"},
	[31] = {58751, "E4", "ffb31f"},
	[32] = {58753, "E4", "ffb31f"},
	[33] = {8075, "E5", "ffb31f"},
	[34] = {8160, "E5", "ffb31f"},
	[35] = {8161, "E5", "ffb31f"},
	[36] = {10442, "E5", "ffb31f"},
	[37] = {25361, "E5", "ffb31f"},
	[38] = {25528, "E5", "ffb31f"},
	[39] = {57622, "E5", "ffb31f"},
	[40] = {58643, "E5", "ffb31f"},
	[41] = {8143, "E6", "ffb31f"},
	[42] = {2894, "F1", "ff8f8f"},
	[43] = {8227, "F2", "ff8f8f"},
	[44] = {8249, "F2", "ff8f8f"},
	[45] = {10526, "F2", "ff8f8f"},
	[46] = {16387, "F2", "ff8f8f"},
	[47] = {25557, "F2", "ff8f8f"},
	[48] = {58649, "F2", "ff8f8f"},
	[49] = {58652, "F2", "ff8f8f"},
	[50] = {58656, "F2", "ff8f8f"},
	[51] = {8181, "F3", "ff8f8f"},
	[52] = {10478, "F3", "ff8f8f"},
	[53] = {10479, "F3", "ff8f8f"},
	[54] = {25560, "F3", "ff8f8f"},
	[55] = {58741, "F3", "ff8f8f"},
	[56] = {58745, "F3", "ff8f8f"},
	[57] = {8190, "F4", "ff8f8f"},
	[58] = {10585, "F4", "ff8f8f"},
	[59] = {10586, "F4", "ff8f8f"},
	[60] = {10587, "F4", "ff8f8f"},
	[61] = {25552, "F4", "ff8f8f"},
	[62] = {58731, "F4", "ff8f8f"},
	[63] = {58734, "F4", "ff8f8f"},
	[64] = {3599, "F5", "ff8f8f"},
	[65] = {6363, "F5", "ff8f8f"},
	[66] = {6364, "F5", "ff8f8f"},
	[67] = {6365, "F5", "ff8f8f"},
	[68] = {10437, "F5", "ff8f8f"},
	[69] = {10438, "F5", "ff8f8f"},
	[70] = {25533, "F5", "ff8f8f"},
	[71] = {58699, "F5", "ff8f8f"},
	[72] = {58703, "F5", "ff8f8f"},
	[73] = {58704, "F5", "ff8f8f"},
	[74] = {30706, "F6", "ff8f8f"},
	[75] = {57720, "F6", "ff8f8f"},
	[76] = {57721, "F6", "ff8f8f"},
	[77] = {57722, "F6", "ff8f8f"},
	[78] = {8170, "W1", "2b76ff"},
	[79] = {8184, "W2", "2b76ff"},
	[80] = {10537, "W2", "2b76ff"},
	[81] = {10538, "W2", "2b76ff"},
	[82] = {25563, "W2", "2b76ff"},
	[83] = {58737, "W2", "2b76ff"},
	[84] = {58739, "W2", "2b76ff"},
	[85] = {5394, "W3", "2b76ff"},
	[86] = {6375, "W3", "2b76ff"},
	[87] = {6377, "W3", "2b76ff"},
	[88] = {10462, "W3", "2b76ff"},
	[89] = {10463, "W3", "2b76ff"},
	[90] = {25567, "W3", "2b76ff"},
	[91] = {58755, "W3", "2b76ff"},
	[92] = {58756, "W3", "2b76ff"},
	[93] = {58757, "W3", "2b76ff"},
	[94] = {5675, "W4", "2b76ff"},
	[95] = {10495, "W4", "2b76ff"},
	[96] = {10496, "W4", "2b76ff"},
	[97] = {10497, "W4", "2b76ff"},
	[98] = {25570, "W4", "2b76ff"},
	[99] = {58771, "W4", "2b76ff"},
	[100] = {58773, "W4", "2b76ff"},
	[101] = {58774, "W4", "2b76ff"},
	[102] = {16190, "W5", "2b76ff"}
}
StaticPopupDialogs["TPTP Donate"] = {
	text = TidyPlatesThreat.title .. L["\n\nThank you for supporting my work!\n"],
	button1 = ACCEPT,
	hasEditBox = 1,
	editBoxWidth = 350,
	OnShow = function(self)
		self.editBox:SetText("bkader@mail.com")
		self.editBox:SetFocus()
	end,
	OnHide = function(self)
		self.editBox:SetText("")
	end,
	timeout = 30,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["TPTP Discord"] = {
	text = TidyPlatesThreat.title .. "\n\nJoin my Discord for more addons!\n",
	button1 = ACCEPT,
	hasEditBox = 1,
	editBoxWidth = 350,
	OnShow = function(self)
		self.editBox:SetText("https://discord.gg/a8z5CyS3eW")
		self.editBox:SetFocus()
	end,
	OnHide = function(self)
		self.editBox:SetText("")
	end,
	timeout = 30,
	whileDead = 1,
	hideOnEscape = 1
}

-- Shared Media Configs
local Media = LibStub("LibSharedMedia-3.0")
local mediaWidgets = Media and LibStub("AceGUISharedMediaWidgets-1.0", true)
Media:Register("statusbar", "ThreatPlatesBar", [[Interface\Addons\TidyPlates_ThreatPlates\Media\Artwork\TP_BarTexture.tga]])
Media:Register("font", "Accidental Presidency", [[Interface\Addons\TidyPlates_ThreatPlates\Media\Fonts\Accidental Presidency.ttf]])

-- Functions
local function GetSpellName(number)
	return select(1, GetSpellInfo(number))
end

local function Update()
	TidyPlates:ReloadTheme()
	TidyPlates:ForceUpdate()
end

local function UpdateSpecial()
	db.uniqueSettings.list = {}
	for k_c, k_v in pairs(db.uniqueSettings) do
		if db.uniqueSettings[k_c].name then
			if type(db.uniqueSettings[k_c].name) == "string" then
				db.uniqueSettings.list[k_c] = db.uniqueSettings[k_c].name
			end
		end
	end
	Update()
end

local function SplitToTable(...)
	local t = {}
	for index = 1, select("#", ...) do
		local line = select(index, ...)
		if line ~= "" then
			t[line] = true
		end
	end
	return t
end

local function TableToString(t)
	local list = ""
	for i = 1, #t do
		if list then
			if (t[(i + 1)] ~= "") then
				list = list .. (tostring(t[i])) .. "\n"
			else
				list = list .. (tostring(t[i]))
			end
		else
			list = (tostring(t[i])) .. "\n"
		end
	end
	return list
end

local function ThreatDisabled()
	if db.threat.ON then
		return false
	else
		return true
	end
end

-- Saved Variables Only

local function GetValue(info)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	if d then
		return db[a][b][c][d]
	elseif c and not d then
		return db[a][b][c]
	elseif b and not d and not c then
		return db[a][b]
	elseif a and not d and not c and not b then
		return db[a]
	end
end

local function SetValue(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]

	if d then
		db[a][b][c][d] = val
	elseif c and not d then
		db[a][b][c] = val
	elseif b and not d and not c then
		db[a][b] = val
	elseif a and not d and not c and not b then
		db[a] = val
	end
	Update()
end

local function GetValueChar(info)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local t = TidyPlatesThreat.db.char
	if d then
		return t[a][b][c][d]
	elseif c and not d then
		return t[a][b][c]
	elseif b and not d and not c then
		return t[a][b]
	elseif a and not d and not c and not b then
		return t[a]
	end
end

local function SetValueChar(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local t = TidyPlatesThreat.db.char
	if d then
		t[a][b][c][d] = val
	elseif c and not d then
		t[a][b][c] = val
	elseif b and not d and not c then
		t[a][b] = val
	elseif a and not d and not c and not b then
		t[a] = val
	end
	Update()
end

-- Colors

local function GetColor(info)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	return color.r, color.g, color.b, color.a
end

local function SetColor(info, r, g, b)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	color.r, color.g, color.b = r, g, b
	Update()
end

local function GetColorAlpha(info)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	return color.r, color.g, color.b, color.a
end

local function SetColorAlpha(info, r, g, b, a)
	local h, i, j, k = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	local color
	if k then
		color = db[h][i][j][k]
	elseif j and not k then
		color = db[h][i][j]
	elseif i and not j and not k then
		color = db[h][i]
	elseif h and not i and not j and not k then
		color = db[h]
	end
	color.r, color.g, color.b, color.a = r, g, b, a
	Update()
end

-- Set Theme Values

local function SetThemeValue(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i = 1, #themeList do
		TidyPlatesThemeList["Threat Plates"][themeList[i]][b][c] = val
	end
	Update()
end

local function SetThemeValueArt(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i = 1, #themeList do
		TidyPlatesThemeList["Threat Plates"][themeList[i]][b][c] = path .. val
	end
	Update()
end

-- Shared Media

local function SetLSMFont(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i = 1, #themeList do
		TidyPlatesThemeList["Threat Plates"][themeList[i]][b][c] = Media:Fetch("font", db[a][b][c])
	end
	Update()
end

local function SetLSMTexture(info, val)
	local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
	db[a][b][c] = val
	for i = 1, #themeList do
		TidyPlatesThemeList["Threat Plates"][themeList[i]][b][c] = Media:Fetch("statusbar", db[a][b][c])
	end
	Update()
end

local function GetToggleNameplate(info)
	return db.nameplate.toggle[info.arg]
end

local function SetToggleNameplate(info)
	db.nameplate.toggle[info.arg] = not db.nameplate.toggle[info.arg]
	Update()
end

-- Return the Options table
local options = nil
local function GetOptions()
	if not options then
		options = {
			name = TidyPlatesThreat.title,
			handler = TidyPlatesThreat,
			type = "group",
			childGroups = "tab",
			args = {
				-- Config Guide
				NameplateSettings = {
					name = L["Nameplate Settings"],
					type = "group",
					order = 10,
					args = {
						GeneralSettings = {
							name = L["General Settings"],
							type = "group",
							order = 10,
							args = {
								Hiding = {
									name = L["Hiding"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										ShowNeutral = {
											type = "toggle",
											order = 1,
											name = L["Show Neutral"],
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Neutral"
										},
										ShowNormal = {
											type = "toggle",
											order = 2,
											name = L["Show Normal"],
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Normal"
										},
										ShowElite = {
											type = "toggle",
											order = 3,
											name = L["Show Elite"],
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Elite"
										},
										ShowBoss = {
											type = "toggle",
											order = 4,
											name = L["Show Boss"],
											get = GetToggleNameplate,
											set = SetToggleNameplate,
											arg = "Boss"
										}
									}
								},
								BlizzSettings = {
									name = L["Blizzard Settings"],
									type = "group",
									order = 2,
									inline = true,
									args = {
										OpenBlizzardSettings = {
											name = L["Open Blizzard Settings"],
											type = "execute",
											order = 1,
											func = function()
												InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
												LibStub("AceConfigDialog-3.0"):Close("Tidy Plates: Threat Plates")
											end
										},
										Friendly = {
											type = "group",
											name = L["Friendly"],
											order = 2,
											inline = true,
											args = {
												nameplateShowFriends = {
													name = L["Show Friends"],
													type = "toggle",
													order = 1,
													get = function()
														return (GetCVar("nameplateShowFriends") == "1")
													end,
													set = function()
														SetCVar("nameplateShowFriends", abs(GetCVar("nameplateShowFriends") - 1))
													end
												},
												nameplateShowFriendlyTotems = {
													name = L["Show Friendly Totems"],
													type = "toggle",
													order = 2,
													get = function()
														return (GetCVar("nameplateShowFriendlyTotems") == "1")
													end,
													set = function()
														SetCVar("nameplateShowFriendlyTotems", abs(GetCVar("nameplateShowFriendlyTotems") - 1))
													end
												},
												nameplateShowFriendlyPets = {
													name = L["Show Friendly Pets"],
													type = "toggle",
													order = 3,
													get = function()
														return (GetCVar("nameplateShowFriendlyPets") == "1")
													end,
													set = function()
														SetCVar("nameplateShowFriendlyPets", abs(GetCVar("nameplateShowFriendlyPets") - 1))
													end
												},
												nameplateShowFriendlyGuardians = {
													name = L["Show Friendly Guardians"],
													type = "toggle",
													order = 4,
													get = function()
														return (GetCVar("nameplateShowFriendlyGuardians") == "1")
													end,
													set = function()
														SetCVar("nameplateShowFriendlyGuardians", abs(GetCVar("nameplateShowFriendlyGuardians") - 1))
													end
												}
											}
										},
										Enemy = {
											type = "group",
											name = L["Enemy"],
											order = 3,
											inline = true,
											args = {
												nameplateShowEnemies = {
													name = L["Show Enemies"],
													type = "toggle",
													order = 1,
													get = function()
														return (GetCVar("nameplateShowEnemies") == "1")
													end,
													set = function()
														SetCVar("nameplateShowEnemies", abs(GetCVar("nameplateShowEnemies") - 1))
													end
												},
												nameplateShowEnemyTotems = {
													name = L["Show Enemy Totems"],
													type = "toggle",
													order = 2,
													get = function()
														return (GetCVar("nameplateShowEnemyTotems") == "1")
													end,
													set = function()
														SetCVar("nameplateShowEnemyTotems", abs(GetCVar("nameplateShowEnemyTotems") - 1))
													end
												},
												nameplateShowEnemyPets = {
													name = L["Show Enemy Pets"],
													type = "toggle",
													order = 3,
													get = function()
														return (GetCVar("nameplateShowEnemyPets") == "1")
													end,
													set = function()
														SetCVar("nameplateShowEnemyPets", abs(GetCVar("nameplateShowEnemyPets") - 1))
													end
												},
												nameplateShowEnemyGuardians = {
													name = L["Show Enemy Guardians"],
													type = "toggle",
													order = 4,
													get = function()
														return (GetCVar("nameplateShowEnemyGuardians") == "1")
													end,
													set = function()
														SetCVar("nameplateShowEnemyGuardians", abs(GetCVar("nameplateShowEnemyGuardians") - 1))
													end
												}
											}
										}
									}
								}
							}
						},
						HealthBarTexture = {
							name = L["Healthbar"],
							type = "group",
							inline = false,
							order = 20,
							args = {
								Size = {
									name = L["Size"],
									type = "group",
									inline = true,
									order = 0,
									args = {
										Width = {
											type = "range",
											name = L["Width"],
											order = 10,
											get = GetValue,
											set = function(info, val)
												SetThemeValue({arg = {"settings", "healthbar", "width"}}, val)
												SetThemeValue({arg = {"settings", "frame", "width"}}, val + 4)
												SetThemeValue({arg = {"settings", "threatborder", "width"}}, (val * 2) + 20)
												SetThemeValue({arg = {"settings", "highlight", "width"}}, (val * 2) + 20)
												SetThemeValue({arg = {"settings", "healthborder", "width"}}, (val * 2) + 20)
												SetThemeValue({arg = {"settings", "castborder", "width"}}, (val * 2) + 20)
												SetThemeValue({arg = {"settings", "castnostop", "width"}}, (val * 2) + 20)
												SetThemeValue({arg = {"settings", "castbar", "width"}}, val)
												SetThemeValue(info, val)
											end,
											min = 80,
											max = 240,
											step = 0.1,
											bigStep = 1,
											arg = {"settings", "healthbar", "width"}
										},
										Height = {
											type = "range",
											name = L["Height"],
											order = 10,
											get = GetValue,
											set = function(info, val)
												SetThemeValue({arg = {"settings", "healthbar", "height"}}, val)
												SetThemeValue({arg = {"settings", "frame", "height"}}, val + 20)
												SetThemeValue({arg = {"settings", "threatborder", "height"}}, val + 54)
												SetThemeValue({arg = {"settings", "highlight", "height"}}, val + 54)
												SetThemeValue({arg = {"settings", "healthborder", "height"}}, val + 54)
												SetThemeValue({arg = {"settings", "castborder", "height"}}, val + 54)
												SetThemeValue({arg = {"settings", "castnostop", "height"}}, val + 54)
												SetThemeValue(info, val)
											end,
											min = 10,
											max = 20,
											step = 0.1,
											bigStep = 1,
											arg = {"settings", "healthbar", "height"}
										}
									}
								},
								HealthBarGroup = {
									name = L["Textures"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										HealthBarTexture = {
											name = L["Healthbar"],
											type = "select",
											width = "double",
											dialogControl = mediaWidgets and "LSM30_Statusbar" or nil,
											order = 1,
											values = Media:HashTable("statusbar"),
											get = GetValue,
											set = SetLSMTexture,
											arg = {"settings", "healthbar", "texture"}
										},
										Header1 = {
											type = "header",
											order = 1.5,
											name = ""
										},
										HealthBorderToggle = {
											type = "toggle",
											order = 2,
											name = L["Show Border"],
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "healthborder", "show"}
										},
										HealthBorder = {
											type = "select",
											order = 3,
											name = L["Normal Border"],
											get = GetValue,
											set = SetThemeValueArt,
											disabled = function()
												return not db.settings.healthborder.show
											end,
											values = {TP_HealthBarOverlay = "Default", TP_HealthBarOverlayThin = "Thin"},
											arg = {"settings", "healthborder", "texture"}
										},
										Header2 = {
											type = "header",
											order = 3.5,
											name = ""
										},
										EliteHealthBorderToggle = {
											type = "toggle",
											order = 4,
											name = L["Show Elite Border"],
											get = GetValue,
											set = SetValue,
											arg = {"settings", "elitehealthborder", "show"}
										},
										EliteBorder = {
											type = "select",
											order = 5,
											name = L["Elite Border"],
											get = GetValue,
											set = SetValue,
											disabled = function()
												return not db.settings.elitehealthborder.show
											end,
											values = {
												TP_HealthBarEliteOverlay = "Default",
												TP_HealthBarEliteOverlayThin = "Thin"
											},
											arg = {"settings", "elitehealthborder", "texture"}
										},
										Header3 = {
											type = "header",
											order = 5.5,
											name = ""
										},
										Mouseover = {
											type = "select",
											width = "double",
											order = 6,
											name = L["Mouseover"],
											get = GetValue,
											set = SetThemeValueArt,
											values = {TP_HealthBarHighlight = "Default", Empty = "None"},
											arg = {"settings", "highlight", "texture"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 20,
									args = {
										Warning = {
											type = "description",
											descStyle = "inline",
											name = L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"],
											order = 1,
											width = "full"
										},
										OffsetX = {
											name = L["Offset X"],
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 2,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "frame", "x"}
										},
										Offsety = {
											name = L["Offset Y"],
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 3,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "frame", "y"}
										}
									}
								},
								Coloring = {
									name = L["Coloring"],
									type = "group",
									inline = true,
									order = 30,
									args = {
										ColorByHPLevel = {
											name = L["Color HP by amount"],
											type = "toggle",
											desc = L["Changes the HP color depending on the amount of HP the nameplate shows."],
											descStyle = "inline",
											width = "double",
											order = 0,
											get = GetValue,
											set = SetValue,
											arg = {"healthColorChange"}
										},
										ClassColors = {
											name = L["Class Coloring"],
											order = 2,
											type = "group",
											inline = true,
											args = {
												Enemy = {
													name = L["Enemy Class Colors"],
													type = "group",
													inline = true,
													order = 1,
													disabled = function()
														return db.healthColorChange
													end,
													args = {
														Enable = {
															name = L["Enable Enemy Class colors"],
															type = "toggle",
															width = "double",
															get = GetValue,
															set = SetValue,
															order = 1,
															arg = {"allowClass"}
														}
													}
												},
												Friendly = {
													name = L["Friendly Class Colors"],
													type = "group",
													inline = true,
													order = 2,
													disabled = function()
														return db.healthColorChange
													end,
													args = {
														FriendlyClass = {
															name = L["Enable Friendly Class Colors"],
															type = "toggle",
															desc = L["Enable the showing of friendly player class color on hp bars."],
															descStyle = "inline",
															order = 1,
															width = "double",
															get = GetValue,
															set = SetValue,
															arg = {"friendlyClass"}
														},
														FriendlyCaching = {
															name = L["Friendly Caching"],
															type = "toggle",
															desc = L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"],
															descStyle = "inline",
															order = 2,
															width = "double",
															disabled = function()
																return (not db.friendlyClass or db.healthColorChange)
															end,
															get = GetValue,
															set = SetValue,
															arg = {"cacheClass"}
														},
														FriendlyTextOnly = {
															name = L["Name Only"],
															desc = L["Show only names above friendly units."],
															descStyle = "inline",
															type = "toggle",
															width = "double",
															get = GetValue,
															set = SetValue,
															arg = {"friendlyNameOnly"}
														}
													}
												}
											}
										},
										CustomColors = {
											name = L["Custom HP Color"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												Enable = {
													name = L["Enable Custom HP colors"],
													type = "toggle",
													width = "double",
													get = GetValue,
													set = SetValue,
													order = 1,
													arg = {"customColor"}
												},
												Colors = {
													name = "Colors",
													type = "group",
													inline = true,
													order = 2,
													disabled = function()
														return not db.customColor
													end,
													args = {
														FriendlyColor = {
															name = L["Friendly Color"],
															type = "color",
															get = GetColor,
															set = SetColor,
															arg = {"fHPbarColor"}
														},
														NeutralColor = {
															name = L["Neutral Color"],
															type = "color",
															get = GetColor,
															set = SetColor,
															arg = {"nHPbarColor"}
														},
														EnemyColor = {
															name = L["Enemy Color"],
															type = "color",
															get = GetColor,
															set = SetColor,
															arg = {"HPbarColor"}
														}
													}
												}
											}
										},
										RaidMarkColors = {
											name = L["Raid Mark HP Color"],
											order = 4,
											type = "group",
											inline = true,
											args = {
												Enable = {
													name = L["Enable Raid Marked HP colors"],
													type = "toggle",
													width = "double",
													get = GetValue,
													set = SetValue,
													order = 1,
													arg = {"settings", "raidicon", "hpColor"}
												},
												Colors = {
													name = L["Colors"],
													type = "group",
													inline = true,
													order = 2,
													disabled = function()
														return not db.settings.raidicon.hpColor
													end,
													get = GetColor,
													set = SetColor,
													args = {
														STAR = {
															type = "color",
															order = 1,
															name = RAID_TARGET_1,
															arg = {"settings", "raidicon", "hpMarked", "STAR"}
														},
														CIRCLE = {
															type = "color",
															order = 2,
															name = RAID_TARGET_2,
															arg = {"settings", "raidicon", "hpMarked", "CIRCLE"}
														},
														DIAMOND = {
															type = "color",
															order = 3,
															name = RAID_TARGET_3,
															arg = {"settings", "raidicon", "hpMarked", "DIAMOND"}
														},
														TRIANGLE = {
															type = "color",
															order = 4,
															name = RAID_TARGET_4,
															arg = {"settings", "raidicon", "hpMarked", "TRIANGLE"}
														},
														MOON = {
															type = "color",
															order = 5,
															name = RAID_TARGET_5,
															arg = {"settings", "raidicon", "hpMarked", "MOON"}
														},
														SQUARE = {
															type = "color",
															order = 6,
															name = RAID_TARGET_6,
															arg = {"settings", "raidicon", "hpMarked", "SQUARE"}
														},
														CROSS = {
															type = "color",
															order = 7,
															name = RAID_TARGET_7,
															arg = {"settings", "raidicon", "hpMarked", "CROSS"}
														},
														SKULL = {
															type = "color",
															order = 8,
															name = RAID_TARGET_8,
															arg = {"settings", "raidicon", "hpMarked", "SKULL"}
														}
													}
												}
											}
										},
										ThreatColors = {
											name = L["Threat Colors"],
											order = 1,
											type = "group",
											inline = true,
											args = {
												ThreatGlow = {
													type = "toggle",
													width = "double",
													order = 1,
													name = L["Show Threat Glow"],
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "threatborder", "show"}
												},
												Header = {
													name = L["Colors"],
													type = "header",
													order = 2
												},
												Low = {
													name = L["|cff00ff00Low threat|r"],
													type = "color",
													order = 3,
													get = GetColorAlpha,
													set = SetColorAlpha,
													arg = {"settings", "normal", "threatcolor", "LOW"},
													hasAlpha = true
												},
												Med = {
													name = L["|cffffff00Medium threat|r"],
													type = "color",
													order = 4,
													get = GetColorAlpha,
													set = SetColorAlpha,
													arg = {"settings", "normal", "threatcolor", "MEDIUM"},
													hasAlpha = true
												},
												High = {
													name = L["|cffff0000High threat|r"],
													type = "color",
													get = GetColorAlpha,
													set = SetColorAlpha,
													order = 5,
													arg = {"settings", "normal", "threatcolor", "HIGH"},
													hasAlpha = true
												}
											}
										}
									}
								}
							}
						},
						CastBarSettings = {
							name = L["Castbar"],
							type = "group",
							order = 30,
							args = {
								Toggles = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 1,
									args = {
										CastbarToggle = {
											name = L["Enable"],
											type = "toggle",
											order = 1,
											get = function()
												return (GetCVar("ShowVKeyCastbar") == "1")
											end,
											set = function(info, val)
												SetCVar("ShowVKeyCastbar", abs(GetCVar("ShowVKeyCastbar") - 1))
												Update()
											end,
											arg = {"settings", "castbar", "show"}
										},
										Header1 = {
											type = "header",
											name = L["Non-Target Castbars"],
											order = 2
										},
										SmartCastbarsToggle = {
											name = L["Enable"],
											type = "toggle",
											desc = L["This allows the castbar to attempt to create a castbar on nameplates of players or creatures you have recently moused over."],
											descStyle = "inline",
											width = "double",
											order = 4,
											disabled = function()
												return (GetCVar("ShowVKeyCastbar") ~= "1")
											end,
											get = function(info)
												return TidyPlatesOptions.EnableCastWatcher
											end,
											set = function(info, val)
												TidyPlatesOptions.EnableCastWatcher = not TidyPlatesOptions.EnableCastWatcher
												if TidyPlatesOptions.EnableCastWatcher then
													TidyPlates:StartSpellCastWatcher()
												else
													TidyPlates:StopSpellCastWatcher()
												end
											end
										}
									}
								},
								Textures = {
									name = L["Textures"],
									type = "group",
									inline = true,
									order = 1,
									disabled = function()
										return (GetCVar("ShowVKeyCastbar") ~= "1")
									end,
									args = {
										CastBarTexture = {
											name = L["Castbar"],
											type = "select",
											width = "double",
											dialogControl = mediaWidgets and "LSM30_Statusbar" or nil,
											order = 1,
											values = Media:HashTable("statusbar"),
											get = GetValue,
											set = SetLSMTexture,
											arg = {"settings", "castbar", "texture"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return (GetCVar("ShowVKeyCastbar") ~= "1")
									end,
									args = {
										PlacementX = {
											name = L["X"],
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 2,
											get = GetValue,
											set = function(info, val)
												local b1 = {arg = {"settings", "castborder", "x"}}
												local b2 = {arg = {"settings", "castnostop", "x"}}
												SetThemeValue(b1, val)
												SetThemeValue(b2, val)
												SetThemeValue(info, val)
											end,
											arg = {"settings", "castbar", "x"}
										},
										PlacementY = {
											name = L["Y"],
											type = "range",
											min = -60,
											max = 60,
											step = 1,
											order = 3,
											get = GetValue,
											set = function(info, val)
												local b1 = {arg = {"settings", "castborder", "y"}}
												local b2 = {arg = {"settings", "castnostop", "y"}}
												SetThemeValue(b1, val)
												SetThemeValue(b2, val)
												SetThemeValue(info, val)
											end,
											arg = {"settings", "castbar", "y"}
										}
									}
								},
								Coloring = {
									name = L["Coloring"],
									type = "group",
									inline = true,
									order = 30,
									args = {
										Enable = {
											name = L["Enable Coloring"],
											type = "toggle",
											order = 1,
											set = SetValue,
											get = GetValue,
											disabled = function()
												return (GetCVar("ShowVKeyCastbar") ~= "1")
											end,
											arg = {"castbarColor", "toggle"}
										},
										Interruptable = {
											name = L["Interruptable Casts"],
											type = "color",
											order = 2,
											get = GetColorAlpha,
											set = SetColorAlpha,
											disabled = function()
												return (not db.castbarColor.toggle or GetCVar("ShowVKeyCastbar") ~= "1")
											end,
											arg = {"castbarColor"}
										},
										Header1 = {
											type = "header",
											order = 3,
											name = ""
										},
										Enable2 = {
											name = L["Shielded Coloring"],
											type = "toggle",
											order = 4,
											set = SetValue,
											get = GetValue,
											disabled = function()
												return (not db.castbarColor.toggle or GetCVar("ShowVKeyCastbar") ~= "1")
											end,
											arg = {"castbarColorShield", "toggle"}
										},
										Shielded = {
											name = L["Uninterruptable Casts"],
											type = "color",
											order = 5,
											get = GetColorAlpha,
											set = SetColorAlpha,
											disabled = function()
												return (GetCVar("ShowVKeyCastbar") ~= "1" or not db.castbarColor.toggle or not db.castbarColorShield.toggle)
											end,
											arg = {"castbarColorShield"}
										}
									}
								}
							}
						},
						Alpha = {
							name = L["Alpha"],
							type = "group",
							order = 40,
							args = {
								BlizzFadeEnable = {
									name = L["Blizzard Target Fading"],
									type = "group",
									order = 1,
									inline = true,
									get = GetValue,
									set = SetValue,
									args = {
										Enable = {
											name = L["Enable Blizzard 'On-Target' Fading"],
											type = "toggle",
											desc = L["Enabling this will allow you to set the alpha adjustment for non-target nameplates."],
											descStyle = "inline",
											order = 1,
											get = GetValue,
											set = SetValue,
											width = "double",
											arg = {"blizzFade", "toggle"}
										},
										Adjustment = {
											name = L["Non-Target Alpha"],
											type = "range",
											order = 2,
											width = "double",
											disabled = function()
												return not db.blizzFade.toggle
											end,
											min = -1,
											max = 0,
											step = 0.01,
											isPercent = true,
											arg = {"blizzFade", "amount"}
										}
									}
								},
								NameplateAlpha = {
									name = L["Alpha Settings"],
									type = "group",
									order = 2,
									inline = true,
									get = GetValue,
									set = SetValue,
									args = {
										Neutral = {
											type = "range",
											order = 2,
											name = COMBATLOG_FILTER_STRING_NEUTRAL_UNITS,
											arg = {"nameplate", "alpha", "Neutral"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true
										},
										Normal = {
											type = "range",
											order = 3,
											name = PLAYER_DIFFICULTY1,
											arg = {"nameplate", "alpha", "Normal"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true
										},
										Elite = {
											type = "range",
											order = 4,
											name = ELITE,
											arg = {"nameplate", "alpha", "Elite"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true
										},
										Boss = {
											type = "range",
											order = 5,
											name = BOSS,
											arg = {"nameplate", "alpha", "Boss"},
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true
										}
									}
								}
							}
						},
						Scale = {
							name = L["Scale"],
							type = "group",
							order = 50,
							args = {
								NameplateScale = {
									name = L["Scale Settings"],
									type = "group",
									order = 2,
									inline = true,
									get = GetValue,
									set = SetValue,
									args = {
										Neutral = {
											type = "range",
											order = 2,
											name = COMBATLOG_FILTER_STRING_NEUTRAL_UNITS,
											arg = {"nameplate", "scale", "Neutral"},
											step = 0.05,
											min = 0.6,
											max = 1.3,
											isPercent = true
										},
										Normal = {
											type = "range",
											order = 3,
											name = PLAYER_DIFFICULTY1,
											arg = {"nameplate", "scale", "Normal"},
											step = 0.05,
											min = 0.6,
											max = 1.3,
											isPercent = true
										},
										Elite = {
											type = "range",
											order = 4,
											name = ELITE,
											arg = {"nameplate", "scale", "Elite"},
											step = 0.05,
											min = 0.6,
											max = 1.3,
											isPercent = true
										},
										Boss = {
											type = "range",
											order = 5,
											name = BOSS,
											arg = {"nameplate", "scale", "Boss"},
											step = 0.05,
											min = 0.6,
											max = 1.3,
											isPercent = true
										},
										Target = {
											type = "range",
											order = 5,
											name = STATUS_TEXT_TARGET,
											arg = {"nameplate", "scale", "Target"},
											step = 0.05,
											min = 0.6,
											max = 1.3,
											isPercent = true
										}
									}
								}
							}
						},
						Nametext = {
							name = L["Name Text"],
							type = "group",
							order = 60,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Name Text"],
											type = "toggle",
											desc = L["Enables the showing of text on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "name", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.name.show
									end,
									args = {
										FontLooks = {
											name = L["Font"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = L["Font"],
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings", "name", "typeface"}
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = L["Font Style"],
													desc = L["Set the outlining style of the text."],
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "flags"}
												},
												Header1 = {
													type = "header",
													order = 3,
													name = ""
												},
												Color = {
													type = "color",
													order = 3,
													name = L["Color"],
													get = GetColor,
													set = SetColor,
													arg = {"settings", "name", "color"},
													hasAlpha = false
												},
												Shadow = {
													name = L["Enable Shadow"],
													order = 5,
													type = "toggle",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "shadow"}
												}
											}
										},
										FontSize = {
											name = L["Text Bounds and Sizing"],
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = L["Font Size"],
													type = "range",
													width = "double",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false
												},
												TextBounds = {
													name = L["Text Boundaries"],
													type = "group",
													order = 2,
													args = {
														Description = {
															type = "description",
															name = L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."],
															descStyle = "inline",
															order = 1,
															width = "full"
														},
														Width = {
															type = "range",
															order = 2,
															name = L["Text Width"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "name", "width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false
														},
														Height = {
															type = "range",
															order = 3,
															name = L["Text Height"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "name", "height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false
														}
													}
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												AlignH = {
													name = L["Horizontal Align"],
													type = "select",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "align"}
												},
												AlignV = {
													name = L["Vertical Align"],
													type = "select",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "name", "vertical"}
												}
											}
										}
									}
								}
							}
						},
						Healthtext = {
							name = L["Health Text"],
							type = "group",
							order = 70,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Health Text"],
											type = "toggle",
											desc = L["Enables the showing of text on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "customtext", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										if db.settings.customtext.show then
											return false
										else
											return true
										end
									end,
									args = {
										DisplaySettings = {
											name = L["Display Settings"],
											type = "group",
											order = 0,
											inline = true,
											args = {
												Full = {
													name = L["Text at Full HP"],
													type = "toggle",
													order = 0,
													width = "double",
													desc = L["Display health text on targets with full HP."],
													descStyle = "inline",
													get = GetValue,
													set = SetValue,
													arg = {"text", "full"}
												},
												EnablePercent = {
													name = L["Percent Text"],
													type = "toggle",
													order = 1,
													width = "double",
													desc = L["Display health percentage text."],
													descStyle = "inline",
													get = GetValue,
													set = SetValue,
													arg = {"text", "percent"}
												},
												EnableAmount = {
													name = L["Amount Text"],
													type = "toggle",
													order = 2,
													width = "double",
													desc = L["Display health amount text."],
													descStyle = "inline",
													get = GetValue,
													set = SetValue,
													arg = {"text", "amount"}
												},
												AmountSettings = {
													name = L["Amount Text Formatting"],
													type = "group",
													order = 3,
													inline = true,
													get = GetValue,
													set = SetValue,
													disabled = function()
														return not (db.text.amount and db.settings.customtext.show)
													end,
													args = {
														Truncate = {
															name = L["Truncate Text"],
															type = "toggle",
															order = 1,
															width = "double",
															desc = L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact HP amounts."],
															descStyle = "inline",
															arg = {"text", "truncate"}
														},
														MaxHP = {
															name = L["Max HP Text"],
															type = "toggle",
															order = 2,
															width = "double",
															desc = L["This will format text to show both the maximum hp and current hp."],
															descStyle = "inline",
															arg = {"text", "max"}
														},
														Deficit = {
															name = L["Deficit Text"],
															type = "toggle",
															order = 3,
															width = "double",
															desc = L["This will format text to show hp as a value the target is missing."],
															descStyle = "inline",
															arg = {"text", "deficit"}
														}
													}
												}
											}
										},
										FontLooks = {
											name = L["Font"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = L["Font"],
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings", "customtext", "typeface"}
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = L["Font Style"],
													desc = L["Set the outlining style of the text."],
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "flags"}
												},
												Shadow = {
													name = L["Enable Shadow"],
													order = 4,
													type = "toggle",
													width = "double",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "shadow"}
												}
											}
										},
										FontSize = {
											name = L["Text Bounds and Sizing"],
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = L["Font Size"],
													type = "range",
													width = "double",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false
												},
												TextBounds = {
													name = L["Text Boundaries"],
													type = "group",
													order = 2,
													args = {
														Description = {
															type = "description",
															order = 1,
															name = L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."],
															width = "full"
														},
														Width = {
															type = "range",
															order = 2,
															name = L["Text Width"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "customtext", "width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false
														},
														Height = {
															type = "range",
															order = 3,
															name = L["Text Height"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "customtext", "height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false
														}
													}
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												AlignH = {
													name = L["Horizontal Align"],
													type = "select",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "align"}
												},
												AlignV = {
													name = L["Vertical Align"],
													type = "select",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "customtext", "vertical"}
												}
											}
										}
									}
								}
							}
						},
						SpellText = {
							name = L["Spell Text"],
							type = "group",
							order = 80,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Spell Text"],
											type = "toggle",
											desc = L["Enables the showing of text on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "spelltext", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.spelltext.show
									end,
									args = {
										FontLooks = {
											name = L["Font"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = L["Font"],
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings", "spelltext", "typeface"}
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = L["Font Style"],
													desc = L["Set the outlining style of the text."],
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "flags"}
												},
												Shadow = {
													name = L["Enable Shadow"],
													order = 4,
													type = "toggle",
													width = "double",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "shadow"}
												}
											}
										},
										FontSize = {
											name = L["Text Bounds and Sizing"],
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = L["Font Size"],
													type = "range",
													width = "double",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false
												},
												TextBounds = {
													name = L["Text Boundaries"],
													type = "group",
													order = 2,
													args = {
														Description = {
															type = "description",
															order = 1,
															name = L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."],
															width = "full"
														},
														Width = {
															type = "range",
															order = 2,
															name = L["Text Width"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "spelltext", "width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false
														},
														Height = {
															type = "range",
															order = 3,
															name = L["Text Height"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "spelltext", "height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false
														}
													}
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												AlignH = {
													name = L["Horizontal Align"],
													type = "select",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "align"}
												},
												AlignV = {
													name = L["Vertical Align"],
													type = "select",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spelltext", "vertical"}
												}
											}
										}
									}
								}
							}
						},
						Leveltext = {
							name = L["Level Text"],
							type = "group",
							order = 90,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Level Text"],
											type = "toggle",
											desc = L["Enables the showing of text on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "level", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.level.show
									end,
									args = {
										FontLooks = {
											name = L["Font"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Font = {
													name = L["Font"],
													type = "select",
													order = 1,
													dialogControl = "LSM30_Font",
													values = AceGUIWidgetLSMlists.font,
													get = GetValue,
													set = SetLSMFont,
													arg = {"settings", "level", "typeface"}
												},
												FontStyle = {
													type = "select",
													order = 2,
													name = L["Font Style"],
													desc = L["Set the outlining style of the text."],
													values = FontStyle,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "flags"}
												},
												Shadow = {
													name = L["Enable Shadow"],
													order = 4,
													type = "toggle",
													width = "double",
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "shadow"}
												}
											}
										},
										FontSize = {
											name = L["Text Bounds and Sizing"],
											type = "group",
											order = 2,
											inline = true,
											args = {
												FontSize = {
													name = L["Font Size"],
													type = "range",
													width = "double",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "size"},
													max = 36,
													min = 6,
													step = 1,
													isPercent = false
												},
												TextBounds = {
													name = L["Text Boundaries"],
													type = "group",
													order = 2,
													args = {
														Description = {
															type = "description",
															name = L["These settings will define the space that text can be placed on the nameplate.\nHaving too large a font and not enough height will cause the text to be not visible."],
															order = 1,
															width = "full"
														},
														Width = {
															type = "range",
															order = 2,
															name = L["Text Width"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "level", "width"},
															max = 250,
															min = 20,
															step = 1,
															isPercent = false
														},
														Height = {
															type = "range",
															order = 3,
															name = L["Text Height"],
															get = GetValue,
															set = SetThemeValue,
															arg = {"settings", "level", "height"},
															max = 40,
															min = 8,
															step = 1,
															isPercent = false
														}
													}
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												AlignH = {
													name = L["Horizontal Align"],
													type = "select",
													order = 3,
													values = AlignH,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "align"}
												},
												AlignV = {
													name = L["Vertical Align"],
													type = "select",
													order = 4,
													values = AlignV,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "level", "vertical"}
												}
											}
										}
									}
								}
							}
						},
						EliteIcon = {
							name = L["Elite Icon"],
							type = "group",
							order = 100,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Elite Icon"],
											type = "toggle",
											desc = L["Enables the showing of the elite icon on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "eliteicon", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.eliteicon.show
									end,
									args = {
										Texture = {
											name = L["Texture"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Preview = {
													name = L["Preview"],
													type = "execute",
													order = 1,
													image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\" .. db.settings.eliteicon.theme
												},
												Style = {
													type = "select",
													order = 2,
													name = L["Elite Icon Style"],
													values = {
														default = "Default",
														skullandcross = "Skull and Crossbones"
													},
													get = GetValue,
													set = function(info, val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i = 1, #themeList do
															TidyPlatesThemeList["Threat Plates"][themeList[i]][b]["texture"] = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\" .. val
														end
														options.args.NameplateSettings.args.EliteIcon.args.Options.args.Texture.args.Preview.image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\" .. val
														Update()
													end,
													arg = {"settings", "eliteicon", "theme"}
												},
												Header1 = {
													type = "header",
													order = 3,
													name = ""
												},
												Size = {
													name = L["Size"],
													type = "range",
													width = "double",
													order = 4,
													get = GetValue,
													set = function(info, val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i = 1, #themeList do
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["eliteicon"]["width"] = val
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["eliteicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings", "eliteicon", "scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "eliteicon", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "eliteicon", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Anchor = {
													name = L["Anchor"],
													type = "select",
													width = "double",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "eliteicon", "anchor"}
												}
											}
										}
									}
								}
							}
						},
						SkullIcon = {
							name = L["Skull Icon"],
							type = "group",
							order = 110,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Skull Icon"],
											type = "toggle",
											desc = L["Enables the showing of the skull icon on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "skullicon", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.skullicon.show
									end,
									args = {
										Texture = {
											name = L["Texture"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Size = {
													name = L["Size"],
													type = "range",
													width = "double",
													order = 4,
													get = GetValue,
													set = function(info, val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i = 1, #themeList do
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["skullicon"]["width"] = val
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["skullicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings", "skullicon", "scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "skullicon", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "skullicon", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Anchor = {
													name = L["Anchor"],
													type = "select",
													width = "double",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "skullicon", "anchor"}
												}
											}
										}
									}
								}
							}
						},
						SpellIcon = {
							name = L["Spell Icon"],
							type = "group",
							order = 120,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Spell Icon"],
											type = "toggle",
											desc = L["Enables the showing of the spell icon on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "spellicon", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.spellicon.show
									end,
									args = {
										Texture = {
											name = L["Texture"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Size = {
													name = L["Size"],
													type = "range",
													width = "double",
													order = 4,
													get = GetValue,
													set = function(info, val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i = 1, #themeList do
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["spellicon"]["width"] = val
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["spellicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings", "spellicon", "scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spellicon", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spellicon", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Anchor = {
													name = L["Anchor"],
													type = "select",
													width = "double",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "spellicon", "anchor"}
												}
											}
										}
									}
								}
							}
						},
						Raidmarks = {
							name = L["Raid Marks"],
							type = "group",
							order = 130,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable Raid Mark Icon"],
											type = "toggle",
											desc = L["Enables the showing of the raid mark icon on nameplates."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetThemeValue,
											arg = {"settings", "raidicon", "show"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.settings.raidicon.show
									end,
									args = {
										Texture = {
											name = L["Texture"],
											type = "group",
											inline = true,
											order = 1,
											args = {
												Size = {
													name = L["Size"],
													type = "range",
													width = "double",
													order = 4,
													get = GetValue,
													set = function(info, val)
														local a, b, c, d = info.arg[1], info.arg[2], info.arg[3], info.arg[4]
														db[a][b][c] = val
														for i = 1, #themeList do
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["raidicon"]["width"] = val
															TidyPlatesThemeList["Threat Plates"][themeList[i]]["raidicon"]["height"] = val
														end
														Update()
													end,
													arg = {"settings", "raidicon", "scale"},
													max = 64,
													min = 6,
													step = 1,
													isPercent = false
												}
											}
										},
										Placement = {
											name = L["Placement"],
											order = 3,
											type = "group",
											inline = true,
											args = {
												X = {
													name = L["X"],
													type = "range",
													order = 1,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "raidicon", "x"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Y = {
													name = L["Y"],
													type = "range",
													order = 2,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "raidicon", "y"},
													max = 120,
													min = -120,
													step = 1,
													isPercent = false
												},
												Anchor = {
													name = L["Anchor"],
													type = "select",
													width = "double",
													order = 3,
													values = FullAlign,
													get = GetValue,
													set = SetThemeValue,
													arg = {"settings", "raidicon", "anchor"}
												}
											}
										}
									}
								}
							}
						}
					}
				},
				ThreatOptions = {
					name = L["Threat System"],
					type = "group",
					order = 30,
					args = {
						Enable = {
							name = L["Enable Threat System"],
							type = "toggle",
							order = 1,
							get = GetValue,
							set = function(info, val)
								SetValue(info, val)
								local iType = select(2, IsInInstance())
								if iType == "party" or iType == "raid" or iType == "none" then
									db.OldSetting = val
								end
							end,
							arg = {"threat", "ON"}
						},
						GeneralSettings = {
							name = L["General Settings"],
							type = "group",
							order = 0,
							disabled = ThreatDisabled,
							args = {
								AdditionalToggles = {
									name = L["Additional Toggles"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										IgnoreNonCombat = {
											type = "toggle",
											name = L["Ignore Non-Combat Threat"],
											order = 1,
											width = "double",
											desc = L["Disables threat feedback from mobs you're currently not in combat with."],
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat", "nonCombat"}
										},
										Neutral = {
											type = "toggle",
											name = L["Show Neutral Threat"],
											order = 2,
											width = "double",
											desc = L["Disables threat feedback from neutral mobs regardless of boss or elite levels."],
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat", "toggle", "Neutral"}
										},
										Normal = {
											type = "toggle",
											name = L["Show Normal Threat"],
											order = 3,
											width = "double",
											desc = L["Disables threat feedback from normal mobs."],
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat", "toggle", "Normal"}
										},
										Elite = {
											type = "toggle",
											name = L["Show Elite Threat"],
											order = 4,
											width = "double",
											desc = L["Disables threat feedback from elite mobs."],
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat", "toggle", "Elite"}
										},
										Boss = {
											type = "toggle",
											name = L["Show Boss Threat"],
											order = 5,
											width = "double",
											desc = L["Disables threat feedback from boss level mobs."],
											descStyle = "inline",
											set = SetValue,
											get = GetValue,
											arg = {"threat", "toggle", "Boss"}
										}
									}
								}
							}
						},
						Alpha = {
							name = L["Alpha"],
							type = "group",
							desc = L["Set alpha settings for different threat reaction types."],
							disabled = ThreatDisabled,
							get = GetValue,
							set = SetValue,
							order = 1,
							args = {
								Enable = {
									name = L["Enable Alpha Threat"],
									type = "group",
									inline = true,
									order = 0,
									args = {
										Enable = {
											type = "toggle",
											name = L["Enable"],
											desc = L["Enable nameplates to change alpha depending on the levels you set below."],
											width = "double",
											descStyle = "inline",
											order = 2,
											arg = {"threat", "useAlpha"}
										}
									}
								},
								Tank = {
									name = L["|cff00ff00Tank|r"],
									type = "group",
									inline = true,
									order = 1,
									disabled = function()
										return not db.threat.useAlpha
									end,
									args = {
										Low = {
											name = L["|cffff0000Low threat|r"],
											type = "range",
											order = 1,
											arg = {"threat", "tank", "alpha", "LOW"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true
										},
										Med = {
											name = L["|cffffff00Medium threat|r"],
											type = "range",
											order = 2,
											arg = {"threat", "tank", "alpha", "MEDIUM"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true
										},
										High = {
											name = L["|cff00ff00High threat|r"],
											type = "range",
											order = 3,
											arg = {"threat", "tank", "alpha", "HIGH"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true
										}
									}
								},
								DPS = {
									name = L["|cffff0000DPS/Healing|r"],
									type = "group",
									inline = true,
									order = 2,
									disabled = function()
										return not db.threat.useAlpha
									end,
									args = {
										Low = {
											name = L["|cff00ff00Low threat|r"],
											type = "range",
											order = 1,
											arg = {"threat", "dps", "alpha", "LOW"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true
										},
										Med = {
											name = L["|cffffff00Medium threat|r"],
											type = "range",
											order = 2,
											arg = {"threat", "dps", "alpha", "MEDIUM"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true
										},
										High = {
											name = L["|cffff0000High threat|r"],
											type = "range",
											order = 3,
											arg = {"threat", "dps", "alpha", "HIGH"},
											min = 0.01,
											max = 1,
											step = 0.01,
											isPercent = true
										}
									}
								},
								Marked = {
									name = L["Marked Targets"],
									type = "group",
									inline = true,
									order = 3,
									disabled = function()
										return not db.threat.useAlpha
									end,
									args = {
										Toggle = {
											name = L["Ignore Marked Targets"],
											type = "toggle",
											order = 2,
											width = "double",
											desc = L["This will allow you to disabled threat alpha changes on marked targets."],
											descStyle = "inline",
											arg = {"threat", "marked", "alpha"}
										},
										Alpha = {
											name = L["Ignored Alpha"],
											order = 3,
											type = "range",
											disabled = function()
												return not (db.threat.marked.alpha and db.threat.useAlpha)
											end,
											step = 0.05,
											min = 0,
											max = 1,
											isPercent = true,
											arg = {"nameplate", "alpha", "Marked"}
										}
									}
								}
							}
						},
						Scale = {
							name = L["Scale"],
							type = "group",
							desc = L["Set scale settings for different threat reaction types."],
							disabled = ThreatDisabled,
							order = 1,
							get = GetValue,
							set = SetValue,
							args = {
								Enable = {
									name = L["Enable Scale Threat"],
									type = "group",
									inline = true,
									order = 0,
									args = {
										Enable = {
											type = "toggle",
											name = L["Enable"],
											desc = L["Enable nameplates to change scale depending on the levels you set below."],
											descStyle = "inline",
											width = "double",
											order = 2,
											arg = {"threat", "useScale"}
										}
									}
								},
								Tank = {
									name = L["|cff00ff00Tank|r"],
									type = "group",
									inline = true,
									order = 1,
									disabled = function()
										return not db.threat.useScale
									end,
									args = {
										Low = {
											name = L["|cffff0000Low threat|r"],
											type = "range",
											order = 1,
											arg = {"threat", "tank", "scale", "LOW"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true
										},
										Med = {
											name = L["|cffffff00Medium threat|r"],
											type = "range",
											order = 2,
											arg = {"threat", "tank", "scale", "MEDIUM"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true
										},
										High = {
											name = L["|cff00ff00High threat|r"],
											type = "range",
											order = 3,
											arg = {"threat", "tank", "scale", "HIGH"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true
										}
									}
								},
								DPS = {
									name = L["|cffff0000DPS/Healing|r"],
									type = "group",
									inline = true,
									order = 2,
									disabled = function()
										return not db.threat.useScale
									end,
									args = {
										Low = {
											name = L["|cff00ff00Low threat|r"],
											type = "range",
											order = 1,
											arg = {"threat", "dps", "scale", "LOW"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true
										},
										Med = {
											name = L["|cffffff00Medium threat|r"],
											type = "range",
											order = 2,
											arg = {"threat", "dps", "scale", "MEDIUM"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true
										},
										High = {
											name = L["|cffff0000High threat|r"],
											type = "range",
											order = 3,
											arg = {"threat", "dps", "scale", "HIGH"},
											min = 0.01,
											max = 2,
											step = 0.01,
											isPercent = true
										}
									}
								},
								Marked = {
									name = L["Marked Targets"],
									type = "group",
									inline = true,
									order = 3,
									disabled = function()
										return not db.threat.useScale
									end,
									args = {
										Toggle = {
											name = L["Ignore Marked Targets"],
											type = "toggle",
											order = 2,
											width = "double",
											desc = L["This will allow you to disabled threat scale changes on marked targets."],
											descStyle = "inline",
											arg = {"threat", "marked", "scale"}
										},
										Scale = {
											name = L["Ignored Scaling"],
											type = "range",
											order = 3,
											disabled = function()
												return not (db.threat.marked.scale and db.threat.useScale)
											end,
											step = 0.05,
											min = 0.3,
											max = 2,
											isPercent = true,
											arg = {"nameplate", "scale", "Marked"}
										}
									}
								},
								TypeSpecific = {
									name = L["Additional Adjustments"],
									type = "group",
									inline = true,
									order = 4,
									disabled = function()
										return not db.threat.useScale
									end,
									args = {
										Toggle = {
											name = L["Enable Adjustments"],
											order = 1,
											type = "toggle",
											width = "double",
											desc = L["This will allow you to add additional scaling changes to specific mob types."],
											descStyle = "inline",
											arg = {"threat", "useType"}
										},
										AdditionalSliders = {
											name = L["Additional Adjustments"],
											type = "group",
											order = 3,
											inline = true,
											disabled = function()
												return not (db.threat.useType and db.threat.useScale)
											end,
											args = {
												NormalNeutral = {
													name = PLAYER_DIFFICULTY1 .. " & " .. COMBATLOG_FILTER_STRING_NEUTRAL_UNITS,
													order = 1,
													type = "range",
													width = "double",
													arg = {"threat", "scaleType", "Normal"},
													min = -0.5,
													max = 0.5,
													step = 0.01,
													isPercent = true
												},
												Elite = {
													name = ELITE,
													order = 2,
													type = "range",
													width = "double",
													arg = {"threat", "scaleType", "Elite"},
													min = -0.5,
													max = 0.5,
													step = 0.01,
													isPercent = true
												},
												Boss = {
													name = BOSS,
													order = 3,
													type = "range",
													width = "double",
													arg = {"threat", "scaleType", "Boss"},
													min = -0.5,
													max = 0.5,
													step = 0.01,
													isPercent = true
												}
											}
										}
									}
								}
							}
						},
						Coloring = {
							name = L["Coloring"],
							type = "group",
							order = 4,
							disabled = ThreatDisabled,
							args = {
								Toggles = {
									name = L["Toggles"],
									order = 1,
									type = "group",
									inline = true,
									args = {
										UseHPColor = {
											name = L["Color HP by Threat"],
											type = "toggle",
											order = 1,
											desc = L["This allows HP color to be the same as the threat colors you set below."],
											descStyle = "inline",
											get = GetValue,
											set = SetValue,
											width = "double",
											arg = {"threat", "useHPColor"}
										}
									}
								},
								Tank = {
									name = L["|cff00ff00Tank|r"],
									type = "group",
									inline = true,
									get = GetColorAlpha,
									set = SetColorAlpha,
									order = 2,
									disabled = function()
										return not db.threat.useHPColor
									end,
									args = {
										Low = {
											name = L["|cffff0000Low threat|r"],
											type = "color",
											order = 1,
											arg = {"settings", "tank", "threatcolor", "LOW"},
											hasAlpha = true
										},
										Med = {
											name = L["|cffffff00Medium threat|r"],
											type = "color",
											order = 2,
											arg = {"settings", "tank", "threatcolor", "MEDIUM"},
											hasAlpha = true
										},
										High = {
											name = L["|cff00ff00High threat|r"],
											type = "color",
											order = 3,
											arg = {"settings", "tank", "threatcolor", "HIGH"},
											hasAlpha = true
										}
									}
								},
								DPS = {
									name = L["|cffff0000DPS/Healing|r"],
									type = "group",
									inline = true,
									get = GetColorAlpha,
									set = SetColorAlpha,
									order = 3,
									disabled = function()
										return not db.threat.useHPColor
									end,
									args = {
										Low = {
											name = L["|cff00ff00Low threat|r"],
											type = "color",
											order = 1,
											arg = {"settings", "dps", "threatcolor", "LOW"},
											hasAlpha = true
										},
										Med = {
											name = L["|cffffff00Medium threat|r"],
											type = "color",
											order = 2,
											arg = {"settings", "dps", "threatcolor", "MEDIUM"},
											hasAlpha = true
										},
										High = {
											name = L["|cffff0000High threat|r"],
											type = "color",
											order = 3,
											arg = {"settings", "dps", "threatcolor", "HIGH"},
											hasAlpha = true
										}
									}
								}
							}
						},
						Textures = {
							name = L["Textures"],
							type = "group",
							order = 5,
							desc = L["Set threat textures and their coloring options here."],
							disabled = ThreatDisabled,
							args = {
								ThreatArt = {
									name = L["Enable"],
									type = "group",
									order = 1,
									inline = true,
									args = {
										Enable = {
											name = L["Enable"],
											type = "toggle",
											order = 1,
											desc = L["These options are for the textures shown on nameplates at various threat levels."],
											descStyle = "inline",
											width = "double",
											get = GetValue,
											set = SetValue,
											arg = {"threat", "art", "ON"}
										}
									}
								},
								Options = {
									name = L["Art Options"],
									type = "group",
									order = 2,
									inline = true,
									disabled = function()
										return not db.threat.art.ON
									end,
									get = GetValue,
									set = SetValue,
									args = {
										PrevLow = {
											name = L["Low Threat"],
											type = "execute",
											order = 1,
											width = "double",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\" .. db.threat.art.theme .. "\\" .. "HIGH",
											imageWidth = 256,
											imageHeight = 64
										},
										PrevMed = {
											name = L["Medium Threat"],
											type = "execute",
											order = 2,
											width = "double",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\" .. db.threat.art.theme .. "\\" .. "MEDIUM",
											imageWidth = 256,
											imageHeight = 64
										},
										PrevHigh = {
											name = L["High Threat"],
											type = "execute",
											order = 3,
											width = "double",
											image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\" .. db.threat.art.theme .. "\\" .. "LOW",
											imageWidth = 256,
											imageHeight = 64
										},
										Style = {
											name = L["Style"],
											type = "group",
											order = 4,
											inline = true,
											args = {
												Dropdown = {
													name = "",
													type = "select",
													order = 1,
													set = function(info, val)
														SetValue(info, val)
														local i = options.args.ThreatOptions.args.Textures.args.Options.args
														local p = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ThreatWidget\\"
														i.PrevLow.image = p .. db.threat.art.theme .. "\\" .. "HIGH"
														i.PrevMed.image = p .. db.threat.art.theme .. "\\" .. "MEDIUM"
														i.PrevHigh.image = p .. db.threat.art.theme .. "\\" .. "LOW"
													end,
													values = {default = "Default", bar = "Bar Style"},
													arg = {"threat", "art", "theme"}
												}
											}
										},
										Marked = {
											name = L["Marked Targets"],
											type = "group",
											inline = true,
											order = 4,
											args = {
												Toggle = {
													name = L["Ignore Marked Targets"],
													order = 2,
													type = "toggle",
													desc = L["This will allow you to disabled threat art on marked targets."],
													descStyle = "inline",
													width = "double",
													arg = {"threat", "marked", "art"}
												}
											}
										}
									}
								}
							}
						},
						DualSpec = {
							name = L["Dual Spec Roles"],
							type = "group",
							desc = L["Set the role your primary and secondary spec represent."],
							disabled = ThreatDisabled,
							order = 6,
							args = {
								Primary = {
									name = L["Primary Spec"],
									type = "group",
									inline = true,
									order = 1,
									args = {
										Tank = {
											name = L["|cff00ff00Tank|r"],
											type = "toggle",
											order = 1,
											desc = L["Sets your primary spec to tanking."],
											get = function()
												return TidyPlatesThreat.db.char.spec.primary
											end,
											set = function(info, val)
												TidyPlatesThreat.db.char.spec.primary = true
												if GetActiveTalentGroup() == 1 then
													TidyPlatesThreat.db.char.threat.tanking = true
												end
												Update()
											end
										},
										DPS = {
											name = L["|cffff0000DPS/Healing|r"],
											type = "toggle",
											order = 2,
											desc = L["Sets your primary spec to DPS."],
											get = function()
												return not TidyPlatesThreat.db.char.spec.primary
											end,
											set = function(info, val)
												TidyPlatesThreat.db.char.spec.primary = false
												if GetActiveTalentGroup() == 1 then
													TidyPlatesThreat.db.char.threat.tanking = false
												end
												Update()
											end
										}
									}
								},
								Sencondary = {
									name = L["Secondary Spec"],
									type = "group",
									inline = true,
									order = 2,
									args = {
										Tank = {
											name = L["|cff00ff00Tank|r"],
											order = 1,
											type = "toggle",
											desc = L["Sets your secondary spec to tanking."],
											get = function()
												return TidyPlatesThreat.db.char.spec.secondary
											end,
											set = function(info, val)
												TidyPlatesThreat.db.char.spec.secondary = true
												if GetActiveTalentGroup() == 2 then
													TidyPlatesThreat.db.char.threat.tanking = true
												end
												Update()
											end
										},
										DPS = {
											name = L["|cffff0000DPS/Healing|r"],
											order = 2,
											type = "toggle",
											desc = L["Sets your secondary spec to DPS."],
											get = function()
												return not TidyPlatesThreat.db.char.spec.secondary
											end,
											set = function(info, val)
												TidyPlatesThreat.db.char.spec.secondary = false
												if GetActiveTalentGroup() == 2 then
													TidyPlatesThreat.db.char.threat.tanking = false
												end
												Update()
											end
										}
									}
								}
							}
						}
					}
				},
				Widgets = {
					name = L["Widgets"],
					type = "group",
					order = 40,
					args = {
						ClassIconWidget = {
							name = L["Class Icons"],
							type = "group",
							order = 0,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = L["Enable"],
											type = "toggle",
											order = 1,
											desc = L["This widget will display class icons on nameplate with the settings you set below."],
											descStyle = "inline",
											width = "double",
											set = SetValue,
											get = GetValue,
											arg = {"classWidget", "ON"}
										}
									}
								},
								Options = {
									name = L["Options"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return not db.classWidget.ON
									end,
									args = {
										FriendlyClass = {
											name = L["Enable Friendly Icons"],
											type = "toggle",
											desc = L["Enable the showing of friendly player class icons."],
											descStyle = "inline",
											width = "double",
											get = GetValue,
											set = SetValue,
											arg = {"friendlyClassIcon"}
										},
										FriendlyCaching = {
											name = L["Friendly Caching"],
											type = "toggle",
											desc = L["This allows you to save friendly player class information between play sessions or nameplates going off the screen.|cffff0000(Uses more memory)"],
											descStyle = "inline",
											width = "double",
											disabled = function()
												return not (db.friendlyClassIcon and db.classWidget.ON)
											end,
											get = GetValue,
											set = SetValue,
											arg = {"cacheClass"}
										}
									}
								},
								Textures = {
									name = L["Textures"],
									type = "group",
									inline = true,
									order = 30,
									disabled = function()
										return not db.classWidget.ON
									end,
									args = {}
								},
								Sizing = {
									name = L["Scale"],
									type = "group",
									inline = true,
									order = 40,
									disabled = function()
										return not db.classWidget.ON
									end,
									args = {
										ScaleSlider = {
											name = "",
											type = "range",
											set = SetValue,
											get = GetValue,
											arg = {"classWidget", "scale"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 50,
									disabled = function()
										return not db.classWidget.ON
									end,
									args = {
										X = {
											name = L["X"],
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"classWidget", "x"}
										},
										Y = {
											name = L["Y"],
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"classWidget", "y"}
										}
									}
								}
							}
						},
						ComboPointWidget = {
							name = L["Combo Points"],
							type = "group",
							order = 10,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = L["Enable"],
											type = "toggle",
											order = 1,
											desc = L["This widget will display combo points on your target nameplate."],
											descStyle = "inline",
											width = "double",
											set = SetValue,
											get = GetValue,
											arg = {"comboWidget", "ON"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return not db.comboWidget.ON
									end,
									args = {
										X = {
											name = L["X"],
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"comboWidget", "x"}
										},
										Y = {
											name = L["Y"],
											type = "range",
											order = 1,
											set = SetValue,
											get = GetValue,
											min = -120,
											max = 120,
											step = 1,
											arg = {"comboWidget", "y"}
										}
									}
								}
							}
						},
						DebuffWidget = {
							name = L["Debuffs"],
							type = "group",
							order = 20,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = L["Enable"],
											type = "toggle",
											order = 1,
											desc = L["This widget will display debuffs that match your filtering on your target nameplate and others you recently moused over."],
											descStyle = "inline",
											width = "double",
											arg = {"debuffWidget", "ON"}
										}
									}
								},
								Sizing = {
									name = L["Sizing"],
									type = "group",
									order = 15,
									inline = true,
									disabled = function()
										return not db.debuffWidget.ON
									end,
									args = {
										Scale = {
											name = L["Scale"],
											type = "range",
											order = 1,
											width = "double",
											min = 0.6,
											max = 1.3,
											step = 0.05,
											isPercent = true,
											arg = {"debuffWidget", "scale"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return not db.debuffWidget.ON
									end,
									args = {
										X = {
											name = L["X"],
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"debuffWidget", "x"}
										},
										Y = {
											name = L["Y"],
											type = "range",
											order = 2,
											min = -120,
											max = 120,
											step = 1,
											arg = {"debuffWidget", "y"}
										},
										Anchor = {
											name = L["Anchor"],
											type = "select",
											order = 3,
											values = FullAlign,
											arg = {"debuffWidget", "anchor"}
										}
									}
								},
								Filtering = {
									name = L["Filtering"],
									order = 30,
									type = "group",
									inline = true,
									disabled = function()
										return not db.debuffWidget.ON
									end,
									args = {
										Mode = {
											name = L["Mode"],
											type = "select",
											order = 1,
											width = "double",
											values = DebuffMode,
											arg = {"debuffWidget", "mode"}
										},
										DebuffList = {
											name = L["Filtered Debuffs"],
											type = "input",
											order = 2,
											dialogControl = "MultiLineEditBox",
											width = "double",
											get = function(info)
												local list = db.debuffWidget.filter
												return TableToString(list)
											end,
											set = function(info, v)
												local table = {strsplit("\n", v)}
												db.debuffWidget.filter = table
											end
										}
									}
								}
							}
						},
						SocialWidget = {
							name = L["Social Widget"],
							type = "group",
							order = 30,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = L["Enable"],
											type = "toggle",
											desc = L["Enables the showing if indicator icons for friends, guildmates, and BNET Friends"],
											descStyle = "inline",
											width = "double",
											order = 1,
											arg = {"socialWidget", "ON"}
										}
									}
								},
								Sizing = {
									name = L["Scale"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return not db.socialWidget.ON
									end,
									args = {
										ScaleSlider = {
											name = "",
											type = "range",
											arg = {"socialWidget", "scale"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 30,
									disabled = function()
										return not db.socialWidget.ON
									end,
									args = {
										X = {
											name = L["X"],
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"socialWidget", "x"}
										},
										Y = {
											name = L["Y"],
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"socialWidget", "y"}
										}
									}
								}
							}
						},
						ThreatLineWidget = {
							name = L["Threat Line"],
							type = "group",
							order = 40,
							set = SetValue,
							get = GetValue,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = L["Enable"],
											type = "toggle",
											order = 1,
											desc = L["This widget will display a small bar that will display your current threat relative to other players on your target nameplate or recently mousedover namplates."],
											descStyle = "inline",
											width = "double",
											arg = {"threatWidget", "ON"}
										}
									}
								},
								Placement = {
									name = L["Placement"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return not db.threatWidget.ON
									end,
									args = {
										X = {
											name = L["X"],
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"threatWidget", "x"}
										},
										Y = {
											name = L["Y"],
											type = "range",
											order = 1,
											min = -120,
											max = 120,
											step = 1,
											arg = {"threatWidget", "y"}
										},
										Anchor = {
											name = L["Anchor"],
											type = "select",
											order = 4,
											values = FullAlign,
											arg = {"threatWidget", "anchor"}
										}
									}
								}
							}
						},
						TargetArtWidget = {
							name = L["Target Highlight"],
							type = "group",
							order = 60,
							args = {
								Enable = {
									name = L["Enable"],
									type = "group",
									inline = true,
									order = 10,
									args = {
										Toggle = {
											name = L["Enable"],
											type = "toggle",
											desc = L["Enables the showing of a texture on your target nameplate"],
											descStyle = "inline",
											width = "double",
											order = 1,
											set = SetValue,
											get = GetValue,
											arg = {"targetWidget", "ON"}
										}
									}
								},
								Style = {
									name = L["Style"],
									type = "group",
									inline = true,
									order = 20,
									disabled = function()
										return not db.targetWidget.ON
									end,
									args = {
										Width = {
											type = "range",
											name = L["Width"],
											order = 10,
											get = GetValue,
											set = SetValue,
											min = 10,
											max = 80,
											step = 0.1,
											bigStep = 1,
											arg = {"targetWidget", "width"}
										},
										Height = {
											type = "range",
											name = L["Height"],
											order = 20,
											get = GetValue,
											set = SetValue,
											min = 10,
											max = 80,
											step = 0.1,
											bigStep = 1,
											arg = {"targetWidget", "height"}
										},
										Color = {
											name = L["Color"],
											type = "color",
											order = 30,
											get = GetColorAlpha,
											set = SetColorAlpha,
											hasAlpha = true,
											arg = {"targetWidget"}
										},
										Invert = {
											type = "toggle",
											name = L["Invert Texture"],
											order = 40,
											get = GetValue,
											set = SetValue,
											arg = {"targetWidget", "inverted"}
										},
									}
								},
								Texture = {
									name = L["Texture"],
									type = "multiselect",
									width = "half",
									order = 30,
									disabled = function()
										return not db.targetWidget.ON
									end,
									get = function(info, key)
										return db.targetWidget.theme == key
									end,
									set = function(info, val)
										SetValue(info, val)
									end,
									arg = {"targetWidget", "theme"}
								}
							}
						}
					}
				},
				Totems = {
					name = L["Totem Nameplates"],
					type = "group",
					childGroups = "list",
					order = 50,
					args = {}
				},
				Custom = {
					name = L["Custom Nameplates"],
					type = "group",
					childGroups = "list",
					order = 60,
					args = {}
				},
				About = {
					name = L["About"],
					type = "group",
					order = 80,
					args = {
						Donate = {
							name = L["Click to Donate!"],
							type = "execute",
							order = 1,
							width = "double",
							image = path .. "Logo2",
							imageWidth = 256,
							imageHeight = 32,
							func = function()
								StaticPopup_Show("TPTP Donate")
							end
						},
						AboutInfo = {
							type = "description",
							name = L["Clear and easy to use nameplate theme for use with TidyPlates.\n\nFeel free to email me at |cff00ff00bkader@mail.com|r"],
							order = 2,
							width = "double",
						},
						Header1 = {
							order = 3,
							type = "header",
							name = "Translators"
						},
						Translators1 = {
							type = "description",
							name = "deDE: Aideen@Perenolde/EU",
							order = 4,
							width = "full"
						},
						Translators2 = {
							type = "description",
							name = "esES: Need Translator!!",
							order = 5,
							width = "full"
						},
						Translators3 = {
							type = "description",
							name = "esMX: Need Translator!!",
							order = 6,
							width = "full"
						},
						Translators4 = {
							type = "description",
							name = "frFR: Need Translator!!",
							order = 7,
							width = "full"
						},
						Translators5 = {
							type = "description",
							name = "koKR: Need Translator!!",
							order = 8,
							width = "full"
						},
						Translators6 = {
							type = "description",
							name = "ruRU: Need Translator!!",
							order = 9,
							width = "full",
						},
						Translators7 = {
							type = "description",
							name = "zhCN: Samonyoge@TW-狂熱之刃",
							order = 10,
							width = "full"
						},
						Translators8 = {
							type = "description",
							name = "zhTW: Samonyoge@TW-狂熱之刃",
							order = 11,
							width = "full",
						},
						seperator = {
							type = "description",
							name = " ",
							order = 12,
							width = "full"
						},
						backporter = {
							type = "header",
							name = "Backported by |cfff58cbaKader|r",
							order = 13
						},
						Discord = {
							name = "Join Discord",
							desc = "Join my Discord for more addons!",
							type = "execute",
							order = 14,
							width = "full",
							func = function()
								StaticPopup_Show("TPTP Discord")
							end
						}
					}
				}
			}
		}
	end
	local ClassOpts_OrderCount = 1
	local ClassOpts = {
		Style = {
			name = "Style",
			order = -1,
			type = "select",
			width = "double",
			get = GetValue,
			set = function(info, val)
				SetValue(info, val)
				for k_c, v_c in pairs(CLASS_SORT_ORDER) do
					options.args.Widgets.args.ClassIconWidget.args.Textures.args["Prev" .. k_c].image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ClassIconWidget\\" .. db.classWidget.theme .. "\\" .. CLASS_SORT_ORDER[k_c]
				end
			end,
			values = {default = "Default", transparent = "Transparent"},
			arg = {"classWidget", "theme"}
		}
	}
	for k_c, v_c in pairs(CLASS_SORT_ORDER) do
		ClassOpts["Prev" .. k_c] = {
			name = CLASS_SORT_ORDER[k_c],
			type = "execute",
			order = ClassOpts_OrderCount,
			image = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\ClassIconWidget\\" .. db.classWidget.theme .. "\\" .. CLASS_SORT_ORDER[k_c]
		}
		ClassOpts_OrderCount = ClassOpts_OrderCount + 1
	end
	options.args.Widgets.args.ClassIconWidget.args.Textures.args = ClassOpts
	local TotemOpts = {
		TotemSettings = {
			name = L["|cffffffffTotem Settings|r"],
			type = "group",
			order = 10,
			args = {
				Toggles = {
					name = L["Toggling"],
					type = "group",
					order = 1,
					inline = true,
					args = {
						HideHealth = {
							name = L["Hide Healthbars"],
							type = "toggle",
							order = 1,
							get = GetValue,
							set = SetValue,
							arg = {"totemSettings", "hideHealthbar"}
						},
						Header1 = {
							type = "header",
							order = 2,
							name = ""
						},
						ShowEnemy = {
							name = L["Show Enemy Totems"],
							type = "toggle",
							order = 3,
							get = function()
								return (GetCVar("nameplateShowEnemyTotems") == "1")
							end,
							set = function()
								SetCVar("nameplateShowEnemyTotems", abs(GetCVar("nameplateShowEnemyTotems") - 1))
							end
						},
						ShowFriend = {
							name = L["Show Friendly Totems"],
							type = "toggle",
							order = 4,
							get = function()
								return (GetCVar("nameplateShowFriendlyTotems") == "1")
							end,
							set = function()
								SetCVar("nameplateShowFriendlyTotems", abs(GetCVar("nameplateShowFriendlyTotems") - 1))
							end
						}
					}
				},
				Icon = {
					name = L["Icon"],
					type = "group",
					order = 2,
					inline = true,
					args = {
						Enable = {
							name = L["Enable"],
							type = "toggle",
							order = 1,
							set = SetValue,
							get = GetValue,
							arg = {"totemWidget", "ON"}
						},
						Options = {
							name = L["Options"],
							type = "group",
							inline = true,
							order = 2,
							disabled = function()
								return not db.totemWidget.ON
							end,
							set = SetValue,
							get = GetValue,
							args = {
								Header1 = {
									type = "header",
									order = 1,
									name = L["Placement"]
								},
								X = {
									name = L["X"],
									type = "range",
									order = 2,
									min = -120,
									max = 120,
									step = 1,
									arg = {"totemWidget", "x"}
								},
								Y = {
									name = L["Y"],
									type = "range",
									order = 3,
									min = -120,
									max = 120,
									step = 1,
									arg = {"totemWidget", "y"}
								},
								Anchor = {
									name = L["Anchor"],
									type = "select",
									order = 4,
									values = FullAlign,
									arg = {"totemWidget", "anchor"}
								},
								Header2 = {
									type = "header",
									order = 4,
									name = ""
								},
								Scale = {
									name = L["Icon Size"],
									type = "range",
									width = "double",
									order = 5,
									min = 0,
									max = 120,
									step = 1,
									arg = {"totemWidget", "scale"}
								}
							}
						}
					}
				},
				Alpha = {
					name = L["Alpha"],
					type = "group",
					order = 3,
					inline = true,
					get = GetValue,
					set = SetValue,
					args = {
						TotemAlpha = {
							name = L["Totem Alpha"],
							order = 1,
							type = "range",
							width = "double",
							arg = {"nameplate", "alpha", "Totem"},
							step = 0.05,
							min = 0,
							max = 1,
							isPercent = true
						}
					}
				},
				Scale = {
					name = L["Scale"],
					type = "group",
					order = 4,
					inline = true,
					get = GetValue,
					set = SetValue,
					args = {
						TotemAlpha = {
							name = L["Totem Scale"],
							order = 1,
							type = "range",
							width = "double",
							arg = {"nameplate", "scale", "Totem"},
							step = 0.05,
							min = 0.6,
							max = 1.3,
							isPercent = true
						}
					}
				}
			}
		}
	}
	local TotemOpts_OrderCnt = 30
	for k_c, v_c in ipairs(totemID) do
		local totemName = GetSpellInfo(totemID[k_c][1])
		TotemOpts[totemName] = {
			name = "|cff" .. totemID[k_c][3] .. totemName .. "|r",
			type = "group",
			order = TotemOpts_OrderCnt,
			args = {
				Header = {
					name = "> |cff" .. totemID[k_c][3] .. totemName .. "|r <",
					type = "header",
					order = 0
				},
				Enabled = {
					name = L["Enable"],
					type = "group",
					inline = true,
					order = 1,
					args = {
						Toggle = {
							name = L["Show Nameplate"],
							type = "toggle",
							set = SetValue,
							get = GetValue,
							arg = {"totemSettings", totemID[k_c][2], 1}
						}
					}
				},
				HealthColor = {
					name = L["Health Coloring"],
					type = "group",
					order = 2,
					inline = true,
					disabled = function()
						return not db.totemSettings[totemID[k_c][2]][1]
					end,
					args = {
						Enable = {
							name = L["Enable Custom Colors"],
							type = "toggle",
							order = 1,
							get = GetValue,
							set = SetValue,
							arg = {"totemSettings", totemID[k_c][2], 2}
						},
						Color = {
							name = L["Color"],
							type = "color",
							order = 2,
							get = GetColor,
							set = SetColor,
							disabled = function()
								return not (db.totemSettings[totemID[k_c][2]][1] and db.totemSettings[totemID[k_c][2]][2])
							end,
							arg = {"totemSettings", totemID[k_c][2], "color"}
						}
					}
				},
				Textures = {
					name = L["Textures"],
					type = "group",
					order = 3,
					inline = true,
					disabled = function()
						return not db.totemSettings[totemID[k_c][2]][1]
					end,
					args = {
						Icon = {
							name = "",
							type = "execute",
							width = "double",
							order = 0,
							image = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\" .. db.totemSettings[totemID[k_c][2]][7] .. "\\" .. totemID[k_c][2]
						},
						Style = {
							name = "",
							type = "select",
							order = 1,
							width = "double",
							get = GetValue,
							set = function(info, val)
								SetValue(info, val)
								options.args.Totems.args[totemName].args.Textures.args.Icon.image = "Interface\\Addons\\TidyPlates_ThreatPlates\\Widgets\\TotemIconWidget\\" .. db.totemSettings[totemID[k_c][2]][7] .. "\\" .. totemID[k_c][2]
							end,
							values = {normal = "Normal", special = "Special"},
							arg = {"totemSettings", totemID[k_c][2], 7}
						}
					}
				}
			}
		}
		TotemOpts_OrderCnt = TotemOpts_OrderCnt + 10
	end
	options.args.Totems.args = TotemOpts
	local CustomOpts_OrderCnt = 30
	local CustomOpts = {
		GeneralSettings = {
			name = L["|cffffffffGeneral Settings|r"],
			type = "group",
			order = 10,
			args = {
				Icon = {
					name = L["Icon"],
					type = "group",
					order = 1,
					inline = true,
					args = {
						Enable = {
							name = L["Enable"],
							type = "toggle",
							desc = L["Disabling this will turn off any all icons without harming custom settings per nameplate."],
							descStyle = "inline",
							width = "double",
							order = 1,
							set = SetValue,
							get = GetValue,
							arg = {"uniqueWidget", "ON"}
						},
						Options = {
							name = L["Options"],
							type = "group",
							inline = true,
							order = 2,
							disabled = function()
								return not db.uniqueWidget.ON
							end,
							set = SetValue,
							get = GetValue,
							args = {
								Header1 = {
									type = "header",
									order = 1,
									name = L["Placement"]
								},
								X = {
									name = L["Y"],
									type = "range",
									order = 2,
									min = -120,
									max = 120,
									step = 1,
									arg = {"uniqueWidget", "x"}
								},
								Y = {
									name = L["Y"],
									type = "range",
									order = 3,
									min = -120,
									max = 120,
									step = 1,
									arg = {"uniqueWidget", "y"}
								},
								Anchor = {
									name = L["Anchor"],
									type = "select",
									order = 4,
									values = FullAlign,
									arg = {"uniqueWidget", "anchor"}
								},
								Header2 = {
									type = "header",
									order = 4,
									name = L["Sizing"]
								},
								Scale = {
									name = "",
									type = "range",
									order = 5,
									min = 0,
									max = 120,
									step = 1,
									arg = {"uniqueWidget", "scale"}
								}
							}
						}
					}
				}
			}
		}
	}
	CustomOpts_OrderCnt = 30
	local clipboard = nil
	for k_c, v_c in ipairs(db.uniqueSettings) do
		CustomOpts["#" .. k_c] = {
			name = "#" .. k_c .. ". " .. db.uniqueSettings[k_c].name,
			type = "group",
			order = CustomOpts_OrderCnt,
			args = {
				Header = {
					name = db.uniqueSettings[k_c].name,
					type = "header",
					order = 0
				},
				Name = {
					name = L["Set Name"],
					order = 1,
					type = "group",
					inline = true,
					args = {
						SetName = {
							name = db.uniqueSettings[k_c].name,
							type = "input",
							order = 1,
							width = "double",
							get = GetValue,
							set = function(info, val)
								SetValue(info, val)
								options.args.Custom.args["#" .. k_c].name = "#" .. k_c .. ". " .. val
								options.args.Custom.args["#" .. k_c].args.Header.name = val
								options.args.Custom.args["#" .. k_c].args.Name.args.SetName.name = val
								UpdateSpecial()
							end,
							arg = {"uniqueSettings", k_c, "name"}
						},
						TargetButton = {
							name = L["Use Target's Name"],
							type = "execute",
							order = 2,
							width = "single",
							func = function()
								if UnitExists("Target") then
									local target = UnitName("Target")
									db.uniqueSettings[k_c].name = target
									options.args.Custom.args["#" .. k_c].name = "#" .. k_c .. ". " .. target
									options.args.Custom.args["#" .. k_c].args.Header.name = target
									options.args.Custom.args["#" .. k_c].args.Name.args.SetName.name = target
									UpdateSpecial()
								else
									if db.verbose then
										print(GetAddOnMetadata("TidyPlates_ThreatPlates", "Title") .. ": " .. L["No target found."])
									end
								end
							end
						},
						ClearButton = {
							name = L["Clear"],
							type = "execute",
							order = 3,
							width = "single",
							func = function()
								db.uniqueSettings[k_c].name = ""
								options.args.Custom.args["#" .. k_c].name = "#" .. k_c .. ". " .. ""
								options.args.Custom.args["#" .. k_c].args.Header.name = ""
								options.args.Custom.args["#" .. k_c].args.Name.args.SetName.name = ""
								UpdateSpecial()
							end
						},
						Header1 = {
							name = "",
							order = 4,
							type = "header"
						},
						Copy = {
							name = L["Copy"],
							order = 5,
							type = "execute",
							func = function()
								clipboard = db.uniqueSettings[k_c]
								if type(clipboard) == "table" and db.verbose then
									print(GetAddOnMetadata("TidyPlates_ThreatPlates", "Title") .. ": " .. L["Copied!"])
								end
							end
						},
						Paste = {
							name = L["Paste"],
							order = 6,
							type = "execute",
							func = function()
								if type(clipboard) == "table" then
									db.uniqueSettings[k_c] = clipboard
									if db.verbose then
										print(GetAddOnMetadata("TidyPlates_ThreatPlates", "Title") .. ": " .. L["Pasted!"])
									end
								else
									if db.verbose then
										print(GetAddOnMetadata("TidyPlates_ThreatPlates", "Title") .. ": " .. L["Nothing to paste!"])
									end
								end
								options.args.Custom.args["#" .. k_c].name = "#" .. k_c .. ". " .. db.uniqueSettings[k_c].name
								options.args.Custom.args["#" .. k_c].args.Header.name = db.uniqueSettings[k_c].name
								options.args.Custom.args["#" .. k_c].args.Name.args.SetName.name = db.uniqueSettings[k_c].name
								if tonumber(db.uniqueSettings[k_c].icon) == nil then
									options.args.Custom.args["#" .. k_c].args.Icon.args.Icon.image = db.uniqueSettings[k_c].icon
								else
									local icon = select(3, GetSpellInfo(tonumber(db.uniqueSettings[k_c].icon)))
									if icon then
										options.args.Custom.args["#" .. k_c].args.Icon.args.Icon.image = icon
									else
										options.args.Custom.args["#" .. k_c].args.Icon.args.Icon.image = "Interface\\Icons\\Temp"
									end
								end
								UpdateSpecial()
								clipboard = nil
							end
						},
						Header2 = {
							name = "",
							order = 7,
							type = "header"
						},
						ResetDefault = {
							type = "execute",
							name = L["Restore Defaults"],
							order = 8,
							func = function()
								local defaults = {
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
								}
								db.uniqueSettings[k_c] = defaults
								options.args.Custom.args["#" .. k_c].name = "#" .. k_c .. ". " .. ""
								options.args.Custom.args["#" .. k_c].args.Header.name = ""
								options.args.Custom.args["#" .. k_c].args.Name.args.SetName.name = ""
								options.args.Custom.args["#" .. k_c].args.Icon.args.Icon.image = ""
								UpdateSpecial()
							end
						}
					}
				},
				Enabled = {
					name = L["Enable"],
					type = "group",
					inline = true,
					order = 2,
					args = {
						UseStyle = {
							name = L["Use Custom Settings"],
							type = "toggle",
							order = 1,
							set = SetValue,
							get = GetValue,
							arg = {"uniqueSettings", k_c, "useStyle"}
						},
						Header1 = {
							type = "header",
							order = 2,
							name = ""
						},
						Namplate = {
							name = L["Show Nameplate"],
							type = "toggle",
							disabled = function()
								return not db.uniqueSettings[k_c].useStyle
							end,
							order = 3,
							set = SetValue,
							get = GetValue,
							arg = {"uniqueSettings", k_c, "showNameplate"}
						},
						CustomSettings = {
							name = L["Custom Settings"],
							type = "group",
							inline = true,
							order = 4,
							disabled = function()
								return (not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate)
							end,
							args = {
								AlphaSettings = {
									name = L["Alpha"],
									type = "group",
									order = 1,
									inline = true,
									set = SetValue,
									get = GetValue,
									args = {
										DisableOverride = {
											name = L["Disable Custom Alpha"],
											type = "toggle",
											desc = L["Disables the custom alpha setting for this nameplate and instead uses your normal alpha settings."],
											descStyle = "inline",
											width = "double",
											order = 1,
											arg = {"uniqueSettings", k_c, "overrideAlpha"}
										},
										AlphaSetting = {
											name = L["Custom Alpha"],
											type = "range",
											order = 2,
											disabled = function()
												return (db.uniqueSettings[k_c].overrideAlpha or not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate)
											end,
											min = 0,
											max = 1,
											step = 0.05,
											isPercent = true,
											arg = {"uniqueSettings", k_c, "alpha"}
										}
									}
								},
								ScaleSettings = {
									name = L["Scale"],
									type = "group",
									order = 1,
									inline = true,
									set = SetValue,
									get = GetValue,
									args = {
										DisableOverride = {
											name = L["Disable Custom Scale"],
											type = "toggle",
											desc = L["Disables the custom scale setting for this nameplate and instead uses your normal scale settings."],
											descStyle = "inline",
											width = "double",
											order = 1,
											arg = {"uniqueSettings", k_c, "overrideScale"}
										},
										ScaleSetting = {
											name = L["Custom Scale"],
											type = "range",
											order = 2,
											disabled = function()
												return (db.uniqueSettings[k_c].overrideScale or not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate)
											end,
											min = 0,
											max = 1.4,
											step = 0.05,
											isPercent = true,
											arg = {"uniqueSettings", k_c, "scale"}
										}
									}
								},
								HealthColor = {
									name = L["Health Coloring"],
									type = "group",
									order = 3,
									inline = true,
									args = {
										UseRaidMarked = {
											name = L["Allow Marked HP Coloring"],
											type = "toggle",
											desc = L["Allow raid marked hp color settings instead of a custom hp setting if the nameplate has a raid mark."],
											descStyle = "inline",
											width = "double",
											order = 1,
											get = GetValue,
											set = SetValue,
											arg = {"uniqueSettings", k_c, "allowMarked"}
										},
										Enable = {
											name = L["Enable Custom Colors"],
											type = "toggle",
											order = 2,
											width = "double",
											get = GetValue,
											set = SetValue,
											arg = {"uniqueSettings", k_c, "useColor"}
										},
										Color = {
											name = L["Color"],
											type = "color",
											order = 3,
											get = GetColor,
											set = SetColor,
											disabled = function()
												return (not db.uniqueSettings[k_c].useColor or not db.uniqueSettings[k_c].useStyle or not db.uniqueSettings[k_c].showNameplate)
											end,
											arg = {"uniqueSettings", k_c, "color"}
										}
									}
								}
							}
						}
					}
				},
				Icon = {
					name = L["Icon"],
					type = "group",
					order = 3,
					inline = true,
					disabled = function()
						return (not db.uniqueWidget.ON or not db.uniqueSettings[k_c].showNameplate)
					end,
					args = {
						Enable = {
							name = L["Enable"],
							type = "toggle",
							order = 1,
							desc = L["Enable the showing of the custom nameplate icon for this nameplate."],
							descStyle = "inline",
							width = "double",
							get = GetValue,
							set = SetValue,
							arg = {"uniqueSettings", k_c, "showIcon"}
						},
						Icon = {
							name = L["Preview"],
							type = "execute",
							width = "double",
							disabled = function()
								return (not db.uniqueSettings[k_c].showIcon or not db.uniqueWidget.ON or not db.uniqueSettings[k_c].showNameplate)
							end,
							order = 2,
							image = function()
								if tonumber(db.uniqueSettings[k_c].icon) == nil then
									return db.uniqueSettings[k_c].icon
								else
									return select(3, GetSpellInfo(tonumber(db.uniqueSettings[k_c].icon))) or "Interface\\Icons\\Temp"
								end
							end,
							imageWidth = 64,
							imageHeight = 64
						},
						Description = {
							type = "description",
							order = 3,
							name = L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."],
							width = "full"
						},
						SetIcon = {
							name = L["Set Icon"],
							type = "input",
							order = 4,
							disabled = function()
								return (not db.uniqueSettings[k_c].showIcon or not db.uniqueWidget.ON or not db.uniqueSettings[k_c].showNameplate)
							end,
							width = "double",
							get = GetValue,
							set = function(info, val)
								SetValue(info, val)
								if tonumber(val) == nil then
									options.args.Custom.args["#" .. k_c].args.Icon.args.Icon.image = val
								else
									local icon = select(3, GetSpellInfo(tonumber(db.uniqueSettings[k_c].icon))) or "Interface\\Icons\\Temp"
									options.args.Custom.args["#" .. k_c].args.Icon.args.Icon.image = icon
								end
								UpdateSpecial()
							end,
							arg = {"uniqueSettings", k_c, "icon"}
						}
					}
				}
			}
		}
		CustomOpts_OrderCnt = CustomOpts_OrderCnt + 10
	end
	options.args.Custom.args = CustomOpts

	do
		local arrows = {}
		options.args.Widgets.args.TargetArtWidget.args.Texture.values = arrows
		for i = 0, 72 do
			arrows["arrow" .. i] = "|TInterface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\TargetArtWidget\\arrow" .. i .. ".tga:45:45|t"
		end
	end

	return options
end

local intoptions = nil
local function GetIntOptions()
	if not intoptions then
		intoptions = {
			name = TidyPlatesThreat.title,
			handler = TidyPlatesThreat,
			type = "group",
			args = {
				note = {
					type = "description",
					name = L["You can access the "] .. TidyPlatesThreat.title .. L[" options by typing: /tptp"],
					order = 10
				},
				openoptions = {
					type = "execute",
					name = L["Open Config"],
					image = path .. "Logo",
					width = "double",
					imageWidth = 256,
					imageHeight = 32,
					func = function()
						TidyPlatesThreat:OpenOptions()
					end,
					order = 20
				}
			}
		}
	end
	return intoptions
end

function TidyPlatesThreat:OpenOptions()
	HideUIPanel(InterfaceOptionsFrame)
	HideUIPanel(GameMenuFrame)
	if not options then
		TidyPlatesThreat:SetUpOptions()
	end
	LibStub("AceConfigDialog-3.0"):Open("Tidy Plates: Threat Plates")
end

function TidyPlatesThreat:ChatCommand(input)
	TidyPlatesThreat:OpenOptions()
end

function TidyPlatesThreat:ConfigRefresh()
	db = self.db.profile
	Update()
end

function TidyPlatesThreat:SetUpInitialOptions()
	self:RegisterChatCommand("tptp", "ChatCommand")
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Tidy Plates: Threat Plates Dialog", GetIntOptions)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Tidy Plates: Threat Plates Dialog", "Tidy Plates: Threat Plates")
end

function TidyPlatesThreat:AddOptions(class)
	local AddOptionsTable = {
		DEATHKNIGHT = {
			AuraType = L["Presences"],
			index = "presences",
			names = {
				[1] = GetSpellInfo(48263), -- Blood
				[2] = GetSpellInfo(48265), -- Frost
				[3] = GetSpellInfo(48266) -- Unholy
			}
		},
		DRUID = {
			AuraType = L["Shapeshifts"],
			index = "shapeshifts",
			names = {
				[1] = GetSpellInfo(5487), -- Bear Form
				[2] = GetSpellInfo(1066), -- Aquatic Form
				[3] = GetSpellInfo(768), -- Cat Form
				[4] = GetSpellInfo(783), -- Travel Form
				[5] = GetSpellInfo(24858) .. ", " .. GetSpellInfo(34551) .. " or " .. GetSpellInfo(33943), -- Moonkin Form, Tree of Life, Flight Form
				[6] = GetSpellInfo(33943) -- Flight Form (if moonkin or tree spec'd)
			}
		},
		PALADIN = {
			AuraType = L["Auras"],
			index = "auras",
			names = {
				[1] = GetSpellInfo(465), -- Devotion Aura
				[2] = GetSpellInfo(7294), -- Retribution Aura
				[3] = GetSpellInfo(19746), -- Concentration Aura
				[4] = GetSpellInfo(19891), -- Resistance Aura
				[5] = GetSpellInfo(32223) -- Crusader Aura
			}
		},
		WARRIOR = {
			AuraType = L["Stances"],
			index = "stances",
			names = {
				[1] = GetSpellInfo(2457), -- Battle Stance
				[2] = GetSpellInfo(71), -- Defensive Stance
				[3] = GetSpellInfo(2458) -- Berserker Stance
			}
		}
	}
	local index = AddOptionsTable[class].index
	local _db = TidyPlatesThreat.db.char[index]
	local AdditionalOptions = {
		type = "group",
		name = AddOptionsTable[class].AuraType,
		order = 70,
		args = {
			Enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				get = GetValueChar,
				set = SetValueChar,
				arg = {index, "ON"}
			},
			Options = {
				type = "group",
				order = 2,
				inline = false,
				disabled = function()
					return not (_db.ON and TidyPlatesThreat.db.profile.threat.ON)
				end,
				name = L["Options"],
				args = {}
			}
		}
	}
	local addorder = 20
	for k_c, k_v in pairs(AddOptionsTable[class].names) do
		AdditionalOptions.args.Options.args[index .. k_c] = {
			type = "group",
			name = k_v,
			inline = true,
			order = k_c,
			args = {
				Tank = {
					type = "toggle",
					order = 1,
					name = L["|cff00ff00Tank|r"],
					get = function(info)
						return _db[k_c]
					end,
					set = function(info, val)
						_db[k_c] = true
						TidyPlatesThreat.ShapeshiftUpdate()
					end
				},
				DPS = {
					type = "toggle",
					order = 2,
					name = L["|cffff0000DPS/Healing|r"],
					get = function(info)
						return not _db[k_c]
					end,
					set = function(info, val)
						_db[k_c] = false
						TidyPlatesThreat.ShapeshiftUpdate()
					end
				}
			}
		}
		addorder = addorder + 10
	end
	options.args.Stances = {}
	options.args.Stances = AdditionalOptions
end

function TidyPlatesThreat:SetUpOptions()
	db = self.db.profile

	GetOptions()
	UpdateSpecial()

	if class == "DEATHKNIGHT" or class == "DRUID" or class == "PALADIN" or class == "WARRIOR" then
		TidyPlatesThreat:AddOptions(class)
	end

	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profiles.order = 10000

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Tidy Plates: Threat Plates", options)
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("Tidy Plates: Threat Plates", 750, 600)
end