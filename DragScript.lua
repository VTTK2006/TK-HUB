local UserInputService = game:GetService("UserInputService")

-- Lấy đối tượng Menu và Nút mở rộng từ ScreenGui
local mainMenu = script.Parent
local screenGui = mainMenu.Parent
local openMenuButton = screenGui:WaitForChild("OpenMenuButton")

----------------------------------------------------------------
-- 1. XỬ LÝ KÉO THẢ CHO MAIN MENU
----------------------------------------------------------------
local menuDragging, menuDragInput, menuDragStart, menuStartPos

local function updateMenu(input)
	local delta = input.Position - menuDragStart
	mainMenu.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
end

mainMenu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		menuDragging = true
		menuDragStart = input.Position
		menuStartPos = mainMenu.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				menuDragging = false
			end
		end)
	end
end)

mainMenu.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		menuDragInput = input
	end
end)

----------------------------------------------------------------
-- 2. XỬ LÝ KÉO THẢ CHO NÚT OPEN MENU BUTTON
----------------------------------------------------------------
local btnDragging, btnDragInput, btnDragStart, btnStartPos

local function updateButton(input)
	local delta = input.Position - btnDragStart
	openMenuButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
end

openMenuButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		btnDragging = true
		btnDragStart = input.Position
		btnStartPos = openMenuButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				btnDragging = false
			end
		end)
	end
end)

openMenuButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		btnDragInput = input
	end
end)

----------------------------------------------------------------
-- 3. HỆ THỐNG LẮNG NGHE SỰ KIỆN CẬP NHẬT CHUNG
----------------------------------------------------------------
UserInputService.InputChanged:Connect(function(input)
	-- Cập nhật cho Menu nếu đang kéo Menu
	if input == menuDragInput and menuDragging then
		updateMenu(input)
	end
	-- Cập nhật cho Nút nếu đang kéo Nút
	if input == btnDragInput and btnDragging then
		updateButton(input)
	end
end)