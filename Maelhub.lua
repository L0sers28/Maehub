
--// MAEL HUB - HUD EDITOR COMPLETO
--// LocalScript em StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// REMOVE VERSÃO ANTERIOR
local old = playerGui:FindFirstChild("MaelHub")
if old then
	old:Destroy()
end

--// CORES
local purple = Color3.fromRGB(150, 70, 255)
local blue = Color3.fromRGB(50, 130, 255)
local dark = Color3.fromRGB(13, 12, 24)
local darker = Color3.fromRGB(8, 8, 16)
local white = Color3.fromRGB(245, 240, 255)
local gray = Color3.fromRGB(155, 150, 175)

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MaelHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

--// FUNÇÃO DE CANTO
local function corner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = parent
	return c
end

--// FUNÇÃO DE CONTORNO
local function stroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thickness
	s.Transparency = transparency or 0
	s.Parent = parent
	return s
end

--// PAINEL PRINCIPAL
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(340, 255)
main.Position = UDim2.new(0.5, -170, 0.5, -127)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Visible = false
main.ClipsDescendants = true
main.Parent = gui

corner(main, 15)
local mainStroke = stroke(main, purple, 2, 0.1)

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 16, 48)),
	ColorSequenceKeypoint.new(1, darker)
})
gradient.Rotation = 45
gradient.Parent = main

--// FUNDO DAS PARTÍCULAS
local particleLayer = Instance.new("Frame")
particleLayer.Name = "Particles"
particleLayer.Size = UDim2.fromScale(1, 1)
particleLayer.BackgroundTransparency = 1
particleLayer.ClipsDescendants = true
particleLayer.ZIndex = 1
particleLayer.Parent = main

--// PARTÍCULAS ANIMADAS
for i = 1, 22 do
	local particle = Instance.new("Frame")
	local size = math.random(2, 4)

	particle.Size = UDim2.fromOffset(size, size)
	particle.Position = UDim2.new(
		math.random(),
		0,
		math.random(),
		0
	)
	particle.BackgroundColor3 = i % 2 == 0 and purple or blue
	particle.BackgroundTransparency = 0.25
	particle.BorderSizePixel = 0
	particle.ZIndex = 1
	particle.Parent = particleLayer

	corner(particle, 10)

	task.spawn(function()
		while particle.Parent do
			local newPosition = UDim2.new(
				math.random(),
				0,
				math.random(),
				0
			)

			local tween = TweenService:Create(
				particle,
				TweenInfo.new(
					math.random(3, 6),
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Position = newPosition,
					BackgroundTransparency = math.random(2, 7) / 10
				}
			)

			tween:Play()
			tween.Completed:Wait()
		end
	end)
end

--// TÍTULO
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -55, 0, 35)
title.Position = UDim2.fromOffset(18, 12)
title.BackgroundTransparency = 1
title.Text = "MAEL HUB"
title.TextColor3 = white
title.Font = Enum.Font.GothamBlack
title.TextSize = 23
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3
title.Parent = main

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -30, 0, 20)
subtitle.Position = UDim2.fromOffset(19, 43)
subtitle.BackgroundTransparency = 1
subtitle.Text = "PREMIUM HUD EDITOR"
subtitle.TextColor3 = purple
subtitle.Font = Enum.Font.GothamBold
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 3
subtitle.Parent = main

--// BOTÃO FECHAR
local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -42, 0, 12)
close.BackgroundColor3 = Color3.fromRGB(45, 25, 65)
close.Text = "×"
close.TextColor3 = white
close.TextSize = 23
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.ZIndex = 4
close.Parent = main
corner(close, 9)

--// LINHA DECORATIVA
local line = Instance.new("Frame")
line.Size = UDim2.new(1, -36, 0, 2)
line.Position = UDim2.fromOffset(18, 72)
line.BackgroundColor3 = purple
line.BorderSizePixel = 0
line.ZIndex = 3
line.Parent = main

--// STATUS
local status = Instance.new("TextLabel")
status.Name = "Status"
status.Size = UDim2.new(1, -36, 0, 22)
status.Position = UDim2.fromOffset(18, 83)
status.BackgroundTransparency = 1
status.Text = "● HUD EDITOR"
status.TextColor3 = gray
status.Font = Enum.Font.GothamBold
status.TextSize = 11
status.TextXAlignment = Enum.TextXAlignment.Left
status.ZIndex = 3
status.Parent = main

