local lib = loadstring(game:HttpGet("http://192.168.1.104/lib.lua"))()
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

ESP.Players = false
ESP.Boxes = false
ESP.Names = true
ESP:Toggle(true)

local NPCFolder = workspace:FindFirstChild("NPCS")
local shrineFolder = workspace:FindFirstChild("Shrines")
local infuserFolder = workspace:FindFirstChild("Infusers")

local default_link_format = "http://192.168.1.104/"

_G.inf_jump = false
_G.loop_speed = false
_G.loop = nil
_G.charAdded = nil

local saved_speed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed

local mouse = game.Players.LocalPlayer:GetMouse()

local GUI = lib:Create{
    Name = "ironslayer v2",
    Size = UDim2.fromOffset(550, 400),
    Theme = lib.Themes.Rust,
    Link = default_link_format
};

local Tab = GUI:Tab{
	Name = "Special Mobs",
	Icon = "rbxassetid://13197518101"
};

local ExtraTab = GUI:Tab{
	Name = "Mobs",
	Icon = "rbxassetid://13197336983"
};

local ShrineTab = GUI:Tab{
	Name = "Shrines / Infusers",
	Icon = "rbxassetid://13197550313"
};

local PlayerTab = GUI:Tab{
	Name = "Client",
	Icon = "rbxassetid://2831361431"
};

-- Mob Tab Data

local mob_data = {
	["Buni"] = {
		["DisplayName"] = "Buni",
		["Color"] = Color3.fromRGB(255,255,255),
		["TagName"] = "buni",
	};
	["DireBuni"] = {
		["DisplayName"] = "Dire Buni (strong grey buni)",
		["Color"] = Color3.fromRGB(100,100,100),
		["TagName"] = "dbuni",
	};
	["PlainsWoof"] = {
		["DisplayName"] = "Plains Woof",
		["Color"] = Color3.fromRGB(70,70,70),
		["TagName"] = "pwoof",
	};
	["EasterBunni"] = {
		["DisplayName"] = "Easter Buni (Easter Event)",
		["Color"] = Color3.fromRGB(234, 19, 241),
		["TagName"] = "easterbuni",
	};
	["IronSlayer"] = {
		["DisplayName"] = "Iron Slayer",
		["Color"] = Color3.fromRGB(255, 0, 0),
		["TagName"] = "ironslayer",
	};
	["Snoeman"] = {
		["DisplayName"] = "Snoeman (THE YETI)",
		["Color"] = Color3.fromRGB(0, 255, 34),
		["TagName"] = "snoeman",
	};
	["Mageling"] = {
		["DisplayName"] = "Mageling Nigga (I NEED THE ZAZA)",
		["Color"] = Color3.fromRGB(98, 0, 255),
		["TagName"] = "mageling",
	};
	["SporeBossMan"] = {
		["DisplayName"] = "COVID 19",
		["Color"] = Color3.fromRGB(30, 255, 0),
		["TagName"] = "bossman",
	};
	["Slizard"] = {
		["DisplayName"] = "Slizard",
		["Color"] = Color3.fromRGB(30, 255, 0),
		["TagName"] = "slizard",
	};

	["Budboy"] = {
		["DisplayName"] = "Budboy nigga virag",
		["Color"] = Color3.fromRGB(23, 117, 11),
		["TagName"] = "budboy",
	};

	["Dragigator"] = {
		["DisplayName"] = "Niggagitor",
		["Color"] = Color3.fromRGB(255, 153, 0),
		["TagName"] = "dragigator",
	};
	["Bloody"] = {
		["DisplayName"] = "BLOODY MOB",
		["Color"] = Color3.fromRGB(141, 2, 2),
		["TagName"] = "bloodymob",
	};
	["Corrupt"] = {
		["DisplayName"] = "CORRUPTED MOB",
		["Color"] = Color3.fromRGB(183, 0, 255),
		["TagName"] = "corruptmob",
	};
	["Legendary"] = {
		["DisplayName"] = "LEGENDARY MOB",
		["Color"] = Color3.fromRGB(187, 255, 0),
		["TagName"] = "legmob",
	};
	["Magical"] = {
		["DisplayName"] = "MAGICAL MOB",
		["Color"] = Color3.fromRGB(0, 238, 255),
		["TagName"] = "magmob",
	};
	["DeadlandsMob"] = {
		["DisplayName"] = "DEADLANDS MOB",
		["Color"] = Color3.fromRGB(250, 8, 0),
		["TagName"] = "deadlandsmobs",
	};
	["Drone"] = {
		["DisplayName"] = "Drone",
		["Color"] = Color3.fromRGB(255, 230, 0),
		["TagName"] = "drone",
	};
	["SteamGolem"] = {
		["DisplayName"] = "Steam Golem",
		["Color"] = Color3.fromRGB(255, 0, 0),
		["TagName"] = "steamgolem",
	};
};

