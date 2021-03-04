local TidyPlatesUtility = _G.TidyPlatesUtility
local TidyPlatesHubHelpers = _G.TidyPlatesHubHelpers
local TidyPlatesHubDefaults = _G.TidyPlatesHubDefaults
local TidyPlatesHubSettings = _G.TidyPlatesHubSettings
local TidyPlatesHubCache = _G.TidyPlatesHubCache
local TidyPlatesWidgetData = _G.TidyPlatesWidgetData

local font = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"
local PanelHelpers = TidyPlatesUtility.PanelHelpers -- PanelTools
local DropdownFrame = CreateFrame("Frame", "TidyPlatesHubCategoryFrame", UIParent, "UIDropDownMenuTemplate")

--[[
The basic concept of RapidPanel is that each UI widget will get attached to a 'rail' or alignment column.  This rail
provides access to a common update function.  Each widget gets attached as a stack, with widget definition tagging
the previous widget to anchor to.  Default and consistent anchor points also make for less work.

--]]
local function QuickSetPoints(frame, columnFrame, neighborFrame, xOffset, yOffset)
    local TopOffset = frame.Margins.Top + (yOffset or 0)
    local LeftOffset = frame.Margins.Left + (xOffset or 0)
    frame:ClearAllPoints()
    if neighborFrame then
        if neighborFrame.Margins then
            TopOffset = neighborFrame.Margins.Bottom + TopOffset + (yOffset or 0)
        end
        frame:SetPoint("TOP", neighborFrame, "BOTTOM", -(neighborFrame:GetWidth() / 2), -TopOffset)
    else
        frame:SetPoint("TOP", columnFrame, "TOP", 0, -TopOffset)
    end
    frame:SetPoint("LEFT", columnFrame, "LEFT", LeftOffset, 0)
end

local function CreateQuickSlider(name, label, ...) --, neighborFrame, xOffset, yOffset)
    local columnFrame = ...
    local frame = PanelHelpers:CreateSliderFrame(name, columnFrame, label, .5, 0, 1, .1)
    frame:SetWidth(250)
    frame.Margins = {Left = 12, Right = 8, Top = 20, Bottom = 13}
    QuickSetPoints(frame, ...)
    -- Set Feedback Function
    frame:SetScript(
        "OnMouseUp",
        function()
            columnFrame.Callback()
        end
    )
    return frame
end

local function CreateQuickCheckbutton(name, label, ...)
    local columnFrame = ...
    local frame = PanelHelpers:CreateCheckButton(name, columnFrame, label)
    frame.Margins = {Left = 2, Right = 100, Top = 0, Bottom = 0}
    QuickSetPoints(frame, ...)
    -- Set Feedback Function
    frame:SetScript("OnClick", function() columnFrame.Callback() end)
    return frame
end

local function SetSliderMechanics(slider, value, minimum, maximum, increment)
    slider:SetMinMaxValues(minimum, maximum)
    slider:SetValueStep(increment)
    slider:SetValue(value)
end

local function CreateQuickEditbox(name, ...)
    local columnFrame = ...
    local frame = CreateFrame("ScrollFrame", name, columnFrame, "UIPanelScrollFrameTemplate")
    frame.BorderFrame = CreateFrame("Frame", nil, frame)
    local EditBox = CreateFrame("EditBox", nil, frame)
    frame.Margins = {Left = 4, Right = 24, Top = 8, Bottom = 8}

    -- Frame Size
    frame:SetWidth(165)
    frame:SetHeight(125)
    -- Border
    frame.BorderFrame:SetPoint("TOPLEFT", 0, 5)
    frame.BorderFrame:SetPoint("BOTTOMRIGHT", 3, -5)
    frame.BorderFrame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4}
    })
    frame.BorderFrame:SetBackdropColor(0.05, 0.05, 0.05, 0)
    frame.BorderFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    -- Text

    EditBox:SetPoint("TOPLEFT")
    EditBox:SetPoint("BOTTOMLEFT")
    EditBox:SetHeight(100)
    EditBox:SetWidth(150)
    EditBox:SetMultiLine(true)

    EditBox:SetFrameLevel(frame:GetFrameLevel() - 1)
    EditBox:SetFont("Fonts\\FRIZQT__.TTF", 11, "NONE")
    EditBox:SetText("Empty")
    EditBox:SetAutoFocus(false)
    EditBox:SetTextInsets(9, 6, 2, 2)
    frame:SetScrollChild(EditBox)
    frame.EditBox = EditBox
    function frame:GetValue()
        return EditBox:GetText()
    end
    function frame:SetValue(value)
        EditBox:SetText(value)
    end
    frame._SetWidth = frame.SetWidth
    function frame:SetWidth(value)
        frame:_SetWidth(value)
        EditBox:SetWidth(value)
    end
    -- Set Positions
    QuickSetPoints(frame, ...)
    -- Set Feedback Function
    return frame
