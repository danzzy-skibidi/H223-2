--==================================================
-- DANZZY TV MAP SCANNER
--==================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "DanzzyMapScanner"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(430, 330)
main.Position = UDim2.new(0.5, -215, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

-- Header
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "📺 DANZZY MAP SCANNER"
title.TextColor3 = Color3.fromRGB(80, 200, 255)
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 25)
status.Position = UDim2.fromOffset(15, 48)
status.BackgroundTransparency = 1
status.Text = "STATUS: READY"
status.TextColor3 = Color3.fromRGB(180, 190, 205)
status.TextSize = 14
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

-- TV screen
local screen = Instance.new("Frame")
screen.Size = UDim2.new(1, -30, 0, 125)
screen.Position = UDim2.fromOffset(15, 78)
screen.BackgroundColor3 = Color3.fromRGB(2, 5, 10)
screen.BorderSizePixel = 0
screen.ClipsDescendants = true
screen.Parent = main

local screenCorner = Instance.new("UICorner")
screenCorner.CornerRadius = UDim.new(0, 8)
screenCorner.Parent = screen

local scanText = Instance.new("TextLabel")
scanText.Size = UDim2.new(1, -20, 1, -20)
scanText.Position = UDim2.fromOffset(10, 10)
scanText.BackgroundTransparency = 1
scanText.Text = "SYSTEM READY\n\nPRESS SCAN MAP"
scanText.TextColor3 = Color3.fromRGB(70, 220, 255)
scanText.TextSize = 16
scanText.Font = Enum.Font.Code
scanText.TextXAlignment = Enum.TextXAlignment.Left
scanText.TextYAlignment = Enum.TextYAlignment.Top
scanText.Parent = screen

-- Progress
local progressBack = Instance.new("Frame")
progressBack.Size = UDim2.new(1, -30, 0, 10)
progressBack.Position = UDim2.fromOffset(15, 215)
progressBack.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
progressBack.BorderSizePixel = 0
progressBack.Parent = main

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(1, 0)
progressCorner.Parent = progressBack

local progress = Instance.new("Frame")
progress.Size = UDim2.new(0, 0, 1, 0)
progress.BackgroundColor3 = Color3.fromRGB(50, 190, 255)
progress.BorderSizePixel = 0
progress.Parent = progressBack

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.CornerRadius = UDim.new(1, 0)
progressBarCorner.Parent = progress

-- Scan button
local scanButton = Instance.new("TextButton")
scanButton.Size = UDim2.fromOffset(190, 45)
scanButton.Position = UDim2.fromOffset(15, 245)
scanButton.BackgroundColor3 = Color3.fromRGB(35, 120, 200)
scanButton.Text = "SCAN MAP"
scanButton.TextColor3 = Color3.new(1, 1, 1)
scanButton.TextSize = 16
scanButton.Font = Enum.Font.GothamBold
scanButton.Parent = main

local scanCorner = Instance.new("UICorner")
scanCorner.CornerRadius = UDim.new(0, 8)
scanCorner.Parent = scanButton

-- Detail button
local detailButton = Instance.new("TextButton")
detailButton.Size = UDim2.fromOffset(190, 45)
detailButton.Position = UDim2.fromOffset(225, 245)
detailButton.BackgroundColor3 = Color3.fromRGB(55, 60, 75)
detailButton.Text = "DETAIL"
detailButton.TextColor3 = Color3.new(1, 1, 1)
detailButton.TextSize = 16
detailButton.Font = Enum.Font.GothamBold
detailButton.Parent = main

local detailCorner = Instance.new("UICorner")
detailCorner.CornerRadius = UDim.new(0, 8)
detailCorner.Parent = detailButton

--==================================================
-- SCANNER
--==================================================

local scanning = false
local results = {}

local function addResult(level, objectName, message, fix)
	table.insert(results, {
		level = level,
		object = objectName,
		message = message,
		fix = fix
	})
end

local function scanObject(obj)

	-- Cek BasePart
	if obj:IsA("BasePart") then

		-- Part sangat besar
		local size = obj.Size

		if size.X > 1000 or size.Y > 1000 or size.Z > 1000 then
			addResult(
				"WARNING",
				obj:GetFullName(),
				"Part memiliki ukuran sangat besar.",
				"Periksa Size dan gunakan ukuran yang sesuai kebutuhan map."
			)
		end

		-- Anchored check
		if not obj.Anchored then
			addResult(
				"CHECK",
				obj:GetFullName(),
				"Part tidak Anchored.",
				"Jika objek seharusnya menjadi bagian map tetap, aktifkan Anchored."
			)
		end
	end

	-- Script check
	if obj:IsA("Script") or obj:IsA("LocalScript") then
		addResult(
			"CHECK",
			obj:GetFullName(),
			"Script ditemukan.",
			"Periksa kode script, RemoteEvent, validasi server, dan permission-nya."
		)
	end

	-- RemoteEvent check
	if obj:IsA("RemoteEvent") then
		addResult(
			"CHECK",
			obj:GetFullName(),
			"RemoteEvent ditemukan.",
			"Pastikan server memvalidasi semua input dari client."
		)
	end

	-- RemoteFunction check
	if obj:IsA("RemoteFunction") then
		addResult(
			"CHECK",
			obj:GetFullName(),
			"RemoteFunction ditemukan.",
			"Pastikan server tidak mempercayai data client secara langsung."
		)
	end
end

local function runScan()

	if scanning then
		return
	end

	scanning = true
	results = {}

	scanButton.Text = "SCANNING..."
	scanButton.Active = false

	status.Text = "STATUS: SCANNING MAP"

	local objects = Workspace:GetDescendants()
	local total = #objects

	if total == 0 then
		total = 1
	end

	for i, obj in ipairs(objects) do

		if not scanning then
			break
		end

		scanObject(obj)

		local percent = i / total
		progress.Size = UDim2.new(percent, 0, 1, 0)

		scanText.Text =
			"MAP SCANNER ONLINE\n\n" ..
			"Scanning: " .. tostring(obj.Name) .. "\n" ..
			"Progress: " .. math.floor(percent * 100) .. "%\n" ..
			"Objects: " .. i .. "/" .. total

		task.wait(0.01)
	end

	scanning = false
	scanButton.Text = "SCAN MAP"
	scanButton.Active = true

	status.Text =
		"STATUS: COMPLETE | FINDINGS: " ..
		tostring(#results)

	if #results == 0 then
		scanText.Text =
			"SCAN COMPLETE\n\n" ..
			"✓ NO POTENTIAL ISSUES FOUND"
	else
		scanText.Text =
			"SCAN COMPLETE\n\n" ..
			"⚠ FINDINGS: " .. tostring(#results) ..
			"\n\nPress DETAIL"
	end
end

--==================================================
-- DETAIL
--==================================================

detailButton.MouseButton1Click:Connect(function()

	if #results == 0 then
		scanText.Text =
			"NO RESULTS\n\n" ..
			"Run SCAN MAP first."
		return
	end

	local text = "SCAN RESULTS\n\n"

	for i, result in ipairs(results) do

		text = text ..
			"[" .. result.level .. "]\n" ..
			result.object .. "\n" ..
			result.message .. "\n" ..
			"FIX: " .. result.fix .. "\n\n"

		if i >= 4 then
			text = text ..
				"... +" ..
				tostring(#results - 4) ..
				" more findings"
			break
		end
	end

	scanText.Text = text
end)

--==================================================
-- START
--==================================================

scanButton.MouseButton1Click:Connect(runScan)

print("[DANZZY MAP SCANNER] Loaded successfully.")
