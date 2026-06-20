-- ==========================================
-- FILE: LocalScript.lua
-- CHỨC NĂNG: TẠO GIAO DIỆN CHÍNH (UI)
-- ==========================================

-- 1. TẠO SCREEN GUI (BỘ KHUNG LỚN)
-- Ta dùng CoreGui để UI không bị reset khi nhân vật chết.
local TKHub_ScreenGui = Instance.new("ScreenGui")
TKHub_ScreenGui.Name = "TKHub_UI"
TKHub_ScreenGui.ResetOnSpawn = false
pcall(function() TKHub_ScreenGui.Parent = game:GetService("CoreGui") end) -- Thử đưa vào CoreGui, nếu lỗi thì đưa vào PlayerGui

-- 2. TẠO FRAME CHÍNH (MAIN MENU - 600x400)
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 600, 0, 400)
MainMenu.Position = UDim2.new(0.5, -300, 0.5, -200) -- Căn giữa màn hình
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 20) -- Màu nền tối đậm
MainMenu.BorderSizePixel = 0
MainMenu.ClipsDescendants = true
MainMenu.Active = true -- Cho phép nhận tương tác
MainMenu.Draggable = true -- Cho phép kéo thả (đây là cách đơn giản nhất, trước khi dùng DragScript)
MainMenu.Parent = TKHub_ScreenGui
MainMenu.Visible = true -- QUAN TRỌNG: Đảm bảo giao diện hiện lên

-- 2a. BO GÓC CHO FRAME CHÍNH
local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 8)
MainUICorner.Parent = MainMenu

-- 3. TẠO SIDEBAR (THANH MENU BÊN TRÁI)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15) -- Màu tối hơn
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainMenu

-- 4. TẠO CONTENT AREA (KHU VỰC HIỂN THỊ NỘI DUNG CHÍNH)
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -150, 1, 0)
Content.Position = UDim2.new(0, 150, 0, 0)
Content.BackgroundColor3 = Color3.fromRGB(20, 20, 25) -- Màu nền sáng hơn một chút
Content.BorderSizePixel = 0
Content.Parent = MainMenu

-- ==========================================
-- THIẾT KẾ CÁC THÀNH PHẦN CHI TIẾT
-- ==========================================

-- 5. SIDEBAR: LOGO TK HUB
local LogoImage = Instance.new("ImageLabel")
LogoImage.Name = "LogoImage"
LogoImage.Size = UDim2.new(0, 100, 0, 100)
LogoImage.Position = UDim2.new(0.5, -50, 0, 20)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = "rbxassetid://16127113101" -- Thay bằng ID ảnh Logo của bạn
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.Parent = Sidebar

local LogoText = Instance.new("TextLabel")
LogoText.Name = "LogoText"
LogoText.Size = UDim2.new(1, 0, 0, 30)
LogoText.Position = UDim2.new(0, 0, 0, 120)
LogoText.BackgroundTransparency = 1
LogoText.Text = "TK HUB"
LogoText.TextColor3 = Color3.fromRGB(150, 100, 255) -- Màu tím sáng
LogoText.TextSize = 24
LogoText.Font = Enum.Font.GothamBold
LogoText.Parent = Sidebar

-- 6. CONTENT: KHU VỰC THÔNG TIN NGƯỜI CHƠI (PLAYER INFO)
-- Lấy thông tin thực tế của người chơi
local player = game.Players.LocalPlayer

local ProfileFrame = Instance.new("Frame")
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(0, 420, 0, 100)
ProfileFrame.Position = UDim2.new(0.5, -210, 0, 20)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Parent = Content

local ProfileUICorner = Instance.new("UICorner")
ProfileUICorner.CornerRadius = UDim.new(0, 6)
ProfileUICorner.Parent = ProfileFrame

-- 6a. CONTENT: PLAYER AVATAR
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Size = UDim2.new(0, 80, 0, 80)
AvatarImage.Position = UDim2.new(0, 10, 0, 10)
AvatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
AvatarImage.BorderSizePixel = 0
AvatarImage.ScaleType = Enum.ScaleType.Fit
AvatarImage.Parent = ProfileFrame

local AvatarUICorner = Instance.new("UICorner")
AvatarUICorner.CornerRadius = UDim.new(0, 6)
AvatarUICorner.Parent = AvatarImage

-- Code tự động lấy ảnh đại diện
local function updateAvatar()
    AvatarImage.Image = game.Players:GetHumanoidDescriptionFromUserId(player.UserId).HeadshotUrl or "rbxassetid://16127113101"
end
pcall(updateAvatar) -- Thử lấy ảnh, nếu lỗi thì dùng ảnh mặc định

-- 6b. CONTENT: PLAYER DETAILS (DisplayName, Username)
local DetailsFrame = Instance.new("Frame")
DetailsFrame.Name = "DetailsFrame"
DetailsFrame.Size = UDim2.new(1, -110, 1, -20)
DetailsFrame.Position = UDim2.new(0, 100, 0, 10)
DetailsFrame.BackgroundTransparency = 1
DetailsFrame.Parent = ProfileFrame

