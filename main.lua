--[[
    ============================================================
    TODDYNHOHUB 2.01 - MM2 Style
    Tema: Spatial Purple 🟣
    ============================================================
]]

if _G.Toddynho201Loaded then return end
_G.Toddynho201Loaded = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

-- ============================================================
-- TEMA
-- ============================================================
local Theme = {
    BG           = Color3.fromRGB(10, 4, 22),
    BG2          = Color3.fromRGB(20, 8, 40),
    Surface      = Color3.fromRGB(22, 14, 44),
    Surface2     = Color3.fromRGB(32, 20, 60),
    Surface3     = Color3.fromRGB(40, 26, 74),
    Accent       = Color3.fromRGB(160, 80, 255),
    AccentLight  = Color3.fromRGB(200, 140, 255),
    AccentNeon   = Color3.fromRGB(210, 150, 255),
    AccentDark   = Color3.fromRGB(90, 40, 160),
    Glow         = Color3.fromRGB(120, 40, 220),
    Text         = Color3.fromRGB(240, 235, 255),
    TextDim      = Color3.fromRGB(160, 145, 200),
    Outline      = Color3.fromRGB(80, 50, 140),
    Green        = Color3.fromRGB(90, 220, 130),
    Red          = Color3.fromRGB(255, 90, 90),
    Yellow       = Color3.fromRGB(255, 215, 80),
}

local BG_IMAGE_ID = "rbxassetid://73420438007535"

-- ============================================================
-- ICONES
-- ============================================================
local Icons = {
    Combat = "⚔", LocalPlayer = "◉", AutoFarm = "◎", Visuals = "◈", Settings = "⚙",
    Murder = "⚔", Innocent = "☗", Sheriff = "✦", Target = "◉", User = "☺",
    Gun = "◎", Eye = "◉", Sword = "⚔", Shield = "☗", Star = "✦",
    Crosshair = "◉", Money = "◈", Sparkle = "✧", Gear = "⚙", Key = "⌨",
    Clean = "✧",
}

-- ============================================================
-- HELPERS
-- ============================================================
local function new(class, props, children)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    for _, c in ipairs(children or {}) do c.Parent = obj end
    return obj
end

local function corner(parent, radius)
    return new("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = parent })
end

local function stroke(parent, color, thickness)
    return new("UIStroke", {
        Color = color or Theme.Outline,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function addGradient(frame, c1, c2, rotation)
    return new("UIGradient", {
        Color = ColorSequence.new(c1 or Theme.Accent, c2 or Theme.AccentDark),
        Rotation = rotation or 90,
        Parent = frame,
    })
end

-- ============================================================
-- SCREEN GUI
-- ============================================================
local ScreenGui = new("ScreenGui", {
    Name = "ToddynhoHub201",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = (gethui and gethui()) or game:GetService("CoreGui"),
})

-- ============================================================
-- JANELA
-- ============================================================
local Window = {}
Window.Tabs = {}
Window.ActiveTab = nil

local viewport = workspace.CurrentCamera.ViewportSize
local isSmall = viewport.X < 700
local winW = isSmall and math.min(viewport.X - 25, 520) or 620
local winH = isSmall and math.min(viewport.Y - 80, 400) or 420
local tabW = isSmall and 110 or 150

local MainFrame = new("Frame", {
    Name = "MainFrame",
    Size = UDim2.fromOffset(winW, winH),
    Position = UDim2.new(0.5, -winW / 2, 0.5, -winH / 2),
    BackgroundColor3 = Theme.BG,
    BorderSizePixel = 0,
    Active = true,
    ClipsDescendants = true,
    Parent = ScreenGui,
})
corner(MainFrame, 14)

-- Glow duplo neon
new("UIStroke", {
    Color = Theme.Glow,
    Thickness = 7,
    Transparency = 0.7,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = MainFrame,
})
new("UIStroke", {
    Color = Theme.AccentNeon,
    Thickness = 1.5,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = MainFrame,
})

-- Imagem de fundo (buraco negro)
local BgImage = new("ImageLabel", {
    Name = "BgImage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = BG_IMAGE_ID,
    ImageTransparency = 0.15,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0,
    Parent = MainFrame,
})
corner(BgImage, 14)

-- Overlay escuro pra melhorar leitura dos textos
local BgOverlay = new("Frame", {
    Name = "BgOverlay",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Theme.BG,
    BackgroundTransparency = 0.55,
    BorderSizePixel = 0,
    ZIndex = 0,
    Parent = MainFrame,
})
corner(BgOverlay, 14)

-- Estrelinhas decorativas
for i = 1, 25 do
    local star = new("Frame", {
        Size = UDim2.fromOffset(math.random(1, 3), math.random(1, 3)),
        Position = UDim2.new(math.random(), 0, math.random(), 0),
        BackgroundColor3 = Theme.AccentLight,
        BackgroundTransparency = math.random(40, 85) / 100,
        BorderSizePixel = 0,
        ZIndex = 1,
        Parent = MainFrame,
    })
    corner(star, 4)
end

-- ============================================================
-- TITLE BAR
-- ============================================================
local TitleBar = new("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 44),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 2,
    Parent = MainFrame,
})

-- Título roxo neon (sem círculo)
local TitleLabel = new("TextLabel", {
    Size = UDim2.new(1, -80, 1, 0),
    Position = UDim2.fromOffset(20, 0),
    BackgroundTransparency = 1,
    Text = "Toddynho 2.01",
    TextColor3 = Theme.AccentNeon,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
    Parent = TitleBar,
})
new("UIStroke", {
    Color = Theme.AccentDark,
    Thickness = 1.5,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
    Parent = TitleLabel,
})

local CloseBtn = new("TextButton", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(1, -42, 0.5, -15),
    BackgroundColor3 = Theme.Surface2,
    Text = "✕",
    TextColor3 = Theme.Text,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    ZIndex = 3,
    Parent = TitleBar,
})
corner(CloseBtn, 8)

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundColor3 = Theme.Red
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundColor3 = Theme.Surface2
end)

-- ============================================================
-- TAB BAR
-- ============================================================
local TabBar = new("Frame", {
    Name = "TabBar",
    Size = UDim2.new(0, tabW, 1, -58),
    Position = UDim2.fromOffset(8, 50),
    BackgroundColor3 = Theme.Surface,
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    ZIndex = 2,
    Parent = MainFrame,
})
corner(TabBar, 12)

new("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = TabBar,
})

new("UIPadding", {
    PaddingTop = UDim.new(0, 8),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    Parent = TabBar,
})

-- ============================================================
-- CONTENT
-- ============================================================
local Content = new("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -(tabW + 24), 1, -62),
    Position = UDim2.fromOffset(tabW + 16, 54),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 2,
    Parent = MainFrame,
})

-- Drag da janela
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end
-- ============================================================
-- NOTIFICACOES
-- ============================================================
local NotifyHolder = new("Frame", {
    Name = "Notifications",
    Size = UDim2.fromOffset(260, 400),
    Position = UDim2.new(1, -280, 0, 60),
    BackgroundTransparency = 1,
    Parent = ScreenGui,
})
new("UIListLayout", {
    Padding = UDim.new(0, 8),
    VerticalAlignment = Enum.VerticalAlignment.Top,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = NotifyHolder,
})

function Window:Notify(title, desc, duration)
    local n = new("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0,
        Parent = NotifyHolder,
    })
    corner(n, 8)
    stroke(n, Theme.Accent, 1)

    new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 20),
        Position = UDim2.fromOffset(12, 8),
        BackgroundTransparency = 1,
        Text = title or "Aviso",
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = n,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 20),
        Position = UDim2.fromOffset(12, 30),
        BackgroundTransparency = 1,
        Text = desc or "",
        TextColor3 = Theme.TextDim,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = n,
    })

    task.delay(duration or 3, function()
        for i = 0, 10 do
            n.BackgroundTransparency = i / 10
            task.wait(0.02)
        end
        n:Destroy()
    end)
end

-- ============================================================
-- WATERMARK
-- ============================================================
local Watermark = new("Frame", {
    Name = "Watermark",
    Size = UDim2.fromOffset(230, 30),
    Position = UDim2.new(0, 10, 0, 10),
    BackgroundColor3 = Theme.Surface,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    Parent = ScreenGui,
})
corner(Watermark, 8)
stroke(Watermark, Theme.Accent, 1)

new("Frame", {
    Size = UDim2.fromOffset(8, 8),
    Position = UDim2.new(0, 10, 0.5, -4),
    BackgroundColor3 = Theme.Accent,
    BorderSizePixel = 0,
    Parent = Watermark,
})

local wmDot = Watermark:FindFirstChildOfClass("Frame")
if wmDot then corner(wmDot, 4) end

local wmText = new("TextLabel", {
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.fromOffset(24, 0),
    BackgroundTransparency = 1,
    Text = "Toddynho 2.01 | -- FPS",
    TextColor3 = Theme.Text,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Watermark,
})

task.spawn(function()
    local frames, lastUpdate = 0, tick()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        if tick() - lastUpdate >= 1 then
            local fps = frames
            frames = 0
            lastUpdate = tick()
            wmText.Text = string.format("Toddynho 2.01 | %d FPS", fps)
        end
    end)
end)

-- ============================================================
-- ADD TAB
-- ============================================================
function Window:AddTab(name, icon)
    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Surface2,
        BackgroundTransparency = 0.3,
        Text = "",
        TextColor3 = Theme.TextDim,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Parent = TabBar,
    })
    corner(btn, 8)

    local btnIcon = new("TextLabel", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(0, 8, 0.5, -15),
        BackgroundTransparency = 1,
        Text = icon or "",
        TextColor3 = Theme.TextDim,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = btn,
    })

    local btnText = new("TextLabel", {
        Size = UDim2.new(1, -46, 1, 0),
        Position = UDim2.fromOffset(44, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Theme.TextDim,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = btn,
    })

    local page = new("ScrollingFrame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = Content,
    })
    new("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = page,
    })
    new("UIPadding", {
        PaddingRight = UDim.new(0, 8),
        Parent = page,
    })

    local tab = { Button = btn, Page = page, Name = name, Icon = btnIcon, Text = btnText }

    btn.MouseButton1Click:Connect(function()
        Window:SelectTab(tab)
    end)

    table.insert(self.Tabs, tab)
    if not self.ActiveTab then self:SelectTab(tab) end
    return tab
