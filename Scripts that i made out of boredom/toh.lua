local Settings =
{
    GodMode = false,
    AutoFarm = false,
    Ambient = false,
    AmbientColor = Color3.fromRGB(76, 0, 153),
    PlayerToTeleport = nil,
    SpinBot = false,
    FollowPlayer = false,
    InfJump = false
}

local players = game:GetService("Players")
local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
local win = DiscordLib:Window("antifurryhack")
local serv = win:Server("i hate furries", "")
local Main = serv:Channel("Main")
local MiscStuff = serv:Channel("Misc")
local acscript = getsenv(players.LocalPlayer.PlayerScripts.LocalScript)
function hooked()
    print("anti cheat bypassed ez fuck all furries")
end
hookfunction(acscript.kick, hooked)

Main:Toggle("God Mode",false, function(bool)
    Settings.GodMode = bool
end)

Main:Toggle("Auto Farm",false, function(bool)
    Settings.AutoFarm = bool    
end)

Main:Toggle("Spinbot",false, function(bool)
    Settings.SpinBot = bool    
end)

Main:Toggle("Infinite Jump",false, function(bool)
    Settings.InfJump = bool    
end)

Main:Toggle("Ambient",false, function(bool)
    Settings.Ambient = bool    
end)

Main:Colorpicker("Ambient Color", Color3.fromRGB(1, 1, 1), function(t)
    Settings.AmbientColor = t
end)


Main:Seperator()

Main:Button("Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

Main:Label("The anti-cheat is bypassed, so commands in infinite yield wont be detected now")

-- misc

local playerDropdown = MiscStuff:Dropdown("Player List",{"Choose a player to teleport"}, function(bool)
    Settings.PlayerToTeleport = bool
end)

MiscStuff:Button("Teleport To Player", function()
    if Settings.PlayerToTeleport ~= nil then 
        players.LocalPlayer.Character.HumanoidRootPart.CFrame = players[Settings.PlayerToTeleport].Character.HumanoidRootPart.CFrame
    else
        DiscordLib:Notification("Error", "You didn't choose anyone to teleport", "Okay")
    end
end)

function refreshPlayerList()
playerDropdown:Clear()
for i, v in pairs(players:GetChildren()) do 
    if v.Name ~= players.LocalPlayer.Name then
    playerDropdown:Add(v.Name)
    end
end
end

refreshPlayerList()

MiscStuff:Button("Refresh Player List", function()
    refreshPlayerList()
end)

MiscStuff:Toggle("Follow Player",false, function(bool)
    Settings.FollowPlayer = bool   
end)





game:GetService("RunService").RenderStepped:Connect(function()
    if Settings.SpinBot then 
        players.LocalPlayer.Character.Humanoid.AutoRotate = false
        players.LocalPlayer.Character.HumanoidRootPart.CFrame = players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(200), 0)
    else    
        players.LocalPlayer.Character.Humanoid.AutoRotate = true
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if Settings.FollowPlayer then
        if Settings.PlayerToTeleport ~= nil then 
            players.LocalPlayer.Character.HumanoidRootPart.CFrame = players[Settings.PlayerToTeleport].Character.HumanoidRootPart.CFrame
        else
            print("You didn't choose a player to follow, the script won't follow a player")
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    for i,v in pairs(game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name]:GetChildren()) do
        if v.Name == "KillScript" and players.LocalPlayer.Character.Humanoid.Health > 0 then
            if Settings.GodMode then
                wait(0.5)
                v.Disabled = true
            else
                v.Disabled = false
            end
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if Settings.Ambient then
        game.Lighting.Ambient = Settings.AmbientColor;
        game.Lighting.OutdoorAmbient = Settings.AmbientColor;
        game.Lighting.ClockTime = Settings.AmbientColor;
        game.Lighting.ColorShift_Top = Settings.AmbientColor;
        game.Lighting.ColorShift_Bottom = Settings.AmbientColor;
    end
 end)

game:GetService("RunService").RenderStepped:Connect(function()
for i, v in pairs(game.Workspace.tower.finishes:GetChildren()) do 
    if Settings.AutoFarm then
    players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
    end
end
end)

game:GetService("RunService").RenderStepped:Connect(function()
if Settings.InfJump then
    if game:GetService("UserInputService"):IsKeyDown("Space") and players.LocalPlayer.Character.Humanoid.Health > 0 then
        players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end
end)