-- Tiêu đề "Displayname:"
local DisplayNameTitle = Instance.new("TextLabel")
DisplayNameTitle.Size = UDim2.new(0, 100, 0, 20)
DisplayNameTitle.Position = UDim2.new(0, 0, 0, 10)
DisplayNameTitle.BackgroundTransparency = 1
DisplayNameTitle.Text = "Displayname:"
DisplayNameTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
DisplayNameTitle.TextSize = 14
DisplayNameTitle.Font = Enum.Font.Gotham
DisplayNameTitle.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameTitle.Parent = DetailsFrame

-- Giá trị DisplayName thực tế
local DisplayNameValue = Instance.new("TextLabel")
DisplayNameValue.Size = UDim2.new(1, -110, 0, 20)
DisplayNameValue.Position = UDim2.new(0, 110, 0, 10)
DisplayNameValue.BackgroundTransparency = 1
DisplayNameValue.Text = player.DisplayName
DisplayNameValue.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayNameValue.TextSize = 16
DisplayNameValue.Font = Enum.Font.GothamMedium
DisplayNameValue.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameValue.Parent = DetailsFrame

-- Tiêu đề "Username:"
local UsernameTitle = Instance.new("TextLabel")
UsernameTitle.Size = UDim2.new(0, 100, 0, 20)
UsernameTitle.Position = UDim2.new(0, 0, 0, 40)
UsernameTitle.BackgroundTransparency = 1
UsernameTitle.Text = "Username:"
UsernameTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
UsernameTitle.TextSize = 14
UsernameTitle.Font = Enum.Font.Gotham
UsernameTitle.TextXAlignment = Enum.TextXAlignment.Left
UsernameTitle.Parent = DetailsFrame

-- Giá trị Username thực tế
local UsernameValue = Instance.new("TextLabel")
UsernameValue.Size = UDim2.new(1, -110, 0, 20)
UsernameValue.Position = UDim2.new(0, 110, 0, 40)
UsernameValue.BackgroundTransparency = 1
UsernameValue.Text = "@" .. player.Name
UsernameValue.TextColor3 = Color3.fromRGB(180, 180, 180) -- Màu nhạt hơn
UsernameValue.TextSize = 14
UsernameValue.Font = Enum.Font.Gotham
UsernameValue.TextXAlignment = Enum.TextXAlignment.Left
UsernameValue.Parent = DetailsFrame

-- 6c. CONTENT: PING INFO
local PingFrame = Instance.new("Frame")
PingFrame.Name = "PingFrame"
PingFrame.Size = UDim2.new(0, 100, 0, 40)
PingFrame.Position = UDim2.new(1, -110, 0, 10)
PingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
PingFrame.BorderSizePixel = 0
PingFrame.Parent = ProfileFrame

local PingUICorner = Instance.new("UICorner")
PingUICorner.CornerRadius = UDim.new(0, 6)
PingUICorner.Parent = PingFrame

local PingText = Instance.new("TextLabel")
PingText.Size = UDim2.new(1, 0, 1, 0)
PingText.BackgroundTransparency = 1
PingText.Text = "Ping: --- ms"
PingText.TextColor3 = Color3.fromRGB(0, 255, 150) -- Màu xanh lá cây sáng
PingText.TextSize = 14
PingText.Font = Enum.Font.GothamBold
PingText.Parent = PingFrame

-- Hàm cập nhật Ping cơ bản
spawn(function()
    while wait(1) do
        local ping = tonumber(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("(%d+)"))
        if ping then
            PingText.Text = "Ping: " .. math.floor(ping) .. " ms"
        end
    end
end)

-- ==========================================
-- TẠO CÁC NÚT BẤM (BUTTONS) TRÊN SIDEBAR
-- ==========================================

local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(1, 0, 1, -160)
ButtonContainer.Position = UDim2.new(0, 0, 0, 160)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = Sidebar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ButtonContainer

local function createSidebarButton(name, layoutOrder)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Button"
    Button.Size = UDim2.new(1, -20, 0, 35) -- Rộng 100%, trừ lề
    Button.Position = UDim2.new(0, 10, 0, 0)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(220, 220, 220)
    Button.TextSize = 16
    Button.Font = Enum.Font.Gotham
    Button.LayoutOrder = layoutOrder
    Button.Parent = ButtonContainer

    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 4)
    ButtonUICorner.Parent = Button

    -- Hiệu ứng khi di chuột qua (Hover)
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        Button.TextColor3 = Color3.fromRGB(220, 220, 220)
    end)

    return Button
end

local HomeButton = createSidebarButton("Home", 1)
local MainButton = createSidebarButton("Main", 2)
local ShopButton = createSidebarButton("Shop", 3)
local SettingButton = createSidebarButton("Setting", 4)

-- Mặc định chọn nút Home
HomeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
HomeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

print("TK HUB UI Loaded Successfuly!")