end

function Window:SelectTab(tab)
    self.ActiveTab = tab
    for _, t in ipairs(self.Tabs) do
        local active = (t == tab)
        t.Page.Visible = active
        t.Button.BackgroundColor3 = active and Theme.Accent or Theme.Surface2
        t.Button.BackgroundTransparency = active and 0 or 0.3
        t.Icon.TextColor3 = active and Theme.Text or Theme.TextDim
        t.Text.TextColor3 = active and Theme.Text or Theme.TextDim
    end
end

-- ============================================================
-- ADD SECTION (com linha divisoria e icone)
-- ============================================================
function Window:AddSection(tab, name, icon)
    local f = new("Frame", {
        Size = UDim2.new(1, 0, 0, 26),
        BackgroundTransparency = 1,
        Parent = tab.Page,
    })

    if icon then
        new("TextLabel", {
            Size = UDim2.fromOffset(24, 24),
            Position = UDim2.fromOffset(0, 1),
            BackgroundTransparency = 1,
            Text = icon,
            TextColor3 = Theme.Accent,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = f,
        })
    end

    local title = new("TextLabel", {
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.fromOffset(icon and 26 or 0, 0),
        BackgroundTransparency = 1,
        Text = name:upper(),
        TextColor3 = Theme.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = f,
    })

    -- Linha divisoria com gradiente
    local line = new("Frame", {
        Size = UDim2.new(1, -(icon and 226 or 200), 1, 0),
        Position = UDim2.new(0, icon and 226 or 200, 0, 0),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = f,
    })
    addGradient(line, Theme.Accent, Theme.Surface, 0)
end

-- ============================================================
-- ADD TOGGLE (pill estilo imagem)
-- ============================================================
function Window:AddToggle(tab, opts)
    local title = opts.Title or "Toggle"
    local default = opts.Default or false
    local callback = opts.Callback or function() end

    local holder = new("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = tab.Page,
    })
    corner(holder, 10)
    stroke(holder, Theme.Outline, 1)

    new("TextLabel", {
        Size = UDim2.new(1, -80, 0, 22),
        Position = UDim2.fromOffset(14, 6),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = holder,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -80, 0, 16),
        Position = UDim2.fromOffset(14, 28),
        BackgroundTransparency = 1,
        Text = opts.Description or "",
        TextColor3 = Theme.TextDim,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = holder,
    })

    local switchBg = new("Frame", {
        Size = UDim2.fromOffset(48, 24),
        Position = UDim2.new(1, -62, 0.5, -12),
        BackgroundColor3 = default and Theme.Accent or Theme.Surface2,
        BorderSizePixel = 0,
        Parent = holder,
    })
    corner(switchBg, 12)

    if default then
        stroke(switchBg, Theme.AccentNeon, 1)
    end

    local knob = new("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = default and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Parent = switchBg,
    })
    corner(knob, 9)

    local btn = new("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        Parent = holder,
    })

    local state = default
    local function set(v)
        state = v
        TweenService:Create(switchBg, TweenInfo.new(0.15), {
            BackgroundColor3 = v and Theme.Accent or Theme.Surface2,
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = v and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
        }):Play()
        pcall(callback, v)
    end

    btn.MouseButton1Click:Connect(function()
        set(not state)
    end)

    return { Set = set, Get = function() return state end }
end
-- ============================================================
-- ADD BUTTON
-- ============================================================
function Window:AddButton(tab, opts)
    local title = opts.Title or "Button"
    local callback = opts.Callback or function() end

    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.2,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamMedium,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Parent = tab.Page,
    })
    corner(btn, 10)
    stroke(btn, Theme.Outline, 1)

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Theme.Surface2
        btn.BackgroundTransparency = 0
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Theme.Surface
        btn.BackgroundTransparency = 0.2
    end)
    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- ============================================================
-- ADD SLIDER
-- ============================================================
function Window:AddSlider(tab, opts)
    local title = opts.Title or "Slider"
    local min = opts.Min or 0
    local max = opts.Max or 100
    local default = opts.Default or min
    local callback = opts.Callback or function() end

    local holder = new("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = tab.Page,
    })
    corner(holder, 10)
    stroke(holder, Theme.Outline, 1)

    local label = new("TextLabel", {
        Size = UDim2.new(1, -16, 0, 22),
        Position = UDim2.fromOffset(14, 6),
        BackgroundTransparency = 1,
        Text = title .. ": " .. tostring(default),
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = holder,
    })

    local barBg = new("Frame", {
        Size = UDim2.new(1, -28, 0, 8),
        Position = UDim2.new(0, 14, 1, -22),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0,
        Parent = holder,
    })
    corner(barBg, 4)

    local fill = new("Frame", {
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Parent = barBg,
    })
    corner(fill, 4)
    addGradient(fill, Theme.AccentNeon, Theme.Accent, 0)

    local dragBtn = new("TextButton", {
        Size = UDim2.fromScale(1, 3),
        Position = UDim2.new(0, 0, 0.5, -12),
        BackgroundTransparency = 1,
        Text = "",
        Parent = barBg,
    })

    local value = default
    local dragging = false

    local function updateFromX(x)
        local rel = math.clamp((x - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
        value = math.floor(min + rel * (max - min) + 0.5)
        fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        label.Text = title .. ": " .. tostring(value)
        pcall(callback, value)
    end

    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromX(input.Position.X)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromX(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return {
        Set = function(v)
            value = math.clamp(v, min, max)
            fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            label.Text = title .. ": " .. tostring(value)
            pcall(callback, value)
        end,
        Get = function() return value end,
    }
end

-- ============================================================
-- ADD DROPDOWN
-- ============================================================
function Window:AddDropdown(tab, opts)
    local title = opts.Title or "Dropdown"
    local options = opts.Options or {}
    local callback = opts.Callback or function() end

    local holder = new("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = tab.Page,
    })
    corner(holder, 10)
    stroke(holder, Theme.Outline, 1)

    local header = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Text = "",
        Parent = holder,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 22),
        Position = UDim2.fromOffset(14, 6),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = holder,
    })
    local valueLabel = new("TextLabel", {
        Size = UDim2.new(1, -60, 0, 16),
        Position = UDim2.fromOffset(14, 28),
        BackgroundTransparency = 1,
        Text = opts.Default or "Selecione...",
        TextColor3 = Theme.TextDim,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = holder,
    })
    new("TextLabel", {
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.new(1, -32, 0.5, -10),
        BackgroundTransparency = 1,
        Text = "v",
        TextColor3 = Theme.TextDim,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        Parent = holder,
    })

    local list = new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.fromOffset(0, 50),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0,
        Parent = holder,
    })
    new("UIListLayout", {
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = list,
    })
    new("UIPadding", {
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
        PaddingLeft = UDim.new(0, 4),
        PaddingRight = UDim.new(0, 4),
        Parent = list,
    })

    local expanded = false
    local buttons = {}

    local function refresh(newOptions)
        options = newOptions
        for _, b in ipairs(buttons) do b:Destroy() end
        buttons = {}
        for _, opt in ipairs(options) do
            local ob = new("TextButton", {
                Size = UDim2.new(1, 0, 0, 26),
                BackgroundColor3 = Theme.Surface,
                Text = "  " .. tostring(opt),
                TextColor3 = Theme.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Parent = list,
            })
            corner(ob, 6)
            ob.MouseEnter:Connect(function()
                ob.BackgroundColor3 = Theme.Accent
            end)
            ob.MouseLeave:Connect(function()
                ob.BackgroundColor3 = Theme.Surface
            end)
            ob.MouseButton1Click:Connect(function()
                valueLabel.Text = tostring(opt)
                expanded = false
                holder.Size = UDim2.new(1, 0, 0, 50)
                list.Size = UDim2.new(1, 0, 0, 0)
                pcall(callback, opt)
            end)
            table.insert(buttons, ob)
        end
    end

    header.MouseButton1Click:Connect(function()
        expanded = not expanded
        if expanded then
            local h = math.min(#options * 28 + 8, 200)
            holder.Size = UDim2.new(1, 0, 0, 50 + h)
            list.Size = UDim2.new(1, 0, 0, h)
        else
            holder.Size = UDim2.new(1, 0, 0, 50)
            list.Size = UDim2.new(1, 0, 0, 0)
        end
    end)

    refresh(options)
    return { Refresh = refresh }
end

-- ============================================================
-- ADD COLOR PICKER
-- ============================================================
function Window:AddColorPicker(tab, opts)
    local title = opts.Title or "Cor"
    local default = opts.Default or Color3.fromRGB(160, 80, 255)
    local callback = opts.Callback or function() end

    local holder = new("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = tab.Page,
    })
    corner(holder, 10)
    stroke(holder, Theme.Outline, 1)

    new("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.fromOffset(14, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = holder,
    })

    local swatch = new("Frame", {
        Size = UDim2.fromOffset(42, 26),
        Position = UDim2.new(1, -56, 0.5, -13),
        BackgroundColor3 = default,
        BorderSizePixel = 0,
        Parent = holder,
    })
    corner(swatch, 7)
    stroke(swatch, Theme.Outline, 1)

    local pickerBtn = new("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        Parent = swatch,
    })

    pickerBtn.MouseButton1Click:Connect(function()
        local colors = {
            Color3.fromRGB(160, 80, 255),
            Color3.fromRGB(80, 160, 255),
            Color3.fromRGB(80, 255, 160),
            Color3.fromRGB(255, 220, 80),
            Color3.fromRGB(255, 80, 80),
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 140, 0),
            Color3.fromRGB(0, 255, 255),
        }
        local idx = 1
        for i, c in ipairs(colors) do
            if c == swatch.BackgroundColor3 then idx = (i % #colors) + 1 break end
        end
        swatch.BackgroundColor3 = colors[idx]
        pcall(callback, colors[idx])
    end)

    return {
        Set = function(c)
            swatch.BackgroundColor3 = c
            pcall(callback, c)
        end,
    }
