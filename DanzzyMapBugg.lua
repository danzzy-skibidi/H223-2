--==================================================
-- DANZZY MAP SCANNER 
--==================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "DanzzyMapScanner"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(440, 390)
main.Position = UDim2.new(0.5, -220, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

--==================================================
-- HEADER / DRAG
--==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
header.BorderSizePixel = 0
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "DANZZY TV MAP SCANNER"
title.TextColor3 = Color3.fromRGB(80, 200, 255)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.fromOffset(70, 30)
hideButton.Position = UDim2.new(1, -80, 0, 7)
hideButton.Text = "HIDE"
hideButton.TextSize = 13
hideButton.TextColor3 = Color3.new(1,1,1)
hideButton.BackgroundColor3 = Color3.fromRGB(55,60,75)
hideButton.Parent = header

Instance.new("UICorner", hideButton).CornerRadius = UDim.new(0,6)

-- Drag
local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = main.Position

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
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--==================================================
-- STATUS
--==================================================

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 25)
status.Position = UDim2.fromOffset(15, 52)
status.BackgroundTransparency = 1
status.Text = "STATUS: READY"
status.TextColor3 = Color3.fromRGB(180,190,205)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

--==================================================
-- SCROLL SCREEN
--==================================================

local screen = Instance.new("ScrollingFrame")
screen.Size = UDim2.new(1, -30, 0, 190)
screen.Position = UDim2.fromOffset(15, 82)
screen.BackgroundColor3 = Color3.fromRGB(2,5,10)
screen.BorderSizePixel = 0
screen.ScrollBarThickness = 7
screen.CanvasSize = UDim2.new(0,0,0,0)
screen.AutomaticCanvasSize = Enum.AutomaticSize.Y
screen.Parent = main

local screenCorner = Instance.new("UICorner")
screenCorner.CornerRadius = UDim.new(0,8)
screenCorner.Parent = screen

local scanText = Instance.new("TextLabel")
scanText.Size = UDim2.new(1, -20, 0, 30)
scanText.Position = UDim2.fromOffset(10, 10)
scanText.BackgroundTransparency = 1
scanText.Text = "SYSTEM READY\n\nPRESS SCAN MAP"
scanText.TextColor3 = Color3.fromRGB(70,220,255)
scanText.TextSize = 15
scanText.Font = Enum.Font.Code
scanText.TextWrapped = true
scanText.TextXAlignment = Enum.TextXAlignment.Left
scanText.TextYAlignment = Enum.TextYAlignment.Top
scanText.AutomaticSize = Enum.AutomaticSize.Y
scanText.Parent = screen

--==================================================
-- PROGRESS
--==================================================

local progressBack = Instance.new("Frame")
progressBack.Size = UDim2.new(1,-30,0,9)
progressBack.Position = UDim2.fromOffset(15,282)
progressBack.BackgroundColor3 = Color3.fromRGB(30,35,45)
progressBack.BorderSizePixel = 0
progressBack.Parent = main

local progress = Instance.new("Frame")
progress.Size = UDim2.new(0,0,1,0)
progress.BackgroundColor3 = Color3.fromRGB(50,190,255)
progress.BorderSizePixel = 0
progress.Parent = progressBack

Instance.new("UICorner",progressBack).CornerRadius = UDim.new(1,0)
Instance.new("UICorner",progress).CornerRadius = UDim.new(1,0)

--==================================================
-- BUTTON FUNCTION
--==================================================

local function button(text,x,y,w)

	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(w,40)
	b.Position = UDim2.fromOffset(x,y)
	b.BackgroundColor3 = Color3.fromRGB(45,70,100)
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = text
	b.TextSize = 14
	b.Font = Enum.Font.GothamBold
	b.Parent = main

	Instance.new("UICorner",b).CornerRadius = UDim.new(0,7)

	return b
end

local scanButton = button("SCAN MAP",15,305,125)
local detailButton = button("DETAIL",150,305,125)
local resetButton = button("RESET VEHICLE",285,305,140)

--==================================================
-- HIDE / SHOW
--==================================================

local hidden = false

local showButton = Instance.new("TextButton")
showButton.Size = UDim2.fromOffset(80,40)
showButton.Position = UDim2.fromOffset(20,20)
showButton.BackgroundColor3 = Color3.fromRGB(35,120,200)
showButton.Text = "SHOW"
showButton.TextColor3 = Color3.new(1,1,1)
showButton.TextSize = 14
showButton.Font = Enum.Font.GothamBold
showButton.Visible = false
showButton.Parent = gui