local function addToESP(folder,data)
	ESP:AddObjectListener(folder, { -- Object Path, For example: Workspace.ThisFolder
    Name = data.actualname, --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
    CustomName = data.displayname, -- Name you want to be displayed
    Color = data.color, -- Color
    IsEnabled = data.tagname -- Any name, has to be the same as the last line: ESP.TheNameYouWant
})
end

local function sendNotification(title, content, duration, soundName)
    duration = (duration + 1.5)
    GUI:Notification{
        Title = title,
        Text = content,
        Duration = duration,
        Callback = function() end
    }

    local sound_data = {
        ["default"] = {
            id = "rbxassetid://9061754547";
            volume = 1.5;
        };
        ["tada"] = {
            id = "rbxassetid://7695856187";
            volume = 2;
        };
    };

	 if soundName ~= nil then
        local Sound = Instance.new("Sound")
		Sound.Parent = game:GetService("CoreGui")
		Sound.SoundId = sound_data[soundName].id
        Sound.Volume = sound_data[soundName].volume
		Sound:Play()
		game:GetService("Debris"):AddItem(Sound, 5)
	 end
end

local function get_data_table(mob)

	local dataTable = nil

	if mob.Name:find("Buni") and not mob.Name:find("Dire") and not mob.Name:find("Easter") then
		dataTable = mob_data["Buni"]
	elseif mob.Name:find("DireBuni") then
		dataTable = mob_data["DireBuni"]
	elseif mob.Name:find("PlainsWoof") then
		dataTable = mob_data["PlainsWoof"]
	elseif mob.Name:find("EasterBuni") then
		dataTable = mob_data["EasterBunni"]
		sendNotification("SPECIAL MOB SPAWNED", "EASTER BUNNI", 4, "default")
	elseif mob.Name:find("IronSlayer") or mob.Name:find("Iron") or mob.Name:find("Slayer") then
		dataTable = mob_data["IronSlayer"]
		sendNotification("SPECIAL MOB SPAWNED", "IRON SLAYER", 4, "tada")
	elseif mob.Name:find("Snoe") or mob.Name:find("snoe") or mob.Name:find("Snoeman") then
		dataTable = mob_data["Snoeman"]
		sendNotification("SPECIAL MOB SPAWNED", "SNOEMAN", 4, "default")
	elseif mob.Name:find("Mageling") then
		dataTable = mob_data["Mageling"]
	elseif mob.Name:find("SporebossMan") then
		dataTable = mob_data["SporeBossMan"]
	elseif mob.Name:find("Slizard") then
		dataTable = mob_data["Slizard"]
	elseif mob.Name:find("Budboy") then
		dataTable = mob_data["Budboy"]
	elseif mob.Name:find("Dragigator") then
		dataTable = mob_data["Dragigator"]
	elseif mob.Name:find("VoidRoot") or mob.Name:find("Bowldur") then
		dataTable = mob_data["DeadlandsMob"]
	elseif mob.Name:find("Drone") then
		dataTable = mob_data["Drone"]
	elseif mob.Name:find("Steam") or mob.Name:find("Golem") then
		dataTable = mob_data["SteamGolem"]
		sendNotification("SPECIAL MOB SPAWNED", "STEAM GOLEM", 4, "tada")
	end

	local magicalParticle = mob:FindFirstChild("Magical"); local magicalLight = mob:FindFirstChild("MagicalL")
	local bloodyParticle = mob:FindFirstChild("Bloody"); local bloodyLight = mob:FindFirstChild("BloodyL")
	local corruptParticle = mob:FindFirstChild("Corrupt"); local corruptLight = mob:FindFirstChild("CorruptL")
	local legendaryParticle = mob:FindFirstChild("Legendary"); local legendaryLight = mob:FindFirstChild("LegendaryL")

	if magicalParticle and magicalLight then
		if magicalParticle.Enabled or magicalLight.Enabled then
			dataTable = mob_data["Magical"]
			sendNotification("MAGICAL MOB SPAWNED", mob.Name, 4, "default")
		end
	end

	if bloodyParticle and bloodyLight then
		if bloodyParticle.Enabled or bloodyLight.Enabled then
			dataTable = mob_data["Bloody"]
			sendNotification("BLOODY MOB SPAWNED", mob.Name, 4, "default")
		end
	end

	if corruptParticle and corruptLight then
		if corruptParticle.Enabled or corruptLight.Enabled then
			dataTable = mob_data["Corrupt"]
			sendNotification("CORRUPTED MOB SPAWNED", mob.Name, 4, "default")
		end
	end

	if legendaryParticle and legendaryLight then
		if legendaryParticle.Enabled or legendaryLight.Enabled then
			dataTable = mob_data["Legendary"]
			sendNotification("LEGENDARY MOB SPAWNED", mob.Name, 4, "default")
		end
	end

	return dataTable
end

