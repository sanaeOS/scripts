-- iron slayer hook vBeta xD

-- // Libraries
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- // Variables & Settings
ESP.Players = false
ESP.Boxes = false
ESP.Names = true
ESP:Toggle(true)

-- // Functions

local NPCFolder = workspace.NPCS

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
};


local function addToESP(folder,data)
	ESP:AddObjectListener(folder, { -- Object Path, For example: Workspace.ThisFolder
    Name = data.actualname, --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
    CustomName = data.displayname, -- Name you want to be displayed
    Color = data.color, -- Color
    IsEnabled = data.tagname -- Any name, has to be the same as the last line: ESP.TheNameYouWant
})
end

local shrineFolder = workspace.Shrines
local infuserFolder = workspace.Infusers

local function sendNotification(title, content, duration, soundid)
	Rayfield:Notify({
		Title = title,
		Content = content,
		Duration = duration,
	 })

	 if soundid ~= nil then
		local Sound = Instance.new("Sound")
		Sound.Parent = game:GetService("CoreGui")
		Sound.SoundId = soundid
		Sound:Play()
		game:GetService("Debris"):AddItem(Sound, 5)
	 end

	 game:GetService("ReplicatedStorage").Effects.SFX.Heal2:Play()
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
		sendNotification("SPECIAL MOB SPAWNED", "EASTER BUNNI", 4)
	elseif mob.Name:find("IronSlayer") or mob.Name:find("Iron") or mob.Name:find("Slayer") then
		dataTable = mob_data["IronSlayer"]
		sendNotification("SPECIAL MOB SPAWNED", "IRON SLAYER", 4)
	elseif mob.Name:find("Snoe") or mob.Name:find("snoe") or mob.Name:find("Snoeman") then
		dataTable = mob_data["Snoeman"]
		sendNotification("SPECIAL MOB SPAWNED", "SNOEMAN", 4)
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
	end

	local magicalParticle = mob:FindFirstChild("Magical"); local magicalLight = mob:FindFirstChild("MagicalL")
	local bloodyParticle = mob:FindFirstChild("Bloody"); local bloodyLight = mob:FindFirstChild("BloodyL")
	local corruptParticle = mob:FindFirstChild("Corrupt"); local corruptLight = mob:FindFirstChild("CorruptL")
	local legendaryParticle = mob:FindFirstChild("Legendary"); local legendaryLight = mob:FindFirstChild("LegendaryL")

	task.delay(0.25, function()
		if magicalParticle and magicalLight then
			if magicalParticle.Enabled or magicalLight.Enabled then
				dataTable = mob_data["Magical"]
				sendNotification("MAGICAL MOB SPAWNED", mob.Name, 4)
			end
		end
	
		if bloodyParticle and bloodyLight then
			if bloodyParticle.Enabled or bloodyLight.Enabled then
				dataTable = mob_data["Magical"]
				sendNotification("BLOODY MOB SPAWNED", mob.Name, 4)
			end
		end
	
		if corruptParticle and corruptLight then
			if corruptParticle.Enabled or corruptLight.Enabled then
				dataTable = mob_data["Corrupt"]
				sendNotification("CORRUPTED MOB SPAWNED", mob.Name, 4)
			end
		end
	
		if legendaryParticle and legendaryLight then
			if legendaryParticle.Enabled or legendaryLight.Enabled then
				dataTable = mob_data["Legendary"]
				sendNotification("LEGENDARY MOB SPAWNED", mob.Name, 4)
			end
		end
	
		return dataTable
	end)
end

-- // RAYFIELD UI SETUP