--// CRIAR BOTÕES
local function makeButton(name, text, y)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, -36, 0, 42)
	button.Position = UDim2.fromOffset(18, y)
	button.BackgroundColor3 = Color3.fromRGB(35, 24, 57)
	button.Text = text
	button.TextColor3 = white
	button.Font = Enum.Font.GothamBold
	button.TextSize = 13
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.ZIndex = 3
	button.Parent = main

	corner(button, 9)
	stroke(button, purple, 1, 0.45)

	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(65, 35, 100)
		}):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(35, 24, 57)
		}):Play()
	end)

	return button
end

local editButton = makeButton(
	"ModifyHUD",
	"✦  MODIFICAR HUD",
	119
)

local doneButton = makeButton(
	"FinishHUD",
	"✓  PRONTO",
	170
)

--// TEXTO INFERIOR
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -30, 0, 17)
footer.Position = UDim2.new(0, 15, 1, -23)
footer.BackgroundTransparency = 1
footer.Text = "MAEL HUB  •  HUD CUSTOMIZATION"
footer.TextColor3 = gray
footer.Font = Enum.Font.Gotham
footer.TextSize = 9
footer.ZIndex = 3
footer.Parent = main

--// BOLINHA FLUTUANTE
local bubble = Instance.new("TextButton")
bubble.Name = "MaelFloatingButton"
bubble.Size = UDim2.fromOffset(58, 58)
bubble.Position = UDim2.new(0, 25, 0.45, 0)
bubble.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
bubble.Text = "MAEL"
bubble.TextColor3 = white
bubble.TextSize = 12
bubble.Font = Enum.Font.GothamBlack
bubble.BorderSizePixel = 0
bubble.AutoButtonColor = false
bubble.ZIndex = 10
bubble.Parent = gui

corner(bubble, 50)
local bubbleStroke = stroke(bubble, purple, 2, 0)

local bubbleGradient = Instance.new("UIGradient")
bubbleGradient.Color = ColorSequence.new(purple, blue)
bubbleGradient.Rotation = 45
bubbleGradient.Parent = bubble

--// ABRIR E FECHAR
local opened = false

local function toggleHub()
	opened = not opened
	main.Visible = opened

	if opened then
		main.Size = UDim2.fromOffset(300, 225)

		TweenService:Create(
			main,
			TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{Size = UDim2.fromOffset(340, 255)}
		):Play()
	end
end

close.MouseButton1Click:Connect(function()
	opened = false
	main.Visible = false
end)

--// CLIQUE E ARRASTE DA BOLINHA
local bubbleHolding = false
local bubbleMoved = false
local bubbleStart
local bubbleStartPosition
local bubbleInput

bubble.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		bubbleHolding = true
		bubbleMoved = false
		bubbleStart = input.Position
		bubbleStartPosition = bubble.Position
		bubbleInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if not bubbleHolding then return end

	local validInput =
		(input.UserInputType == Enum.UserInputType.MouseMovement)
		or (input == bubbleInput)

	if not validInput then return end

	local delta = input.Position - bubbleStart

	if delta.Magnitude > 8 then
		bubbleMoved = true
	end

	if bubbleMoved then
		bubble.Position = UDim2.new(
			bubbleStartPosition.X.Scale,
			bubbleStartPosition.X.Offset + delta.X,
			bubbleStartPosition.Y.Scale,
			bubbleStartPosition.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if not bubbleHolding then return end

	local validInput =
		(input.UserInputType == Enum.UserInputType.MouseButton1)
		or (input == bubbleInput)

	if not validInput then return end

	bubbleHolding = false

	if not bubbleMoved then
		toggleHub()
	end

	bubbleInput = nil
end)

