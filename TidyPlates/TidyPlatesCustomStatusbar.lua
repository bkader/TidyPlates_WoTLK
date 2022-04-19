local core = {}
core.callbacks = core.callbacks or LibStub("CallbackHandler-1.0"):New(core)

local assert, type = assert, type
local setmetatable = setmetatable
local CreateFrame = CreateFrame

local barFrame = CreateFrame("Frame")
local barPrototype_SetScript = barFrame.SetScript

local function barPrototype_Update(self, sizeChanged, width, height)
	local progress = (self.VALUE - self.MINVALUE) / (self.MAXVALUE - self.MINVALUE)

	local align1, align2
	local TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy
	local TLx_, TLy_, BLx_, BLy_, TRx_, TRy_, BRx_, BRy_
	local xprogress, yprogress

	width = width or self:GetWidth()
	height = height or self:GetHeight()

	if self.ORIENTATION == "HORIZONTAL" then
		xprogress = width * progress -- progress horizontally
		if self.FILLSTYLE == "CENTER" then
			align1, align2 = "TOP", "BOTTOM"
		elseif self.REVERSE or self.FILLSTYLE == "REVERSE" then
			align1, align2 = "TOPRIGHT", "BOTTOMRIGHT"
		else
			align1, align2 = "TOPLEFT", "BOTTOMLEFT"
		end
	elseif self.ORIENTATION == "VERTICAL" then
		yprogress = height * progress -- progress vertically
		if self.FILLSTYLE == "CENTER" then
			align1, align2 = "LEFT", "RIGHT"
		elseif self.REVERSE or self.FILLSTYLE == "REVERSE" then
			align1, align2 = "TOPLEFT", "TOPRIGHT"
		else
			align1, align2 = "BOTTOMLEFT", "BOTTOMRIGHT"
		end
	end

	if self.ROTATE then
		TLx, TLy = 0.0, 1.0
		TRx, TRy = 0.0, 0.0
		BLx, BLy = 1.0, 1.0
		BRx, BRy = 1.0, 0.0
		TLx_, TLy_ = TLx, TLy
		TRx_, TRy_ = TRx, TRy
		BLx_, BLy_ = BLx * progress, BLy
		BRx_, BRy_ = BRx * progress, BRy
	else
		TLx, TLy = 0.0, 0.0
		TRx, TRy = 1.0, 0.0
		BLx, BLy = 0.0, 1.0
		BRx, BRy = 1.0, 1.0
		TLx_, TLy_ = TLx, TLy
		TRx_, TRy_ = TRx * progress, TRy
		BLx_, BLy_ = BLx, BLy
		BRx_, BRy_ = BRx * progress, BRy
	end

	if not sizeChanged then
		self.bg:ClearAllPoints()
		self.bg:SetAllPoints()
		self.bg:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy)

		self.fg:ClearAllPoints()
		self.fg:SetPoint(align1)
		self.fg:SetPoint(align2)
		self.fg:SetTexCoord(TLx_, TLy_, BLx_, BLy_, TRx_, TRy_, BRx_, BRy_)
	end

	if xprogress then
		self.fg:SetWidth(xprogress > 0 and xprogress or 0.1)
		core.callbacks:Fire("OnValueChanged", self, self.VALUE)
	end
	if yprogress then
		self.fg:SetHeight(yprogress > 0 and yprogress or 0.1)
		core.callbacks:Fire("OnValueChanged", self, self.VALUE)
	end
end

local function barPrototype_OnSizeChanged(self, width, height)
	barPrototype_Update(self, true, width, height)
end

