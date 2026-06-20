local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

-- Lấy thông tin người chơi hiện tại
local player = Players.LocalPlayer

-- Lấy các thành phần UI đã tạo ở Bước 1
local homePage = script.Parent
local avatarImage = homePage:WaitForChild("AvatarImage")
local displayNameLabel = homePage:WaitForChild("DisplayNameLabel")
local usernameLabel = homePage:WaitForChild("UsernameLabel")
local pingLabel = homePage:WaitForChild("PingLabel")

----------------------------------------------------------------
-- 1. CẬP NHẬT TÊN VÀ AVATAR
----------------------------------------------------------------
-- Sửa đúng theo yêu cầu của bạn:
-- Dòng 1: Lấy DisplayName (Tên hiển thị)
displayNameLabel.Text = "" .. player.DisplayName 

-- Dòng 2: Lấy Name (Username) - Lưu ý: trong Roblox "player.Name" CHÍNH LÀ Username
usernameLabel.Text = "@" .. player.Name

-- Lấy link ảnh Avatar dạng Headshot (Ảnh thẻ cận mặt) của người chơi
local userId = player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size150x150
local avatarUrl, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

-- Gán ảnh vào ImageLabel
avatarImage.Image = avatarUrl


----------------------------------------------------------------
-- 2. CẬP NHẬT TÌNH TRẠNG MẠNG (PING) LIÊN TỤC
----------------------------------------------------------------
-- Vì Ping thay đổi liên tục, ta cần một vòng lặp cập nhật sau mỗi khoảng thời gian ngắn
coroutine.wrap(function()
	while true do
		-- Lấy dữ liệu Ping từ Stats service của Roblox (trả về giá trị tính bằng giây)
		local pingInSeconds = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
		-- Đổi từ giây sang miligiây (ms) và làm tròn số
		local pingMs = math.floor(pingInSeconds * 1000)

		-- Hiển thị lên màn hình và đổi màu chữ theo tình trạng mạng
		pingLabel.Text = "Ping: " .. pingMs .. " ms"

		if pingMs < 80 then
			pingLabel.TextColor3 = Color3.fromRGB(85, 255, 127) -- Màu xanh lá (Mạng tốt)
		elseif pingMs < 150 then
			pingLabel.TextColor3 = Color3.fromRGB(255, 170, 0)  -- Màu cam (Mạng trung bình)
		else
			pingLabel.TextColor3 = Color3.fromRGB(255, 85, 85)   -- Màu đỏ (Mạng lag)
		end

		task.wait(1) -- Cập nhật lại sau mỗi 1 giây
	end
end)()