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
endE#MKw?}nm?woJw(dUK??BcUK/(MowERED;hComU((JKKU(.Jm/MkomDMmJM/wDEnmMMJwwVDhnMMwJZUmhMnKM*om/(hwn4BmwMUwho?m(MwoU0Km?MBwwcihKMmwM/EmfMKw?Tomw9Zwh/nBoMEJ>IKo(MowEjUmhJ(woU/mD(mw(BJmE?o?msMhJM/(DAnmMMooDUhmnnMwJUUmhMnw(/wDUMhMnSMXwMUwh9?mMrwwUUKm?mBww/2mhMnjBCEm=MKh?9oKEMdwhB(moMEw>Umm(MowEWDmmM(woOwoDMmw(9JK/mDwmsMmmJMJow/wM(Jn/lhmnMDonJMKJKUKD/nUUMhwn{BmwMUwh)K%nMwJUMKm?MBwMUMUwmUEno?JB?E(?UBUEMvwK8hhm(?/oBEU((ohE+DmmMhomJ(MoB/JDwn*(UoU/JMmJM/wD#nmMMJw/5hmn(MMJ)UmhMUmDJnEBKhJn?BmwMUw/BUUhm(BBJwhUhKK?EBUK(?mBWEmiMUoAUmD?EBwEUDDKEEJWBmm(MowBKJKwcKJmK((oBmB(Uo?/MDwmFK/mU(/Jw;/DUmo(Eo%Dnhmn(MMwmnJMnwmUMhwDEDUn?MowJU?hmMJBKw(UBBJwB}mKM?wmd?Mo(wKPJKh?n+JKo(moMEwoKEnDmK((moUm((hop/mDMUBcwmn(?J(/wmKmJ(UJDnK(EJw/:hm3wDEnEBKJw<whm?K(Uw(//BKJUUwhV?mnn?mBUwhY(KBnwBUw??JBBEm%MKwh/hU?wB)EJUaKnEwMKn(wK)w/Bm/BMK/oUEcDMmw(2mEM(oU/JMKJh/wD_nmKnmw(/JUU(hMJU/JhMnwMO(EMKJ/<EDI?(MMwJUDB(wmU*Km?Mn??(BhEKDoKUn)oKKo?UnMEMpwK7?hEDEwpUmm?howE_DmhM(BoW/KDMmJ(toJ/MNomnMmJn/wDDnmMMJw/.dEnMMJJRUDhMnoM+om/hhwnUBmw(UwD/?m(MJUUkKK?MBJw1UoKMmwMmEm!(Kw?UomwJ8wKHhJoMEBxWmm(MowE4DmMB(woU/mDnmw(/Jm/hnom_MKJMEnDrnKMMJw/vDfn?MwJ0UmDDnwMUwm/?JUn7BKwMUohb?mBMJo(UKm??BwJoimKM?w(bwBVMKo?4ohEM4KKk?hBhEw0wmm?BowEODmmM((og/hDMmM(XJh/MUwKnMmJ?/wD/nm(?Jww hhnMMoJHUhhMnhMOwmU(hwn/Bmw?Uwh}?m(MKMUpKh?MBow+/wKM?whhEme(Kw?/omE?fwh/EMoMEJ25Km(MowE&V>m?(wo9/m/omw(UJmE?oUmqMKJME?DRnmMMBwhBhmn(MwJUUmDUnw(/oEUMhBnQMnwMUwh1?mMmwwUUKm?nBww/AmDMnwB_EK)MKJ?pBhEM/wKw(mo(Ew!Umm?nowJ1:UmM(Joj/KDMKU(kJmEDDwmEMmJM/wDlnmMMUE/chKnMMBJTUhhMn?hDwmU(hwKEBmw(UwhU?mBmwoUkKm?M(BwYbKKM?MB/EmRMKwmhomE(Gwh/=(oMEJ<ymh(MowEFbhw((wo//mlhmw(0JmwM:nm1MhJM/oDZmJMMooEwhmnmMwJDUmhMnwMLwhUMhonIMPwMUoh<mmMKwwU/Km??BwJ/SmDMm-B;Eh#MKo?TBDEM}wKE(mo?Ew+/mm(MowJ*(YmM(oo#/hDMKm(,Jm?oDwmUMmJ?/wD/nm(?DY/>hKnM(wJ>UmhMmohKwmU(hwmLBmwMUw=ogkBMwJUW/B?MBJwHUMKM?MB/EmsMKwhnomE(Pwh/i(oMEJQtKm(MowEG)hok(wo//mD(mw(NJmwMxEmbMhJM/oD&mwMMowE?hmn(MwJnUmh?nw(/JoUMhJn!MmwMUwhdnhM)wwU/Km?(BwwXgmDMmFB,EhSMKo?_BwEMUwKE(mo(Ew:hmm(?oww/o(mM(JoQEmDMmw(dohBDDwm/MmJ(/wDXnm?Mon/.hhnMMoJs/whMmw(KwmU(hwmUBmw?UwD/n/BMwJU6hm?MBwwbEmK(?wBUEm/UKwnJomw?UUKi(KoMwwagmm(M(wEhDmm((wBB/mDDmw?/m(/MDJm3(mJM/wD;mhKDJw//hmn(MwJFUm4MnMMSwhUMhonLMwwM/wh/?mB(wwUJKm??BwJ/UBKM?JB_wm#MKw?4(mEhTwKU(mBmEweEmm??oKE7DKmM?woT/mDMDw?JJm/(DwmoMmoK/wr//(MMJJ/%DmnMMwJGwmE(nwMUwmUmhwm?BmwMJ?h7?mBMwJU#Km?MBJwONmKM?w");local n=0;s.KkkmIFDX(function()s.POSsAlWr()n=n+1 end)local function e(e,m)if m then return n end;n=e+n;end local m,n,r=t(0,t,e,a,s.CEmZaluR);local function d()local m,n=s.CEmZaluR(a,e(1,3),e(5,6)+2);e(2);return(n*256)+m;end;local c=true;local c=0 local function p()local h=n();local e=n();local o=1;local h=(m(e,1,20)*(2^32))+h;local n=m(e,21,31);local e=((-1)^m(e,32));if(n==0)then if(h==c)then return e*0;else n=1;o=0;end;elseif(n==2047)then return(h==0)and(e*(1/0))or(e*(0/0));end;return s.djBAlRvv(e,n-1023)*(o+(h/(2^52)));end;local _=n;local function u(n)local m;if(not n)then n=_();if(n==0)then return'';end;end;m=s.eUhJpDbJ(a,e(1,3),e(5,6)+n-1);e(n)local e=""for n=(1+c),#m do e=e..s.eUhJpDbJ(m,n,n)end return e;end;local _=#s.BhrKyswc(b('\49.\48'))~=1 local e=n;local function oe(...)return{...},s.FCctwXyh('#',...)end local function ne()local b={};local e={};local a={};local c={a,b,nil,e};local e=n()local f={}for h=1,e do local m=r();local n;if(m==2)then n=(r()~=#{});elseif(m==0)then local e=p();if _ and s.kawdLawA(s.BhrKyswc(e),'.(\48+)$')then e=s.SvvkpkEx(e);end n=e;elseif(m==1)then n=u();end;f[h]=n;end;for s=1,n()do local e=r();if(m(e,1,1)==0)then local t=m(e,2,3);local r=m(e,4,6);local e={d(),d(),nil,nil};if(t==0)then e[o]=d();e[l]=d();elseif(t==#{1})then e[o]=n();elseif(t==k[2])then e[o]=n()-(2^16)elseif(t==k[3])then e[o]=n()-(2^16)e[l]=d();end;if(m(r,1,1)==1)then e[h]=f[e[h]]end if(m(r,2,2)==1)then e[o]=f[e[o]]end if(m(r,3,3)==1)then e[l]=f[e[l]]end a[s]=e;end end;c[3]=r();for e=1,n()do b[e-(#{1})]=ne();end;return c;end;local function me(m,e,n)local h=e;local h=n;return b(s.kawdLawA(s.kawdLawA(({s.KkkmIFDX(m)})[2],e),n))end local function p(ee,c,r)local function ne(...)local d,u,_,ne,b,n,a,j,y,g,k,m;local e=0;while-1<e do if e>=3 then if 5<=e then if 2~=e then repeat if e~=6 then m=t(7);break;end;e=-2;until true;else m=t(7);end else if 1~=e then for n=34,81 do if 4>e then j={};y={...};break;end;g=s.FCctwXyh('#',...)-1;k={};break;end;else j={};y={...};end end else if 0>=e then d=t(6,43,1,17,ee);u=t(6,82,2,27,ee);else if-3~=e then repeat if e<2 then _=t(6,88,3,43,ee);b=oe ne=0;break;end;n=-41;a=-1;until true;else n=-41;a=-1;end end end e=e+1;end;for e=0,g do if(e>=_)then j[e-_]=y[e+1];else m[e]=y[e+1];end;end;local e=g-_+1 local e;local t;local function _(...)while true do end end while true do if n<-40 then n=n+42 end e=d[n];t=e[z];if t<110 then if t>=55 then if 82>t then if t<68 then if t<61 then if t<=57 then if 55<t then if t<57 then local f,a;for t=0,6 do if t>2 then if 5<=t then if t>=4 then repeat if 5~=t then m[e[h]]=m[e[o]][e[l]];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];end else if-1~=t then repeat if t~=3 then for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];break;end;f=e[h];a=m[e[o]];m[f+1]=a;m[f]=a[e[l]];n=n+1;e=d[n];until true;else for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];end end else if t<1 then m[e[h]]=r[e[o]];n=n+1;e=d[n];else if t~=2 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end end end else for t=0,6 do if t>=3 then if 4<t then if 3<=t then repeat if 5~=t then m[e[h]]=m[e[o]][e[l]];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];end else if 4~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if 1<=t then if t>-1 then for f=38,59 do if 1~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end end end else local a,f;for t=0,6 do if t>2 then if t<=4 then if t~=1 then for r=28,74 do if t~=4 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;a=e[h];f=m[e[o]];m[a+1]=f;m[a]=f[e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if t~=4 then for l=11,69 do if 5<t then m[e[h]]=r[e[o]];break;end;for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];break;end;else for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];end end else if t>=1 then if t>-3 then for f=28,66 do if 2>t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else r[e[o]]=m[e[h]];n=n+1;e=d[n];end end end end else if t>58 then if t~=57 then repeat if 60>t then m[e[h]]=m[e[o]]-e[l];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;until true;else m[e[h]]=m[e[o]]-e[l];end else local a,s;for t=0,6 do if 3<=t then if t<=4 then if t~=3 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if 6>t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else a=e[h];s=m[e[o]];m[a+1]=s;m[a]=s[e[l]];end end else if t<=0 then a=e[h]m[a](f(m,a+1,e[o]))n=n+1;e=d[n];else if-2<=t then repeat if t~=1 then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end end end end end else if t>63 then if t>=66 then if 62<=t then repeat if 67~=t then r[e[o]]=m[e[h]];break;end;local e=e[h]m[e]=m[e]()until true;else r[e[o]]=m[e[h]];end else if 60<=t then for f=29,61 do if 64~=t then for t=0,6 do if t<3 then if 1<=t then if t~=-3 then for f=48,59 do if 1~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else m[e[h]]=r[e[o]];n=n+1;e=d[n];end else if t>=5 then if 1~=t then repeat if t~=6 then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];until true;else m[e[h]]=m[e[o]][e[l]];end else if t~=-1 then repeat if 3<t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end end end break;end;local f,t;for a=0,3 do if 1<a then if a>1 then for t=24,93 do if a>2 then m[e[h]][e[o]]=e[l];break;end;m[e[h]]={};n=n+1;e=d[n];break;end;else m[e[h]][e[o]]=e[l];end else if a>=-3 then repeat if a<1 then r[e[o]]=m[e[h]];n=n+1;e=d[n];break;end;f=e[h];t=m[e[o]];m[f+1]=t;m[f]=t[e[l]];n=n+1;e=d[n];until true;else f=e[h];t=m[e[o]];m[f+1]=t;m[f]=t[e[l]];n=n+1;e=d[n];end end end break;end;else local t,f;for a=0,3 do if 1<a then if a>1 then for t=24,93 do if a>2 then m[e[h]][e[o]]=e[l];break;end;m[e[h]]={};n=n+1;e=d[n];break;end;else m[e[h]][e[o]]=e[l];end else if a>=-3 then repeat if a<1 then r[e[o]]=m[e[h]];n=n+1;e=d[n];break;end;t=e[h];f=m[e[o]];m[t+1]=f;m[t]=f[e[l]];n=n+1;e=d[n];until true;else t=e[h];f=m[e[o]];m[t+1]=f;m[t]=f[e[l]];n=n+1;e=d[n];end end end end end else if 62>t then local t,r;for a=0,6 do if a<3 then if a>0 then if-2<=a then repeat if a~=1 then t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m(e[h],e[o]);n=n+1;e=d[n];until true;else m(e[h],e[o]);n=n+1;e=d[n];end else t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];end else if a<5 then if 1<=a then repeat if 3<a then m(e[h],e[o]);n=n+1;e=d[n];break;end;t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];until true;else t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];end else if a~=5 then t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];else t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end end end end else if t==62 then for t=0,1 do if t~=0 then if(m[e[h]]==e[l])then n=n+1;else n=e[o];end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else local t;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];end end end end else if t<75 then if 71<=t then if 73<=t then if 74~=t then m[e[h]]=m[e[o]];else local t,r;m[e[h]]=m[e[o]]+e[l];n=n+1;e=d[n];m[e[h]]={};n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];if not m[e[h]]then n=n+1;else n=e[o];end;end else if 72==t then local n=e[h];local h=m[n];for e=n+1,e[o]do s.MBLdlHVz(h,m[e])end;else m[e[h]]=m[e[o]]+e[l];end end else if t>68 then if t>67 then for n=23,78 do if 70>t then m[e[h]]=m[e[o]]+e[l];break;end;do return end;break;end;else m[e[h]]=m[e[o]]+e[l];end else m[e[h]]={};end end else if t<78 then if t>75 then if 72<=t then for r=36,60 do if 77>t then local t,a;for r=0,4 do if r<2 then if-3~=r then repeat if r~=0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];until true;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else if r>2 then if r~=2 then repeat if 4>r then m[e[h]]={};n=n+1;e=d[n];break;end;m[e[h]][e[o]]=e[l];until true;else m[e[h]][e[o]]=e[l];end else t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];end end end break;end;local r,b,a,k,c,s,u,t;m[e[h]][e[o]]=e[l];n=n+1;e=d[n];r=e[h]m[r]=m[r](f(m,r+1,e[o]))n=n+1;e=d[n];r=e[h];b=m[e[o]];m[r+1]=b;m[r]=b[e[l]];n=n+1;e=d[n];t=0;while t>-1 do if 3<=t then if t>4 then if t==6 then t=-2;else m(u,s);end else if 4~=t then s=a[c];else u=a[k];end end else if t<1 then a=e;else if 1~=t then c=o;else k=h;end end end t=t+1 end n=n+1;e=d[n];r=e[h]m[r]=m[r](f(m,r+1,e[o]))n=n+1;e=d[n];r=e[h];b=m[e[o]];m[r+1]=b;m[r]=b[e[l]];n=n+1;e=d[n];t=0;while t>-1 do if t>=3 then if t>4 then if t~=4 then for e=25,95 do if t<6 then m(u,s);break;end;t=-2;break;end;else m(u,s);end else if 0~=t then for e=32,85 do if 4~=t then s=a[c];break;end;u=a[k];break;end;else s=a[c];end end else if 0>=t then a=e;else if-3<t then for e=17,85 do if t<2 then k=h;break;end;c=o;break;end;else k=h;end end end t=t+1 end break;end;else local t,a;for r=0,4 do if r<2 then if-3~=r then repeat if r~=0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];until true;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else if r>2 then if r~=2 then repeat if 4>r then m[e[h]]={};n=n+1;e=d[n];break;end;m[e[h]][e[o]]=e[l];until true;else m[e[h]][e[o]]=e[l];end else t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];end end end end else local t;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];do return end;end else if 80<=t then if t>=77 then repeat if t<81 then local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;break;end;m[e[h]][e[o]]=e[l];until true;else m[e[h]][e[o]]=e[l];end else if 75<=t then for r=12,58 do if t>78 then local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;break;end;m[e[h]][m[e[o]]]=m[e[l]];break;end;else local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;end end end end end else if t<=95 then if t>88 then if 92<=t then if 93<t then if 95>t then local e=e[h]m[e]=m[e](f(m,e+1,a))else if(m[e[h]]~=e[l])then n=n+1;else n=e[o];end;end else if t>88 then repeat if 92~=t then m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];end end else if t<=89 then local t,r;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];r=m[e[l]];if not r then n=n+1;else m[e[h]]=r;n=e[o];end;else if t<91 then local a,c,u,k,b,t,s;for t=0,6 do if 2>=t then if 0>=t then for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];else if t>-1 then for f=41,63 do if 2>t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if t<=4 then if 0~=t then for l=23,91 do if 4>t then t=0;while t>-1 do if t<3 then if t<=0 then a=e;else if t==2 then u=o;else c=h;end end else if 4<t then if t>1 then for e=31,74 do if 6>t then m(b,k);break;end;t=-2;break;end;else t=-2;end else if 2<=t then repeat if 4~=t then k=a[u];break;end;b=a[c];until true;else b=a[c];end end end t=t+1 end n=n+1;e=d[n];break;end;s=e[h]m[s]=m[s](m[s+1])n=n+1;e=d[n];break;end;else t=0;while t>-1 do if t<3 then if t<=0 then a=e;else if t==2 then u=o;else c=h;end end else if 4<t then if t>1 then for e=31,74 do if 6>t then m(b,k);break;end;t=-2;break;end;else t=-2;end else if 2<=t then repeat if 4~=t then k=a[u];break;end;b=a[c];until true;else b=a[c];end end end t=t+1 end n=n+1;e=d[n];end else if 2<t then for r=28,97 do if t<6 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;s=e[h]m[s](f(m,s+1,e[o]))break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end end end else for t=0,1 do if 0~=t then m[e[h]][e[o]]=e[l];else m[e[h]][e[o]]=e[l];n=n+1;e=d[n];end end end end end else if t<=84 then if 83<=t then if t>83 then if(m[e[h]]~=e[l])then n=n+1;else n=e[o];end;else local f;for t=0,6 do if t>2 then if 5<=t then if t>2 then repeat if t~=5 then m[e[h]]=m[e[o]][e[l]];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if t>=1 then repeat if 3~=t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end else if 0>=t then f=e[h]m[f]=m[f]()n=n+1;e=d[n];else if t>=-2 then repeat if t>1 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end end end end else if(m[e[h]]~=m[e[l]])then n=n+1;else n=e[o];end;end else if t<=86 then if t>82 then for a=36,77 do if t~=85 then local t;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](m[t+1])n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];do return end;break;end;local t,a;for f=0,6 do if f>2 then if 5<=f then if 1~=f then for r=19,57 do if f>5 then m[e[h]]=m[e[o]];break;end;t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];break;end;else t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];end else if 1<=f then for t=12,90 do if f~=3 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if 1>f then t=e[h]m[t]=m[t](m[t+1])n=n+1;e=d[n];else if-3~=f then repeat if 1<f then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]();n=n+1;e=d[n];until true;else m[e[h]]();n=n+1;e=d[n];end end end end break;end;else local t;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](m[t+1])n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];do return end;end else if 88~=t then m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]][e[o]]=e[l];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]][e[o]]=e[l];else local a,b,r,t,f,s,d;local n=0;while n>-1 do if 2<n then if n>4 then if n>2 then for e=21,95 do if n~=5 then n=-2;break;end;m[s]=d;break;end;else n=-2;end else if n>=1 then for e=44,53 do if n~=4 then s=t[a];break;end;d=m[f];for e=1+f,t[r]do d=d..m[e];end;break;end;else d=m[f];for e=1+f,t[r]do d=d..m[e];end;end end else if n<=0 then a=h;b=o;r=l;else if 2==n then f=t[b];else t=e;end end end n=n+1 end end end end end else if 102>=t then if t>=99 then if 101<=t then if 101==t then local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;else for t=0,1 do if t~=-4 then repeat if t>0 then m[e[h]][e[o]]=e[l];break;end;m[e[h]][e[o]]=e[l];n=n+1;e=d[n];until true;else m[e[h]][e[o]]=e[l];end end end else if t>96 then for a=24,97 do if 99<t then local t,s;for a=0,5 do if 2<a then if 3<a then if 3<=a then for l=17,80 do if a~=5 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];break;end;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else m(e[h],e[o]);n=n+1;e=d[n];end else if 0>=a then m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];else if 0<=a then for r=18,74 do if a~=2 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];break;end;else t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];end end end end break;end;local t,a;for r=0,4 do if 1>=r then if-2<r then repeat if 0~=r then t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m(e[h],e[o]);n=n+1;e=d[n];until true;else m(e[h],e[o]);n=n+1;e=d[n];end else if r>2 then if 3<r then m[e[h]][e[o]]=e[l];else m[e[h]]={};n=n+1;e=d[n];end else t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];end end end break;end;else local t,s;for a=0,5 do if 2<a then if 3<a then if 3<=a then for l=17,80 do if a~=5 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];break;end;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else m(e[h],e[o]);n=n+1;e=d[n];end else if 0>=a then m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];else if 0<=a then for r=18,74 do if a~=2 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];break;end;else t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];end end end end end end else if 97>t then m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];else if 96<t then for r=26,60 do if t~=98 then local f,r;for t=0,6 do if 3>t then if t<1 then f=e[h];r=m[e[o]];m[f+1]=r;m[f]=r[e[l]];n=n+1;e=d[n];else if 1~=t then m[e[h]][e[o]]=e[l];n=n+1;e=d[n];else m[e[h]]={};n=n+1;e=d[n];end end else if t>=5 then if 3<t then repeat if 6~=t then m(e[h],e[o]);n=n+1;e=d[n];break;end;m(e[h],e[o]);until true;else m(e[h],e[o]);end else if t>=2 then repeat if t~=4 then m[e[h]]={};n=n+1;e=d[n];break;end;m(e[h],e[o]);n=n+1;e=d[n];until true;else m(e[h],e[o]);n=n+1;e=d[n];end end end end break;end;local r,s,a,k,b,p,u,t;for t=0,4 do if 2>t then if-4~=t then repeat if 0~=t then r=e[h];s=m[e[o]];m[r+1]=s;m[r]=s[e[l]];n=n+1;e=d[n];break;end;m[e[h]]=c[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=c[e[o]];n=n+1;e=d[n];end else if t<3 then t=0;while t>-1 do if t>=3 then if 4>=t then if t==4 then u=a[k];else p=a[b];end else if t>5 then t=-2;else m(u,p);end end else if t>=1 then if-2~=t then repeat if t>1 then b=o;break;end;k=h;until true;else b=o;end else a=e;end end t=t+1 end n=n+1;e=d[n];else if-1<t then for l=12,78 do if t~=4 then r=e[h]m[r]=m[r](f(m,r+1,e[o]))n=n+1;e=d[n];break;end;if not m[e[h]]then n=n+1;else n=e[o];end;break;end;else if not m[e[h]]then n=n+1;else n=e[o];end;end end end end break;end;else local r,f;for t=0,6 do if 3>t then if t<1 then r=e[h];f=m[e[o]];m[r+1]=f;m[r]=f[e[l]];n=n+1;e=d[n];else if 1~=t then m[e[h]][e[o]]=e[l];n=n+1;e=d[n];else m[e[h]]={};n=n+1;e=d[n];end end else if t>=5 then if 3<t then repeat if 6~=t then m(e[h],e[o]);n=n+1;e=d[n];break;end;m(e[h],e[o]);until true;else m(e[h],e[o]);end else if t>=2 then repeat if t~=4 then m[e[h]]={};n=n+1;e=d[n];break;end;m(e[h],e[o]);n=n+1;e=d[n];until true;else m(e[h],e[o]);n=n+1;e=d[n];end end end end end end end else if 105>=t then if t>=104 then if t~=102 then repeat if 105>t then local f,t,r,a,b,l,c,k;for l=0,4 do if l<=1 then if l>-4 then for s=31,55 do if 1~=l then m[e[h]]={};n=n+1;e=d[n];break;end;l=0;while l>-1 do if l<3 then if 0<l then if l>-1 then for e=47,52 do if 2>l then t=h;break;end;r=o;break;end;else t=h;end else f=e;end else if l<=4 then if 3~=l then b=f[t];else a=f[r];end else if l>2 then for e=10,78 do if l>5 then l=-2;break;end;m(b,a);break;end;else l=-2;end end end l=l+1 end n=n+1;e=d[n];break;end;else l=0;while l>-1 do if l<3 then if 0<l then if l>-1 then for e=47,52 do if 2>l then t=h;break;end;r=o;break;end;else t=h;end else f=e;end else if l<=4 then if 3~=l then b=f[t];else a=f[r];end else if l>2 then for e=10,78 do if l>5 then l=-2;break;end;m(b,a);break;end;else l=-2;end end end l=l+1 end n=n+1;e=d[n];end else if l<=2 then m(e[h],e[o]);n=n+1;e=d[n];else if l~=3 then c=e[h];k=m[c];for e=c+1,e[o]do s.MBLdlHVz(k,m[e])end;else m(e[h],e[o]);n=n+1;e=d[n];end end end end break;end;local t,r;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];do return end;until true;else local f,t,b,a,r,l,c,k;for l=0,4 do if l<=1 then if l>-4 then for s=31,55 do if 1~=l then m[e[h]]={};n=n+1;e=d[n];break;end;l=0;while l>-1 do if l<3 then if 0<l then if l>-1 then for e=47,52 do if 2>l then t=h;break;end;b=o;break;end;else t=h;end else f=e;end else if l<=4 then if 3~=l then r=f[t];else a=f[b];end else if l>2 then for e=10,78 do if l>5 then l=-2;break;end;m(r,a);break;end;else l=-2;end end end l=l+1 end n=n+1;e=d[n];break;end;else l=0;while l>-1 do if l<3 then if 0<l then if l>-1 then for e=47,52 do if 2>l then t=h;break;end;b=o;break;end;else t=h;end else f=e;end else if l<=4 then if 3~=l then r=f[t];else a=f[b];end else if l>2 then for e=10,78 do if l>5 then l=-2;break;end;m(r,a);break;end;else l=-2;end end end l=l+1 end n=n+1;e=d[n];end else if l<=2 then m(e[h],e[o]);n=n+1;e=d[n];else if l~=3 then c=e[h];k=m[c];for e=c+1,e[o]do s.MBLdlHVz(k,m[e])end;else m(e[h],e[o]);n=n+1;e=d[n];end end end end end else local d=m[e[l]];if not d then n=n+1;else m[e[h]]=d;n=e[o];end;end else if 107<t then if t==109 then m[e[h]]=r[e[o]];else local n=e[h]m[n]=m[n](f(m,n+1,e[o]))end else if t~=107 then local n=e[h]m[n](f(m,n+1,e[o]))else local t,a;for r=0,4 do if 2>r then if r~=-3 then for a=19,69 do if r~=0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];break;end;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else if 2>=r then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r<4 then m[e[h]]={};n=n+1;e=d[n];else m[e[h]][e[o]]=e[l];end end end end end end end end end end else if t>26 then if 41<=t then if t<=47 then if 43<t then if 46<=t then if t~=46 then local n=e[h];local h=m[e[o]];m[n+1]=h;m[n]=h[e[l]];else local t;for a=0,6 do if a>=3 then if a<5 then if a>3 then m[e[h]]=r[e[o]];n=n+1;e=d[n];else t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else if 1<=a then repeat if 6>a then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if a<=0 then m(e[h],e[o]);n=n+1;e=d[n];else if 1~=a then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else t=e[h]m[t]=m[t](m[t+1])n=n+1;e=d[n];end end end end end else if t==44 then for t=0,6 do if 2<t then if t<5 then if t>0 then for f=33,58 do if 3~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if t~=5 then m[e[h]][e[o]]=m[e[l]];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if 0<t then if 0<t then repeat if 1~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end end end else local t,r;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m[e[h]]={};end end else if t<=41 then if(m[e[h]]==e[l])then n=n+1;else n=e[o];end;else if t~=42 then local t;for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t]=m[t]()n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]]=r[e[o]];else local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;end end end else if 51<=t then if t>=53 then if 52~=t then for f=46,64 do if 54~=t then local a,f;for t=0,6 do if 3<=t then if 5<=t then if t>2 then for l=23,66 do if t>5 then m[e[h]]=r[e[o]];break;end;for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];break;end;else for e=e[h],e[o]do m[e]=nil;end;n=n+1;e=d[n];end else if 2<t then for r=25,69 do if 3~=t then a=e[h];f=m[e[o]];m[a+1]=f;m[a]=f[e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if 1<=t then if 0<t then for f=31,68 do if t~=1 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else r[e[o]]=m[e[h]];n=n+1;e=d[n];end end end break;end;m[e[h]]=m[e[o]][e[l]];break;end;else m[e[h]]=m[e[o]][e[l]];end else if t~=47 then repeat if t~=51 then local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;break;end;local e=e[h]local h,n=b(m[e]())a=n+e-1 local n=0;for e=e,a do n=n+1;m[e]=h[n];end;until true;else local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;end end else if 49>t then local t,a;for r=0,4 do if 1<r then if r<3 then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r==4 then m[e[h]][e[o]]=e[l];else m[e[h]]={};n=n+1;e=d[n];end end else if r>=-4 then repeat if 0~=r then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];until true;else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end end end else if t~=48 then for s=44,52 do if 50~=t then local e=e[h]local h,n=b(m[e](m[e+1]))a=n+e-1 local n=0;for e=e,a do n=n+1;m[e]=h[n];end;break;end;local a;for t=0,6 do if 3<=t then if 5>t then if 2~=t then repeat if t>3 then m(e[h],e[o]);n=n+1;e=d[n];break;end;m(e[h],e[o]);n=n+1;e=d[n];until true;else m(e[h],e[o]);n=n+1;e=d[n];end else if 5~=t then a=e[h]m[a]=m[a](f(m,a+1,e[o]))else m(e[h],e[o]);n=n+1;e=d[n];end end else if t<=0 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else if-2~=t then repeat if 2>t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end end end break;end;else local e=e[h]local h,n=b(m[e](m[e+1]))a=n+e-1 local n=0;for e=e,a do n=n+1;m[e]=h[n];end;end end end end else if 33<t then if t<37 then if 34<t then if 32~=t then for a=47,84 do if t~=36 then local t;t=e[h]m[t]=m[t](m[t+1])n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];break;end;m[e[h]][e[o]]=m[e[l]];break;end;else m[e[h]][e[o]]=m[e[l]];end else local f;for t=0,7 do if 4>t then if t<=1 then if-1<=t then repeat if t>0 then m(e[h],e[o]);n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m(e[h],e[o]);n=n+1;e=d[n];end else if t>0 then repeat if 2<t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;f=e[h]m[f](m[f+1])n=n+1;e=d[n];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end else if t<=5 then if 3~=t then repeat if 5~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if t>6 then m[e[h]]=c[e[o]];else c[e[o]]=m[e[h]];n=n+1;e=d[n];end end end end end else if t>38 then if t>36 then repeat if t~=39 then local e=e[h]m[e](m[e+1])break;end;local t,a;for r=0,4 do if 1>=r then if-2<r then repeat if r~=0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];until true;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else if 2>=r then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r~=-1 then for t=33,86 do if 3<r then m[e[h]][e[o]]=e[l];break;end;m[e[h]]={};n=n+1;e=d[n];break;end;else m[e[h]][e[o]]=e[l];end end end end until true;else local t,a;for r=0,4 do if 1>=r then if-2<r then repeat if r~=0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];until true;else t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else if 2>=r then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r~=-1 then for t=33,86 do if 3<r then m[e[h]][e[o]]=e[l];break;end;m[e[h]]={};n=n+1;e=d[n];break;end;else m[e[h]][e[o]]=e[l];end end end end end else if t>=34 then repeat if 37~=t then if(m[e[h]]==m[e[l]])then n=n+1;else n=e[o];end;break;end;local t,a;m[e[h]]=r[e[o]];n=n+1;e=d[n];t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];until true;else local t,a;m[e[h]]=r[e[o]];n=n+1;e=d[n];t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];end end end else if 29<t then if 32<=t then if 33==t then m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];else m[e[h]]=m[e[o]]-e[l];end else if t~=30 then local t,r;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m(e[h],e[o]);else m[e[h]]={};end end else if t<28 then local t,k,s,u,r,c;for s=0,4 do if 1<s then if 3<=s then if 0<s then repeat if 4~=s then t=e[h]c={m[t](f(m,t+1,a))};r=0;for e=t,e[l]do r=r+1;m[e]=c[r];end n=n+1;e=d[n];break;end;n=e[o];until true;else n=e[o];end else t=e[h]c,u=b(m[t](m[t+1]))a=u+t-1 r=0;for e=t,a do r=r+1;m[e]=c[r];end;n=n+1;e=d[n];end else if s>-4 then repeat if 0<s then t=e[h];k=m[e[o]];m[t+1]=k;m[t]=k[e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end end else if t~=26 then repeat if 29~=t then for e=e[h],e[o]do m[e]=nil;end;break;end;local e=e[h]m[e]=m[e](m[e+1])until true;else for e=e[h],e[o]do m[e]=nil;end;end end end end end else if t<=12 then if 6>t then if 2>=t then if 1>t then local h=e[h]local o={m[h](f(m,h+1,a))};local n=0;for e=h,e[l]do n=n+1;m[e]=o[n];end else if-1~=t then for r=13,75 do if 1~=t then n=e[o];break;end;local t,a;for r=0,4 do if r>1 then if r<3 then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r==3 then m[e[h]]={};n=n+1;e=d[n];else m[e[h]][e[o]]=e[l];end end else if r~=-2 then for a=30,90 do if r>0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];break;end;else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end end end break;end;else local t,a;for r=0,4 do if r>1 then if r<3 then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r==3 then m[e[h]]={};n=n+1;e=d[n];else m[e[h]][e[o]]=e[l];end end else if r~=-2 then for a=30,90 do if r>0 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];break;end;else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end end end end end else if 4<=t then if 4<t then local a,b,s,d,r,f,t;local n=0;while n>-1 do if 3<=n then if n>4 then if n<6 then m[f]=t;else n=-2;end else if 1<n then repeat if n>3 then t=m[r];for e=1+r,d[s]do t=t..m[e];end;break;end;f=d[a];until true;else f=d[a];end end else if n>0 then if 1~=n then r=d[b];else d=e;end else a=h;b=o;s=l;end end n=n+1 end else local t;m(e[h],e[o]);n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];do return end;end else local d=m[e[l]];if not d then n=n+1;else m[e[h]]=d;n=e[o];end;end end else if 8<t then if t>=11 then if 12==t then local t,r;m[e[h]]=c[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];do return end;else m[e[h]]();end else if t>9 then local t,s;for a=0,6 do if 2<a then if 4>=a then if 0<a then for l=17,73 do if 3~=a then t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]]=c[e[o]];n=n+1;e=d[n];break;end;else m[e[h]]=c[e[o]];n=n+1;e=d[n];end else if a<6 then m[e[h]]=r[e[o]];n=n+1;e=d[n];else m(e[h],e[o]);end end else if a<=0 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else if a>=-3 then repeat if 2~=a then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];until true;else t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];end end end end else local d=e[h];local o={};for e=1,#k do local e=k[e];for n=0,#e do local n=e[n];local h=n[1];local e=n[2];if h==m and e>=d then o[e]=h[e];n[1]=o;end;end;end;end end else if 6<t then if 6<t then for a=47,88 do if t<8 then local a,f;for t=0,6 do if t<=2 then if t>0 then if-1~=t then repeat if 2~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;a=e[h];f=m[e[o]];m[a+1]=f;m[a]=f[e[l]];n=n+1;e=d[n];until true;else a=e[h];f=m[e[o]];m[a+1]=f;m[a]=f[e[l]];n=n+1;e=d[n];end else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if 4>=t then if 0<=t then for f=26,62 do if 3<t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if t>4 then for f=26,56 do if t~=6 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];break;end;else m[e[h]]=m[e[o]][e[l]];end end end end break;end;local t,a;for r=0,4 do if 1>=r then if r~=-2 then repeat if r<1 then m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];break;end;t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];until true;else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end else if 2>=r then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r~=3 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))else m(e[h],e[o]);n=n+1;e=d[n];end end end end break;end;else local t,a;for r=0,4 do if 1>=r then if r~=-2 then repeat if r<1 then m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];break;end;t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];until true;else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end else if 2>=r then t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];else if r~=3 then t=e[h]m[t]=m[t](f(m,t+1,e[o]))else m(e[h],e[o]);n=n+1;e=d[n];end end end end end else m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];end end end else if t>19 then if 22<t then if 24<t then if 25~=t then m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]][e[o]]=e[l];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]][e[o]]=e[l];else m[e[h]]=c[e[o]];end else if t>20 then for r=23,55 do if 24~=t then local t,r;for a=0,6 do if a<=2 then if 1<=a then if a>-1 then for s=10,74 do if a~=1 then t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];break;end;t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;else t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];end else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end else if a<=4 then if a~=-1 then for l=13,86 do if 3~=a then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m(e[h],e[o]);n=n+1;e=d[n];break;end;else m(e[h],e[o]);n=n+1;e=d[n];end else if 1<a then for f=35,71 do if a~=6 then t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];break;end;m(e[h],e[o]);break;end;else t=e[h];r=m[e[o]];m[t+1]=r;m[t]=r[e[l]];n=n+1;e=d[n];end end end end break;end;local t,a,r;m(e[h],e[o]);n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[o];a=m[t]for e=t+1,e[l]do a=a..m[e];end;m[e[h]]=a;n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];r=e[h]m[r](f(m,r+1,e[o]))n=n+1;e=d[n];r=e[h];t=m[e[o]];m[r+1]=t;m[r]=t[e[l]];n=n+1;e=d[n];m[e[h]]={};break;end;else local t,a,r;m(e[h],e[o]);n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[o];a=m[t]for e=t+1,e[l]do a=a..m[e];end;m[e[h]]=a;n=n+1;e=d[n];m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];r=e[h]m[r](f(m,r+1,e[o]))n=n+1;e=d[n];r=e[h];t=m[e[o]];m[r+1]=t;m[r]=t[e[l]];n=n+1;e=d[n];m[e[h]]={};end end else if t<21 then local f,t,r,s,a,u,b,c,k;local d=0;while d>-1 do if d>2 then if 4>=d then if 1<=d then for e=48,58 do if 3~=d then k=b==c and t[u]or 1+r;break;end;b=f[s];c=f[a];break;end;else b=f[s];c=f[a];end else if 2<=d then repeat if 5<d then d=-2;break;end;n=k;until true;else n=k;end end else if d<=0 then f=m;else if-2<d then for m=28,60 do if d~=1 then s=t[h];a=t[l];u=o;break;end;t=e;r=n;break;end;else t=e;r=n;end end end d=d+1 end else if 22==t then local t,s;for a=0,6 do if 3>a then if 0<a then if 0<=a then repeat if 1~=a then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];until true;else t=e[h]m[t](f(m,t+1,e[o]))n=n+1;e=d[n];end else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if a<5 then if a>=1 then for t=40,84 do if a~=3 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if a~=5 then m[e[h]]=r[e[o]];else t=e[h];s=m[e[o]];m[t+1]=s;m[t]=s[e[l]];n=n+1;e=d[n];end end end end else local f,a;for t=0,6 do if 3<=t then if 4<t then if 5~=t then f=e[h];a=m[e[o]];m[f+1]=a;m[f]=a[e[l]];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if 4~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if 1<=t then if t>0 then repeat if 1~=t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]]-e[l];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]]-e[l];n=n+1;e=d[n];end else m[e[h]]();n=n+1;e=d[n];end end end end end end else if t<16 then if t>13 then if t==14 then local t,a;for r=0,4 do if r<2 then if r~=-1 then repeat if 0<r then t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];break;end;m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];until true;else m[e[h]][e[o]]=m[e[l]];n=n+1;e=d[n];end else if 3<=r then if 4~=r then m[e[h]]={};n=n+1;e=d[n];else m[e[h]][e[o]]=e[l];end else t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];end end end else for t=0,6 do if t>2 then if t>=5 then if 2<=t then repeat if 5<t then m[e[h]]=m[e[o]][e[l]];break;end;m[e[h]]=r[e[o]];n=n+1;e=d[n];until true;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end else if 3==t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end else if t<=0 then m[e[h]]=r[e[o]];n=n+1;e=d[n];else if t~=-2 then for f=40,84 do if 1~=t then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end end end end else local t,a;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];m(e[h],e[o]);n=n+1;e=d[n];t=e[h]m[t]=m[t](f(m,t+1,e[o]))n=n+1;e=d[n];t=e[h];a=m[e[o]];m[t+1]=a;m[t]=a[e[l]];n=n+1;e=d[n];m[e[h]]={};end else if t<18 then if 16==t then for t=0,3 do if t<=1 then if-4~=t then for l=45,70 do if t>0 then r[e[o]]=m[e[h]];n=n+1;e=d[n];break;end;m[e[h]]=(e[o]~=0);n=n+1;e=d[n];break;end;else r[e[o]]=m[e[h]];n=n+1;e=d[n];end else if t>1 then for f=21,71 do if t~=3 then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;if(m[e[h]]~=e[l])then n=n+1;else n=e[o];end;break;end;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end end else local t,f;m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];t=e[h];f=m[e[o]];m[t+1]=f;m[t]=f[e[l]];n=n+1;e=d[n];m[e[h]]=r[e[o]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];m[e[h]]=m[e[o]][e[l]];end else if t<19 then local s,y,k,p,g,_,u,t,j,z,c;for t=0,6 do if t>2 then if t>4 then if t>2 then for o=30,56 do if 6~=t then s=e[h]m[s]=m[s](f(m,s+1,a))n=n+1;e=d[n];break;end;s=e[h]m[s]=m[s]()break;end;else s=e[h]m[s]=m[s]()end else if t==3 then t=0;while t>-1 do if t<=2 then if t<=0 then k=e;else if t>=0 then for e=41,94 do if t~=2 then p=h;break;end;g=o;break;end;else g=o;end end else if 4<t then if t>2 then for e=25,74 do if t~=5 then t=-2;break;end;m(u,_);break;end;else m(u,_);end else if t>=-1 then repeat if t~=4 then _=k[g];break;end;u=k[p];until true;else u=k[p];end end end t=t+1 end n=n+1;e=d[n];else s=e[h]j,z=b(m[s](f(m,s+1,e[o])))a=z+s-1 c=0;for e=s,a do c=c+1;m[e]=j[c];end;n=n+1;e=d[n];end end else if 0<t then if 2~=t then m[e[h]]=r[e[o]];n=n+1;e=d[n];else s=e[h];y=m[e[o]];m[s+1]=y;m[s]=y[e[l]];n=n+1;e=d[n];end else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end end else for t=0,6 do if t>=3 then if t<=4 then if 1<t then for f=32,86 do if t<4 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end else if 1<=t then for f=19,88 do if 6>t then m[e[h]]=r[e[o]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];break;end;else m[e[h]]=r[e[o]];n=n+1;e=d[n];end end else if 1>t then m[e[h]]=r[e[o]];n=n+1;e=d[n];else if-2~=t then repeat if t~=2 then m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];break;end;m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];until true;else m[e[h]]=m[e[o]][e[l]];n=n+1;e=d[n];end end end end end end end end end end end else if 164>=t then if 136<t then if 150<t then if 157>=t then if t<=153 then if 152<=t then if 153==t then local h=e[h];local d=m[h]
