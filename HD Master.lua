if game.PlaceId == 155615604 then
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local Player = game.Players.LocalPlayer
    local Players = game:GetService("Players")

    Rayfield:Notify({
        Title = "Loaded HD Master",
        Content = "Welcome "..Player.Name,
    })

    local Window = Rayfield:CreateWindow({
        Name = "HD Master | Prison Life",
        LoadingTitle = " HD Master",
        LoadingSubtitle = "by Admin Master Official",
     })

     local LocalPlayerTab = Window:CreateTab("Local Player")

     local LocalPlayerLabel = LocalPlayerTab:CreateLabel("Character")

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

     local ChangeTeamabel = LocalPlayerTab:CreateLabel("Switch Teams")

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

     local CombatTab = Window:CreateTab("Combat")
     local GunsModsLabel = CombatTab:CreateLabel("Guns Mods")

     local GiveGunDropdown = CombatTab:CreateDropdown({
        Name = "Give Gun",
        Options = {"M9", "Remington 870", "AK-47"},
        CurrentOption = "M9",
        
        Callback = function(v)
            local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver[v].ITEMPICKUP
            local Event = game:GetService("Workspace").Remote.ItemHandler
            Event:InvokeServer(A_1)

        end
     })

     local GunModDropdown = CombatTab:CreateDropdown({
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

     local UtilitiesLabel = CombatTab:CreateLabel("Utilities")

     local GrabGunsButton = CombatTab:CreateButton({
        Name = "Grab Guns",

        Callback = function()
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
        end
     })

     local GrabMeleeWeaponsButton = CombatTab:CreateButton({
        Name = "Grab Melee Weapons",

        Callback = function()
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Hammer"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Crude Knife"].ITEMPICKUP)
        end
     })

    local KillingLabel = CombatTab:CreateLabel("Killing")

    spawn(function()
        while wait(.75) do
            if LoopKill_Others then
                pcall(function()
                    KillAll()
                end)
            end
        end
    end)

    function KillAll()
        local events = {}
        local gun = nil
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                if v.TeamColor.Name == game.Players.LocalPlayer.TeamColor.Name then
                    local savedcf = GetOrientation()
                    local camcf = workspace.CurrentCamera.CFrame
                    workspace.Remote.loadchar:InvokeServer(nil, BrickColor.random().Name)
                    workspace.CurrentCamera.CFrame = camcf
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
                end
                for i = 1,10 do
                    events[#events + 1] = {
                        Hit = v.Character:FindFirstChild("Head") or v.Character:FindFirstChildOfClass("Part"),
                        Cframe = CFrame.new(),
                        RayObject = Ray.new(Vector3.new(), Vector3.new()),
                        Distance = 0
                    }
                end
            end
        end
        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name ~= "Taser" and v:FindFirstChild("GunStates") then
                gun = v
            end
        end
        if gun == nil then
            for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v.Name ~= "Taser" and v:FindFirstChild("GunStates") then
                    gun = v
                end
            end
        end
        coroutine.wrap(function()
            for i = 1,30 do
                game.ReplicatedStorage.ReloadEvent:FireServer(gun)
                wait(.5)
            end
        end)()
        game.ReplicatedStorage.ShootEvent:FireServer(events, gun)
    end

    local KillAllButton = CombatTab:CreateButton({
        Name = "Kill All",

        Callback = function()
            workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Deep blue").Name)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.77,100,2379.07)
            KillAll()
			workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Bright blue").Name)
        end
     })

    local LoopkillAllToggle = CombatTab:CreateToggle({
        Name = "Loop Kill All",

        Callback = function()
           if LoopKill_Others == true then
                LoopKill_Others = false
                workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Bright blue").Name)

            else
                LoopKill_Others = true
                workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Deep blue").Name)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.77,100,2379.07)
            end
        end
     })

     local ArrestingLabel = CombatTab:CreateLabel("Arresting")

     local LoopkillAllButtonOn = CombatTab:CreateButton({
        Name = "Arrest All",

        Callback = function()
            wait(0.1)
            Player = game.Players.LocalPlayer
	        Pcf = Player.Character.HumanoidRootPart.CFrame
            for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
                if v.Name ~= Player.Name then
                    local i = 10
                    repeat
                        wait()
                        i = i-1
                        game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
                        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                    until  i == 0
                end
            end
        end
     })

     local TasingLabel = CombatTab:CreateLabel("Tasing")

     function TaserAll()
        local events = {}
        local gun = nil
        local savedteam = game.Players.LocalPlayer.TeamColor.Name
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                events[#events + 1] = {
                    Hit = v.Character:FindFirstChildOfClass("Part"),
                    Cframe = CFrame.new(),
                    RayObject = Ray.new(Vector3.new(), Vector3.new()),
                    Distance = 0
                }
            end
        end
        if not game.Players.LocalPlayer.Character:FindFirstChild("Taser") and not game.Players.LocalPlayer:FindFirstChild("Backpack"):FindFirstChild("Taser") then
            savedteam = game.Players.LocalPlayer.TeamColor.Name
            workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Bright blue").Name)
        end
            gun = game.Players.LocalPlayer.Character:FindFirstChild("Taser") or game.Players.LocalPlayer.Backpack:FindFirstChild("Taser")
            game.ReplicatedStorage.ShootEvent:FireServer(events, gun)
    end    

     local TaseAllButton = CombatTab:CreateButton({
        Name = "Tase All",

        Callback = function()
            TaserAll()
            workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Bright blue").Name)
        end
     })

     local UtilitiesTab = Window:CreateTab("Utilities")

     local ToggleDoors = UtilitiesTab:CreateToggle({
        Name = "Doors",

        Callback = function(Value)
            if Workspace:FindFirstChild("Doors") then
                Workspace.Doors.Parent = Lighting
                
                else
                    Lighting.Doors.Parent = Workspace
             end
        end
     })

     local FencesToggle = UtilitiesTab:CreateToggle({
        Name = "Fences",

        Callback = function()
            if Workspace:FindFirstChild("Prison_Fences") then
                Workspace.Prison_Fences.Parent = Lighting
                
            else
                Lighting.Prison_Fences.Parent = Workspace
             end
        end
     })

     local TeleportationTab = Window:CreateTab("Teleportation")
     
     local LocationsLabel = TeleportationTab:CreateLabel("Locations")

     local OutSidePrisonTeleportButton = TeleportationTab:CreateButton({
            Name = "Outside Prison",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(288.452, 69.999, 2206.731)
            end
        })

        local YardTeleportButton = TeleportationTab:CreateButton({
            Name = "Yard",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(779.092, 96.001, 2451.114)
            end
        })

        local TowerTeleportButton = TeleportationTab:CreateButton({
            Name = "Tower",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(822, 131, 2588)
            end
        })

        local CafeteriaTeleportButton = TeleportationTab:CreateButton({
            Name = "Cafeteria",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(930, 97.54, 2291)
            end
        })
        
        local KitchenTeleportButton = TeleportationTab:CreateButton({
            Name = "Kitchen",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(906.641845703125, 99.98993682861328, 2237.67333984375)
            end
        })

        local CellsTeleportButton = TeleportationTab:CreateButton({
            Name = "Cells",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918, 97.73, 2447)
            end
        })

        local GuardsRoomTeleportButton = TeleportationTab:CreateButton({
            Name = "Guards Room",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(836.5386352539062, 99.98998260498047, 2320.604248046875)
            end
        })

        local SewerEnteranceTeleportButton = TeleportationTab:CreateButton({
            Name = "Sewer Enterance",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.174, 76.406, 2426.199)
            end
        })

        local SewerExitTeleportButton = TeleportationTab:CreateButton({
            Name = "Sewer Exit",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(916.506, 96.285, 2111.396)
            end
        })

        local SurveilanceRoomTeleportButton = TeleportationTab:CreateButton({
            Name = "Surveilance Room",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(795.251953125, 99.98998260498047, 2327.720703125)
            end
        })

        local CriminalBaseTeleportButton = TeleportationTab:CreateButton({
            Name = "Criminal Base",

            Callback = function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-943, 95, 2055)
            end
        })

        local VisualsTab = Window:CreateTab("Visuals")
        VisualsTab:CreateLabel("ESP")

        local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/RealJasonJaco/ESP/main/ESP.lua"))()
        ESP:Toggle(true)
        ESP.Players = false
        ESP.Names = false

        local PlayerESPToggle = VisualsTab:CreateToggle({
            Name = "ESP Player",
            CurrentValue = false,

            Callback = function(Value)
                ESP.Players = Value
            end
        })

        local NameESPToggle = VisualsTab:CreateToggle({
            Name = "ESP Name",
            CurrentValue = false,

            Callback = function(Value)
                ESP.Names = Value
            end
        })

        local SettingsTab = Window:CreateTab("Settings")
        local CreditsLabel = SettingsTab:CreateLabel("Credits")

        SettingsTab:CreateLabel("Scripting - Erick Denis David#7317")
        SettingsTab:CreateLabel("UI - Alex Luthor (Main)#9684, Real_PainNonsense#9552")
        SettingsTab:CreateLabel("Coding UI - 3tggevev, Jason Jade#5061")

        SettingsTab:CreateButton({
            Name = "Join Discord Server",

            Callback = function()
                setclipboard("https://discord.gg/GpXVVeut65")
            end
        })
end
