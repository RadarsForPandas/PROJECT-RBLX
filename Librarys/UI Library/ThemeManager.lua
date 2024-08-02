local RunService = game:GetService("RunService")
local Themes = {
    Default = {1, [[{"Outline":"000000","Accent":"5d3e98","LightText":"ffffff","DarkText":"afafaf","LightContrast":"1e1e1e","CursorOutline":"0a0a0a","DarkContrast":"141414","TextBorder":"000000","Inline":"323232"}]]},
    Abyss = {2, [[{"Outline":"0a0a0a","Accent":"8c87b4","LightText":"ffffff","DarkText":"afafaf","LightContrast":"1e1e1e","CursorOutline":"141414","DarkContrast":"141414","TextBorder":"0a0a0a","Inline":"2d2d2d"}]]},
    Fatality = {3, [[{"Outline":"0f0f28","Accent":"f00f50","LightText":"c8c8ff","DarkText":"afafaf","LightContrast":"231946","CursorOutline":"0f0f28","DarkContrast":"191432","TextBorder":"0a0a0a","Inline":"322850"}]]},
    Neverlose = {4, [[{"Outline":"000005","Accent":"00b4f0","LightText":"ffffff","DarkText":"afafaf","LightContrast":"000f1e","CursorOutline":"0f0f28","DarkContrast":"050514","TextBorder":"0a0a0a","Inline":"0a1e28"}]]},
    Aimware = {5, [[{"Outline":"000005","Accent":"c82828","LightText":"e8e8e8","DarkText":"afafaf","LightContrast":"2b2b2b","CursorOutline":"191919","DarkContrast":"191919","TextBorder":"0a0a0a","Inline":"373737"}]]},
    Youtube = {6, [[{"Outline":"000000","Accent":"ff0000","LightText":"f1f1f1","DarkText":"aaaaaa","LightContrast":"232323","CursorOutline":"121212","DarkContrast":"0f0f0f","TextBorder":"121212","Inline":"393939"}]]},
    Gamesense = {7, [[{"Outline":"000000","Accent":"a7d94d","LightText":"ffffff","DarkText":"afafaf","LightContrast":"171717","CursorOutline":"141414","DarkContrast":"0c0c0c","TextBorder":"141414","Inline":"282828"}]]},
    Onetap = {8, [[{"Outline":"000000","Accent":"dda85d","LightText":"d6d9e0","DarkText":"afafaf","LightContrast":"2c3037","CursorOutline":"000000","DarkContrast":"1f2125","TextBorder":"000000","Inline":"4e5158"}]]},
    Entropy = {9, [[{"Outline":"0a0a0a","Accent":"81bbe9","LightText":"dcdcdc","DarkText":"afafaf","LightContrast":"3d3a43","CursorOutline":"000000","DarkContrast":"302f37","TextBorder":"000000","Inline":"4c4a52"}]]},
    Interwebz = {10, [[{"Outline":"1a1a1a","Accent":"c9654b","LightText":"fcfcfc","DarkText":"a8a8a8","LightContrast":"291f38","CursorOutline":"1a1a1a","DarkContrast":"1f162b","TextBorder":"000000","Inline":"40364f"}]]},
    Dracula = {11, [[{"Outline":"202126","Accent":"9a81b3","LightText":"b4b4b8","DarkText":"88888b","LightContrast":"2a2c38","CursorOutline":"202126","DarkContrast":"252730","TextBorder":"2a2c38","Inline":"3c384d"}]]},
    Spotify = {12, [[{"Outline":"0a0a0a","Accent":"1ed760","LightText":"d0d0d0","DarkText":"949494","LightContrast":"181818","CursorOutline":"000000","DarkContrast":"121212","TextBorder":"000000","Inline":"292929"}]]},
    Sublime = {13, [[{"Outline":"000000","Accent":"ff9800","LightText":"e8ffff","DarkText":"d3d3c2","LightContrast":"32332d","CursorOutline":"000000","DarkContrast":"282923","TextBorder":"000000","Inline":"484944"}]]},
    Vape = {14, [[{"Outline":"0a0a0a","Accent":"26866a","LightText":"dcdcdc","DarkText":"afafaf","LightContrast":"1f1f1f","CursorOutline":"000000","DarkContrast":"1a1a1a","TextBorder":"000000","Inline":"363636"}]]},
    Neko = {15, [[{"Outline":"000000","Accent":"d21f6a","LightText":"ffffff","DarkText":"afafaf","LightContrast":"171717","CursorOutline":"0a0a0a","DarkContrast":"131313","TextBorder":"000000","Inline":"2d2d2d"}]]},
    Corn = {16, [[{"Outline":"000000","Accent":"ff9000","LightText":"dcdcdc","DarkText":"afafaf","LightContrast":"252525","CursorOutline":"000000","DarkContrast":"191919","TextBorder":"000000","Inline":"333333"}]]},
    Minecraft = {17, [[{"Outline":"000000","Accent":"27ce40","LightText":"ffffff","DarkText":"d7d7d7","LightContrast":"333333","CursorOutline":"000000","DarkContrast":"262626","TextBorder":"000000","Inline":"333333"}]]},
}
local ThemeManager = {}

local Shift = 0
local ShiftTick = tick()
local function MathShift(Value, ShiftAmount)
    return (Value + ShiftAmount) % 360
end

local Clamp = math.clamp