end

-- ============================================================
-- ADD KEYBIND
-- ============================================================
function Window:AddKeybind(tab, opts)
    local title = opts.Title or "Keybind"
    local default = opts.Default or Enum.KeyCode.Unknown
    local callback = opts.Callback or function() end

    local holder = new("Frame", {
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = tab.Page,
    })
    corner(holder, 10)
    stroke(holder, Theme.Outline, 1)

    new("TextLabel", {
        Size = UDim2.new(1, -110, 1, 0),
        Position = UDim2.fromOffset(14, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = holder,
    })

    local keyBtn = new("TextButton", {
        Size = UDim2.fromOffset(84, 28),
        Position = UDim2.new(1, -94, 0.5, -14),
        BackgroundColor3 = Theme.Surface2,
        Text = default == Enum.KeyCode.Unknown and "Nenhuma" or default.Name,
        TextColor3 = Theme.Text,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Parent = holder,
    })
    corner(keyBtn, 7)

    local currentKey = default
    local listening = false

    keyBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        keyBtn.Text = "..."
        keyBtn.BackgroundColor3 = Theme.Accent
    end)

    UIS.InputBegan:Connect(function(input, processed)
        if not listening then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        listening = false
        keyBtn.BackgroundColor3 = Theme.Surface2
        if input.KeyCode == Enum.KeyCode.Backspace then
            currentKey = Enum.KeyCode.Unknown
            keyBtn.Text = "Nenhuma"
        else
            currentKey = input.KeyCode
            keyBtn.Text = input.KeyCode.Name
        end
    end)

    UIS.InputBegan:Connect(function(input, processed)
        if processed or listening then return end
        if currentKey ~= Enum.KeyCode.Unknown and input.KeyCode == currentKey then
            pcall(callback, currentKey)
        end
    end)

    return {
        Get = function() return currentKey end,
        Set = function(k)
            currentKey = k
            keyBtn.Text = k == Enum.KeyCode.Unknown and "Nenhuma" or k.Name
        end,
    }
end
-- ============================================================
-- SAVE / LOAD CONFIG (silencioso no autosave)
-- ============================================================
local CONFIG_FILE = "Toddynho201_Config.json"
local ConfigRegistry = {}

local function saveConfig(silent)
    local data = {}
    for key, entry in pairs(ConfigRegistry) do
        local val = entry.getter and entry.getter()
        if typeof(val) == "Color3" then
            data[key] = { __color = { val.R * 255, val.G * 255, val.B * 255 } }
        else
            data[key] = { value = val }
        end
    end
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    if ok and writefile then
        pcall(function() writefile(CONFIG_FILE, encoded) end)
        if not silent then
            Window:Notify("Config", "Salvo ✅", 2)
        end
    end
end

local function loadConfig()
    if not (isfile and isfile(CONFIG_FILE)) then
        Window:Notify("Config", "Nenhum config salvo", 2)
        return
    end
    local ok, content = pcall(function() return readfile(CONFIG_FILE) end)
    if not ok then return end
    local ok2, data = pcall(function() return HttpService:JSONDecode(content) end)
    if not ok2 or not data then return end

    for key, entry in pairs(data) do
        local reg = ConfigRegistry[key]
        if reg and reg.setter then
            local v = entry.value
            if entry.__color and type(entry.__color) == "table" and #entry.__color >= 3 then
                v = Color3.fromRGB(entry.__color[1], entry.__color[2], entry.__color[3])
            end
            if v ~= nil then pcall(reg.setter, v) end
        end
    end
    Window:Notify("Config", "Carregado ✅", 2)
end

local function registerConfig(key, getter, setter)
    ConfigRegistry[key] = { getter = getter, setter = setter }
end

_G.ToddynhoRegisterConfig = registerConfig
_G.ToddynhoSaveConfig = saveConfig
_G.ToddynhoLoadConfig = loadConfig

-- Autosave silencioso a cada 30s
task.spawn(function()
    while task.wait(30) do
        pcall(function() saveConfig(true) end)
    end
end)

-- ============================================================
-- CRIA AS ABAS
-- ============================================================
local CombatTab = Window:AddTab("Combat", Icons.Combat)
local LocalTab = Window:AddTab("LocalPlayer", Icons.User)
local FarmTab = Window:AddTab("AutoFarm", Icons.Money)
local VisualTab = Window:AddTab("Visuals", Icons.Eye)
local SettingsTab = Window:AddTab("Settings", Icons.Gear)

-- ============================================================
-- SETTINGS TAB
-- ============================================================
Window:AddSection(SettingsTab, "Configuracoes", Icons.Gear)

Window:AddButton(SettingsTab, {
    Title = "Salvar Config",
    Callback = function() saveConfig(false) end,
})

Window:AddButton(SettingsTab, {
    Title = "Carregar Config",
    Callback = function() loadConfig() end,
})

Window:AddButton(SettingsTab, {
    Title = "Resetar Config",
    Callback = function()
        if delfile then
            pcall(function() delfile(CONFIG_FILE) end)
            Window:Notify("Config", "Apagado", 2)
        end
    end,
})

Window:AddSection(SettingsTab, "Informacoes", Icons.Star)

local InfoLabel = new("TextLabel", {
    Size = UDim2.new(1, 0, 0, 70),
    BackgroundColor3 = Theme.Surface,
    BackgroundTransparency = 0.2,
    Text = "Toddynhohub 2.01\nFeito por wandinhozin-ship-it\nPanic Key: End",
    TextColor3 = Theme.Text,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    BorderSizePixel = 0,
    Parent = SettingsTab.Page,
})
corner(InfoLabel, 10)
stroke(InfoLabel, Theme.Outline, 1)

-- ============================================================
-- ROLE TRACKING
-- ============================================================
local Roles = { Sheriff = nil, Murderer = nil, Innocent = nil, Hero = nil }

local okRemotes, Remotes = pcall(function() return RS:WaitForChild("Remotes", 10) end)
local GetPlayerData, PlayerDataChanged
if okRemotes and Remotes then
    local extras = Remotes:FindFirstChild("Extras")
    local gameplay = Remotes:FindFirstChild("Gameplay")
    if extras then GetPlayerData = extras:FindFirstChild("GetPlayerData") end
    if gameplay then PlayerDataChanged = gameplay:FindFirstChild("PlayerDataChanged") end
end

local function applyRoleData(data)
    if not data then return end
    for name, info in pairs(data) do
        local plr = Players:FindFirstChild(name)
        if plr and info and info.Role then
            for r, p in pairs(Roles) do
                if p == plr then Roles[r] = nil end
            end
            Roles[info.Role] = plr
        end
    end
end

local function refreshRoles()
    if not GetPlayerData then return end
    local ok, data = pcall(function() return GetPlayerData:InvokeServer() end)
    if ok then applyRoleData(data) end
end

if PlayerDataChanged then
    PlayerDataChanged.OnClientEvent:Connect(applyRoleData)
end

task.spawn(function()
    refreshRoles()
    while task.wait(3) do refreshRoles() end
end)

local function isMurderer() return Roles.Murderer == LP end
local function isSheriff() return Roles.Sheriff == LP end
local function isInnocent() return Roles.Innocent == LP end

-- ============================================================
-- COMBAT HELPERS
-- ============================================================
local function getKnife()
    if not LP.Character then return nil end
    local knife = LP.Character:FindFirstChild("Knife")
    if knife then return knife end
    if LP.Backpack then
        knife = LP.Backpack:FindFirstChild("Knife")
        if knife then
            knife.Parent = LP.Character
            return knife
        end
    end
    return nil
end

local function getGun()
    if not LP.Character then return nil end
    local gun = LP.Character:FindFirstChild("Gun")
    if gun then return gun end
    if LP.Backpack then
        gun = LP.Backpack:FindFirstChild("Gun")
        if gun then
            gun.Parent = LP.Character
            return gun
        end
    end
    return nil
end

local function stabPlayer(target)
    if not target or not target.Character then return false end
    local head = target.Character:FindFirstChild("Head")
    if not head then return false end
    local knife = getKnife()
    if not knife then return false end
    local events = knife:FindFirstChild("Events")
    if not events then return false end
    local ok = pcall(function()
        events.KnifeStabbed:FireServer()
        events.HandleTouched:FireServer(head)
    end)
    return ok
end

local function getPlayerList()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then table.insert(list, plr.Name) end
    end
    if #list == 0 then list = { "Nenhum jogador" } end
    return list
end
-- ============================================================
-- MURDER FUNCTIONS
-- ============================================================
Window:AddSection(CombatTab, "Murder Functions", Icons.Murder)

local autoKillAll = false

Window:AddToggle(CombatTab, {
    Title = "Auto Kill All",
    Description = "Mata todos automaticamente quando Murderer",
    Default = false,
    Callback = function(v) autoKillAll = v end,
})

Window:AddButton(CombatTab, {
    Title = "Kill All",
    Callback = function()
        if not isMurderer() then
            Window:Notify("Erro", "Voce precisa ser o Murderer!", 2)
            return
        end
        if not getKnife() then
            Window:Notify("Erro", "Faca nao encontrada", 2)
            return
        end
        local count = 0
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                if stabPlayer(plr) then count = count + 1 end
                task.wait(0.05)
            end
        end
        Window:Notify("Kill All", "Tentou matar " .. count .. " jogadores", 2)
    end,
})

local killDropdown = Window:AddDropdown(CombatTab, {
    Title = "Kill Selected Player",
    Description = "Escolha um jogador para matar",
    Options = getPlayerList(),
    Default = "Selecione...",
    Callback = function(v)
        if v == "Nenhum jogador" or v == "Selecione..." then return end
        local plr = Players:FindFirstChild(v)
        if not plr or not plr.Character or not plr.Character:FindFirstChild("Head") then
            Window:Notify("Erro", "Jogador invalido ou morto", 2)
            return
        end
        if not isMurderer() then
            Window:Notify("Erro", "Voce precisa ser o Murderer!", 2)
            return
        end
        if not getKnife() then
            Window:Notify("Erro", "Faca nao encontrada", 2)
            return
        end
        if stabPlayer(plr) then
            Window:Notify("Kill Selected", "Tentou matar " .. v, 2)
        else
            Window:Notify("Erro", "Falha ao matar " .. v, 2)
        end
    end,
})

