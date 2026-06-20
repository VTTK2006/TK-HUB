-- Lấy các thành phần giao diện
local mainMenu = script.Parent
local sidebar = mainMenu:WaitForChild("Sidebar")
local contentFrame = mainMenu:WaitForChild("Content") -- Thư mục chứa các trang

-- Định nghĩa các Nút bấm
local homeButton = sidebar:WaitForChild("HomeButton")
local mainButton = sidebar:WaitForChild("MainButton")
local shopButton = sidebar:WaitForChild("ShopButton")
local settingButton = sidebar:WaitForChild("SettingButton")

-- Ánh xạ các Nút tương ứng với các Trang nằm trong mục Content
local pages = {
	[homeButton] = contentFrame:WaitForChild("HomePage", 5),
	[mainButton] = contentFrame:WaitForChild("MainPage", 5),
	[shopButton] = contentFrame:WaitForChild("ShopPage", 5),
	[settingButton] = contentFrame:WaitForChild("SettingPage", 5),
}

-- Hàm ẩn toàn bộ các trang nội dung
local function hideAllPages()
	for _, page in pairs(pages) do
		if page then
			page.Visible = false
		end
	end
end

-- Lắng nghe sự kiện click cho từng nút
for button, page in pairs(pages) do
	if page then
		button.MouseButton1Click:Connect(function()
			hideAllPages() -- Ẩn hết trang cũ
			page.Visible = true -- Hiện trang được chọn
		end)
	else
		warn("Lỗi: Không tìm thấy trang nội dung tương ứng với nút " .. button.Name)
	end
end

-- Lấy các nút tương ứng
local minimizeButton = mainMenu:WaitForChild("MinimizeButton")
local closeButton = mainMenu:WaitForChild("CloseButton") -- Nút X của bạn
local screenGui = mainMenu.Parent
local openMenuButton = screenGui:WaitForChild("OpenMenuButton")

-- Khi ấn nút dấu trừ (-) để thu nhỏ
minimizeButton.MouseButton1Click:Connect(function()
	mainMenu.Visible = false         -- Ẩn menu chính
	openMenuButton.Visible = true    -- Hiện nút bấm nhỏ để mở lại
end)

-- Khi ấn nút nhỏ để mở lại Menu lớn
openMenuButton.MouseButton1Click:Connect(function()
	mainMenu.Visible = true          -- Hiện lại menu chính
	openMenuButton.Visible = false   -- Ẩn nút bấm nhỏ đi
end)

-- (Tùy chọn) Nếu bạn muốn nút X tắt hẳn Menu và hiện lại nút nhỏ luôn:
closeButton.MouseButton1Click:Connect(function()
	mainMenu.Visible = false
	openMenuButton.Visible = true
end)