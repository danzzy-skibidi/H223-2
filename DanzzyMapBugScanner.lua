 DANZZY MAP BUG SCANNER
-- File: DanzzyMapBugScanner.lua
-- Untuk debugging map Roblox milik sendiri.
-- Pasang sebagai LocalScript di Roblox Studio:
-- StarterPlayer > StarterPlayerScripts
--
-- Jika file ini disimpan di GitHub, GitHub hanya menjadi tempat hosting.
-- Jalankan melalui Roblox Studio, bukan di halaman GitHub.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DanzzyMapBugScanner"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(430, 520)
main.Position = UDim2.new(0.5, -215, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(10, 14, 24)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(55, 110, 220)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 48)
title.Position = UDim2.fromOffset(16, 2)
title.BackgroundTransparency = 1
title.Text = "📺 DANZZY BUG SCANNER"
title.TextColor3 = Color3.fromRGB(235, 245, 255)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local hide = Instance.new("TextButton")
hide.Size = UDim2.fromOffset(36, 36)
hide.Position = UDim2.new(1, -44, 0, 7)
hide.Text = "—"
hide.TextSize = 20
hide.Font = Enum.Font.GothamBold
hide.TextColor3 = Color3.new(1, 1, 1)
hide.BackgroundColor3 = Color3.fromRGB(35, 42, 58)
hide.Parent = main
Instance.new("UICorner", hide).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -32, 0, 30)
status.Position = UDim2.fromOffset(16, 50)
status.BackgroundTransparency = 1
status.Text = "STATUS: READY"
status.TextColor3 = Color3.fromRGB(100, 210, 255)
status.TextSize = 13
status.Font = Enum.Font.GothamBold
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

local progress = Instance.new("TextLabel")
progress.Size = UDim2.new(1, -32, 0, 24)
progress.Position = UDim2.fromOffset(16, 78)
progress.BackgroundTransparency = 1
progress.Text = "Progress: 0% | Errors: 0 | Warnings: 0"
progress.TextColor3 = Color3.fromRGB(170, 185, 205)
progress.TextSize = 12
progress.Font = Enum.Font.Gotham
progress.TextXAlignment = Enum.TextXAlignment.Left
progress.Parent = main

local scan = Instance.new("TextButton")
scan.Size = UDim2.fromOffset(125, 40)
scan.Position = UDim2.fromOffset(16, 108)
scan.Text = "SCAN MAP"
scan.TextSize = 14
scan.Font = Enum.Font.GothamBold
scan.TextColor3 = Color3.new(1, 1, 1)
scan.BackgroundColor3 = Color3.fromRGB(45, 105, 220)
scan.Parent = main
Instance.new("UICorner", scan).CornerRadius = UDim.new(0, 9)

local auto = Instance.new("TextButton")
auto.Size = UDim2.fromOffset(125, 40)
auto.Position = UDim2.fromOffset(150, 108)
auto.Text = "AUTO: OFF"
auto.TextSize = 14
auto.Font = Enum.Font.GothamBold
auto.TextColor3 = Color3.new(1, 1, 1)
auto.BackgroundColor3 = Color3.fromRGB(55, 60, 75)
auto.Parent = main
Instance.new("UICorner", auto).CornerRadius = UDim.new(0, 9)

local tutorial = Instance.new("TextButton")
tutorial.Size = UDim2.fromOffset(125, 40)
tutorial.Position = UDim2.fromOffset(284, 108)
tutorial.Text = "TUTORIAL"
tutorial.TextSize = 14
tutorial.Font = Enum.Font.GothamBold
tutorial.TextColor3 = Color3.new(1, 1, 1)
tutorial.BackgroundColor3 = Color3.fromRGB(90, 65, 180)
tutorial.Parent = main
Instance.new("UICorner", tutorial).CornerRadius = UDim.new(0, 9)