Players.PlayerAdded:Connect(function()
    task.wait(1)
    killDropdown.Refresh(getPlayerList())
end)

Players.PlayerRemoving:Connect(function()
    task.wait(0.5)
    killDropdown.Refresh(getPlayerList())
end)

task.spawn(function()
    while task.wait(0.5) do
        if autoKillAll and isMurderer() then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                    stabPlayer(plr)
                    task.wait(0.05)
                end
            end
        end
    end
end)

-- ============================================================
-- KILL AURA
-- ============================================================
local killAuraOn = false
local killAuraRadius = 8

Window:AddToggle(CombatTab, {
    Title = "Kill Aura",
    Description = "Equipa a faca e mata qualquer jogador perto",
    Default = false,
    Callback = function(v) killAuraOn = v end,
})

Window:AddSlider(CombatTab, {
    Title = "Kill Aura Radius",
    Min = 5, Max = 20, Default = 8,
    Callback = function(v) killAuraRadius = v end,
})

task.spawn(function()
    while task.wait(0.1) do
        if killAuraOn and isMurderer() then
            local char = LP.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local knife = getKnife()
                if knife then
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LP and plr.Character then
                            local head = plr.Character:FindFirstChild("Head")
                            local theirRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                            if head and theirRoot then
                                local dist = (myRoot.Position - theirRoot.Position).Magnitude
                                if dist <= killAuraRadius then
                                    local events = knife:FindFirstChild("Events")
                                    if events then
                                        pcall(function()
                                            events.KnifeStabbed:FireServer()
                                            events.HandleTouched:FireServer(head)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- INNOCENT FUNCTIONS
-- ============================================================
Window:AddSection(CombatTab, "Innocent Functions", Icons.Innocent)

local autoGrabGun = false
local grabLoopRunning = false

local function findDroppedGun()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Gun" and obj:IsA("Tool") and obj.Parent == workspace then
            return obj
        end
    end
    return nil
end

Window:AddToggle(CombatTab, {
    Title = "Auto Grab Gun",
    Description = "Pega a arma do Sheriff quando ele morrer",
    Default = false,
    Callback = function(v)
        autoGrabGun = v
        if v and not grabLoopRunning then
            grabLoopRunning = true
            task.spawn(function()
                while autoGrabGun do
                    task.wait(0.3)
                    local hasGun = LP.Character and LP.Character:FindFirstChild("Gun")
                    if not hasGun then
                        local gun = findDroppedGun()
                        if gun then
                            local handle = gun:FindFirstChild("Handle")
                            if handle and LP.Character then
                                local hum = LP.Character:FindFirstChildOfClass("Humanoid")
                                if hum then
                                    hum:MoveTo(handle.Position)
                                    local root = LP.Character:FindFirstChild("HumanoidRootPart")
                                    if root and (root.Position - handle.Position).Magnitude < 5 then
                                        local prompt = gun:FindFirstChildOfClass("ProximityPrompt")
                                        if prompt then
                                            pcall(function()
                                                fireproximityprompt(prompt)
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                grabLoopRunning = false
            end)
        end
    end,
})

-- ============================================================
-- AUTO RESPAWN
-- ============================================================
local autoRespawn = false

Window:AddToggle(CombatTab, {
    Title = "Auto Respawn",
    Description = "Volta automaticamente quando morrer",
    Default = false,
    Callback = function(v) autoRespawn = v end,
})

task.spawn(function()
    while task.wait(1) do
        if autoRespawn then
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health <= 0 then
                task.wait(0.5)
                pcall(function() LP:LoadCharacter() end)
            end
        end
    end
end)
-- ============================================================
-- SHERIFF FUNCTIONS
-- ============================================================
Window:AddSection(CombatTab, "Sheriff Functions", Icons.Sheriff)

local function getPing()
    local ok, val = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    return ok and val or 50
end

local function predictPosition(rootPart, multiplier)
    multiplier = multiplier or 2.5
    local ping = getPing()
    local dt = (ping / 1000) * multiplier
    local vel = rootPart.Velocity
    local speed = vel.Magnitude
    if speed < 1 then
        return rootPart.Position + (rootPart.CFrame.LookVector * 2)
    else
        local adjust = 1 + (speed / 50)
        return rootPart.Position + (vel * dt * adjust)
    end
end

local autoShoot = false
local predictionMult = 2.5

local function shootMurderer()
    local murderer = Roles.Murderer
    if not murderer or not murderer.Character then return end
    local targetRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    local gun = getGun()
    if not gun then return end
    local shootRemote = gun:FindFirstChild("Shoot")
    if not shootRemote or not shootRemote:IsA("RemoteEvent") then return end
    local predictedPos = predictPosition(targetRoot, predictionMult)
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local origin = myRoot.Position - (myRoot.CFrame.LookVector * 1)
    pcall(function()
        shootRemote:FireServer(
            CFrame.new(origin.X, origin.Y, origin.Z),
            CFrame.new(predictedPos.X, predictedPos.Y, predictedPos.Z)
        )
    end)
end

Window:AddToggle(CombatTab, {
    Title = "Auto Shoot Murderer",
    Description = "Atira no Murderer com predicao",
    Default = false,
    Callback = function(v) autoShoot = v end,
})

Window:AddSlider(CombatTab, {
    Title = "Prediction Multiplier",
    Min = 1, Max = 10, Default = 3,
    Callback = function(v) predictionMult = v end,
})

task.spawn(function()
    while task.wait(0.1) do
        if autoShoot and isSheriff() then
            shootMurderer()
        end
    end
end)

-- ============================================================
-- MAGIC BULLET
-- ============================================================
local magicBulletOn = false
local magicConnection = nil
local disabledGunClients = {}

local function disableGunClient(gun)
    if not gun then return end
    local gc = gun:FindFirstChild("GunClient")
    if gc and gc:IsA("LocalScript") and gc.Enabled then
        gc.Enabled = false
        disabledGunClients[gun] = gc
    end
end

local function restoreGunClient(gun)
    local gc = disabledGunClients[gun]
    if gc and gc.Parent then gc.Enabled = true end
    disabledGunClients[gun] = nil
end

local function magicShoot(gun)
    local murderer = Roles.Murderer
    if not murderer or not murderer.Character then return end
    local targetRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    local shootRemote = gun:FindFirstChild("Shoot")
    if not shootRemote or not shootRemote:IsA("RemoteEvent") then return end
    local predictedPos = predictPosition(targetRoot, predictionMult)
    local origin = targetRoot.Position - (targetRoot.CFrame.LookVector * 1)
    pcall(function()
        shootRemote:FireServer(
            CFrame.new(origin.X, origin.Y, origin.Z),
            CFrame.new(predictedPos.X, predictedPos.Y, predictedPos.Z)
        )
    end)
end

local function setupMagicGun(gun)
    if not gun or not gun:IsA("Tool") then return end
    if magicConnection then magicConnection:Disconnect() end
    disableGunClient(gun)
    magicConnection = gun.Activated:Connect(function()
        if magicBulletOn then magicShoot(gun) end
    end)
end

local function monitorGuns()
    local function watch(container)
        container.ChildAdded:Connect(function(child)
            if child.Name == "Gun" and child:IsA("Tool") and magicBulletOn then
                task.wait(0.1)
                setupMagicGun(child)
            end
        end)
        local existing = container:FindFirstChild("Gun")
        if existing and magicBulletOn then
            task.wait(0.1)
            setupMagicGun(existing)
        end
    end
    if LP.Character then watch(LP.Character) end
    if LP.Backpack then watch(LP.Backpack) end
    LP.CharacterAdded:Connect(function(char)
        if not magicBulletOn then return end
        task.wait(1)
        watch(char)
        watch(LP.Backpack)
    end)
end

local function enableMagicBullet()
    magicBulletOn = true
    if LP.Character then
        local g = LP.Character:FindFirstChild("Gun")
        if g then setupMagicGun(g) end
    end
    if LP.Backpack then
        local g = LP.Backpack:FindFirstChild("Gun")
        if g then setupMagicGun(g) end
    end
end

local function disableMagicBullet()
    magicBulletOn = false
    if magicConnection then
        magicConnection:Disconnect()
        magicConnection = nil
    end
    for gun, _ in pairs(disabledGunClients) do
        restoreGunClient(gun)
    end
    disabledGunClients = {}
end

monitorGuns()

Window:AddToggle(CombatTab, {
    Title = "Magic Bullet",
    Description = "Atira da posicao do Murderer",
    Default = false,
    Callback = function(v)
        if v then
            enableMagicBullet()
            Window:Notify("Magic Bullet ON", "Atira da posicao do alvo", 2)
        else
            disableMagicBullet()
            Window:Notify("Magic Bullet OFF", "Normal restaurado", 2)
        end
    end,
})

-- ============================================================
-- SILENT AIM
-- ============================================================
Window:AddSection(CombatTab, "Silent Aim", Icons.Target)

local silentAimOn = false
local silentAimTarget = "Murderer"
local silentAimFov = 300
local silentAimPrediction = 3

local function getSilentAimTarget()
    if silentAimTarget == "Murderer" then
        local m = Roles.Murderer
        if m and m.Character then
            return m.Character:FindFirstChild("HumanoidRootPart")
        end
        return nil
    elseif silentAimTarget == "Sheriff" then
        local s = Roles.Sheriff
        if s and s.Character and s ~= LP then
            return s.Character:FindFirstChild("HumanoidRootPart")
        end
        return nil
    elseif silentAimTarget == "Todos" then
        local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local closest, closestDist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local r = plr.Character:FindFirstChild("HumanoidRootPart")
                if r then
                    local d = (myRoot.Position - r.Position).Magnitude
                    if d < closestDist and d < silentAimFov then
                        closest, closestDist = r, d
                    end
                end
            end
        end
        return closest
    end
    return nil
end

local silentAimConn = nil

local function silentAimLoop()
    if silentAimConn then silentAimConn:Disconnect() end
    silentAimConn = RunService.RenderStepped:Connect(function()
        if not silentAimOn then return end
        local target = getSilentAimTarget()
        if not target then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local predicted = predictPosition(target, silentAimPrediction)
        cam.CFrame = CFrame.new(cam.CFrame.Position, predicted)
    end)
end

Window:AddToggle(CombatTab, {
    Title = "Silent Aim",
    Description = "Mira automatica no alvo",
    Default = false,
    Callback = function(v)
        silentAimOn = v
        if v then silentAimLoop() end
        if not v and silentAimConn then
            silentAimConn:Disconnect()
            silentAimConn = nil
        end
    end,
})

Window:AddDropdown(CombatTab, {
    Title = "Silent Aim Target",
    Options = { "Murderer", "Sheriff", "Todos" },
    Default = "Murderer",
    Callback = function(v) silentAimTarget = v end,
})

Window:AddSlider(CombatTab, {
    Title = "Silent Aim FOV",
    Min = 100, Max = 1000, Default = 300,
    Callback = function(v) silentAimFov = v end,
})

Window:AddSlider(CombatTab, {
    Title = "Silent Aim Prediction",
    Min = 0, Max = 10, Default = 3,
    Callback = function(v) silentAimPrediction = v end,
})

-- ============================================================
-- AIMBOT
-- ============================================================
Window:AddSection(CombatTab, "Aimbot", Icons.Crosshair)

local aimbotOn = false
local aimbotKey = Enum.KeyCode.E
local aimbotUseKey = false
local aimbotConn = nil

local function aimbotLoop()
    if aimbotConn then aimbotConn:Disconnect() end
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not aimbotOn then return end
        if aimbotUseKey and not UIS:IsKeyDown(aimbotKey) then return end
        local target = getSilentAimTarget()
        if not target then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local predicted = predictPosition(target, silentAimPrediction)
        cam.CFrame = CFrame.new(cam.CFrame.Position, predicted)
    end)
end

Window:AddToggle(CombatTab, {
    Title = "Aimbot",
    Description = "Trava a mira no alvo",
    Default = false,
    Callback = function(v)
        aimbotOn = v
        if v then
            aimbotLoop()
        elseif aimbotConn then
            aimbotConn:Disconnect()
            aimbotConn = nil
        end
    end,
})

Window:AddToggle(CombatTab, {
    Title = "Aimbot: usar tecla",
    Description = "So ativa enquanto a tecla estiver pressionada",
    Default = false,
    Callback = function(v) aimbotUseKey = v end,
})

Window:AddKeybind(CombatTab, {
    Title = "Aimbot Key",
    Default = Enum.KeyCode.E,
    Callback = function(k) aimbotKey = k end,
})

-- ============================================================
-- FLING
-- ============================================================
Window:AddSection(CombatTab, "Fling", Icons.Sparkle)

local flingActive = false
local flingTarget = nil
local flingConn = nil

local function skidFling(target)
    if not target or not target.Character then return end
    if flingConn then flingConn:Disconnect() end

    local flingPart = Instance.new("Part")
    flingPart.Size = Vector3.new(1, 1, 1)
    flingPart.Transparency = 1
    flingPart.CanCollide = false
    flingPart.Anchored = false
    flingPart.Parent = workspace

    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = flingPart

    flingConn = RunService.Heartbeat:Connect(function()
        if not flingActive or not target.Character then return end
        local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if not tRoot then return end
        flingPart.CFrame = tRoot.CFrame
        bv.Velocity = Vector3.new(
            math.random(-100000, 100000),
            math.random(-100000, 100000),
            math.random(-100000, 100000)
        )
    end)

    task.delay(5, function()
        flingActive = false
        if flingConn then flingConn:Disconnect() end
        flingPart:Destroy()
    end)
end

local flingDropdown = Window:AddDropdown(CombatTab, {
    Title = "Fling Target",
    Options = getPlayerList(),
    Default = "Selecione...",
    Callback = function(v)
        if v == "Nenhum jogador" or v == "Selecione..." then return end
        flingTarget = Players:FindFirstChild(v)
    end,
})

Window:AddButton(CombatTab, {
    Title = "Fling Selected",
    Callback = function()
        if not flingTarget or not flingTarget.Character then
            Window:Notify("Erro", "Selecione um jogador valido", 2)
            return
        end
        flingActive = true
        skidFling(flingTarget)
        Window:Notify("Fling", "Arremessando " .. flingTarget.Name, 2)
    end,
})

Players.PlayerAdded:Connect(function()
    task.wait(1)
    flingDropdown.Refresh(getPlayerList())
end)

Players.PlayerRemoving:Connect(function()
    task.wait(0.5)
    flingDropdown.Refresh(getPlayerList())
end)

-- ============================================================
-- NOCLIP
-- ============================================================
Window:AddSection(CombatTab, "Noclip", Icons.Eye)

local noclipEnabled = false
local noclipConn = nil

local function startNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LP.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                pcall(function() part.CanCollide = false end)
            end
        end
    end)
end

local function stopNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
end

Window:AddToggle(CombatTab, {
    Title = "Noclip",
    Description = "Atravessa paredes",
    Default = false,
    Callback = function(v)
        noclipEnabled = v
        if v then startNoclip() else stopNoclip() end
    end,
})

Window:AddKeybind(CombatTab, {
    Title = "Noclip Key",
    Default = Enum.KeyCode.N,
    Callback = function()
        noclipEnabled = not noclipEnabled
        if noclipEnabled then startNoclip() else stopNoclip() end
        Window:Notify("Noclip", noclipEnabled and "Ligado" or "Desligado", 1)
    end,
})

-- ============================================================
-- SERVER HOP
-- ============================================================
Window:AddSection(CombatTab, "Server Hop", Icons.Star)

local function serverHop()
    local placeId = game.PlaceId
    local ok, response = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100")
    end)

    if not ok or not response then
        Window:Notify("Server Hop", "Falha ao buscar servidores", 3)
        return
    end

    local ok2, data = pcall(function() return HttpService:JSONDecode(response) end)
    if not ok2 or not data or not data.data then
        Window:Notify("Server Hop", "Sem servidores disponiveis", 3)
        return
    end

    local servers = {}
    for _, srv in ipairs(data.data) do
        if srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
            table.insert(servers, srv.id)
        end
    end

    if #servers == 0 then
        Window:Notify("Server Hop", "Nenhum servidor disponivel", 3)
        return
    end

    local chosen = servers[math.random(1, #servers)]
    Window:Notify("Server Hop", "Entrando em outro servidor...", 2)
    task.wait(1)
    pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, chosen, LP)
    end)
