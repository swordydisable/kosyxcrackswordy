local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "kOSYX HuB | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    LoadingTitle = "Kosyx Hub",
    LoadingSubtitle = "by KoSYX",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KOSYX HUB",
        FileName = "KOSYX HUB"
    },
    Discord = {
        Enabled = true,
        Invite = "spicyhub", 
        RememberJoins = true 
    },
    KeySystem = true, 
    KeySettings = {
        Title = "Kosyx hub",
        Subtitle = "Key System",
        Note = "Join the discord (kosyxcrackluaboost)",
        FileName = "SpicyHubKey",
        SaveKey = true,
        GrabKeyFromSite = false, 
        Key = {"kosyxcracklua"}
    }
})

Rayfield:Notify({
    Title = "Spicy Hub",
    Content = "Welcome to Spicy Hub!",
    Duration = 6.5,
    Image = 13047715178,
    Actions = { 
        Ignore = {
            Name = "Okay!",
            Callback = function()
            end
        },
    },
})

local MainTab = Window:CreateTab("Main", 4483362458) 
local MainSection = MainTab:CreateSection("Main")

local Toggle = MainTab:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "AutoClickerToggle", 
    Callback = function(Value)
        getgenv().autoclick = Value
        while getgenv().autoclick do
            task.wait()
            game:GetService("ReplicatedStorage").Click:FireServer()
        end
    end,
})

local Slider = MainTab:CreateSlider({
    Name = "Click Rate",
    Range = {0, 100},
    Increment = 1,
    Suffix = "Clicks",
    CurrentValue = 10,
    Flag = "ClickRateSlider",
    Callback = function(Value)
        getgenv().clickrate = Value
    end,
})

local Button = MainTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end,
})

local PlayerTab = Window:CreateTab("Player", 4483362458) 
local PlayerSection = PlayerTab:CreateSection("Player")

local Slider = PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Value
    end,
})

local Slider = PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = Value
    end,
})

local Button = PlayerTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character:BreakJoints()
    end,
})

local TeleportTab = Window:CreateTab("Teleport", 4483362458) 
local TeleportSection = TeleportTab:CreateSection("Teleport")

local Dropdown = TeleportTab:CreateDropdown({
    Name = "Teleport to Player",
    Options = {"Player1", "Player2"},
    CurrentOption = "Select",
    Flag = "TeleportDropdown", 
    Callback = function(Option)
        local targetPlayer = game:GetService("Players"):FindFirstChild(Option)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    end,
})

game:GetService("Players").PlayerAdded:Connect(function(player)
    local currentOptions = Dropdown.Options
    table.insert(currentOptions, player.Name)
    Dropdown:Refresh(currentOptions, true)
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    local currentOptions = Dropdown.Options
    for i, option in ipairs(currentOptions) do
        if option == player.Name then
            table.remove(currentOptions, i)
            break
        end
    end
    Dropdown:Refresh(currentOptions, true)
end)

for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game:GetService("Players").LocalPlayer then
        local currentOptions = Dropdown.Options
        table.insert(currentOptions, player.Name)
        Dropdown:Refresh(currentOptions, true)
    end
end

local MiscTab = Window:CreateTab("Misc", 4483362458) 
local MiscSection = MiscTab:CreateSection("Misc")

local Input = MiscTab:CreateInput({
    Name = "FPS Cap",
    PlaceholderText = "Enter FPS Cap",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if tonumber(Text) then
            setfpscap(tonumber(Text))
        end
    end,
})

local Button = MiscTab:CreateButton({
    Name = "Copy Discord Invite",
    Callback = function()
        setclipboard("discord.gg/spicyhub")
        Rayfield:Notify({
            Title = "Spicy Hub",
            Content = "Discord invite copied to clipboard!",
            Duration = 6.5,
            Image = 13047715178,
        })
    end,
})

local Toggle = MiscTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFKToggle", 
    Callback = function(Value)
        if Value then
            getgenv().antiAfkConn = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        else
            if getgenv().antiAfkConn then
                getgenv().antiAfkConn:Disconnect()
            end
        end
    end,
})

local CreditTab = Window:CreateTab("Credits", 4483362458) 
local CreditSection = CreditTab:CreateSection("Credits")

local Label = CreditTab:CreateLabel("Spicy Hub v3.0")
local Label = CreditTab:CreateLabel("Made by Spicy")
local Label = CreditTab:CreateLabel("UI: Rayfield")
local Label = CreditTab:CreateLabel("Thanks for using!")

local Button = CreditTab:CreateButton({
    Name = "Copy Discord Invite",
    Callback = function()
        setclipboard("discord.gg/spicyhub")
        Rayfield:Notify({
            Title = "Spicy Hub",
            Content = "Discord invite copied to clipboard!",
            Duration = 6.5,
            Image = 13047715178,
        })
    end,
})

Rayfield:LoadConfiguration()