function ThemeManager:UpdateColor(ColorType, ColorValue)
    local ColorType = ColorType:lower()
    Theme[ColorType] = ColorValue
    for Index, Value in pairs(Library.colors) do
        for Index2, Value2 in pairs(Value) do
            if Value2 == ColorType then
                Index[Index2] = Theme[Value2]
            end
        end
    end
end

function ThemeManager:UpdateTheme(ThemeType, ThemeValue)
    if Flags["ConfigTheme_" .. ThemeType] then
        Flags["ConfigTheme_" .. ThemeType]:Set(ThemeValue)
    end
end

function ThemeManager:LoadTheme(ThemeType)
    if Themes[ThemeType] then
        local ThemeValue = game:GetService("HttpService"):JSONDecode(Themes[ThemeType][2])
        for Index, Value in pairs(ThemeValue) do
            self:UpdateTheme(Library, Flags, Index, Color3.fromHex(Value)) 
        end
    end
end

function ThemeManager:UpdateHue()
    if (tick() - ShiftTick) >= (1 / 60) then
        Shift = Shift + 0.01
        local AccentEffect = Flags["ConfigTheme_AccentEffect"]:Get()
        local AccentColor = Flags["ConfigTheme_Accent"]:Get()

        if not AccentColor then
            print("AccentColor is nil.")
            return
        end

        if AccentEffect == "Rainbow" then
            self:UpdateColor(Library, "Accent", Color3.fromHSV(MathShift(Shift, 0), 0.55, 1))
        elseif AccentEffect == "Shift" then
            local Hue, Saturation, Value = AccentColor:ToHSV()
            self:UpdateColor(Library, "Accent", Color3.fromHSV(MathShift(Hue, Shift * (Flags["ConfigTheme_EffectLength"]:Get() / 360)), Saturation, Value))
        elseif AccentEffect == "Reverse Shift" then
            local Hue, Saturation, Value = AccentColor:ToHSV()
            self:UpdateColor(Library, "Accent", Color3.fromHSV(MathShift(Clamp(Hue - Shift * (Flags["ConfigTheme_EffectLength"]:Get() / 360), 0, 9999)), Saturation, Value))
        end

        ShiftTick = tick()
    end
end

function ThemeManager:AddTheme(Tab)
    local Config_Theme = Tab:Section({Name = "Theme"})
    Config_Theme:Dropdown({Name = "Theme", Flag = "ConfigTheme_Theme", Default = "Default", Max = 8, Options = GetTableIndexes(Themes, true)})
    Config_Theme:Button({Name = "Load", Callback = function() self:LoadTheme(Library, Flags, Flags["ConfigTheme_Theme"]:Get()) end})
    Config_Theme:Colorpicker({Name = "Accent", Flag = "ConfigTheme_Accent", Default = Color3.fromRGB(93, 62, 152), Callback = function(Color) self:UpdateColor(Library, "Accent", Color) end})
    Config_Theme:Colorpicker({Name = "Light Contrast", Flag = "ConfigTheme_LightContrast", Default = Color3.fromRGB(30, 30, 30), Callback = function(Color) self:UpdateColor(Library, "LightContrast", Color) end})
    Config_Theme:Colorpicker({Name = "Dark Contrast", Flag = "ConfigTheme_DarkContrast", Default = Color3.fromRGB(20, 20, 20), Callback = function(Color) self:UpdateColor(Library, "DarkContrast", Color) end})
    Config_Theme:Colorpicker({Name = "Outline", Flag = "ConfigTheme_Outline", Default = Color3.fromRGB(0, 0, 0), Callback = function(Color) self:UpdateColor(Library, "Outline", Color) end})
    Config_Theme:Colorpicker({Name = "Inline", Flag = "ConfigTheme_Inline", Default = Color3.fromRGB(50, 50, 50), Callback = function(Color) self:UpdateColor(Library, "Inline", Color) end})
    Config_Theme:Colorpicker({Name = "Light Text", Flag = "ConfigTheme_LightText", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) self:UpdateColor(Library, "TextColor", Color) end})
    Config_Theme:Colorpicker({Name = "Dark Text", Flag = "ConfigTheme_DarkText", Default = Color3.fromRGB(175, 175, 175), Callback = function(Color) self:UpdateColor(Library, "TextDark", Color) end})
    Config_Theme:Colorpicker({Name = "Text Outline", Flag = "ConfigTheme_TextBorder", Default = Color3.fromRGB(0, 0, 0), Callback = function(Color) self:UpdateColor(Library, "TextBorder", Color) end})
    Config_Theme:Colorpicker({Name = "Cursor Outline", Flag = "ConfigTheme_CursorOutline", Default = Color3.fromRGB(10, 10, 10), Callback = function(Color) self:UpdateColor("CursorOutline", Color) end})
    Config_Theme:Dropdown({Name = "Accent Effect", Flag = "ConfigTheme_AccentEffect", Default = "None", Options = {"None", "Rainbow", "Shift", "Reverse Shift"}, Callback = function(State) if State == "None" then self:UpdateColor("Accent", Flags["ConfigTheme_Accent"]:Get()) end end})
    Config_Theme:Slider({Name = "Effect Length", Flag = "ConfigTheme_EffectLength", Default = 40, Maximum = 360, Minimum = 1, Decimals = 1})
    RunService.RenderStepped:Connect(ThemeManager:UpdateHue())
end

return ThemeManager
-- if you can see this I AM DEEPLY IN LOVE WITH YOU