Instance.new("UICorner",showButton).CornerRadius = UDim.new(0,8)

hideButton.MouseButton1Click:Connect(function()
	hidden = true
	main.Visible = false
	showButton.Visible = true
end)

showButton.MouseButton1Click:Connect(function()
	hidden = false
	main.Visible = true
	showButton.Visible = false
end)

--==================================================
-- SCANNER
--==================================================

local results = {}
local scanning = false

local function addResult(level,obj,message,fix)

	table.insert(results,{
		level = level,
		object = obj,
		message = message,
		fix = fix
	})

end

local function scanObject(obj)

	if obj:IsA("BasePart") then

		local s = obj.Size

		if s.X > 1000 or s.Y > 1000 or s.Z > 1000 then

			addResult(
				"WARNING",
				obj:GetFullName(),
				"Part sangat besar.",
				"Periksa Size part."
			)

		end

		if not obj.Anchored then

			addResult(
				"CHECK",
				obj:GetFullName(),
				"Part tidak Anchored.",
				"Jika memang bagian map tetap, aktifkan Anchored."
			)

		end
	end

	if obj:IsA("RemoteEvent") then

		addResult(
			"CHECK",
			obj:GetFullName(),
			"RemoteEvent ditemukan.",
			"Validasi semua data yang dikirim client di server."
		)

	end

	if obj:IsA("RemoteFunction") then

		addResult(
			"CHECK",
			obj:GetFullName(),
			"RemoteFunction ditemukan.",
			"Jangan mempercayai input client tanpa validasi server."
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

	local objects = Workspace:GetDescendants()
	local total = math.max(#objects,1)

	for i,obj in ipairs(objects) do

		scanObject(obj)

		local percent = i / total

		progress.Size =
			UDim2.new(percent,0,1,0)

		scanText.Text =
			"TV MAP SCANNER\n\n" ..
			"Scanning: " .. obj.Name .. "\n" ..
			"Progress: " ..
			math.floor(percent*100) .. "%\n\n" ..
			"Objects: " .. i .. "/" .. total

		task.wait(0.01)

	end

	scanning = false

	scanButton.Text = "SCAN MAP"
	scanButton.Active = true

	status.Text =
		"STATUS: COMPLETE | FINDINGS: " ..
		#results

	if #results == 0 then

		scanText.Text =
			"SCAN COMPLETE\n\n" ..
			"✓ NO POTENTIAL ISSUES FOUND"

	else

		scanText.Text =
			"SCAN COMPLETE\n\n" ..
			"⚠ FINDINGS: " .. #results ..
			"\n\nPress DETAIL"

	end

end

scanButton.MouseButton1Click:Connect(runScan)

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

	for i,result in ipairs(results) do

		text = text ..
			"[" .. result.level .. "]\n" ..
			result.object .. "\n" ..
			result.message .. "\n" ..
			"FIX: " .. result.fix .. "\n\n"

		if i >= 20 then

			text = text ..
				"... " ..
				(#results - 20) ..
				" more findings"

			break
		end

	end

	scanText.Text = text

end)

--==================================================
-- VEHICLE RESET
--==================================================

local savedVehicle
local savedPivot

local function findVehicle()

	local character = player.Character

	if not character then
		return nil
	end

	local seat = character:FindFirstChildWhichIsA(
		"VehicleSeat",
		true
	)

	if not seat then
		return nil
	end

	local model = seat:FindFirstAncestorOfClass("Model")

	return model
end

local function saveVehicle()

	local vehicle = findVehicle()

	if vehicle then

		savedVehicle = vehicle
		savedPivot = vehicle:GetPivot()

		status.Text = "VEHICLE POSITION SAVED"

	end
end

local function resetVehicle()

	if not savedVehicle or not savedPivot then

		status.Text =
			"NO SAVED VEHICLE POSITION"

		return
	end

	if not savedVehicle.Parent then

		status.Text =
			"VEHICLE NO LONGER EXISTS"

		return
	end

	savedVehicle:PivotTo(savedPivot)

	status.Text =
		"VEHICLE RESET SUCCESS"

end

resetButton.MouseButton1Click:Connect(resetVehicle)

-- Simpan posisi kendaraan ketika pemain masuk kendaraan
task.spawn(function()

	while true do

		local vehicle = findVehicle()

		if vehicle and vehicle ~= savedVehicle then
			saveVehicle()
		end

		task.wait(1)

	end

end)

print("[DANZZY] Map Scanner loaded.")