local results = Instance.new("ScrollingFrame")
results.Size = UDim2.new(1, -32, 1, -165)
results.Position = UDim2.fromOffset(16, 158)
results.BackgroundColor3 = Color3.fromRGB(6, 9, 16)
results.BorderSizePixel = 0
results.ScrollBarThickness = 5
results.CanvasSize = UDim2.new()
results.Parent = main
Instance.new("UICorner", results).CornerRadius = UDim.new(0, 10)

local layout = Instance.new("UIListLayout", results)
layout.Padding = UDim.new(0, 7)

local pad = Instance.new("UIPadding", results)
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	results.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 20)
end)

-- Drag window
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch) then
		local d = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + d.X,
			startPos.Y.Scale, startPos.Y.Offset + d.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Mini button
local mini = Instance.new("TextButton")
mini.Size = UDim2.fromOffset(115, 40)
mini.Position = UDim2.fromOffset(20, 180)
mini.Text = "BUG SCANNER"
mini.TextSize = 13
mini.Font = Enum.Font.GothamBold
mini.TextColor3 = Color3.new(1, 1, 1)
mini.BackgroundColor3 = Color3.fromRGB(45, 105, 220)
mini.Visible = false
mini.Parent = gui
Instance.new("UICorner", mini).CornerRadius = UDim.new(0, 9)

hide.MouseButton1Click:Connect(function()
	main.Visible = false
	mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
	main.Visible = true
	mini.Visible = false
end)

local errors = 0
local warnings = 0
local infos = 0

local tutorials = {
	["Unanchored"] = {
		"Part tidak Anchored dapat jatuh atau bergerak saat physics aktif.",
		"1. Buka Explorer.",
		"2. Pilih objek yang dilaporkan.",
		"3. Buka Properties.",
		"4. Cari Anchored.",
		"5. Ubah menjadi True jika objek memang harus diam."
	},
	["Small"] = {
		"Part yang sangat kecil dapat sulit terlihat atau digunakan.",
		"1. Pilih Part.",
		"2. Buka Properties > Size.",
		"3. Periksa nilai X, Y, dan Z.",
		"4. Besarkan jika ukuran tersebut tidak disengaja."
	},
	["Huge"] = {
		"Part yang sangat besar dapat membuat map sulit dikelola.",
		"1. Pilih Part.",
		"2. Periksa Properties > Size.",
		"3. Jika tidak diperlukan, pecah menjadi beberapa Part."
	},
	["CanCollide"] = {
		"CanCollide OFF membuat pemain dapat melewati objek.",
		"1. Pilih Part.",
		"2. Buka Properties.",
		"3. Cari CanCollide.",
		"4. Aktifkan jika objek harus menjadi penghalang."
	},
	["PrimaryPart"] = {
		"Model belum memiliki PrimaryPart.",
		"1. Pilih Model.",
		"2. Tentukan BasePart utama.",
		"3. Set sebagai PrimaryPart jika sistem model membutuhkannya."
	},
	["Disabled"] = {
		"Script sedang Disabled sehingga tidak akan berjalan.",
		"1. Pilih Script/LocalScript.",
		"2. Buka Properties.",
		"3. Periksa Disabled.",
		"4. Aktifkan hanya jika memang diperlukan."
	},
	["Spawn"] = {
		"SpawnLocation terlalu tipis.",
		"1. Pilih SpawnLocation.",
		"2. Periksa Properties > Size.",
		"3. Pastikan ukurannya cukup untuk spawn pemain."
	}
}