local barPrototype = setmetatable({
	MINVALUE = 0.0,
	MAXVALUE = 1.0,
	VALUE = 1.0,
	ROTATE = true,
	REVERSE = false,
	ORIENTATION = "HORIZONTAL",
	FILLSTYLE = "STANDARD",

	SetMinMaxValues = function(self, minValue, maxValue)
		assert((type(minValue) == "number" and type(maxValue) == "number"), "Usage: StatusBar:SetMinMaxValues(number, number)")

		if maxValue > minValue then
			self.MINVALUE = minValue
			self.MAXVALUE = maxValue
		else
			self.MINVALUE = 0
			self.MAXVALUE = 1
		end

		if not self.VALUE or self.VALUE > self.MAXVALUE then
			self.VALUE = self.MAXVALUE
		elseif not self.VALUE or self.VALUE < self.MINVALUE then
			self.VALUE = self.MINVALUE
		end

		barPrototype_Update(self)
	end,

	GetMinMaxValues = function(self)
		return self.MINVALUE, self.MAXVALUE
	end,

	SetValue = function(self, value)
		assert(type(value) == "number", "Usage: StatusBar:SetValue(number)")
		if value >= self.MINVALUE and value <= self.MAXVALUE then
			self.VALUE = value
			barPrototype_Update(self)
		end
	end,

	GetValue = function(self)
		return self.VALUE
	end,

	SetOrientation = function(self, orientation)
		if orientation == "HORIZONTAL" or orientation == "VERTICAL" then
			self.ORIENTATION = orientation
			barPrototype_Update(self)
		end
	end,

	GetOrientation = function(self)
		return self.ORIENTATION
	end,

	SetRotatesTexture = function(self, rotate)
		self.ROTATE = (rotate ~= nil and rotate ~= false)
		barPrototype_Update(self)
	end,

	GetRotatesTexture = function(self)
		return self.ROTATE
	end,

	SetReverseFill = function(self, reverse)
		self.REVERSE = (reverse == true)
		barPrototype_Update(self)
	end,

	GetReverseFill = function(self)
		return self.REVERSE
	end,

	SetFillStyle = function(self, style)
		assert(type(style) == "string" or style == nil, "Usage: StatusBar:SetFillStyle(string)")
		if style and style:lower() == "center" then
			self.FILLSTYLE = "CENTER"
			barPrototype_Update(self)
		elseif style and style:lower() == "reverse" then
			self.FILLSTYLE = "REVERSE"
			barPrototype_Update(self)
		else
			self.FILLSTYLE = "STANDARD"
			barPrototype_Update(self)
		end
	end,

	GetFillStyle = function(self)
		return self.FILLSTYLE
	end,

	SetStatusBarTexture = function(self, texture)
		self.fg:SetTexture(texture)
		self.bg:SetTexture(texture)
	end,

	GetStatusBarTexture = function(self)
		return self.fg
	end,

	SetForegroundColor = function(self, r, g, b, a)
		self.fg:SetVertexColor(r, g, b, a)
	end,

	GetForegroundColor = function(self)
		return self.fg
	end,

	SetBackgroundColor = function(self, r, g, b, a)
		self.bg:SetVertexColor(r, g, b, a)
	end,

	GetBackgroundColor = function(self)
		return self.bg:GetVertexColor()
	end,

	SetTexture = function(self, texture)
		self:SetStatusBarTexture(texture)
	end,

	GetTexture = function(self)
		return self.fg:GetTexture()
	end,

	SetStatusBarColor = function(self, r, g, b, a)
		self:SetForegroundColor(r, g, b, a)
	end,

	GetStatusBarColor = function(self)
		return self.fg:GetVertexColor()
	end,

	SetVertexColor = function(self, r, g, b, a)
		self:SetForegroundColor(r, g, b, a)
	end,

	GetVertexColor = function(self)
		return self.fg:GetVertexColor()
	end,

	SetStatusBarGradient = function(self, r1, g1, b1, a1, r2, g2, b2, a2)
		self.fg:SetGradientAlpha(self.ORIENTATION, r1, g1, b1, a1, r2, g2, b2, a2)
	end,

	SetStatusBarGradientAuto = function(self, r, g, b, a)
		self.fg:SetGradientAlpha(self.ORIENTATION, 0.5 + (r * 1.1), g * 0.7, b * 0.7, a, r * 0.7, g * 0.7, 0.5 + (b * 1.1), a)
	end,

	SetStatusBarSmartGradient = function(self, r1, g1, b1, r2, g2, b2)
		self.fg:SetGradientAlpha(self.ORIENTATION, r1, g1, b1, 1, r2 or r1, g2 or g1, b2 or b1, 1)
	end,

	GetObjectType = function(self)
		return "StatusBar"
	end,

	IsObjectType = function(self, otype)
		return (otype == "StatusBar") and 1 or nil
	end,

	SetScript = function(self, event, callback)
		if event == "OnValueChanged" then
			assert(type(callback) == "function", 'Usage: StatusBar:SetScript("OnValueChanged", function)')
			core.RegisterCallback(self, "OnValueChanged", function() callback(self, self.VALUE) end)
		else
			barPrototype_SetScript(self, event, callback)
		end
	end
}, {__index = barFrame})

local barPrototype_mt = {__index = barPrototype}

CreateTidyPlatesStatusbar = function(parent, name)
	-- create the bar and its elements.
	local bar = setmetatable(CreateFrame("Frame", name, parent), barPrototype_mt)
	bar.fg = bar.fg or bar:CreateTexture(name and "$parent.Texture", "ARTWORK")
	bar.bg = bar.bg or bar:CreateTexture(name and "$parent.Background", "BACKGROUND")
	bar.bg:Hide()

	-- do some stuff then return it.
	bar:HookScript("OnSizeChanged", barPrototype_OnSizeChanged)
	bar:SetRotatesTexture(false)
	return bar
end