end

Window:AddButton(CombatTab, {
    Title = "Server Hop",
    Callback = serverHop,
})

-- ============================================================
-- PREDICTION BEAM
-- ============================================================
Window:AddSection(CombatTab, "Prediction Beam", Icons.Target)

local showPrediction = false
local beamParts = nil
local beamConn = nil

local function createBeamParts()
    if beamParts then return beamParts end
    local p0 = Instance.new("Part")
    p0.Name = "PredPart0"
    p0.Anchored = true
    p0.CanCollide = false
    p0.Transparency = 1
    p0.Size = Vector3.new(0.1, 0.1, 0.1)
    p0.Parent = workspace

    local p1 = Instance.new("Part")
    p1.Name = "PredPart1"
    p1.Anchored = true
    p1.CanCollide = false
    p1.Transparency = 1
    p1.Size = Vector3.new(0.1, 0.1, 0.1)
    p1.Parent = workspace

    local a0 = Instance.new("Attachment")
    a0.Parent = p0
    local a1 = Instance.new("Attachment")
    a1.Parent = p1

    local beam = Instance.new("Beam")
    beam.FaceCamera = true
    beam.Width0 = 0.2
    beam.Width1 = 0.2
    beam.Color = ColorSequence.new(Theme.Accent)
    beam.Transparency = NumberSequence.new(0.4)
    beam.LightEmission = 1
    beam.LightInfluence = 0
    beam.Attachment0 = a0
    beam.Attachment1 = a1
    beam.Parent = p0

    beamParts = { P0 = p0, P1 = p1, Beam = beam }
    return beamParts
end

local function destroyBeamParts()
    if beamParts then
        beamParts.P0:Destroy()
        beamParts.P1:Destroy()
        beamParts = nil
    end
end

Window:AddToggle(CombatTab, {
    Title = "Show Prediction Beam",
    Description = "Linha ate a posicao prevista do alvo",
    Default = false,
    Callback = function(v)
        showPrediction = v
        if v then
            createBeamParts()
            if not beamConn then
                beamConn = RunService.RenderStepped:Connect(function()
                    if not showPrediction or not beamParts then return end
                    local target = getSilentAimTarget()
                    if not target then return end
                    local pos = predictPosition(target, predictionMult)
                    beamParts.P0.Position = target.Position
                    beamParts.P1.Position = pos
                end)
            end
        else
            if beamConn then beamConn:Disconnect() beamConn = nil end
            destroyBeamParts()
        end
    end,
})
-- ============================================================
-- LOCALPLAYER - ANTI-FLING
-- ============================================================
Window:AddSection(LocalTab, "Anti-Fling", Icons.Shield)

local antiFlingOn = false

local function setupAntiFling(char)
    if not char then return end
    local function disableCollide(part)
        if antiFlingOn and part:IsA("BasePart") then
            pcall(function() part.CanCollide = false end)
        end
    end
    for _, part in ipairs(char:GetChildren()) do
        disableCollide(part)
    end
    local c1 = char.ChildAdded:Connect(disableCollide)
    local c2 = RunService.Stepped:Connect(function()
        if antiFlingOn and char:IsDescendantOf(workspace) then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    pcall(function() part.CanCollide = false end)
                end
            end
        end
    end)
    char.Destroying:Connect(function()
        c1:Disconnect()
        c2:Disconnect()
    end)
end