local function clear()
	for _, child in ipairs(results:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	errors, warnings, infos = 0, 0, 0
end

local function addResult(level, object, problem, key)
	if level == "ERROR" then
		errors += 1
	elseif level == "WARNING" then
		warnings += 1
	else
		infos += 1
	end

	local item = Instance.new("Frame")
	item.Size = UDim2.new(1, -5, 0, 126)
	item.BackgroundColor3 = Color3.fromRGB(19, 24, 35)
	item.BorderSizePixel = 0
	item.Parent = results
	Instance.new("UICorner", item).CornerRadius = UDim.new(0, 8)

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, -16, 1, -12)
	text.Position = UDim2.fromOffset(8, 6)
	text.BackgroundTransparency = 1
	text.TextWrapped = true
	text.TextYAlignment = Enum.TextYAlignment.Top
	text.TextXAlignment = Enum.TextXAlignment.Left
	text.Font = Enum.Font.Gotham
	text.TextSize = 12
	text.Text = "[" .. level .. "] " .. object:GetFullName()
		.. "\nMasalah: " .. problem
		.. "\n\nCara memperbaiki:"
		.. "\n" .. table.concat(tutorials[key] or {"Periksa objek tersebut secara manual."}, "\n")
	text.TextColor3 =
		level == "ERROR" and Color3.fromRGB(255, 95, 95)
		or level == "WARNING" and Color3.fromRGB(255, 210, 90)
		or Color3.fromRGB(125, 215, 255)
	text.Parent = item
end

local function scanMap()
	clear()
	status.Text = "STATUS: SCANNING..."
	local objects = workspace:GetDescendants()
	local total = #objects

	for i, object in ipairs(objects) do
		if object:IsA("BasePart") then
			if not object.Anchored then
				addResult("WARNING", object, "Part tidak Anchored.", "Unanchored")
			end

			local s = object.Size
			if s.X < 0.05 or s.Y < 0.05 or s.Z < 0.05 then
				addResult("WARNING", object, "Ukuran Part sangat kecil.", "Small")
			end

			if s.X > 2048 or s.Y > 2048 or s.Z > 2048 then
				addResult("WARNING", object, "Ukuran Part sangat besar.", "Huge")
			end

			if not object.CanCollide and object.Transparency < 1 then
				addResult("INFO", object, "CanCollide OFF.", "CanCollide")
			end
		end

		if object:IsA("Model") then
			local hasPart = false
			for _, d in ipairs(object:GetDescendants()) do
				if d:IsA("BasePart") then
					hasPart = true
					break
				end
			end
			if hasPart and object.PrimaryPart == nil then
				addResult("INFO", object, "Model belum memiliki PrimaryPart.", "PrimaryPart")
			end
		end

		if object:IsA("Script") or object:IsA("LocalScript") then
			if object.Disabled then
				addResult("WARNING", object, "Script sedang Disabled.", "Disabled")
			end
		end

		if object:IsA("SpawnLocation") and object.Size.Y < 0.5 then
			addResult("WARNING", object, "SpawnLocation terlalu tipis.", "Spawn")
		end

		if i % 100 == 0 then
			local pct = math.floor((i / math.max(total, 1)) * 100)
			status.Text = "STATUS: SCANNING..."
			progress.Text = "Progress: " .. pct .. "% | Errors: "
				.. errors .. " | Warnings: " .. warnings
			task.wait()
		end
	end

	status.Text = "STATUS: SCAN SELESAI"
	progress.Text = "Progress: 100% | Errors: "
		.. errors .. " | Warnings: " .. warnings
		.. " | Info: " .. infos
end

scan.MouseButton1Click:Connect(scanMap)

local autoOn = false
auto.MouseButton1Click:Connect(function()
	autoOn = not autoOn
	auto.Text = autoOn and "AUTO: ON" or "AUTO: OFF"
	auto.BackgroundColor3 = autoOn
		and Color3.fromRGB(35, 150, 90)
		or Color3.fromRGB(55, 60, 75)

	if autoOn then
		task.spawn(scanMap)
	end
end)

tutorial.MouseButton1Click:Connect(function()
	clear()

	local fake = {
		GetFullName = function()
			return "TUTORIAL BUG"
		end
	}

	addResult("INFO", fake, "Panduan umum pemeriksaan map.", "Unanchored")
end)