if shrineFolder then
    for _, shrine in pairs(shrineFolder:GetChildren()) do
        ShrineTab:Toggle{
            Name = shrine.Name,
            StartingState = false,
            Description = "Sword Shrine",
            Callback = function(Value)
                ESP["shrine_"..shrine.Name] = Value
            end
        };
     end
end

if infuserFolder then
    for _, infuser in pairs(infuserFolder:GetChildren()) do
        ShrineTab:Toggle{
            Name = infuser.Name,
            StartingState = false,
            Description = "Infuser",
            Callback = function(Value)
                ESP["infuser_"..infuser.Name] = Value
            end
        };
     end
end

if NPCFolder then
    local function CheckMob(mob)
        local dataTable = get_data_table(mob)
    
        if dataTable then
            local finalData = {
                actualname = mob.Name,
                displayname = dataTable.DisplayName,
                color = dataTable.Color,
                tagname = dataTable.TagName,
            };
            addToESP(NPCFolder,finalData)
        end
    end

    for _, mob in pairs(NPCFolder:GetChildren()) do
        task.delay(0.5, function()
            CheckMob(mob)
        end)
    end
    
    NPCFolder.ChildAdded:Connect(function(mob)
        task.delay(0.5, function()
            CheckMob(mob)
        end)
    end)
end

mouse.KeyDown:Connect(function(Key)
	if _G.inf_jump == true and Key == " " then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
	end
end)

local function loopspeed_update()
	local Char = game.Players.LocalPlayer.Character or workspace:FindFirstChild(game.Players.LocalPlayer.Character.Name)
	local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
	local speed = saved_speed

	local function WalkSpeedChange()
		if Char and Human then
			Human.WalkSpeed = speed
		end
	end

	if _G.loop_speed == true then
		speed = 50
		_G.loop = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
			WalkSpeedChange()
			game:GetService("RunService").RenderStepped:Wait()
		end)

		_G.charAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(newCharacter)
			Char = newCharacter
			Human = newCharacter:WaitForChild("Humanoid")
		end)
	else
		-- disconnect loop
		if _G.loop ~= nil then
			_G.loop:Disconnect()
			_G.loop = nil
		end
		if _G.charAdded ~= nil then
			_G.charAdded:Disconnect()
			_G.charAdded = nil
		end
		WalkSpeedChange()
	end
end

--[[
Tab:Button{
	Name = "Notification Test",
	Description = nil,
	Callback = function()
        GUI:Notification{
            Title = "Spawn Alert",
            Text = "A bloody mob has spawned.",
            Duration = 3,
            Callback = function() end
        }
    end
};
--]]

GUI:Prompt{
	Followup = false,
	Title = "important message",
	Text = "kill yourself",
	
    Buttons = {
		ok = function()
			if game:GetService("ReplicatedStorage"):FindFirstChild("Effects") then
				pcall(function()
					game:GetService("ReplicatedStorage").Effects.SFX.Roar:Play()
				end)
			end
			return true
		end,
	},
};

Tab:Toggle{
	Name = "Iron Slayer",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.ironslayer = Value
    end
};

Tab:Toggle{
	Name = "Steam Golem",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.steamgolem = Value
    end
};

Tab:Toggle{
	Name = "Easter Buni",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.easterbuni = Value
    end
};

Tab:Toggle{
	Name = "Snoeman",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.snoeman = Value
    end
};

Tab:Toggle{
	Name = "Legendary/Bloody/Magical/Corrupt",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.legmob = Value;
		ESP.magmob = Value;
		ESP.corruptmob = Value;
		ESP.bloodymob = Value;
    end
};

-- // Mob Tab Data

ExtraTab:Toggle{
	Name = "Mageling",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.mageling = Value;
    end
};

ExtraTab:Toggle{
	Name = "Sporeman bossman",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.bossman = Value;
    end
};

ExtraTab:Toggle{
	Name = "Slizard",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.slizard = Value;
    end
};

ExtraTab:Toggle{
	Name = "Budboy",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.budboy = Value;
    end
};

ExtraTab:Toggle{
	Name = "Dragigator",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.dragigator = Value;
    end
};

ExtraTab:Toggle{
	Name = "All Deadlands Mobs",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.deadlandsmobs = Value;
    end
};

ExtraTab:Toggle{
	Name = "Plains Woof",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.pwoof = Value;
    end
};

ExtraTab:Toggle{
	Name = "Drone",
	StartingState = false,
	Description = "ESP",
	Callback = function(Value)
        ESP.drone = Value;
    end
};

PlayerTab:Toggle{
	Name = "Infinite Jump",
	StartingState = false,
	Description = "Allows you to jump infinitely.",
	Callback = function(Value)
        _G.inf_jump = Value;
    end
};

PlayerTab:Toggle{
	Name = "Fast Walk",
	StartingState = false,
	Description = "Allows you to walk faster. (50)",
	Callback = function(Value)
		_G.loop_speed = Value;
		loopspeed_update()
    end
};