local function trackPlayerAF(plr)
    if plr == LP then return end
    plr.CharacterAdded:Connect(function(char)
        if antiFlingOn then setupAntiFling(char) end
    end)
    if plr.Character and antiFlingOn then
        setupAntiFling(plr.Character)
    end
end

for _, plr in ipairs(Players:GetPlayers()) do trackPlayerAF(plr) end
Players.PlayerAdded:Connect(trackPlayerAF)

Window:AddToggle(LocalTab, {
    Title = "Anti-Fling",
    Description = "Impede outros jogadores de te arremessarem",
    Default = false,
    Callback = function(v)
        antiFlingOn = v
        if v then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then setupAntiFling(plr.Character) end
            end
        end
    end,
})

-- ============================================================
-- VOID HIDE
-- ============================================================
Window:AddSection(LocalTab, "Void Hide", Icons.Eye)

local VoidHide = {
    Enabled = false,
    UpdateRate = 0.1,
    VoidChangeRate = 0.06,
    OffsetY = 9e9 - 1000,
    RandomPos = true,
    RangeXZ = { 100000000, 1000000000 },
    RangeY = { 100000000, 1000000000 },
}

local spoofed = {}
local realCFrame = CFrame.new()
local lastChange = tick()
local lastVoid = tick()
local currentVoidPos = nil
local inVoid = false
local oldIndex, oldNewIndex
local voidConn = nil

local function randomLarge(min, max)
    local range = max - min
    return min + math.random(0, 999999) + math.random(0, 999) * 1000000 % range
end

local function initHook()
    if oldIndex then return end
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if not checkcaller() and self and key then
            local s = spoofed[self]
            if s and s[key] ~= nil then return s[key] end
        end
        return oldIndex(self, key)
    end)
    oldNewIndex = hookmetamethod(game, "__newindex", function(self, key, val)
        if not checkcaller() and self and key and val then
            local s = spoofed[self]
            if s and key == "CFrame" then
                s[key] = val
                if VoidHide.Enabled then return end
            end
        end
        return oldNewIndex(self, key, val)
    end)
end

local function voidSpam(_, rootPart)
    if not VoidHide.Enabled then
        inVoid = false
        currentVoidPos = nil
        return
    end
    if not rootPart or not rootPart.Parent then return end
    local now = tick()
    if not currentVoidPos or (now - lastChange) >= VoidHide.VoidChangeRate then
        if VoidHide.RandomPos then
            local x = randomLarge(VoidHide.RangeXZ[1], VoidHide.RangeXZ[2])
            local y = randomLarge(VoidHide.RangeY[1], VoidHide.RangeY[2])
            local z = randomLarge(VoidHide.RangeXZ[1], VoidHide.RangeXZ[2])
            if math.random() > 0.5 then x = -x end
            if math.random() > 0.5 then z = -z end
            currentVoidPos = CFrame.new(x, y, z)
        else
            currentVoidPos = CFrame.new(
                realCFrame.Position - Vector3.new(0, VoidHide.OffsetY, 0)
            )
        end
        lastChange = now
    end
    if now - lastVoid > VoidHide.UpdateRate and not inVoid then
        inVoid = true
        task.delay(VoidHide.UpdateRate, function()
            lastVoid = now
            inVoid = false
        end)
    end
    if inVoid then
        realCFrame = oldIndex(rootPart, "CFrame")
        local vel = oldIndex(rootPart, "Velocity")
        spoofed[rootPart]["CFrame"] = realCFrame
        oldNewIndex(rootPart, "CFrame", currentVoidPos)
        RunService.RenderStepped:Wait()
        oldNewIndex(rootPart, "CFrame", realCFrame)
        oldNewIndex(rootPart, "Velocity", vel)
    else
        spoofed[rootPart]["CFrame"] = nil
    end
end

local function enableVoidHide()
    initHook()
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then spoofed[root] = {} end
    if not voidConn then
        voidConn = RunService.Heartbeat:Connect(function()
            local c = LP.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if not r or not r.Parent then
                if c then
                    r = c:WaitForChild("HumanoidRootPart", 1)
                    if r then spoofed[r] = {} end
                end
                return
            end
            if not spoofed[r] then spoofed[r] = {} end
            pcall(voidSpam, nil, r)
        end)
    end
end

local function disableVoidHide()
    if voidConn then
        voidConn:Disconnect()
        voidConn = nil
    end
    inVoid = false
    currentVoidPos = nil
    local c = LP.Character
    local r = c and c:FindFirstChild("HumanoidRootPart")
    if r and spoofed[r] then spoofed[r]["CFrame"] = nil end
end

Window:AddToggle(LocalTab, {
    Title = "Void Hide",
    Description = "Servidor te ve no void",
    Default = false,
    Callback = function(v)
        VoidHide.Enabled = v
        if v then
            enableVoidHide()
            Window:Notify("Void Hide ON", "Invisivel pro servidor", 3)
        else
            disableVoidHide()
            Window:Notify("Void Hide OFF", "Posicao normal", 2)
        end
    end,
})

LP.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local root = char:WaitForChild("HumanoidRootPart", 5)
    if root and VoidHide.Enabled then
        spoofed[root] = {}
        if voidConn then voidConn:Disconnect() end
        voidConn = nil
        enableVoidHide()
    end
end)

-- ============================================================
-- CHARACTER MODIFIERS
-- ============================================================
Window:AddSection(LocalTab, "Character Modifiers", Icons.Star)

local wsEnabled = false
local wsValue = 16

local function applyWalkSpeed()
    if not wsEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum.WalkSpeed = wsValue end) end
end

Window:AddToggle(LocalTab, {
    Title = "Custom WalkSpeed",
    Description = "Velocidade personalizada",
    Default = false,
    Callback = function(v)
        wsEnabled = v
        if v then applyWalkSpeed()
        else
            local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end,
})

Window:AddSlider(LocalTab, {
    Title = "WalkSpeed Value",
    Min = 16, Max = 200, Default = 16,
    Callback = function(v)
        wsValue = v
        if wsEnabled then applyWalkSpeed() end
    end,
})

local jpEnabled = false
local jpValue = 50

local function applyJumpPower()
    if not jpEnabled then return end
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            hum.UseJumpPower = true
            hum.JumpPower = jpValue
        end)
    end
end

Window:AddToggle(LocalTab, {
    Title = "Custom JumpPower",
    Description = "Forca de pulo personalizada",
    Default = false,
    Callback = function(v)
        jpEnabled = v
        if v then applyJumpPower()
        else
            local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = 50
            end
        end
    end,
})

Window:AddSlider(LocalTab, {
    Title = "JumpPower Value",
    Min = 50, Max = 250, Default = 50,
    Callback = function(v)
        jpValue = v
        if jpEnabled then applyJumpPower() end
    end,
})

local fovEnabled = false
local fovValue = 70

local function applyFOV()
    if not fovEnabled then return end
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = fovValue end
end

Window:AddToggle(LocalTab, {
    Title = "Custom FOV",
    Description = "Campo de visao personalizado",
    Default = false,
    Callback = function(v)
        fovEnabled = v
        if v then applyFOV()
        else
            local cam = workspace.CurrentCamera
            if cam then cam.FieldOfView = 70 end
        end
    end,
})

Window:AddSlider(LocalTab, {
    Title = "FOV Value",
    Min = 70, Max = 120, Default = 70,
    Callback = function(v)
        fovValue = v
        if fovEnabled then applyFOV() end
    end,
})

task.spawn(function()
    while task.wait(0.5) do
        if wsEnabled then applyWalkSpeed() end
        if jpEnabled then applyJumpPower() end
        if fovEnabled then applyFOV() end
    end
end)

LP.CharacterAdded:Connect(function()
    task.wait(1)
    if wsEnabled then applyWalkSpeed() end
    if jpEnabled then applyJumpPower() end
    if fovEnabled then applyFOV() end
end)

-- ============================================================
-- AURAS MELHORADAS
-- ============================================================
Window:AddSection(VisualTab, "Character Aura", Icons.Sparkle)

local auraEnabled = false
local selectedAuras = {}
local auraTemplates = {}
local auraParts = {}
local auraColorOverride = nil
local auraTransparency = 0.5

local AURA_ASSETS = {
    starlight = "rbxassetid://134645216613107",
    heavenly  = "rbxassetid://139300897520961",
    ribbon    = "rbxassetid://132069507632161",
    sakura    = "rbxassetid://81755778619404",
    angel     = "rbxassetid://97658130917593",
    wind      = "rbxassetid://80694081850877",
    flow      = "rbxassetid://119913533725648",
    star      = "rbxassetid://73754563740680",
}

task.spawn(function()
    for name, id in pairs(AURA_ASSETS) do
        local ok, obj = pcall(function()
            return game:GetObjects(id)[1]
        end)
        if ok and obj then
            auraTemplates[name] = obj
        end
    end
end)

local function clearAura()
    for _, p in ipairs(auraParts) do
        pcall(function() p:Destroy() end)
    end
    auraParts = {}
end

local function applyAuraOverrides(part)
    if auraColorOverride then
        pcall(function() part.Color = auraColorOverride end)
    end
    if part:IsA("ParticleEmitter") then
        pcall(function() part.Transparency = NumberSequence.new(auraTransparency) end)
    elseif part:IsA("BasePart") then
        pcall(function() part.Transparency = auraTransparency end)
    end
end

local function createAura(char)
    clearAura()
    if not auraEnabled or not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for name, enabled in pairs(selectedAuras) do
        if enabled and auraTemplates[name] then
            local template = auraTemplates[name]
            local clone = template:Clone()
            for _, child in ipairs(clone:GetChildren()) do
                local target = char:FindFirstChild(child.Name)
                if target then
                    for _, sub in ipairs(child:GetChildren()) do
                        local cloned = sub:Clone()
                        applyAuraOverrides(cloned)
                        cloned.Parent = target
                        table.insert(auraParts, cloned)
                    end
                end
            end
            clone:Destroy()
        end
    end
end

Window:AddToggle(VisualTab, {
    Title = "Character Aura",
    Description = "Ativa efeitos de aura",
    Default = false,
    Callback = function(v)
        auraEnabled = v
        if v then createAura(LP.Character)
        else clearAura() end
    end,
})