local Window = Rayfield:CreateWindow({
	Name = "ironslayerHook",
	LoadingTitle = "the void comin",
	LoadingSubtitle = "by ironslayerkiller9823123",
	ConfigurationSaving = {
	   Enabled = false,
	   FolderName = "ironcfg", -- Create a custom folder for your hub/game
	   FileName = "slayercfg"
	},
	Discord = {
	   Enabled = false,
	   Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
	   RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
	   Title = "ironslayerHook",
	   Subtitle = "the void comin",
	   Note = "by ironslayerkiller9823123",
	   FileName = "islayerhookKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
	   SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
	   GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
	   Key = {"zaza"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
 })

 local Tab = Window:CreateTab("Mobs") -- Title, Image

 local ESP_Section = Tab:CreateSection("ESP")

 local EBuniButton = Tab:CreateToggle({
	Name = "ESP :: Easter Buni",
	CurrentValue = false,
	Flag = "EBuniEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.easterbuni = Value
	end,
 })

 local SlayerButton = Tab:CreateToggle({
	Name = "ESP :: Iron Slayer",
	CurrentValue = false,
	Flag = "ISEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.ironslayer = Value
	end,
 })

 local YetiButton = Tab:CreateToggle({
	Name = "ESP :: Snoeman (THE YETI)",
	CurrentValue = false,
	Flag = "SnoeEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.snoeman = Value
	end,
 })

 local ParticleMobButton = Tab:CreateToggle({
	Name = "ESP :: Legendary/Bloody/Magical/Corrupt Mobs (Fixed)",
	CurrentValue = false,
	Flag = "LegEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.legmob = Value;
		ESP.magmob = Value;
		ESP.corruptmob = Value;
		ESP.bloodymob = Value;
	end,
 })

 local Extra_Section = Tab:CreateSection("EXTRA")

 local MagelingButton = Tab:CreateToggle({
	Name = "ESP :: Mageling",
	CurrentValue = false,
	Flag = "MagelingEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.mageling = Value
	end,
 })

 local BossButton = Tab:CreateToggle({
	Name = "ESP :: Sporeman bossman",
	CurrentValue = false,
	Flag = "BossEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.bossman = Value
	end,
 })

 local SlizardButton = Tab:CreateToggle({
	Name = "ESP :: Slizard the wizard",
	CurrentValue = false,
	Flag = "SlizardEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.slizard = Value
	end,
 })

 local BudboyButton = Tab:CreateToggle({
	Name = "ESP :: Budboy",
	CurrentValue = false,
	Flag = "BudEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.budboy = Value
	end,
 })

 local DragiButton = Tab:CreateToggle({
	Name = "ESP :: Dragigator",
	CurrentValue = false,
	Flag = "DragEnabled", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESP.dragigator = Value
	end,
 })

 --bossman

 local Debug_Section = Tab:CreateSection("DEBUG")

 local DestroyButton = Tab:CreateButton({
	Name = "Destroy UI",
	Callback = function()
		Rayfield:Destroy()
	end,
 })

 local Tab2 = Window:CreateTab("Interactables")

 local Shrine_Section = Tab2:CreateSection("Shrines")

 for _, shrine in pairs(shrineFolder:GetChildren()) do
	local shrine_button = Tab2:CreateToggle({
		Name = shrine.Name,
		CurrentValue = false,
		Callback = function(Value)
			ESP["shrine_"..shrine.Name] = Value
		end,
	 })
 end

 local Infuser_Section = Tab2:CreateSection("Infusers")

 for _, infuser in pairs(infuserFolder:GetChildren()) do
	local infuser_button = Tab2:CreateToggle({
		Name = infuser.Name,
		CurrentValue = false,
		Callback = function(Value)
			ESP["infuser_"..infuser.Name] = Value
		end,
	 })
 end

-- snail xdd

local StandObject = workspace.Map.Stand
local SnailManPart = StandObject.Snailsman



local snail_locations = {
	["Deadlands"] = {
		pos = CFrame.new(2373.69995, 277, 2403.8501, -1, 0, 0, 0, 1, 0, 0, 0, -1);
		color = Color3.fromRGB(251, 255, 0);
		displayName = "Deadlands"
	};
	["Swamp"] = {
		pos = CFrame.new(-1281.32495, -18.1625061, 2263.92456, 0, 0, -1, 0, 1, 0, 1, 0, 0);
		color = Color3.fromRGB(0, 255, 0);
		displayName = "Swamp"
	};

};

---1281.32495, -18.1625061, 2263.92456, 0, 0, -1, 0, 1, 0, 1, 0, 0


local function get_snail()
	local foundSnail = nil
	local color = nil

	for _, location in pairs(snail_locations) do
		if location.pos == SnailManPart.CFrame then
			foundSnail = location.displayName
			color = location.color
			break
		end
	end
	
	return foundSnail, color
end

local function updateSnail()
	local location_name, location_color = get_snail()

	if location_name then
		local snail_data = {
			actualname = "Snailsman",
			displayname = "Snailsman [ "..location_name.." ]",
			color = location_color,
			tagname = "snails",
		};
		addToESP(workspace.Map.Stand,snail_data)
	else
		local snail_data = {
			actualname = "Snailsman",
			displayname = "Snailsman [ Unknown ]",
			color = Color3.fromRGB(255,255,255),
			tagname = "snails",
		};
		addToESP(workspace.Map.Stand,snail_data)
	end
end

updateSnail()

SnailManPart:GetPropertyChangedSignal("Position"):Connect(function()
	updateSnail()
end)

local Extra_Section2 = Tab2:CreateSection("Extras")

local snailsmanButton = Tab2:CreateToggle({
	Name = "Snailsman",
	CurrentValue = false,
	Callback = function(Value)
		ESP["snails"] = Value
	end,
 })
 -- DO NOT EDIT BELOW THIS LINE

 for _, mob in pairs(NPCFolder:GetChildren()) do
	local dataTable = get_data_table(mob)

	if dataTable then
		local finalData = {
			actualname = mob.Name,
			displayname = dataTable.DisplayName,
			color = dataTable.Color,
			tagname = dataTable.TagName,
		};
	
		addToESP(workspace.NPCS,finalData)
	end
end

NPCFolder.ChildAdded:Connect(function(mob)
	local dataTable = get_data_table(mob)

	if dataTable then
		local finalData = {
			actualname = mob.Name,
			displayname = dataTable.DisplayName,
			color = dataTable.Color,
			tagname = dataTable.TagName,
		};
	
		addToESP(workspace.NPCS,finalData)
	end
end)

for _, shrine in pairs(shrineFolder:GetChildren()) do
	local finalData = {
		actualname = shrine.Name,
		displayname = shrine.Name,
		color = Color3.fromRGB(255,255,255),
		tagname = "shrine_"..shrine.Name,
	};

	addToESP(workspace.Shrines,finalData)
end

for _, infuser in pairs(infuserFolder:GetChildren()) do
	local finalData = {
		actualname = infuser.Name,
		displayname = infuser.Name,
		color = Color3.fromRGB(208, 255, 0),
		tagname = "infuser_"..infuser.Name,
	};

	addToESP(workspace.Infusers,finalData)
end