--========================================================
-- DANZZY TV MAP SCANNER
--========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--========================================================
-- GUI
--========================================================

local gui = Instance.new("ScreenGui")
gui.Name = "DanzzyTVScanner"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

--========================================================
-- MAIN MENU
--========================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(450, 410)
main.Position = UDim2.new(0.5, -225, 0.5, -205)
main.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

--========================================================
-- HEADER
--========================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "📺 DANZZY TV MAP SCANNER"
title.TextColor3 = Color3.fromRGB(80, 210, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

--========================================================
-- HIDE BUTTON
--========================================================

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.fromOffset(65, 30)
hideButton.Position = UDim2.new(1, -75, 0, 9)
hideButton.BackgroundColor3 = Color3.fromRGB(55, 60, 75)
hideButton.Text = "HIDE"
hideButton.TextColor3 = Color3.new(1, 1, 1)
hideButton.TextSize = 13
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = header

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideButton

--========================================================
-- DRAG MENU
--========================================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end

		end)
	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,

			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

	end

end)

--========================================================
-- STATUS
--========================================================

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 25)
status.Position = UDim2.fromOffset(15, 55)
status.BackgroundTransparency = 1
status.Text = "STATUS: READY"
status.TextColor3 = Color3.fromRGB(180, 190, 205)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

--========================================================
-- TV DETAIL SCREEN
--========================================================

local screen = Instance.new("ScrollingFrame")
screen.Name = "DetailScroll"

screen.Size = UDim2.new(1, -30, 0, 195)
screen.Position = UDim2.fromOffset(15, 85)

screen.BackgroundColor3 = Color3.fromRGB(2, 5, 10)
screen.BorderSizePixel = 0

screen.ScrollingDirection = Enum.ScrollingDirection.Y
screen.ScrollingEnabled = true
screen.Active = true

screen.ScrollBarThickness = 10
screen.ScrollBarImageTransparency = 0
screen.CanvasSize = UDim2.new(0, 0, 0, 0)

screen.Parent = main

local screenCorner = Instance.new("UICorner")
screenCorner.CornerRadius = UDim.new(0, 8)
screenCorner.Parent = screen

--========================================================
-- DETAIL TEXT
--========================================================

local scanText = Instance.new("TextLabel")
scanText.Name = "DetailText"

scanText.Size = UDim2.new(1, -30, 0, 0)
scanText.Position = UDim2.fromOffset(15, 12)

scanText.BackgroundTransparency = 1

scanText.Text =
	"SYSTEM READY\n\n" ..
	"Tekan SCAN MAP untuk memulai."

scanText.TextColor3 = Color3.fromRGB(80, 220, 255)
scanText.TextSize = 15
scanText.Font = Enum.Font.Code

scanText.TextWrapped = true
scanText.TextXAlignment = Enum.TextXAlignment.Left
scanText.TextYAlignment = Enum.TextYAlignment.Top

scanText.AutomaticSize = Enum.AutomaticSize.Y

scanText.Parent = screen

--========================================================
-- UPDATE SCREEN
--========================================================

local function showDetails(text)

	scanText.Text = text

	task.wait()

	screen.CanvasSize = UDim2.new(
		0,
		0,
		0,
		scanText.AbsoluteSize.Y + 30
	)

	screen.CanvasPosition = Vector2.new(0, 0)

end

--========================================================
-- PROGRESS BAR
--========================================================

local progressBack = Instance.new("Frame")
progressBack.Size = UDim2.new(1, -30, 0, 9)
progressBack.Position = UDim2.fromOffset(15, 290)
progressBack.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
progressBack.BorderSizePixel = 0
progressBack.Parent = main

local progressBackCorner = Instance.new("UICorner")
progressBackCorner.CornerRadius = UDim.new(1, 0)
progressBackCorner.Parent = progressBack

local progress = Instance.new("Frame")
progress.Size = UDim2.new(0, 0, 1, 0)
progress.BackgroundColor3 = Color3.fromRGB(50, 190, 255)
progress.BorderSizePixel = 0
progress.Parent = progressBack

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(1, 0)
progressCorner.Parent = progress

--========================================================
-- BUTTON CREATOR
--========================================================

local function createButton(text, x, width)

	local button = Instance.new("TextButton")

	button.Size = UDim2.fromOffset(width, 42)
	button.Position = UDim2.fromOffset(x, 310)

	button.BackgroundColor3 = Color3.fromRGB(45, 75, 105)

	button.Text = text
	button.TextColor3 = Color3.new(1, 1, 1)

	button.TextSize = 13
	button.Font = Enum.Font.GothamBold

	button.Parent = main

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	return button
end

local scanButton = createButton("SCAN MAP", 15, 125)
local detailButton = createButton("DETAIL", 150, 125)
local resetButton = createButton("RESET VEHICLE", 285, 150)

--========================================================
-- HIDE / SHOW
--========================================================

local showButton = Instance.new("TextButton")
showButton.Size = UDim2.fromOffset(85, 40)
showButton.Position = UDim2.fromOffset(20, 20)

showButton.BackgroundColor3 = Color3.fromRGB(35, 120, 200)

showButton.Text = "SHOW"
showButton.TextColor3 = Color3.new(1, 1, 1)
showButton.TextSize = 14
showButton.Font = Enum.Font.GothamBold

showButton.Visible = false
showButton.Parent = gui

local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(0, 8)
showCorner.Parent = showButton

hideButton.MouseButton1Click:Connect(function()

	main.Visible = false
	showButton.Visible = true

end)