local auraNames = { "angel", "starlight", "heavenly", "ribbon", "sakura", "wind", "flow", "star" }
for _, name in ipairs(auraNames) do
    Window:AddToggle(VisualTab, {
        Title = "Aura: " .. name:sub(1,1):upper() .. name:sub(2),
        Description = "Ativa o efeito " .. name,
        Default = false,
        Callback = function(v)
            selectedAuras[name] = v
            if auraEnabled then createAura(LP.Character) end
        end,
    })
end

Window:AddColorPicker(VisualTab, {
    Title = "Aura Color Override",
    Description = "Muda a cor de todas as auras",
    Default = Color3.fromRGB(160, 80, 255),
    Callback = function(c)
        auraColorOverride = c
        if auraEnabled then createAura(LP.Character) end
    end,
})

Window:AddSlider(VisualTab, {
    Title = "Aura Transparency",
    Min = 0, Max = 1, Default = 0.5,
    Callback = function(v)
        auraTransparency = v
        if auraEnabled then createAura(LP.Character) end
    end,
})

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    if auraEnabled then createAura(char) end
end)
-- ============================================================
-- KILL EFFECT
-- ============================================================
Window:AddSection(VisualTab, "Kill Effect", Icons.Sword)

local killEffectEnabled = false
local killEffectColor = Color3.fromRGB(160, 80, 255)
local killEffectType = "Neon"
local killEffectParticles = false
local killEffectConns = {}

local EFFECT_PRESETS = {
    Neon = { material = Enum.Material.Neon },
    Fogo = { material = Enum.Material.Neon, particles = "Fire", color = Color3.fromRGB(255, 100, 0) },
    Gelo = { material = Enum.Material.Ice, color = Color3.fromRGB(150, 220, 255) },
    Raio = { material = Enum.Material.Neon, particles = "Sparkles", color = Color3.fromRGB(255, 255, 100) },
    Ouro = { material = Enum.Material.Neon, particles = "Sparkles", color = Color3.fromRGB(255, 215, 0) },
}

local function addParticleTo(part, kind, color)
    if kind == "Fire" then
        local fire = Instance.new("Fire")
        fire.Heat = 10
        fire.Size = 8
        fire.Color = color or Color3.fromRGB(255, 100, 0)
        fire.SecondaryColor = Color3.fromRGB(255, 200, 0)
        fire.Parent = part
    elseif kind == "Sparkles" then
        local sp = Instance.new("Sparkles")
        sp.SparkleColor = color or Color3.fromRGB(255, 215, 0)
        sp.Parent = part
    end
end

local function freezeCharacter(char, cf)
    if not char then return end
    local clone = char:Clone()
    local hrp = clone:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.Transparency = 1 end

    local preset = EFFECT_PRESETS[killEffectType] or EFFECT_PRESETS.Neon
    local useColor = preset.color or killEffectColor

    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("MeshPart") then
            if d.Name == "HumanoidRootPart" then
                d.Transparency = 1
                d.Anchored = true
                d.CanCollide = false
            else
                d.Anchored = true
                d.CanCollide = false
                d.Material = preset.material
                d.Color = useColor
                d.Transparency = 0
                if d:IsA("MeshPart") then d.TextureID = "" end
                if killEffectParticles and preset.particles then
                    addParticleTo(d, preset.particles, preset.color)
                end
            end
        elseif d:IsA("Accessory") then
            local handle = d:FindFirstChild("Handle")
            if handle and (handle:IsA("BasePart") or handle:IsA("MeshPart")) then
                handle.Material = preset.material
                handle.Color = useColor
                handle.Transparency = 0
                handle.Anchored = true
                handle.CanCollide = false
                if handle:IsA("MeshPart") then handle.TextureID = "" end
                if killEffectParticles and preset.particles then
                    addParticleTo(handle, preset.particles, preset.color)
                end
            end
        elseif d:IsA("SpecialMesh") then
            d.TextureId = ""
        elseif d:IsA("Decal") or d:IsA("Texture") then
            d:Destroy()
        elseif d:IsA("Script") or d:IsA("LocalScript") or d:IsA("ModuleScript") then
            d:Destroy()
        elseif d:IsA("Humanoid") or d:IsA("Tool") then
            d:Destroy()
        end
    end

    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("Weld") or d:IsA("Motor6D") or d:IsA("JointInstance") then
            d:Destroy()
        end
    end
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("BasePart") or d:IsA("MeshPart") then
            d.Anchored = true
        end
    end

    if clone.PrimaryPart then
        pcall(function() clone:PivotTo(cf) end)
    elseif hrp then
        hrp.CFrame = cf
    end

    clone.Parent = workspace

    task.spawn(function()
        local duration = 2.5
        local steps = 70
        local inc = 1 / steps
        for _ = 1, steps do
            task.wait(duration / steps)
            for _, d in ipairs(clone:GetDescendants()) do
                if d:IsA("BasePart") or d:IsA("MeshPart") then
                    d.Transparency = math.min(1, d.Transparency + inc)
                end
            end
        end
        clone:Destroy()
    end)
end

local function wasKilledByMe(deadChar)
    if not deadChar then return false end
    local myChar = LP.Character
    if not myChar then return false end
    local IHaveKnife = myChar:FindFirstChild("Knife") or (LP.Backpack and LP.Backpack:FindFirstChild("Knife"))
    local IHaveGun = myChar:FindFirstChild("Gun") or (LP.Backpack and LP.Backpack:FindFirstChild("Gun"))
    if not IHaveKnife and not IHaveGun then return false end
    if IHaveGun and Roles.Murderer and deadChar == Roles.Murderer.Character then return true end
    if IHaveKnife and Roles.Sheriff and deadChar == Roles.Sheriff.Character then return true end
    if IHaveKnife and isMurderer() then return true end
    return false
end

local function setupKillEffectFor(plr)
    if plr == LP then return end
    local function watchChar(char)
        task.wait(0.5)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local conn = hum.Died:Connect(function()
            if not killEffectEnabled then return end
            if wasKilledByMe(char) then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local cf = hrp and hrp.CFrame or CFrame.new()
                freezeCharacter(char, cf)
            end
        end)
        table.insert(killEffectConns, conn)
    end
    if plr.Character then watchChar(plr.Character) end
    local cc = plr.CharacterAdded:Connect(watchChar)
    table.insert(killEffectConns, cc)
end

local function setupAllKillEffects()
    for _, c in ipairs(killEffectConns) do
        if c then c:Disconnect() end
    end
    killEffectConns = {}
    if not killEffectEnabled then return end
    for _, plr in ipairs(Players:GetPlayers()) do
        setupKillEffectFor(plr)
    end
end

Window:AddToggle(VisualTab, {
    Title = "Kill Effect",
    Description = "Congela o corpo dos jogadores que voce matar",
    Default = false,
    Callback = function(v)
        killEffectEnabled = v
        setupAllKillEffects()
    end,
})

Window:AddDropdown(VisualTab, {
    Title = "Kill Effect Type",
    Options = { "Neon", "Fogo", "Gelo", "Raio", "Ouro" },
    Default = "Neon",
    Callback = function(v) killEffectType = v end,
})

Window:AddToggle(VisualTab, {
    Title = "Kill Effect Particles",
    Default = false,
    Callback = function(v) killEffectParticles = v end,
})

Window:AddColorPicker(VisualTab, {
    Title = "Kill Effect Color",
    Default = Color3.fromRGB(160, 80, 255),
    Callback = function(c) killEffectColor = c end,
})

Players.PlayerAdded:Connect(function(plr)
    if killEffectEnabled then setupKillEffectFor(plr) end
end)

-- ============================================================
-- ESP
-- ============================================================
Window:AddSection(VisualTab, "ESP", Icons.Eye)

local ESP = {
    Enabled = false, ShowBox = true, ShowName = true, ShowRole = true,
    ShowDistance = true, ShowHealth = false, ShowHealthBar = true,
    ShowTracer = false, ShowChams = false, MaxDistance = 500,
    TeamCheck = false, TextSize = 14,
}

local ROLE_COLORS = {
    Murderer = Color3.fromRGB(255, 60, 60),
    Sheriff  = Color3.fromRGB(80, 160, 255),
    Innocent = Color3.fromRGB(240, 240, 240),
    Hero     = Color3.fromRGB(255, 215, 80),
}
local DEFAULT_COLOR = Color3.fromRGB(200, 200, 200)

local espData = {}
local espHolder = nil

local function ensureHolder()
    if espHolder then return end
    espHolder = Instance.new("ScreenGui")
    espHolder.Name = "ESP_Drawings"
    espHolder.ResetOnSpawn = false
    espHolder.IgnoreGuiInset = true
    espHolder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    espHolder.Parent = (gethui and gethui()) or game:GetService("CoreGui")
end

local function getRoleOf(plr)
    if Roles.Murderer == plr then return "Murderer" end
    if Roles.Sheriff == plr then return "Sheriff" end
    if Roles.Hero == plr then return "Hero" end
    if Roles.Innocent == plr then return "Innocent" end
    return nil
end

local function getColorFor(plr)
    local role = getRoleOf(plr)
    if role and ROLE_COLORS[role] then return ROLE_COLORS[role], role end
    return DEFAULT_COLOR, "?"
end

local drawingSupported = pcall(function() return Drawing.new("Square") end)

