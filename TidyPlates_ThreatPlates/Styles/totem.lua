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
			x = db.frame.x,
			y = db.frame.y,
			anchor = "CENTER"
		}
		config.threatborder = {
			texture = path .. "TP_Threat",
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = 0,
			anchor = "CENTER",
			show = db.threatborder.show
		}
		config.highlight = {
			texture = path .. db.highlight.texture,
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = 0,
			anchor = "CENTER"
		}
		config.healthborder = {
			texture = path .. db.healthborder.texture,
			backdrop = path .. db.healthborder.backdrop,
			width = width * 2.1333,
			height = height * 6.4,
			x = 0,
			y = 0,
			anchor = "CENTER",
			show = db.healthborder.show
		}
		config.eliteicon = {
			texture = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\EliteArtWidget\\" ..
				TidyPlatesThreat.db.profile.settings.eliteicon.theme,
			width = db.eliteicon.scale,
			height = db.eliteicon.scale,
			x = db.eliteicon.x,
			y = db.eliteicon.y,
			anchor = db.eliteicon.anchor,
			show = db.eliteicon.show
		}
		config.castborder = {
			texture = path .. "TP_CastBarOverlay",
			width = width * 2.1333,
			height = height * 6.4,
			x = db.castborder.x,
			y = db.castborder.y,
			anchor = "CENTER",
			show = db.castborder.show
		}
		config.castnostop = {
			texture = path .. "TP_CastBarLock",
			width = width * 2.1333,
			height = height * 6.4,
			x = db.castnostop.x,
			y = db.castnostop.y,
			anchor = "CENTER",
			show = db.castnostop.show
		}
		-- Bar Textures
		config.healthbar = {
			texture = Media:Fetch("statusbar", db.healthbar.texture),
			width = db.healthbar.width or 120,
			height = db.healthbar.height or 10,
			x = 0,
			y = 0,
			anchor = "CENTER",
			orientation = "HORIZONTAL"
		}
		config.castbar = {
			texture = Media:Fetch("statusbar", db.castbar.texture),
			width = db.healthbar.width or 120,
			height = 10,
			x = db.castbar.x,
			y = db.castbar.y,
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
			shadow = db.name.shadow,
			flags = db.name.flags,
			show = db.name.show
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
			shadow = db.level.shadow,
			flags = db.level.flags,
			show = db.level.show
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
			shadow = db.customtext.shadow,
			flags = db.customtext.flags,
			show = db.customtext.show
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
			shadow = db.spelltext.shadow,
			flags = db.spelltext.flags,
			show = db.spelltext.show
		}
		-- ICONS
		config.skullicon = {
			width = (db.skullicon.scale),
			height = (db.skullicon.scale),
			x = (db.skullicon.x),
			y = (db.skullicon.y),
			anchor = (db.skullicon.anchor),
			show = db.skullicon.show
		}
		config.customart = {
			width = (db.customart.scale),
			height = (db.customart.scale),
			x = (db.customart.x),
			y = (db.customart.y),
			anchor = (db.customart.anchor),
			show = db.customart.show
		}
		config.spellicon = {
			width = (db.spellicon.scale),
			height = (db.spellicon.scale),
			x = (db.spellicon.x),
			y = (db.spellicon.y),
			anchor = (db.spellicon.anchor),
			show = db.spellicon.show
		}
		config.raidicon = {
			width = (db.raidicon.scale),
			height = (db.raidicon.scale),
			x = (db.raidicon.x),
			y = (db.raidicon.y),
			anchor = (db.raidicon.anchor),
			show = db.raidicon.show
		}
		-- OPTIONS
		local threat = db.totem.threatcolor
		config.threatcolor = {
			LOW = {
				r = threat.LOW.r,
				g = threat.LOW.g,
				b = threat.LOW.b,
				a = threat.LOW.a
			},
			MEDIUM = {
				r = threat.MEDIUM.r,
				g = threat.MEDIUM.g,
				b = threat.MEDIUM.b,
				a = threat.MEDIUM.a
			},
			HIGH = {
				r = threat.HIGH.r,
				g = threat.HIGH.g,
				b = threat.HIGH.b,
				a = threat.HIGH.a
			}
		}
		TidyPlatesThemeList["Threat Plates"]["totem"] = {}
		TidyPlatesThemeList["Threat Plates"]["totem"] = config
	end
end
f:SetScript("OnEvent", function(self, event, ...) CreateStyle(self, event, ...) end)
f:RegisterEvent("ADDON_LOADED")