showButton.MouseButton1Click:Connect(function()

	main.Visible = true
	showButton.Visible = false

end)

--========================================================
-- SCANNER
--========================================================

local results = {}
local scanning = false

local function addResult(level, objectName, message, fix)

	table.insert(results, {

		level = level,
		object = objectName,
		message = message,
		fix = fix

	})

end

local function scanObject(obj)

	-- BasePart
	if obj:IsA("BasePart") then

		local size = obj.Size

		if size.X > 1000
			or size.Y > 1000
			or size.Z > 1000 then

			addResult(
				"WARNING",
				obj:GetFullName(),
				"Part memiliki ukuran sangat besar.",
				"Periksa Size part dan sesuaikan dengan kebutuhan map."
			)

		end

		if not obj.Anchored then

			addResult(
				"CHECK",
				obj:GetFullName(),
				"Part tidak Anchored.",
				"Jika objek seharusnya tetap di tempat, aktifkan Anchored."
			)

		end

	end

	-- RemoteEvent
	if obj:IsA("RemoteEvent") then

		addResult(
			"CHECK",
			obj:GetFullName(),
			"RemoteEvent ditemukan.",
			"Pastikan server memvalidasi semua data dari client."
		)

	end

	-- RemoteFunction
	if obj:IsA("RemoteFunction") then

		addResult(
			"CHECK",
			obj:GetFullName(),
			"RemoteFunction ditemukan.",
			"Pastikan server memvalidasi input sebelum menjalankan aksi."
		)

	end

end

local function runScan()

	if scanning then
		return
	end

	scanning = true
	results = {}

	progress.Size = UDim2.new(0, 0, 1, 0)

	scanButton.Text = "SCANNING..."
	scanButton.Active = false

	status.Text = "STATUS: SCANNING"

	local objects = Workspace:GetDescendants()

	local total = math.max(#objects, 1)

	for index, object in ipairs(objects) do

		scanObject(object)

		local percent = index / total

		progress.Size =
			UDim2.new(percent, 0, 1, 0)

		showDetails(
			"===== TV MAP SCANNER =====\n\n" ..

			"SCANNING MAP...\n\n" ..

			"OBJECT:\n" ..
			object.Name ..

			"\n\nPROGRESS: " ..
			math.floor(percent * 100) ..
			"%\n\nOBJECTS: " ..
			index ..
			" / " ..
			total
		)

		task.wait(0.01)

	end

	scanning = false

	scanButton.Text = "SCAN MAP"
	scanButton.Active = true

	status.Text =
		"STATUS: COMPLETE | FINDINGS: " ..
		#results

	if #results == 0 then

		showDetails(
			"===== SCAN COMPLETE =====\n\n" ..

			"✓ NO POTENTIAL ISSUES FOUND\n\n" ..

			"Map selesai diperiksa."
		)

	else

		showDetails(
			"===== SCAN COMPLETE =====\n\n" ..

			"⚠ FINDINGS: " ..
			#results ..

			"\n\nTekan DETAIL untuk membaca hasil."
		)

	end

end

scanButton.MouseButton1Click:Connect(runScan)

--========================================================
-- DETAIL
--========================================================

detailButton.MouseButton1Click:Connect(function()

	if #results == 0 then

		showDetails(
			"===== NO RESULTS =====\n\n" ..

			"Tekan SCAN MAP terlebih dahulu."
		)

		return

	end

	local text =
		"===== DANZZY MAP SCANNER =====\n\n" ..

		"TOTAL FINDINGS: " ..
		#results ..
		"\n\n"

	for index, result in ipairs(results) do

		text = text ..

			"━━━━━━━━━━━━━━━━━━\n" ..

			"FINDING #" ..
			index ..

			"\nLEVEL: " ..
			result.level ..

			"\n\nOBJECT:\n" ..
			result.object ..

			"\n\nMASALAH:\n" ..
			result.message ..

			"\n\nLANGKAH PERBAIKAN:\n" ..
			result.fix ..

			"\n\n"

	end

	showDetails(text)

end)

--========================================================
-- VEHICLE SYSTEM
--========================================================

local savedVehicle = nil
local savedPivot = nil

local function findVehicle()

	local character = player.Character

	if not character then
		return nil
	end

	local seat =
		character:FindFirstChildWhichIsA(
			"VehicleSeat",
			true
		)

	if not seat then
		return nil
	end

	return seat:FindFirstAncestorOfClass("Model")

end

local function saveVehicle()

	local vehicle = findVehicle()

	if not vehicle then
		return
	end

	if vehicle ~= savedVehicle then

		savedVehicle = vehicle
		savedPivot = vehicle:GetPivot()

		status.Text =
			"VEHICLE POSITION SAVED"

	end

end

local function resetVehicle()

	if not savedVehicle then

		status.Text =
			"NO SAVED VEHICLE"

		return

	end

	if not savedVehicle.Parent then

		status.Text =
			"VEHICLE NOT FOUND"

		return

	end

	savedVehicle:PivotTo(savedPivot)

	status.Text =
		"VEHICLE RESET SUCCESS"

end

resetButton.MouseButton1Click:Connect(resetVehicle)

--========================================================
-- AUTO SAVE VEHICLE POSITION
--========================================================

task.spawn(function()

	while gui.Parent do

		saveVehicle()

		task.wait(1)

	end

end)

--========================================================
-- DONE
--========================================================

print("[DANZZY TV MAP SCANNER] Loaded successfully.")
