--[[

Faux Plate

Ideas:
#1
TidyPlates:ApplyThemeToFrame(frame, unittable)
Runs the units' UpdateStyle function, and applies the current theme to the frame.
-Benefit:
-Drawback: Need to know when theme changes

#2
TidyPlates:CreateBlankPlate() returns a frame

#3 Total simulation
Addon creates a frame

use: pcall(function() end)
to process the style changes
--]]

local TidyPlates = TidyPlates
local OnNewNameplate = TidyPlates.OnNewNameplate
local Plates = {}

local function CreateFauxPlate(plate)
	if plate and not Plates[plate] then
		Plates[plate] = true
		plate.extended = CreateFrame("Frame", nil, plate)
		local extended = plate.extended

		extended:SetPoint("CENTER", plate)
		extended.style, extended.unit, extended.unitcache, extended.stylecache, extended.widgets = {}, {}, {}, {}, {}
		extended.regions, extended.bars, extended.visual = {}, {}, {}
		regions = extended.regions
		bars = extended.bars
		extended.stylename = ""

		-- Create Statusbars
		local level = plate:GetFrameLevel()
		bars.healthbar = CreateTidyPlatesStatusbar(extended)
		bars.castbar = CreateTidyPlatesStatusbar(extended)

		--extended.text = CreateFrame("Frame", nil, healthbar)

		health, cast, healthbar, castbar = bars.health, bars.cast, bars.healthbar, bars.castbar
		healthbar:SetFrameLevel(level)
		castbar:Hide()
		castbar:SetFrameLevel(level)
		castbar:SetStatusBarColor(1, .8, 0)

		-- Create Visual Regions
		visual = extended.visual
		visual.threatborder = healthbar:CreateTexture(nil, "ARTWORK")
		visual.specialArt = extended:CreateTexture(nil, "OVERLAY")
		visual.specialText = healthbar:CreateFontString(nil, "OVERLAY")
		visual.specialText2 = healthbar:CreateFontString(nil, "OVERLAY")
		visual.healthborder = healthbar:CreateTexture(nil, "ARTWORK")
		visual.threatborder = healthbar:CreateTexture(nil, "OVERLAY")
		visual.castborder = castbar:CreateTexture(nil, "ARTWORK")
		visual.castnostop = castbar:CreateTexture(nil, "ARTWORK")
		visual.spellicon = castbar:CreateTexture(nil, "OVERLAY")
		visual.dangerskull = healthbar:CreateTexture(nil, "OVERLAY")
		visual.raidicon = healthbar:CreateTexture(nil, "OVERLAY")
		visual.eliteicon = healthbar:CreateTexture(nil, "OVERLAY")
		visual.name = extended:CreateFontString(nil, "ARTWORK")
		visual.level = extended:CreateFontString(nil, "OVERLAY")

		visual.highlight = regions.highlight

		visual.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
		visual.dangerskull:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull")

		OnNewNameplate(plate)
	end
end