end

local function CreateQuickColorbox(name, label, ...)
    local columnFrame = ...
    local frame = PanelHelpers:CreateColorBox(name, columnFrame, label, 0, .5, 1, 1)
    frame.Margins = {Left = 5, Right = 100, Top = 3, Bottom = 2}
    -- Set Positions
    QuickSetPoints(frame, ...)
    -- Set Feedback Function
    frame.OnValueChanged = function()
        columnFrame.Callback()
    end
    return frame
end

local function CreateQuickDropdown(name, label, dropdownTable, initialValue, ...)
    local columnFrame = ...
    local frame = PanelHelpers:CreateDropdownFrame(name, columnFrame, dropdownTable, initialValue, label)
    frame.Margins = {Left = -12, Right = 2, Top = 22, Bottom = 0}
    -- Set Positions
    QuickSetPoints(frame, ...)
    -- Set Feedback Function
    frame.OnValueChanged = function()
        columnFrame.Callback()
    end
    return frame
end

local function CreateQuickHeadingLabel(name, label, ...)
    local columnFrame = ...
    local frame = CreateFrame("Frame", name, columnFrame)
    -- Heading Appearance
    frame:SetHeight(20)
    frame:SetWidth(500)
    frame.Text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    frame.Text:SetFont(font, 22)
    frame.Text:SetTextColor(255 / 255, 105 / 255, 6 / 255)
    frame.Text:SetAllPoints()
    frame.Text:SetText(label)
    frame.Text:SetJustifyH("LEFT")
    frame.Text:SetJustifyV("BOTTOM")
    frame.Margins = {Left = 6, Right = 2, Top = 2, Bottom = 2}
    -- Set Positions
    QuickSetPoints(frame, ...)
    -- Bookmark
    local bookmark = CreateFrame("Frame", nil, columnFrame)
    bookmark:SetPoint("TOPLEFT", columnFrame, "TOPLEFT")
    bookmark:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
    columnFrame.Headings = columnFrame.Headings or {}
    columnFrame.Headings[(#columnFrame.Headings) + 1] = label
    columnFrame.HeadingBookmarks = columnFrame.HeadingBookmarks or {}
    columnFrame.HeadingBookmarks[label] = bookmark
    -- Done!
    return frame
end

local function CreateQuickItemLabel(name, label, ...)
    local columnFrame = ...
    local frame = CreateFrame("Frame", name, columnFrame)
    frame:SetHeight(15)
    frame:SetWidth(500)
    frame.Text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    frame.Text:SetAllPoints()
    frame.Text:SetText(label)
    frame.Text:SetJustifyH("LEFT")
    frame.Text:SetJustifyV("BOTTOM")
    frame.Margins = {Left = 6, Right = 2, Top = 2, Bottom = 2}
    -- Set Positions
    QuickSetPoints(frame, ...)
    return frame
end

local function OnMouseWheelScrollFrame(frame, value, name)
    local scrollbar = _G[frame:GetName() .. "ScrollBar"]
    local currentPosition = scrollbar:GetValue()
    local increment = 50

    -- Spin Up
    if (value > 0) then
        -- Spin Down
        scrollbar:SetValue(currentPosition - increment)
    else
        scrollbar:SetValue(currentPosition + increment)
    end
end

TidyPlatesHubRapidPanel = {}
TidyPlatesHubRapidPanel.CreateQuickSlider = CreateQuickSlider
TidyPlatesHubRapidPanel.CreateQuickCheckbutton = CreateQuickCheckbutton
TidyPlatesHubRapidPanel.SetSliderMechanics = SetSliderMechanics
TidyPlatesHubRapidPanel.CreateQuickEditbox = CreateQuickEditbox
TidyPlatesHubRapidPanel.CreateQuickColorbox = CreateQuickColorbox
TidyPlatesHubRapidPanel.CreateQuickDropdown = CreateQuickDropdown
TidyPlatesHubRapidPanel.CreateQuickHeadingLabel = CreateQuickHeadingLabel
TidyPlatesHubRapidPanel.CreateQuickItemLabel = CreateQuickItemLabel
TidyPlatesHubRapidPanel.OnMouseWheelScrollFrame = OnMouseWheelScrollFrame

---------------
-- Helpers
---------------

local CallForStyleUpdate = TidyPlatesHubHelpers.CallForStyleUpdate
local GetPanelValues = TidyPlatesHubHelpers.GetPanelValues
local SetPanelValues = TidyPlatesHubHelpers.SetPanelValues
local GetSavedVariables = TidyPlatesHubHelpers.GetSavedVariables
local ListToTable = TidyPlatesHubHelpers.ListToTable
local ConvertStringToTable = TidyPlatesHubHelpers.ConvertStringToTable
local ConvertDebuffListTable = TidyPlatesHubHelpers.ConvertDebuffListTable
local CopyTable = TidyPlatesUtility.copyTable

local function CheckVariableIntegrity(objectName)
    for i, v in pairs(TidyPlatesHubDefaults) do
        if TidyPlatesHubSettings[objectName][i] == nil then
            TidyPlatesHubSettings[objectName][i] = v
        end
    end
end

local function CreateVariableSet(objectName)
    TidyPlatesHubSettings[objectName] = CopyTable(TidyPlatesHubDefaults)
    return TidyPlatesHubSettings[objectName]
end

local function GetVariableSet(panel)
    return TidyPlatesHubSettings[panel.objectName]
end

local function CheckCacheSet(objectName)
    for i, v in pairs(TidyPlatesHubDefaults) do
        if TidyPlatesHubCache[objectName][i] == nil then
            TidyPlatesHubCache[objectName][i] = v
        end
    end
end

local function ClearVariableSet(panel)
    for i, v in pairs(TidyPlatesHubSettings[panel.objectName]) do
        TidyPlatesHubSettings[panel.objectName][i] = nil
    end
    TidyPlatesHubSettings[panel.objectName] = nil
    ReloadUI()
end

local function GetCacheSet(objectName)
    if not TidyPlatesHubCache[objectName] then
        TidyPlatesHubCache[objectName] = {}
    end
    CheckCacheSet(objectName)
    return TidyPlatesHubCache[objectName]
end

local function RefreshSettings(LocalVars)
    CallForStyleUpdate()
    ConvertDebuffListTable(
        LocalVars.WidgetsDebuffTrackList,
        LocalVars.WidgetsDebuffLookup,
        LocalVars.WidgetsDebuffPriority
    )
    ConvertStringToTable(LocalVars.OpacityFilterList, LocalVars.OpacityFilterLookup)
end

local function OnPanelItemChange(panel)
    local LocalVars = GetVariableSet(panel)
    GetPanelValues(panel, LocalVars)
    RefreshSettings(LocalVars)
end

-- Colors
local yellow, blue, red, orange = "|cffffff00", "|cFF5599EE", "|cFFFF1100", "|cFFFF9920"

local function PasteSettings(panel)
    local cacheName, LocalVars

    if IsShiftKeyDown() then
        cacheName = panel.objectName
        print(orange .. "Settings pasted from the " .. yellow .. panel.name .. orange .. " clipboard.")
    else
        cacheName = "GlobalClipboard"
        print(orange .. "Settings pasted from the clipboard.")
    end

    LocalVars = GetCacheSet(cacheName)

    SetPanelValues(panel, LocalVars)
    OnPanelItemChange(panel)
    PlaySound("igMainMenuOptionCheckBoxOn")
end

local function CopySettings(panel)
    local cacheName, LocalVars

    if IsShiftKeyDown() then
        cacheName = panel.objectName
        print(blue .. "Settings copied to the " .. yellow .. panel.name .. blue .. " clipboard." .. yellow .. "  To use these values, hold down 'Shift' while clicking 'Paste'.")
    else
        cacheName = "GlobalClipboard"
        print(blue .. "Settings copied to the clipboard.")
    end

    LocalVars = GetCacheSet(cacheName)

    GetPanelValues(panel, LocalVars)
    PlaySound("igMainMenuOptionCheckBoxOn")
end

local function ResetSettings(panel)
    if IsShiftKeyDown() then
        ClearVariableSet(panel)
        CreateVariableSet(panel.objectName)
        for index, obj in pairs(TidyPlatesWidgetData) do
            if type(obj) == "table" then
                for subIndex in pairs(obj) do
                    TidyPlatesWidgetData[index][subIndex] = nil
                end
            end
        end
        ReloadUI()
    else
        SetPanelValues(panel, TidyPlatesHubDefaults)
        OnPanelItemChange(panel)
        print(yellow .. "Resetting " .. orange .. panel.name .. yellow .. " Configuration to Default")
        print(yellow .. "Holding down " .. blue .. "Shift" .. yellow .. " while clicking " .. red .. "Reset" .. yellow .. " will clear all saved settings, cached data, and reload the user interface.")
    end
end

local function AddDropdownTitle(title)
    local DropdownTitle = {}

    -- Define Title
    DropdownTitle.text = title
    DropdownTitle.notCheckable = 1
    DropdownTitle.isTitle = 1
    DropdownTitle.padding = 16

    -- Add Menu Buttons
    UIDropDownMenu_AddButton(DropdownTitle)
end

local function CreateInterfacePanel(objectName, panelTitle, parentTitle)
    -- Variables
    ------------------------------
    CreateVariableSet(objectName)

    -- Panel
    ------------------------------
    local panel = CreateFrame("Frame", objectName .. "_InterfaceOptionsPanel", UIParent)
    panel.objectName = objectName
    panel:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        insets = {left = 2, right = 2, top = 2, bottom = 2}
    })
    panel:SetBackdropColor(0.06, 0.06, 0.06, .5)
    if parentTitle then
        panel.parent = parentTitle
    end
    panel.name = panelTitle

    -- Heading
    ------------------------------
    panel.MainLabel = CreateQuickHeadingLabel(nil, panelTitle, panel, nil, 16, 16)

    -- Main Scrolled Frame
    ------------------------------
    panel.MainFrame = CreateFrame("Frame")
    panel.MainFrame:SetWidth(412)
    panel.MainFrame:SetHeight(2760) -- This can be set VERY long since we've got it in a scrollable window.

    -- Scrollable Panel Window
    ------------------------------
    panel.ScrollFrame = CreateFrame("ScrollFrame", objectName .. "_Scrollframe", panel, "UIPanelScrollFrameTemplate")
    panel.ScrollFrame:SetPoint("TOPLEFT", 16, -48)
    panel.ScrollFrame:SetPoint("BOTTOMRIGHT", -32, 16)
    panel.ScrollFrame:SetScrollChild(panel.MainFrame)
    panel.ScrollFrame:SetScript("OnMouseWheel", OnMouseWheelScrollFrame)

    -- Scroll Frame Border
    ------------------------------
    panel.ScrollFrameBorder = CreateFrame("Frame", objectName .. "ScrollFrameBorder", panel.ScrollFrame)
    panel.ScrollFrameBorder:SetPoint("TOPLEFT", -4, 5)
    panel.ScrollFrameBorder:SetPoint("BOTTOMRIGHT", 3, -5)
    panel.ScrollFrameBorder:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4}
    })
    panel.ScrollFrameBorder:SetBackdropColor(0.05, 0.05, 0.05, 0)
    panel.ScrollFrameBorder:SetBackdropBorderColor(0.2, 0.2, 0.2, 0)

    -- Alignment Colum
    ------------------------------
    panel.AlignmentColumn = CreateFrame("Frame", objectName .. "_AlignmentColumn", panel.MainFrame)
    panel.AlignmentColumn:SetPoint("TOPLEFT", 12, 0)
    panel.AlignmentColumn:SetPoint("BOTTOMRIGHT", panel.MainFrame, "BOTTOM")
    panel.AlignmentColumn.Callback = function()
        OnPanelItemChange(panel)
    end

    -----------------
    -- Panel Event Handler
    -----------------
    panel:SetScript("OnEvent", function()
        -- Check for Variable Set
        if not GetVariableSet(panel) then
            CreateVariableSet(objectName)
        end
        -- Verify Variable Integrity
        CheckVariableIntegrity(objectName)
        -- Refresh Panel based on loaded variables
        RefreshSettings(GetVariableSet(panel))
    end)
    panel:RegisterEvent("PLAYER_ENTERING_WORLD")

    -----------------
    -- Config Management Buttons
    -----------------

    -- Paste
    local PasteThemeDataButton = CreateFrame("Button", objectName .. "PasteThemeDataButton", panel, "TidyPlatesPanelButtonTemplate")
    PasteThemeDataButton.tooltipText = "Pastes your settings from the clipboard.  'Shift'-clicking uses the panel-specific clipboard"
    PasteThemeDataButton:SetPoint("TOPRIGHT", -40, -22)
    PasteThemeDataButton:SetWidth(60)
    PasteThemeDataButton:SetScale(0.85)
    PasteThemeDataButton:SetText("Paste")
    PasteThemeDataButton:SetScript("OnClick", function() PasteSettings(panel) end)

    -- Copy
    local CopyThemeDataButton = CreateFrame("Button", objectName .. "CopyThemeDataButton", panel, "TidyPlatesPanelButtonTemplate")
    CopyThemeDataButton.tooltipText = "Copies your settings to the clipboard.  'Shift'-clicking uses a panel-specific clipboard"
    CopyThemeDataButton:SetPoint("TOPRIGHT", PasteThemeDataButton, "TOPLEFT", -4, 0)
    CopyThemeDataButton:SetWidth(60)
    CopyThemeDataButton:SetScale(0.85)
    CopyThemeDataButton:SetText("Copy")
    CopyThemeDataButton:SetScript("OnClick", function() CopySettings(panel) end)

    -- Reset
    local ReloadThemeDataButton = CreateFrame("Button", objectName .. "ReloadThemeDataButton", panel, "TidyPlatesPanelButtonTemplate")
    ReloadThemeDataButton.tooltipText = "Resets the configuration to Default.  Holding down 'Shift' will also clear saved unit data, and restart your UI."
    ReloadThemeDataButton:SetPoint("TOPRIGHT", CopyThemeDataButton, "TOPLEFT", -4, 0)
    ReloadThemeDataButton:SetWidth(60)
    ReloadThemeDataButton:SetScale(0.85)
    ReloadThemeDataButton:SetText("Reset")
    ReloadThemeDataButton:SetScript("OnClick", function()
        PlaySound("igMainMenuOptionCheckBoxOn")
        ResetSettings(panel)
    end)

    -- Bookmarks
    local BookmarkButton = CreateFrame("Button", objectName .. "BookmarkButton", panel, "TidyPlatesPanelButtonTemplate")
    BookmarkButton:SetPoint("TOPRIGHT", ReloadThemeDataButton, "TOPLEFT", -4, 0)
    BookmarkButton:SetWidth(110)
    BookmarkButton:SetScale(0.85)
    BookmarkButton:SetText("Bookmarks...")

    local function InitializeDropdownMenu()
        AddDropdownTitle("Bookmarks")
        -- Populate List with Categories
        local CatgegoryHeading = {}
        for index, name in pairs(panel.AlignmentColumn.Headings) do
            CatgegoryHeading.text = name
            CatgegoryHeading.padding = 16
            CatgegoryHeading.notCheckable = 1
            --CatgegoryHeading.keepShownOnClick = 1
            CatgegoryHeading.func = function(self)
                local scrollTo = panel.AlignmentColumn.HeadingBookmarks[self:GetText()]:GetHeight()
                panel.ScrollFrame:SetVerticalScroll(ceil(scrollTo - 27))
            end
            UIDropDownMenu_AddButton(CatgegoryHeading)
        end
    end

    BookmarkButton:SetScript("OnClick", function(frame)
        UIDropDownMenu_Initialize(DropdownFrame, InitializeDropdownMenu, "MENU")
        ToggleDropDownMenu(1, nil, DropdownFrame, frame)
        PlaySound("igMainMenuOptionCheckBoxOn")
    end)

    local function SetMaximizeButtonTexture(frame)
        frame:SetNormalTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Up")
        frame:SetPushedTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Down")
    end

    -- Unlink - Detach -
    local ClosePanel, UnLinkPanel, EnableUnlink
    local UnlinkButton
    UnlinkButton = CreateFrame("Button", objectName .. "UnlinkButton", panel, "UIPanelCloseButton")
    UnlinkButton:SetPoint("LEFT", PasteThemeDataButton, "RIGHT", 0, -0.5)
    UnlinkButton:SetScale(0.95)
    SetMaximizeButtonTexture(UnlinkButton)

    EnableUnlink = function()
        UnlinkButton:SetScript("OnClick", UnLinkPanel)
        SetMaximizeButtonTexture(UnlinkButton)
        UnlinkButton:SetScript("OnClick", UnLinkPanel)

        panel:SetScale(1)
        panel:SetMovable(false)
        panel:SetScript("OnDragStart", nil)
        panel:SetScript("OnDragStop", nil)
    end

    -- The Unlink feature will pop the config panel onto its own movable window frame
    UnLinkPanel = function(self)
        HideUIPanel(InterfaceOptionsFrame) -- ShowUIPanel(InterfaceOptionsFrame);
        local height, width = panel:GetHeight(), panel:GetWidth()
        panel:SetParent(UIParent)
        panel:ClearAllPoints()
        panel:SetHeight(height - 40)
        panel:SetWidth(width - 90)
        panel:SetPoint("CENTER")
        panel:SetScale(0.95)

        panel:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = {left = 4, right = 4, top = 4, bottom = 4}
        })
        panel:SetBackdropColor(0.06, 0.06, 0.06, 1)
        panel:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

        panel:SetClampedToScreen(true)
        panel:RegisterForDrag("LeftButton")
        panel:EnableMouse(true)
        panel:SetMovable(true)
        panel:SetScript("OnDragStart", function(self, button)
            panel:SetAlpha(0.9)
            if button == "LeftButton" then
                panel:StartMoving()
            end
        end)
        panel:SetScript("OnDragStop", function(self, button)
            panel:SetAlpha(1)
            panel:StopMovingOrSizing()
        end)

        -- Repurpose button for Close
        self:SetScript("OnClick", ClosePanel)
        self:SetScale(0.90)
        self:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
        self:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    end

    ClosePanel = function(self)
        OnPanelItemChange(panel)
        EnableUnlink()
        panel:Hide()
    end

    UnlinkButton:SetScript("OnClick", UnLinkPanel)

    -----------------
    -- Button Handlers
    -----------------
    panel.okay = function()
        OnPanelItemChange(panel)
    end
    panel.refresh = function()
        SetPanelValues(panel, GetVariableSet(panel))
        EnableUnlink(UnlinkButton)
    end

    ----------------
    -- Return a pointer to the whole thingy
    ----------------
    InterfaceOptions_AddCategory(panel)
    return panel
end

TidyPlatesHubRapidPanel.CreateInterfacePanel = CreateInterfacePanel
TidyPlatesHubRapidPanel.CreateVariableSet = CreateVariableSet