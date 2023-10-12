local player = game.Players.LocalPlayer
local userGui = player:WaitForChild("PlayerGui")
local userInputService = game:GetService("UserInputService")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local walkSpeedSliderValue = 16

local gui = Instance.new("ScreenGui")
gui.Name = "WalkSpeedGUI"
gui.Parent = userGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
frame.Parent = gui

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(0, 180, 0, 20)
slider.Position = UDim2.new(0, 10, 0, 15)
slider.BackgroundColor3 = Color3.new(0, 0, 0)
slider.Text = "Prędkość: " .. walkSpeedSliderValue
slider.TextColor3 = Color3.new(1, 1, 1)
slider.Parent = frame

local function updateWalkSpeed(value)
    walkSpeedSliderValue = value
    slider.Text = "Prędkość: " .. walkSpeedSliderValue
    humanoid.WalkSpeed = 16 * walkSpeedSliderValue
end

local isDragging = false

slider.MouseButton1Down:Connect(function()
    isDragging = true
end)

userInputService.InputEnded:Connect(function(input, gameProcessed)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

userInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderPosition = slider.Position
        local sliderSize = slider.Size
        local mouseX = input.Position.X

        local sliderMinX = sliderPosition.X.Offset
        local sliderMaxX = sliderMinX + sliderSize.X.Offset

        if mouseX >= sliderMinX and mouseX <= sliderMaxX then
            local relativeX = (mouseX - sliderMinX) / sliderSize.X.Offset
            local newValue = math.floor(relativeX * 10) + 1
            updateWalkSpeed(newValue)
        end
    end
end)

updateWalkSpeed(walkSpeedSliderValue)
