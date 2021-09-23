local Media = LibStub("LibSharedMedia-3.0")
local config = {}
local path = "Interface\\Addons\\TidyPlates_ThreatPlates\\Media\\Artwork\\"
local f = CreateFrame("Frame")
local function CreateStyle(self, event, ...)
	if ... == "TidyPlates_ThreatPlates" then
		local db = TidyPlatesThreat.db.profile.settings
		local width = db.healthbar.width or 120
		local height = db.healthbar.height or 10

		config.hitbox = {
			width = width * 1.0667,
			height = height * 2.4
		}
		config.frame = {
			emptyTexture = path .. "Empty",
			width = width * 1.0333,
			height = height * 3,
			x = 0,
			y = 0,
			anchor = "CENTER"
		}
		config.threatborder = {
			texture = path .. "Empty",
			elitetexture = path .. "Empty",
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = 0,
			anchor = "CENTER"
		}
		config.healthborder = {
			texture = path .. "Empty",
			glowtexture = path .. "Empty",
			elitetexture = path .. "Empty",
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = 0,
			anchor = "CENTER"
		}
		config.castborder = {
			texture = path .. "Empty",
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = -15,
			anchor = "CENTER"
		}

		config.castnostop = {
			texture = path .. "Empty",
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = -15,
			anchor = "CENTER"
		}
		-- Bar Textures
		config.healthbar = {
			texture = path .. "Empty",
			backdrop = [[Interface\Buttons\WHITE8X8]],
			backdropcolor = {0, 0, 0, 0.75},
			width = db.healthbar.width or 120,
			height = db.healthbar.height or 10,
			x = 0,
			y = 0,
			anchor = "CENTER",
			orientation = "HORIZONTAL"
		}
		config.castbar = {
			texture = path .. "Empty",
			width = db.healthbar.width or 120,
			height = 10,
			x = 0,
			y = -15,
			anchor = "CENTER",
			orientation = "HORIZONTAL"
		}
		-- TEXT

		config.name = {
			typeface = Media:Fetch("font", db.name.typeface),
			size = db.name.size,
			width = db.name.width,
			height = db.name.height,
			x = db.name.x,
			y = db.name.y,
			align = db.name.align,
			anchor = "CENTER",
			vertical = db.name.vertical,
			shadow = true,
			show = false
		}
		config.level = {
			typeface = Media:Fetch("font", db.level.typeface),
			size = db.level.size,
			width = db.level.width,
			height = db.level.height,
			x = db.level.x,
			y = db.level.y,
			align = db.level.align,
			anchor = "CENTER",
			vertical = db.level.vertical,
			shadow = true,
			show = false
		}
		config.customtext = {
			typeface = Media:Fetch("font", db.customtext.typeface),
			size = db.customtext.size,
			width = db.customtext.width,
			height = db.customtext.height,
			x = db.customtext.x,
			y = db.customtext.y,
			align = db.customtext.align,
			anchor = "CENTER",
			vertical = db.customtext.vertical,
			shadow = true,
			show = false
		}
		config.spelltext = {
			typeface = Media:Fetch("font", db.spelltext.typeface),
			size = db.spelltext.size,
			width = db.spelltext.width,
			height = db.spelltext.height,
			x = db.spelltext.x,
			y = db.spelltext.y,
			align = db.spelltext.align,
			anchor = "CENTER",
			vertical = db.spelltext.vertical,
			shadow = true,
			show = false
		}
		-- ICONS
		config.skullicon = {
			width = (db.skullicon.scale),
			height = (db.skullicon.scale),
			x = (db.skullicon.x),
			y = (db.skullicon.y),
			anchor = (db.skullicon.anchor),
			show = false
		}
		config.customart = {
			width = (db.customart.scale),
			height = (db.customart.scale),
			x = (db.customart.x),
			y = (db.customart.y),
			anchor = (db.customart.anchor),
			show = false
		}
		config.spellicon = {
			width = (db.spellicon.scale),
			height = (db.spellicon.scale),
			x = (db.spellicon.x),
			y = (db.spellicon.y),
			anchor = (db.spellicon.anchor),
			show = false
		}
		config.raidicon = {
			width = (db.raidicon.scale),
			height = (db.raidicon.scale),
			x = (db.raidicon.x),
			y = (db.raidicon.y),
			anchor = (db.raidicon.anchor),
			show = false
		}
		-- OPTIONS
		config.threatcolor = {
			LOW = {r = 0, g = 0, b = 0, a = 0},
			MEDIUM = {r = 0, g = 0, b = 0, a = 0},
			HIGH = {r = 0, g = 0, b = 0, a = 0}
		}
		TidyPlatesThemeList["Threat Plates"]["empty"] = {}
		TidyPlatesThemeList["Threat Plates"]["empty"] = config
	end
end
f:SetScript("OnEvent", function(self, event, ...) CreateStyle(self, event, ...) end)
f:RegisterEvent("ADDON_LOADED")