--// ARRASTAR O PAINEL PELO TÍTULO
local draggingMain = false
local mainDragStart
local mainStartPosition
local mainDragInput

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		draggingMain = true
		mainDragStart = input.Position
		mainStartPosition = main.Position
		mainDragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if not draggingMain then return end

	local validInput =
		(input.UserInputType == Enum.UserInputType.MouseMovement)
		or (input == mainDragInput)

	if not validInput then return end

	local delta = input.Position - mainDragStart

	main.Position = UDim2.new(
		mainStartPosition.X.Scale,
		mainStartPosition.X.Offset + delta.X,
		mainStartPosition.Y.Scale,
		mainStartPosition.Y.Offset + delta.Y
	)
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input == mainDragInput then

		draggingMain = false
		mainDragInput = nil
	end
end)

--// LOCALIZAR BOTÕES DO HUD
local originals = {}
local editing = false
local connectedObjects = {}

local function findHUDButtons()
	local found = {}

	for _, obj in ipairs(playerGui:GetDescendants()) do
		if obj:IsA("GuiObject")
			and not obj:IsDescendantOf(gui)
			and obj.Visible then

			local name = obj.Name:lower()

			if name:find("dash")
				or name:find("m1")
				or name:find("attack")
				or name:find("skill")
				or name:find("button") then

				table.insert(found, obj)
			end
		end
	end

	return found
end

--// ATIVAR ARRASTE DOS BOTÕES DO HUD
local function enableHUDDrag(obj)
	if connectedObjects[obj] then return end
	connectedObjects[obj] = true

	obj.InputBegan:Connect(function(input)
		if not editing then return end

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			local startPosition = obj.Position
			local startPoint = input.Position
			local dragInput = input
			local moved = false

			local changedConnection
			local endedConnection

			changedConnection = UIS.InputChanged:Connect(function(changed)
				if not editing then
					changedConnection:Disconnect()
					endedConnection:Disconnect()
					return
				end

				local validInput =
					(changed.UserInputType == Enum.UserInputType.MouseMovement)
					or (changed == dragInput)

				if not validInput then return end

				local delta = changed.Position - startPoint

				if delta.Magnitude > 5 then
					moved = true
				end

				if moved then
					obj.Position = UDim2.new(
						startPosition.X.Scale,
						startPosition.X.Offset + delta.X,
						startPosition.Y.Scale,
						startPosition.Y.Offset + delta.Y
					)
				end
			end)

			endedConnection = UIS.InputEnded:Connect(function(ended)
				local validInput =
					(ended.UserInputType == Enum.UserInputType.MouseButton1)
					or (ended == dragInput)

				if validInput then
					changedConnection:Disconnect()
					endedConnection:Disconnect()
				end
			end)
		end
	end)
end

--// EDITOR
local function toggleEditor(state)
	editing = state

	for _, obj in ipairs(findHUDButtons()) do
		if state then
			if not originals[obj] then
				originals[obj] = {
					position = obj.Position,
					active = obj.Active,
					selectable = obj.Selectable
				}
			end

			obj.Active = true
			obj.Selectable = true

			enableHUDDrag(obj)
		else
			if originals[obj] then
				obj.Active = originals[obj].active
				obj.Selectable = originals[obj].selectable
			end
		end
	end

	if state then
		status.Text = "● MODO DE EDIÇÃO ATIVO"
		status.TextColor3 = Color3.fromRGB(100, 255, 150)
	else
		status.Text = "● HUD EDITOR"
		status.TextColor3 = gray
	end
end

editButton.MouseButton1Click:Connect(function()
	toggleEditor(true)
end)

doneButton.MouseButton1Click:Connect(function()
	toggleEditor(false)
end)

--// ANIMAÇÃO DO CONTORNO
task.spawn(function()
	while gui.Parent do
		TweenService:Create(
			mainStroke,
			TweenInfo.new(1.5, Enum.EasingStyle.Sine),
			{Color = blue}
		):Play()

		TweenService:Create(
			bubbleStroke,
			TweenInfo.new(1.5, Enum.EasingStyle.Sine),
			{Color = blue}
		):Play()

		task.wait(1.5)

		TweenService:Create(
			mainStroke,
			TweenInfo.new(1.5, Enum.EasingStyle.Sine),
			{Color = purple}
		):Play()

		TweenService:Create(
			bubbleStroke,
			TweenInfo.new(1.5, Enum.EasingStyle.Sine),
			{Color = purple}
		):Play()

		task.wait(1.5)
	end
end)

print("MAEL HUB carregado com sucesso!")