local function createESP(plr)
    if espData[plr] or not drawingSupported then return end
    ensureHolder()

    local data = {}
    data.Box = Drawing.new("Square")
    data.Box.Thickness = 1
    data.Box.Filled = false
    data.Box.Transparency = 1
    data.Box.Visible = false

    data.BoxOutline = Drawing.new("Square")
    data.BoxOutline.Thickness = 3
    data.BoxOutline.Filled = false
    data.BoxOutline.Color = Color3.new(0, 0, 0)
    data.BoxOutline.Transparency = 1
    data.BoxOutline.Visible = false

    data.HealthBarBg = Drawing.new("Square")
    data.HealthBarBg.Filled = true
    data.HealthBarBg.Color = Color3.new(0, 0, 0)
    data.HealthBarBg.Transparency = 0.5
    data.HealthBarBg.Visible = false

    data.HealthBarFill = Drawing.new("Square")
    data.HealthBarFill.Filled = true
    data.HealthBarFill.Transparency = 1
    data.HealthBarFill.Visible = false

    data.Name = Drawing.new("Text")
    data.Name.Size = ESP.TextSize
    data.Name.Center = true
    data.Name.Outline = true
    data.Name.OutlineColor = Color3.new(0, 0, 0)
    data.Name.Font = 2
    data.Name.Visible = false

    data.Role = Drawing.new("Text")
    data.Role.Size = 12
    data.Role.Center = true
    data.Role.Outline = true
    data.Role.OutlineColor = Color3.new(0, 0, 0)
    data.Role.Font = 2
    data.Role.Visible = false

    data.Distance = Drawing.new("Text")
    data.Distance.Size = 12
    data.Distance.Center = true
    data.Distance.Outline = true
    data.Distance.OutlineColor = Color3.new(0, 0, 0)
    data.Distance.Font = 2
    data.Distance.Visible = false

    data.Health = Drawing.new("Text")
    data.Health.Size = 12
    data.Health.Center = true
    data.Health.Outline = true
    data.Health.OutlineColor = Color3.new(0, 0, 0)
    data.Health.Font = 2
    data.Health.Visible = false

    data.Tracer = Drawing.new("Line")
    data.Tracer.Thickness = 1
    data.Tracer.Transparency = 1
    data.Tracer.Visible = false

    local hl = Instance.new("Highlight")
    hl.Name = "ESP_Highlight"
    hl.FillTransparency = 1
    hl.OutlineTransparency = 0.3
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = plr.Character or plr
    data.Highlight = hl

    espData[plr] = data
end

local function destroyESP(plr)
    local data = espData[plr]
    if not data then return end
    for _, v in pairs(data) do
        if typeof(v) == "Drawing" then
            pcall(function() v:Remove() end)
        elseif typeof(v) == "Instance" then
            pcall(function() v:Destroy() end)
        end
    end
    espData[plr] = nil
end

local function hideAllESP(data)
    for _, obj in pairs(data) do
        if typeof(obj) == "Drawing" then obj.Visible = false
        elseif typeof(obj) == "Instance" and obj:IsA("Highlight") then obj.Enabled = false end
    end
end

local function updateESP()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    for plr, data in pairs(espData) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        local shouldShow = ESP.Enabled and char and hrp and hum and hum.Health > 0 and plr ~= LP

        if shouldShow and ESP.TeamCheck then
            local myRole = getRoleOf(LP)
            local theirRole = getRoleOf(plr)
            local iAmGood = myRole == "Innocent" or myRole == "Sheriff" or myRole == "Hero"
            local theyAreGood = theirRole == "Innocent" or theirRole == "Sheriff" or theirRole == "Hero"
            if iAmGood and theyAreGood then shouldShow = false end
        end

        local dist = myRoot and (myRoot.Position - hrp.Position).Magnitude or 0
        if shouldShow and ESP.MaxDistance > 0 and dist > ESP.MaxDistance then
            shouldShow = false
        end

        if not shouldShow then
            hideAllESP(data)
            continue
        end

        local color, roleName = getColorFor(plr)

        if data.Highlight then
            data.Highlight.Enabled = true
            data.Highlight.OutlineColor = color
            data.Highlight.FillColor = color
            data.Highlight.FillTransparency = ESP.ShowChams and 0.5 or 1
            data.Highlight.Adornee = char
        end

        local head = char:FindFirstChild("Head")
        local topScreen = cam:WorldToViewportPoint((head and head.Position or hrp.Position) + Vector3.new(0, 0.5, 0))
        local bottomScreen = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
        local topPos = Vector2.new(topScreen.X, topScreen.Y)
        local bottomPos = Vector2.new(bottomScreen.X, bottomScreen.Y)

        if topScreen.Z < 0 or bottomScreen.Z < 0 then
            hideAllESP(data)
            continue
        end

        local height = math.abs(bottomPos.Y - topPos.Y)
        local width = height * 0.55
        local centerX = (topPos.X + bottomPos.X) / 2
        local boxTop = topPos.Y
        local boxBottom = bottomPos.Y

        data.BoxOutline.Visible = ESP.ShowBox
        data.BoxOutline.Size = Vector2.new(width + 2, height + 2)
        data.BoxOutline.Position = Vector2.new(centerX - width / 2 - 1, boxTop - 1)

        data.Box.Visible = ESP.ShowBox
        data.Box.Color = color
        data.Box.Size = Vector2.new(width, height)
        data.Box.Position = Vector2.new(centerX - width / 2, boxTop)

        if ESP.ShowHealthBar then
            local hpPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            data.HealthBarBg.Visible = true
            data.HealthBarBg.Size = Vector2.new(3, height)
            data.HealthBarBg.Position = Vector2.new(centerX - width / 2 - 6, boxTop)

            data.HealthBarFill.Visible = true
            data.HealthBarFill.Color = Color3.fromRGB(255 * (1 - hpPct), 255 * hpPct, 0)
            data.HealthBarFill.Size = Vector2.new(3, height * hpPct)
            data.HealthBarFill.Position = Vector2.new(centerX - width / 2 - 6, boxBottom - height * hpPct)
        else
            data.HealthBarBg.Visible = false
            data.HealthBarFill.Visible = false
        end

        data.Name.Visible = ESP.ShowName
        data.Name.Size = ESP.TextSize
        data.Name.Color = color
        data.Name.Text = plr.Name
        data.Name.Position = Vector2.new(centerX, boxTop - 36)

        data.Role.Visible = ESP.ShowRole
        data.Role.Color = color
        data.Role.Text = "[" .. (roleName or "?") .. "]"
        data.Role.Position = Vector2.new(centerX, boxTop - 20)

        data.Distance.Visible = ESP.ShowDistance
        data.Distance.Color = color
        data.Distance.Text = string.format("%d m", math.floor(dist))
        data.Distance.Position = Vector2.new(centerX, boxBottom + 2)

        if ESP.ShowHealth then
            data.Health.Visible = true
            data.Health.Color = color
            data.Health.Text = string.format("HP: %d", math.floor(hum.Health))
            data.Health.Position = Vector2.new(centerX, boxBottom + 18)
        else
            data.Health.Visible = false
        end

        if ESP.ShowTracer then
            data.Tracer.Visible = true
            data.Tracer.Color = color
            data.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
            data.Tracer.To = Vector2.new(centerX, boxBottom)
        else
            data.Tracer.Visible = false
        end
    end
end

local function trackPlayerForESP(plr)
    if plr == LP then return end
    createESP(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.3)
        if espData[plr] and espData[plr].Highlight then
            espData[plr].Highlight.Adornee = plr.Character
        end
    end)
end

for _, plr in ipairs(Players:GetPlayers()) do trackPlayerForESP(plr) end
Players.PlayerAdded:Connect(trackPlayerForESP)
Players.PlayerRemoving:Connect(destroyESP)

Window:AddToggle(VisualTab, {
    Title = "ESP Enabled",
    Description = "Mostra jogadores atraves das paredes",
    Default = false,
    Callback = function(v)
        ESP.Enabled = v
        if not v then
            for _, data in pairs(espData) do hideAllESP(data) end
        end
    end,
})

Window:AddToggle(VisualTab, { Title = "ESP: Box", Default = true, Callback = function(v) ESP.ShowBox = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Health Bar", Default = true, Callback = function(v) ESP.ShowHealthBar = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Name", Default = true, Callback = function(v) ESP.ShowName = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Role", Default = true, Callback = function(v) ESP.ShowRole = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Distance", Default = true, Callback = function(v) ESP.ShowDistance = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Health (texto)", Default = false, Callback = function(v) ESP.ShowHealth = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Tracer", Default = false, Callback = function(v) ESP.ShowTracer = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Chams", Default = false, Callback = function(v) ESP.ShowChams = v end })
Window:AddToggle(VisualTab, { Title = "ESP: Team Check", Default = false, Callback = function(v) ESP.TeamCheck = v end })

Window:AddSlider(VisualTab, {
    Title = "ESP Max Distance",
    Min = 50, Max = 2000, Default = 500,
    Callback = function(v) ESP.MaxDistance = v end,
})

Window:AddSlider(VisualTab, {
    Title = "ESP Text Size",
    Min = 10, Max = 24, Default = 14,
    Callback = function(v) ESP.TextSize = v end,
})

RunService.RenderStepped:Connect(function()
    if ESP.Enabled then pcall(updateESP) end
end)

-- ============================================================
-- MINI MAPA
-- ============================================================
Window:AddSection(VisualTab, "Mini Mapa", Icons.Target)

local minimapEnabled = false
local minimapSize = 200
local minimapRange = 500
local minimapFrame = nil
local minimapDots = {}

local function createMinimap()
    if minimapFrame then minimapFrame:Destroy() end
    minimapFrame = new("Frame", {
        Name = "Minimap",
        Size = UDim2.fromOffset(minimapSize, minimapSize),
        Position = UDim2.new(1, -minimapSize - 15, 0, 60),
        BackgroundColor3 = Theme.BG,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = ScreenGui,
    })
    corner(minimapFrame, 8)
    stroke(minimapFrame, Theme.Accent, 2)

    new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = "MAPA",
        TextColor3 = Theme.Accent,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        Parent = minimapFrame,
    })

    local center = new("Frame", {
        Size = UDim2.fromOffset(8, 8),
        Position = UDim2.new(0.5, -4, 0.5, -4),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = minimapFrame,
    })
    corner(center, 4)
end

local function getOrCreateDot(plr)
    if minimapDots[plr] then return minimapDots[plr] end
    if not minimapFrame then return nil end
    local dot = new("Frame", {
        Size = UDim2.fromOffset(10, 10),
        BackgroundColor3 = DEFAULT_COLOR,
        BorderSizePixel = 0,
        ZIndex = 4,
        Parent = minimapFrame,
    })
    corner(dot, 5)
    minimapDots[plr] = dot
    return dot
e
