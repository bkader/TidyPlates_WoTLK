local TidyPlates = _G.TidyPlates
local TidyPlatesUtility = _G.TidyPlatesUtility
TidyPlatesThemeList = TidyPlatesThemeList or {}

-------------------------------------------------------------------------------------
-- Template
-------------------------------------------------------------------------------------

local theme = {}
local defaultArtPath = "Interface\\Addons\\TidyPlates\\media"
local font = "FONTS\\arialn.ttf"
local EMPTY_TEXTURE = defaultArtPath .. "\\Empty"

theme.hitbox = {
	width = 149,
	height = 40
}

theme.highlight = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64
}

theme.healthborder = {
	texture = EMPTY_TEXTURE,
	width = 0,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = true
}

theme.eliteicon = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = false
}

theme.threatborder = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = true
}

theme.castborder = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -11,
	anchor = "CENTER",
	show = true
}

theme.castnostop = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -11,
	anchor = "CENTER",
	show = true
}

theme.name = {
	typeface = font,
	size = 9,
	width = 88,
	height = 10,
	x = 0,
	y = 1,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true
}

theme.level = {
	typeface = font,
	size = 9,
	width = 25,
	height = 10,
	x = 36,
	y = 1,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true
}

theme.healthbar = {
	texture = EMPTY_TEXTURE,
	backdrop = EMPTY_TEXTURE,
	backdropcolor = {0, 0, 0, 0.75},
	height = 12,
	width = 0,
	x = 0,
	y = 10,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
	texcoord = {left = 0, right = 1, top = 0, bottom = 1},
	linkwidth = false,
	edgeFile = EMPTY_TEXTURE,
	edgeSize = 1,
	edgeInset = {left = 0, right = 0, top = 0, bottom = 0}
}

theme.castbar = {
	texture = EMPTY_TEXTURE,
	backdrop = EMPTY_TEXTURE,
	height = 12,
	width = 99,
	x = 0,
	y = -19,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
	texcoord = {left = 0, right = 1, top = 0, bottom = 1},
	linkwidth = false,
	edgeFile = EMPTY_TEXTURE,
	edgeSize = 1,
	edgeInset = {left = 0, right = 0, top = 0, bottom = 0}
}

theme.spelltext = {
	typeface = font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 11,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false
}

theme.customtext = {
	typeface = font,
	size = 8,
	width = 100,
	height = 10,
	x = 1,
	y = -19,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false
}

theme.customart = {
	width = 24,
	height = 24,
	x = -5,
	y = 10,
	anchor = "TOP",
	show = false
}

theme.spellicon = {
	width = 18,
	height = 18,
	x = 62,
	y = -19,
	anchor = "CENTER",
	show = true
}

theme.raidicon = {
	width = 20,
	height = 20,
	x = -35,
	y = 7,
	anchor = "TOP",
	show = true
}

theme.skullicon = {
	texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
	width = 14,
	height = 14,
	x = 44,
	y = 3,
	anchor = "CENTER",
	show = true
}

theme.frame = {
	width = 101,
	height = 45,
	x = 0,
	y = 0,
	anchor = "CENTER"
}

theme.target = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = false
}

theme.threatcolor = {
	LOW = {r = .75, g = 1, b = 0, a = 1},
	MEDIUM = {r = 1, g = 1, b = 0, a = 1},
	HIGH = {r = 1, g = 0, b = 0, a = 1}
}

TidyPlates.Template = theme
-- Activates the template as a holder theme, until the user preference is loaded
TidyPlates:ActivateTheme(theme)

------------
-- "Name Only" Theme
------------
local NameOnlyTheme = TidyPlatesUtility.copyTable(TidyPlates.Template)

NameOnlyTheme.customtext = {
	size = 12,
	width = 200,
	height = 16,
	x = 0,
	y = 12,
	align = "CENTER",
	anchor = "CENTER",
	shadow = true,
	show = true
}

NameOnlyTheme.level = {show = false}
NameOnlyTheme.name = {show = false}
NameOnlyTheme.skullicon = {show = false}
NameOnlyTheme.spellicon = {show = false}

-- Hex Colors
local TextColors = {}
TextColors.FRIENDLY = {NPC = "|cFF3cee35", PLAYER = "|cFF5cb8ff"}
TextColors.HOSTILE = {NPC = "|cFFFF3535", PLAYER = "|cFFfc551b"}
TextColors.NEUTRAL = {NPC = "|cFFFFEE11"}

local function TextDelegate(unit)
	local TextColor
	TextColor = TextColors[unit.reaction][unit.type] or ""
	return TextColor .. unit.name
end

NameOnlyTheme.SetCustomText = TextDelegate
TidyPlatesThemeList["None"] = NameOnlyTheme