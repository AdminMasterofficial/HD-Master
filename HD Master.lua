if game.PlaceId == 155615604 then
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local Player = game.Players.LocalPlayer

    Rayfield:Notify({
        Title = "Loaded HD Master",
        Content = "Welcome "..Player.Name,
    })

    local Window = Rayfield:CreateWindow({
        Name = "HD Master | Prison Life",
        LoadingTitle = " HD Master",
        LoadingSubtitle = "by Admin Master Official",
     })

     local MainTab = Window:CreateTab("Main")

     local GiveGunDropdown = MainTab:CreateDropdown({
        Name = "Give Gun",
        Options = {"M9", "Remington 870", "AK-47"},
        CurrentOption = "M9",
        
        Callback = function(v)
            local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver[v].ITEMPICKUP
            local Event = game:GetService("Workspace").Remote.ItemHandler
            Event:InvokeServer(A_1)

        end
     })

     local GunModDropdown = MainTab:CreateDropdown({
        Name = "Gun Mod",
        Options = {"M9", "Remington 870", "AK-47"},
        CurrentOption = "M9",
        
        Callback = function(v)
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v) then
                module = require(game:GetService("Players").LocalPlayer.Backpack[v].GunStates)
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(v) then
                    module = require(game:GetService("Players").LocalPlayer.Character[v].GunStates)
            end
            if module ~= nil then
                module["MaxAmmo"] = math.huge
                module["CurrentAmmo"] = math.huge
                module["StoredAmmo"] = math.huge
                module["FireRate"] = 0.000001
                module["Spread"] = 0
                module["Range"] = math.huge
                module["Bullets"] = 10
                module["ReloadTime"] = 0.000001
                module["AutoFire"] = true
            end
        end
     })

     local LocalPlayerTab = Window:CreateTab("Local Player")

     local WalkSpeedSlider = LocalPlayerTab:CreateSlider({
        Name = "WalkSpeed",
        Range = {16, 100},
        Increment = 16,
        CurrentValue = 16,

        Callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
     })

     local JumpPowerSlider = LocalPlayerTab:CreateSlider({
        Name = "JumpPower",
        Range = {50, 100},
        Increment = 50,
        CurrentValue = 50,

        Callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
        end
     })

     local ChangeTeamabel = LocalPlayerTab:CreateLabel("Change Team")

     local GuardsTeamButton = LocalPlayerTab:CreateButton({
        Name = "Guards",

        Callback = function()
            Workspace.Remote.TeamEvent:FireServer("Bright blue")
        end
     })

     local InmatesTeamButton = LocalPlayerTab:CreateButton({
        Name = "Inmates",

        Callback = function()
            Workspace.Remote.TeamEvent:FireServer("Bright orange")
        end
     })

     local NeutralTeamButton = LocalPlayerTab:CreateButton({
        Name = "Neutral",

        Callback = function()
            Workspace.Remote.TeamEvent:FireServer("Medium stone grey")
        end
     })

     local CriminalTeamButton = LocalPlayerTab:CreateButton({
        Name = "Criminal",

        Callback = function()
            workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Really red").Name)
        end
     })

     local TeleportLocationLabel = LocalPlayerTab:CreateLabel("Teleport Location")

     local OutSidePrisonTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Outside Prison",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(288.452, 69.999, 2206.731)
        end
     })

     local YardTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Yard",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(779.092, 96.001, 2451.114)
        end
     })

     local TowerTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Tower",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(822, 131, 2588)
        end
     })

     local CafeteriaTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Cafeteria",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(930, 97.54, 2291)
        end
     })
     
     local KitchenTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Kitchen",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(906.641845703125, 99.98993682861328, 2237.67333984375)
        end
     })

     local CellsTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Cells",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918, 97.73, 2447)
        end
     })

     local GuardsRoomTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Guards Room",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(836.5386352539062, 99.98998260498047, 2320.604248046875)
        end
     })

     local SewerEnteranceTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Sewer Enterance",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.174, 76.406, 2426.199)
        end
     })

     local SewerExitTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Sewer Exit",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(916.506, 96.285, 2111.396)
        end
     })

     local SurveilanceRoomTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Surveilance Room",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(795.251953125, 99.98998260498047, 2327.720703125)
        end
     })

     local CriminalBaseTeleportButton = LocalPlayerTab:CreateButton({
        Name = "Criminal Base",

        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-943, 95, 2055)
        end
     })

     local ServerClintTab = Window:CreateTab("Server Client")

     local ToggleDoors = ServerClintTab:CreateToggle({
        Name = "Doors",
        CurrentValue = false,

        Callback = function(Value)
            if Workspace:FindFirstChild("Doors") then
                Workspace.Doors.Parent = Lighting
                
                else
                    Lighting.Doors.Parent = Workspace
             end
        end
     })


     local ToggleFences = ServerClintTab:CreateToggle({
        Name = "Fences",
        CurrentValue = false,

        Callback = function()
            if Workspace:FindFirstChild("Prison_Fences") then
                Workspace.Prison_Fences.Parent = Lighting
                
            else
                Lighting.Prison_Fences.Parent = Workspace
             end
        end
     })

end