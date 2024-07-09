repeat task.wait() until game:IsLoaded()

local library = {}
local spawnConnections = {}
local utils = {}

local canLoadPolaris = true--getgenv().EOIFHEIUFHu0e98fekwjfbnweiurghfueiyrgy9re088ug
local hurttime = 0

if not canLoadPolaris then return end

Players = game:GetService("Players")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
UserInputService = game:GetService("UserInputService")
LocalPlayer = Players.LocalPlayer
Character = LocalPlayer.Character
Humanoid = Character.Humanoid
PrimaryPart = Character.PrimaryPart
PlayerGui = LocalPlayer.PlayerGui
PlayerScripts = LocalPlayer.PlayerScripts
Camera = workspace.Camera
CurrentCamera = workspace.CurrentCamera
RunService = game["Run Service"]
TweenService = game.TweenService
DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
inventory = workspace[LocalPlayer.Name].InventoryFolder.Value
local inventory = workspace[LocalPlayer.Name].InventoryFolder.Value
local CollectionService = game:GetService("CollectionService")

local config = {
	Buttons = {},
	Toggles = {},
	Options = {},
	Keybinds = {}
}

local function saveConfig()
	local encrypt = game:GetService("HttpService"):JSONEncode(config)
	if isfile("HvHClub/config.json") then
		delfile("HvHClub/config.json")
	end
	writefile("HvHClub/config.json",encrypt)
end

local function loadConfig()
	local decrypt = game:GetService("HttpService"):JSONDecode(readfile("HvHClub/config.json"))
	config = decrypt
end

if not isfile("HvHClub/config.json") then
	makefolder("HvHClub")
	saveConfig()
end

task.wait(0.001)
loadConfig()
task.wait(0.001)

sethiddenproperty = function(X,Y,Z)
	pcall(function()
		X[Y] = Z
	end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
	repeat task.wait(1) until char ~= nil

	Character = char
	Humanoid = char.Humanoid
	PrimaryPart = char.PrimaryPart
	Camera = workspace.Camera
	CurrentCamera = workspace.CurrentCamera

	Character.Archivable = true

	for i,v in next, spawnConnections do
		task.spawn(function() v(char) end)
	end
end)

table.insert(spawnConnections,function(char)
	task.wait(1)
	inventory = workspace[LocalPlayer.Name].InventoryFolder.Value
end)

library.WindowCount = 0
library.Color = Color3.fromRGB(0, 191, 255)
library.KeyBind = Enum.KeyCode.RightShift
library.Modules = {}
library.Modules.Rotations = false

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.ResetOnSpawn = false

UserInputService.InputBegan:Connect(function(key,gpe)
	if key.KeyCode == library.KeyBind then
		cmdBar.Visible = not cmdBar.Visible
	end
end)

local arrayFrame = Instance.new("Frame",ScreenGui)
arrayFrame.Size = UDim2.fromScale(0.3,1)
arrayFrame.Position = UDim2.fromScale(0.7,0)
arrayFrame.BackgroundTransparency = 1
local sort = Instance.new("UIListLayout",arrayFrame)
sort.SortOrder = Enum.SortOrder.LayoutOrder

local arrayStuff = {}

local id = "http://www.roblox.com/asset/?id=7498352732"

local arrayListFrame = Instance.new("Frame",ScreenGui)
arrayListFrame.Size = UDim2.fromScale(0.2,1)
arrayListFrame.Position = UDim2.fromScale(0.795,0.03)
arrayListFrame.BackgroundTransparency = 1
arrayListFrame.Name = "ArrayList"
local sort = Instance.new("UIListLayout",arrayListFrame)
sort.SortOrder = Enum.SortOrder.LayoutOrder
sort.HorizontalAlignment = Enum.HorizontalAlignment.Right

local colors = {
	["CottonCandy"] = {
		["Main"] = Color3.fromRGB(234, 149, 255),
		["Second"] = Color3.fromRGB(143, 253, 255)
	},
	["Purple"] = {
		["Main"] = Color3.fromRGB(191, 0, 255),
		["Second"] = Color3.fromRGB(119, 0, 255)
	},
	["Blue"] = {
		["Main"] = Color3.fromRGB(135, 206, 255),
		["Second"] = Color3.fromRGB(135, 206, 255)
	},
	["Wave4Mc"] = {
		["Main"] = Color3.fromRGB(76, 118, 255),
		["Second"] = Color3.fromRGB(255, 255, 255)
	},
	["Hackerman"] = {
		["Main"] = Color3.fromRGB(0, 145, 17),
		["Second"] = Color3.fromRGB(255, 255, 255)
	},
	["Blurple"] = { -- Springs fav frfrfrfrfrfrfrfr :D
		["Main"] = Color3.fromRGB(124, 7, 191),
		["Second"] = Color3.fromRGB(66, 2, 227)
	},
}

local imageId = "http://www.roblox.com/asset/?id=5857213084"
local currentTheme = colors.Blue
local arrayItems = {}
local arraylist = {
	Create = function(o)

		local item = Instance.new("TextLabel",arrayListFrame)
		item.Text = o
		item.BackgroundTransparency = 0.3
		item.BorderSizePixel = 0
		item.BackgroundColor3 = Color3.fromRGB(0,0,0)
		item.Size = UDim2.new(0,0,0,0)
		item.TextSize = 12
		item.TextColor3 = Color3.fromRGB(255,255,255)
		--item.TextXAlignment = Enum.TextXAlignment.Right

		local glow = Instance.new("ImageLabel",item)
		glow.Size = UDim2.fromScale(4,4)
		glow.BackgroundTransparency = 1
		glow.Image = imageId
		glow.ImageTransparency = 0.3
		glow.Position = UDim2.fromScale(-1,-1.5)
		glow.ZIndex = -10

		local size = UDim2.new(0.01,game.TextService:GetTextSize(o,22,Enum.Font.SourceSans,Vector2.new(0,0)).X,0.033,0)

		if o == "" then
			size = UDim2.fromScale(0,0)
		end

		item.Size = size

		item.BackgroundTransparency = 0.6
		item.TextTransparency = 0

		table.insert(arrayItems,item)
		table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X > game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
		for i,v in ipairs(arrayItems) do
			v.LayoutOrder = i
		end

	end,
	Remove = function(o)
		table.sort(arrayItems,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X > game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
		local c = 0
		for i,v in ipairs(arrayItems) do
			c += 1
			if (v.Text == o) then
				v:Destroy()
				table.remove(arrayItems,c)
			else
				v.LayoutOrder = i
			end
		end
	end,
}

arraylist.Create("")

task.spawn(function()
	local loops = 0
	repeat task.wait()
		loops += 1
		local count = 0

		local half = #arrayItems / 2
		local glowTemps = {}
		for i,v in pairs(arrayItems) do
			count += 1
			local formula = ((count - 1) / (#arrayItems - 1))
			local offset = math.sin(tick() * 2 + formula * 2 * math.pi) / 0.5
			game.TweenService:Create(v,TweenInfo.new(0.5),{
				TextColor3 = currentTheme.Main:Lerp(currentTheme.Second,math.clamp(offset + 0.5,0,1))
			}):Play()
			game.TweenService:Create(v.ImageLabel,TweenInfo.new(0.5),{
				ImageColor3 = currentTheme.Main:Lerp(currentTheme.Second,math.clamp(offset + 0.5,0,1))
			}):Play()
		end

		if loops > 1 then
			for i,v in pairs(glowTemps) do
				v:Destroy()
			end

			table.clear(glowTemps)
		end
	until false
end)


function NewTween(item, totime, toChange)
	TweenService:Create(item, totime, toChange):Play()
end

local NOTIFY_FRAME = Instance.new("Frame", ScreenGui)
NOTIFY_FRAME.Position = UDim2.fromScale(0.8, 0.5)
NOTIFY_FRAME.Size = UDim2.fromScale(0.19, 0.4)
NOTIFY_FRAME.BackgroundTransparency = 1

local SORT_NOTIFY_FRAME = Instance.new("UIListLayout", NOTIFY_FRAME)
SORT_NOTIFY_FRAME.SortOrder = Enum.SortOrder.LayoutOrder
SORT_NOTIFY_FRAME.VerticalAlignment = Enum.VerticalAlignment.Bottom
SORT_NOTIFY_FRAME.Padding = UDim.new(0, 5)

function library:Notification(Description, Time)
	spawn(function()
		local newNotif = Instance.new("TextLabel", NOTIFY_FRAME)
		newNotif.Size = UDim2.fromScale(0.9, 0.1)
		newNotif.Position = UDim2.fromScale(0, 0)
		newNotif.BorderSizePixel = 0
		newNotif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		newNotif.BackgroundTransparency = 0.4
		newNotif.TextColor3 = Color3.fromRGB(255,255,255)
		newNotif.TextScaled = true
		newNotif.Text = Description

		local Box = Instance.new("Frame", newNotif)
		Box.Position = UDim2.fromScale(-0.05, 0)
		Box.Size = UDim2.fromScale(0.05, 1)
		Box.BorderSizePixel = 0
		Box.BackgroundColor3 = library.Color

		task.delay(Time, function()
			NewTween(newNotif, TweenInfo.new(1), {Transparency = 1})
			NewTween(Box, TweenInfo.new(1), {Transparency = 1})
		end)
	end)
end

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

function CreateNotification(Title, Duration, Message)
    Notification:Notify(
        {Title = Title, Description = Message},
        {OutlineColor = Color3.fromRGB(0, 191, 255), Time = Duration, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(0, 191, 255)}
    )
end

function CreateNotification2(Title, Duration, Message)
    Notification:Notify(
        {Title = Title, Description = Message},
        {OutlineColor = Color3.fromRGB(255, 255, 0), Time = Duration, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6031071053", ImageColor = Color3.fromRGB(255, 255, 0)}
    )
end

function CreateNotificationStaffDetector(Title, Duration, Message)
    sound = Instance.new("Sound",workspace)
    sound.Name = "Noooooooooooooooot noooooooooooooooooooooooot"
    sound.SoundId = "rbxassetid://7396762708"
    sound:Play()

    Notification:Notify(
        {Title = Title, Description = Message},
        {OutlineColor = Color3.fromRGB(255, 0, 0), Time = Duration, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6031071053", ImageColor = Color3.fromRGB(255, 84, 84)}
    )
end

library.NewWindow = function(name)
	local textlabel = Instance.new("TextLabel", ScreenGui)
	textlabel.Position = UDim2.fromScale(0.1 + (library.WindowCount / 8), 0.1)
	textlabel.Size = UDim2.fromScale(0.1, 0.0425)
	textlabel.Text = name
	textlabel.Name = name
	textlabel.BorderSizePixel = 1
	textlabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	textlabel.BackgroundTransparency = 0.2
	textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textlabel.BorderColor3 = Color3.fromRGB(50, 50, 50)
	textlabel.ZIndex = 2

	local modules = Instance.new("Frame", textlabel)
	modules.Size = UDim2.fromScale(1, 5)
	modules.Position = UDim2.fromScale(0, 1)
	modules.BackgroundTransparency = 1
	modules.BorderSizePixel = 0

	local sortmodules = Instance.new("UIListLayout", modules)
	sortmodules.SortOrder = Enum.SortOrder.Name

	UserInputService.InputBegan:Connect(function(k, g)
		if g then return end
		if k == nil then return end
		if k.KeyCode == library.KeyBind then
			textlabel.Visible = not textlabel.Visible
		end
	end)

	library.WindowCount += 1

	local lib = {}

	lib.NewButton = function(Table)
		library.Modules[Table.Name] = {
			Keybind = Table.Keybind,
		}

		if config.Buttons[Table.Name] == nil then
			config.Buttons[Table.Name] = {
				Enabled = false,
			}
		else
			saveConfig()
		end

		if config.Keybinds[Table.Name] == nil then
			config.Keybinds[Table.Name] = tostring(Table.Keybind):split(".")[3] or "Unknown"
		end

		library.Modules[Table.Name].Keybind = Enum.KeyCode[config.Keybinds[Table.Name]]

		local enabled = false
		local textbutton = Instance.new("TextButton", modules)
		textbutton.Size = UDim2.fromScale(1, 0.2)
		textbutton.Position = UDim2.fromScale(0, 0)
		textbutton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		textbutton.BackgroundTransparency = 0.3
		textbutton.BorderSizePixel = 1
		textbutton.BorderColor3 = Color3.fromRGB(70, 70, 70)
		textbutton.Text = Table.Name
		textbutton.Name = Table.Name
		textbutton.TextColor3 = Color3.fromRGB(255, 255, 255)

		local dropdown = Instance.new("Frame", textbutton)
		dropdown.Position = UDim2.fromScale(0, 1)
		dropdown.Size = UDim2.fromScale(1, 5)
		dropdown.BackgroundTransparency = 1
		dropdown.Visible = false

		local dropdownsort = Instance.new("UIListLayout", dropdown)
		dropdownsort.SortOrder = Enum.SortOrder.Name

		local lib2 = {}
		lib2.Enabled = false

		lib2.ToggleButton = function(v)
			if v then
				enabled = true
			else
				enabled = not enabled
			end

			if enabled then
				arraylist.Create(Table.Name)
				CreateNotification("HvHClub", 5, Table.Name .. " has been enabled")
			else
				arraylist.Remove(Table.Name)
				CreateNotification("HvHClub", 5, Table.Name .. " has been disabled")
			end

			lib2.Enabled = enabled
			task.spawn(function()
				task.delay(0.1, function()
					Table.Function(enabled)
				end)
			end)

			textbutton.BackgroundColor3 = (textbutton.BackgroundColor3 == Color3.fromRGB(60, 60, 60) and library.Color or Color3.fromRGB(60, 60, 60))
			config.Buttons[Table.Name].Enabled = enabled
			saveConfig()
		end

		local keybindButton = Instance.new("TextButton", dropdown)
        keybindButton.Size = UDim2.fromScale(1, 0.15)
        keybindButton.Position = UDim2.fromScale(0, 0)
        keybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        keybindButton.BackgroundTransparency = 0.3
        keybindButton.BorderSizePixel = 1
        keybindButton.BorderColor3 = Color3.fromRGB(70, 70, 70)
        keybindButton.Text = "Keybind: " .. config.Keybinds[Table.Name]
        keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)

        local keybindConnection
        keybindButton.MouseButton1Down:Connect(function()
            keybindConnection = game.UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                keybindButton.Text = "Keybind: " .. tostring(input.KeyCode):split(".")[3]
                config.Keybinds[Table.Name] = tostring(input.KeyCode):split(".")[3]
                library.Modules[Table.Name].Keybind = Enum.KeyCode[config.Keybinds[Table.Name]]
                task.wait(0.06)
                saveConfig()
                keybindConnection:Disconnect()
            end)
        end)

		lib2.NewToggle = function(v)
			local Enabled = false

			if config.Toggles[v.Name .. "_" .. Table.Name] == nil then
				config.Toggles[v.Name .. "_" .. Table.Name] = {Enabled = false}
			end

			local textbutton2 = Instance.new("TextButton", dropdown)
			textbutton2.Size = UDim2.fromScale(1, 0.15)
			textbutton2.Position = UDim2.fromScale(0, 0)
			textbutton2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			textbutton2.BackgroundTransparency = 0.3
			textbutton2.BorderSizePixel = 1
			textbutton2.BorderColor3 = Color3.fromRGB(70, 70, 70)
			textbutton2.Text = v.Name
			textbutton2.Name = v.Name
			textbutton2.TextColor3 = Color3.fromRGB(255, 255, 255)

			local v2 = {}
			v2.Enabled = Enabled

			v2.ToggleButton = function(v3)
				if v3 then
					Enabled = v3
				else
					Enabled = not Enabled
				end
				v2.Enabled = Enabled
				task.spawn(function()
					v["Function"](Enabled)
				end)
				textbutton2.BackgroundColor3 = (textbutton2.BackgroundColor3 == Color3.fromRGB(60, 60, 60) and library.Color or Color3.fromRGB(60, 60, 60))
				config.Toggles[v.Name .. "_" .. Table.Name].Enabled = Enabled
				saveConfig()
			end

			textbutton2.MouseButton1Down:Connect(function()
				v2.ToggleButton()
			end)

			if config.Toggles[v.Name .. "_" .. Table.Name].Enabled then
				v2.ToggleButton()
			end

			return v2
		end

		lib2.NewPicker = function(v)
			local Enabled = false

			if config.Options[v.Name .. "_" .. Table.Name] == nil then
				config.Options[v.Name .. "_" .. Table.Name] = {Option = v.Options[1]}
			end

			local textbutton2 = Instance.new("TextButton", dropdown)
			textbutton2.Size = UDim2.fromScale(1, 0.15)
			textbutton2.Position = UDim2.fromScale(0, 0)
			textbutton2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			textbutton2.BackgroundTransparency = 0.3
			textbutton2.BorderSizePixel = 1
			textbutton2.BorderColor3 = Color3.fromRGB(70, 70, 70)
			textbutton2.Text = v.Name .. " - " .. v.Options[1]
			textbutton2.Name = v.Name
			textbutton2.TextColor3 = Color3.fromRGB(255, 255, 255)

			local v2 = {
				Option = v.Options[1]
			}

			local index = 0
			textbutton2.MouseButton1Down:Connect(function()
				index += 1

				if index > #v.Options then
					index = 1
				end

				v2.Option = v.Options[index]
				textbutton2.Text = v.Name .. " - " .. v2.Option

				config.Options[v.Name .. "_" .. Table.Name].Option = v.Options[index]
				saveConfig()
			end)

			textbutton2.MouseButton2Down:Connect(function()
				index -= 1

				if index < 1 then
					index = #v.Options
				end

				v2.Option = v.Options[index]

				textbutton2.Text = v.Name .. " - " .. v2.Option
				config.Options[v.Name .. "_" .. Table.Name].Option = v.Options[index]
				saveConfig()
			end)

			local option = config.Options[v.Name .. "_" .. Table.Name].Option
			v2.Option = option
			textbutton2.Text = v.Name .. " - " .. option

			return v2
		end

		textbutton.MouseButton1Down:Connect(function()
			lib2.ToggleButton()
		end)

		textbutton.MouseButton2Down:Connect(function()
			dropdown.Visible = not dropdown.Visible
			for i, v in pairs(modules:GetChildren()) do
				if v.Name == Table.Name then continue end
				if v:IsA("UIListLayout") then continue end
				v.Visible = not v.Visible
			end
		end)

		UserInputService.InputBegan:Connect(function(k, g)
			if g then return end
			if k == nil then return end
			if k.KeyCode == library.Modules[Table.Name].Keybind and k.KeyCode ~= Enum.KeyCode.Unknown then
				lib2.ToggleButton()
			end
		end)

		if config.Buttons[Table.Name].Enabled then
			lib2.ToggleButton()
		end

		return lib2
	end

	return lib
end


local colors = {
	["CottonCandy"] = {
		["Main"] = Color3.fromRGB(234, 149, 255),
		["Second"] = Color3.fromRGB(143, 253, 255)
	},
	["Purple"] = {
		["Main"] = Color3.fromRGB(191, 0, 255),
		["Second"] = Color3.fromRGB(119, 0, 255)
	},
	["Wave4Mc"] = {
		["Main"] = Color3.fromRGB(76, 118, 255),
		["Second"] = Color3.fromRGB(255, 255, 255)
	},
	["Hackerman"] = {
		["Main"] = Color3.fromRGB(0, 145, 17),
		["Second"] = Color3.fromRGB(255, 255, 255)
	},
	["Blurple"] = { -- Springs fav frfrfrfrfrfrfrfr :D
		["Main"] = Color3.fromRGB(124, 7, 191),
		["Second"] = Color3.fromRGB(66, 2, 227)
	},
}

Combat = library.NewWindow("Combat")
Blatant = library.NewWindow("Blatant")
Utility = library.NewWindow("Utility")
Visuals = library.NewWindow("Visuals")
World = library.NewWindow("World")

local weaponMeta = loadstring(game:HttpGet("https://raw.githubusercontent.com/ziankmodz/LOLJKA/main/weaponMeta", true))()
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/ziankmodz/LOLJKA/main/FunctionTable", true))()
local Utilities = loadstring(game:HttpGet("https://raw.githubusercontent.com/ziankmodz/LOLJKA/main/utils", true))()

local netmanaged = ReplicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged
local blockenginemanaged = ReplicatedStorage.rbxts_include.node_modules:WaitForChild("@easy-games"):WaitForChild("block-engine").node_modules:WaitForChild("@rbxts").net.out:WaitForChild("_NetManaged")

local getRemote = Functions.getRemote

local function hasItem(item)
	if inventory:FindFirstChild(item) then
		return true, 1
	end
	return false
end

local function getBestWeapon()
	local bestSword
	local bestSwordMeta = 0
	for i, sword in ipairs(weaponMeta) do
		local name = sword[1]
		local meta = sword[2]
		if meta > bestSwordMeta and hasItem(name) then
			bestSword = name
			bestSwordMeta = meta
		end
	end
	return inventory:FindFirstChild(bestSword)
end

local function getNearestPlayer(range)
	local nearest
	local nearestDist = math.huge
	for i,v in pairs(game.Players:GetPlayers()) do
		pcall(function()
			if v == LocalPlayer or v.Team == LocalPlayer.Team then return end
			if v.Character.Humanoid.health > 0 and (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude < nearestDist and (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude <= range then
				nearest = v
				nearestDist = (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude
			end
		end)
	end
	return nearest
end

local Define = true

local SetInvItem = getRemote("SetInvItem")
local function spoofHand(item)
	if hasItem(item) then
		SetInvItem:InvokeServer({
			["hand"] = inventory:WaitForChild(item)
		})
	end
end

local knitRecieved, knit
knitRecieved, knit = pcall(function()
	repeat task.wait()
		return debug.getupvalue(require(LocalPlayer.PlayerScripts.TS.knit).setup, 6)
	until knitRecieved
end)

local function getController(name)
	return knit.Controllers[name]
end

local AuraRemote = getRemote("SwordHit")

local viewmodel = Camera.Viewmodel.RightHand.RightWrist
local weld = viewmodel.C0
local oldweld = viewmodel.C0

local animRunning = true
local reverseTween

local animAuraTab = {}

local auraAnimations = {
	["FAST!!!"] = {
		{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Timer = 0.1},
        {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Timer = 0.1},
        {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(220), math.rad(100), math.rad(100)),Timer = 0.1},
	},
}

local funAnimations = {
	PLAYER_VACUUM_SUCK = "rbxassetid://9671620809",
	WINTER_BOSS_SPAWN = "rbxassetid://11843861791",
	GLUE_TRAP_FLYING = "rbxassetid://11466075174",
	VOID_DRAGON_TRANSFORM = "rbxassetid://10967424821",
	SIT_ON_DODO_BIRD = "http://www.roblox.com/asset/?id=2506281703",
	DODO_BIRD_FALL = "rbxassetid://7617326953",
	SWORD_SWING = "rbxassetid://7234367412",
}

local swingAnim
local auraConnection
Killaura = Combat.NewButton({
	Name = "Killaura",
	Function = function(callback)
		if callback then
			auraConnection = RunService.Heartbeat:Connect(function()
				local nearest = getNearestPlayer(22)

				if nearest ~= nil then
					if DragonAnimation.Enabled then
						netmanaged.DragonBreath:FireServer()
					end
					local nearestCharacter = nearest.Character
					local nearestPrimaryPartPosition = nearestCharacter.PrimaryPart.Position
					local selfPrimaryPartPosition = PrimaryPart.Position
					local weapon = getBestWeapon()

					if not ToolCheck.Enabled then
						spoofHand(weapon.Name)
					end

					task.spawn(function()
						AuraRemote:FireServer({
							chargedAttack = {
								chargeRatio = 0
							},
							entityInstance = nearestCharacter,
							validate = {
								raycast = {
									cameraPosition = CurrentCamera,
									cursorDirection = CFrame.LookVector
								},
								targetPosition = {
									value = nearestPrimaryPartPosition
								},
								selfPosition = {
									value = selfPrimaryPartPosition
								},
							},
							weapon = weapon
						})
					end)
				end
			end)

            repeat task.wait(.1)
            for i = 1, 35 do
            local KaDetector = Instance.new("Part", Workspace)
            KaDetector.Anchored = true
            KaDetector.Transparency = 1
end
            until Define == false

			task.spawn(function()
				repeat task.wait(0.2)
					if getNearestPlayer(20) ~= nil then
						pcall(function()
							local animation = auraAnimations["FAST!!!"]
							local allTime = 0
							task.spawn(function()
								if CustomAnimation.Enabled then
									animRunning = true
									for i,v in pairs(animation) do allTime += v.Timer end
									for i,v in pairs(animation) do
										local tween = game.TweenService:Create(viewmodel,TweenInfo.new(v.Timer),{C0 = oldweld * v.CFrame})
										tween:Play()
										task.wait(v.Timer - 0)
									end
									animRunning = false
									game.TweenService:Create(viewmodel,TweenInfo.new(1),{C0 = oldweld}):Play()
								end
							end)
							task.wait(allTime)
						end)
					end
				until (not Killaura.Enabled)
			end)
		else
			pcall(function()
				auraConnection:Disconnect()
			end)
		end
	end,
})

local animAuraTab = {}
for i,v in pairs(auraAnimations) do table.insert(animAuraTab,i) end

CustomAnimation = Killaura.NewToggle({
	Name = "Animations",
	Function = function() end
})
ToolCheck = Killaura.NewToggle({
	Name = "ToolCheck",
	Function = function() end
})
DragonAnimation = Killaura.NewToggle({Name = "DragonAnimation", Function = function() end})

table.insert(spawnConnections,function(char)
	task.wait(1)
	viewmodel = workspace.Camera.Viewmodel.RightHand.RightWrist
end)

local ProjectileFire = getRemote("ProjectileFire")
local function shoot(bow, pos)
	local args = {}
	local shootFormulaStart = pos + Vector3.new(0,2,0)
	local shootFormulaDirection = Vector3.new(0,-100,0)

	ProjectileFire:InvokeServer({
		[1] = bow,
		[2] = (bow.Name:lower():find("bow") and "arrow"),
		[3] = (bow.Name:lower():find("bow") and "arrow"),
		[4] = pos,
		[5] = shootFormulaStart,
		[6] = Vector3.new(0,-5,0),
		[7] = tostring(game:GetService("HttpService"):GenerateGUID(true)),
		[8] = {
			["drawDurationSeconds"] = 1,
			["shotId"] = tostring(game:GetService("HttpService"):GenerateGUID(false))
		},
		[9] =  workspace:GetServerTimeNow() - 0.045
	})
end

local function getAllBows()
	local bows = {}
	for i,v in pairs(inventory:GetChildren()) do
		if v.Name:find("bow") or v.Name:find("fireball") or v.Name:find("snowball") then
			table.insert(bows,v)
		end
	end
	return bows
end

Projectileaura = Combat.NewButton({
	Name = "Projectileaura",
	Function = function(callback)
		if callback then
			task.spawn(function()
				swingAnim = Instance.new("Animation")
				swingAnim.AnimationId = funAnimations.SWORD_SWING
				local track = Humanoid.Animator:LoadAnimation(swingAnim)
				repeat
					local target = getNearestPlayer(9e9)
					local rangeCheck = getNearestPlayer(2)
					local entity = target
					if target and rangeCheck == nil then
						local bows = getAllBows()
						for i,v in pairs(bows) do
							spoofHand(v.Name)
							task.wait()
							if v.Name == "fireball" or v.Name == "snowball" and not AllProjectiles.Enabled then
								continue
							end
							shoot(v,target.Character.PrimaryPart.Position)
							track:Play()
						end
					end
					task.wait()
				until (not Projectileaura.Enabled)
			end)
		end
	end,
})
AllProjectiles = Projectileaura.NewToggle({
	Name = "AllProjectiles",
	Function = function() end
})

local function shoot2(pos)
	local args = {
        [1] = {
            ["ProjectileRefId"] = tostring(game:GetService("HttpService"):GenerateGUID(true)),
            ["direction"] = Vector3.new(19.34561538696289, -41.82197952270508, -235.53485107421875),
            ["fromPosition"] = pos,
            ["initialVelocity"] = Vector3.new(19.34561538696289, -41.82197952270508, -235.53485107421875)
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("OwlFireProjectile"):InvokeServer(unpack(args))
end

OwlAimbot = Combat.NewButton({
	Name = "OwlAimbot",
	Function = function(callback)
		if callback then
			task.spawn(function()
                repeat
                    task.wait()
                    local target = getNearestPlayer(9e9)
                    if target then
                        task.wait(0)
                        shoot2(target.Character.PrimaryPart.Position)
                    end
                until not OwlAimbot.Enabled
            end)
        end
    end,
})

function setCameraToPlayer(target)
    local player = game.Players.LocalPlayer
    local camera = game.Workspace.CurrentCamera
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = target.Character.HumanoidRootPart.Position
        camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    end
end

AimAssist = Combat.NewButton({
	Name = "AimAssist",
	Function = function(callback)
		if callback then
            task.spawn(function()
                repeat task.wait(0)
                    local Entity = getNearestPlayer(20)
                    if Entity then
                        setCameraToPlayer(Entity)
                    end
                until (not AimAssist.Enabled)
            end)
        end
    end,
})

local chests = {}
for i,v in pairs(workspace:GetChildren()) do
	if v.Name == "chest" then
		table.insert(chests,v)
	end
end
Stealer = Blatant.NewButton({
	Name = "ChestStealer",
	Function = function(callback)
		if callback then
            task.spawn(function()
				repeat task.wait()
					task.wait(0.15)
					task.spawn(function()
						for i, v in pairs(chests) do
							local Magnitude = (v.Position - PrimaryPart.Position).Magnitude
							if Magnitude <= 30 then
								for _, item in pairs(v.ChestFolderValue.Value:GetChildren()) do
									if item:IsA("Accessory") then
										task.wait()
										game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("Inventory/ChestGetItem"):InvokeServer(v.ChestFolderValue.Value, item)
									end
								end
							end
						end
					end)
				until (not Stealer.Enabled)
			end)
		end
	end,
})

Gravity = Blatant.NewButton({
	Name = "Gravity",
	Function = function(callback)
		if callback then
            task.spawn(function()
				repeat task.wait()	
				workspace.Gravity = 72.6
		until (not Gravity.Enabled)
		workspace.Gravity = 196.2
        end)
    end
end
})

local countdownValue = 2.5
local countdownLabel = nil
local flycon = nil

-- Function to create UI
local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FlightModeUI"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local Frame_1 = Instance.new("Frame")
    Frame_1.Parent = ScreenGui
    Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_1.BackgroundTransparency = 0.8
    Frame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_1.BorderSizePixel = 0
    Frame_1.Position = UDim2.new(0.5, -116.5, 0.5, -51.5)
    Frame_1.Size = UDim2.new(0, 233, 0, 103)
    
    local UICorner_1 = Instance.new("UICorner")
    UICorner_1.Parent = Frame_1
    UICorner_1.CornerRadius = UDim.new(0, 20)
    
    countdownLabel = Instance.new("TextLabel")
    countdownLabel.Name = "CountdownLabel"
    countdownLabel.Parent = Frame_1
    countdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    countdownLabel.BorderSizePixel = 0
    countdownLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
    countdownLabel.Size = UDim2.new(0, 200, 0, 50)
    countdownLabel.Font = Enum.Font.LuckiestGuy
    countdownLabel.Text = string.format("%.1f", countdownValue)
    countdownLabel.TextScaled = true
    countdownLabel.TextSize = 14
    countdownLabel.TextWrapped = true
    
    local Frame_2 = Instance.new("Frame")
    Frame_2.Parent = ScreenGui
    Frame_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0.5, -77, 0.5, 20)
    Frame_2.Size = UDim2.new(0, 154, 0, 22)
    
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.Parent = Frame_2
    UICorner_2.CornerRadius = UDim.new(0, 30)
end

-- Function to remove UI
local function removeUI()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local flightModeUI = playerGui:FindFirstChild("FlightModeUI")
        if flightModeUI then
            flightModeUI:Destroy()
        end
    end
    countdownLabel = nil
end

-- Function to update countdown UI
local function updateCountdownUI(value)
    if countdownLabel then
        countdownLabel.Text = string.format("%.1f", value)
    end
end

-- Countdown function
local function countdown()
    while countdownValue > 0 do
        countdownValue = countdownValue - 0.1
        updateCountdownUI(countdownValue)
        wait(0.1)
    end
end

local countdownValue = 2.5
local countdownLabel = nil

local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FlightModeUI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local Frame_1 = Instance.new("Frame")
    Frame_1.Parent = ScreenGui
    Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_1.BackgroundTransparency = 0.8
    Frame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_1.BorderSizePixel = 0
    Frame_1.Position = UDim2.new(0.5, -116.5, 0.5, -51.5)
    Frame_1.Size = UDim2.new(0, 233, 0, 103)
    
    local UICorner_1 = Instance.new("UICorner")
    UICorner_1.Parent = Frame_1
    UICorner_1.CornerRadius = UDim.new(0, 20)
    
    countdownLabel = Instance.new("TextLabel")
    countdownLabel.Name = "CountdownLabel"
    countdownLabel.Parent = Frame_1
    countdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    countdownLabel.BorderSizePixel = 0
    countdownLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
    countdownLabel.Size = UDim2.new(0, 200, 0, 50)
    countdownLabel.Font = Enum.Font.LuckiestGuy
    countdownLabel.Text = string.format("%.1f", countdownValue)
    countdownLabel.TextScaled = true
    countdownLabel.TextSize = 14
    countdownLabel.TextWrapped = true
    
    local Frame_2 = Instance.new("Frame")
    Frame_2.Parent = ScreenGui
    Frame_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0.5, -77, 0.5, 20)
    Frame_2.Size = UDim2.new(0, 154, 0, 22)
    
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.Parent = Frame_2
    UICorner_2.CornerRadius = UDim.new(0, 30)
end

-- 删除UI的函数
local function removeUI()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local flightModeUI = playerGui:FindFirstChild("FlightModeUI")
        if flightModeUI then
            flightModeUI:Destroy()
        end
    end
    countdownLabel = nil
end

-- 更新倒计时的函数
local function updateCountdownUI(value)
    if countdownLabel then
        countdownLabel.Text = string.format("%.1f", value)
    end
end

local Flying = true

local function countdown()
    while Flying and countdownValue > 0 do
        countdownValue = countdownValue - 0.1
        updateCountdownUI(countdownValue)
        wait(0.1)
    end
end


local flycon
Fly = Blatant.NewButton({
	Name = "Fly",
	Function = function(callback)
		if callback then

			createUI() 

			task.spawn(function()
                countdown()
            end)

			flycon = RunService.Heartbeat:Connect(function()
				local velo = PrimaryPart.Velocity
				PrimaryPart.Velocity = Vector3.new(velo.X, 2.03, velo.Z)

				if UserInputService:IsKeyDown("Space") then
					PrimaryPart.Velocity = Vector3.new(velo.X, 44, velo.Z)
				end
				if UserInputService:IsKeyDown("LeftShift") then
					PrimaryPart.Velocity = Vector3.new(velo.X, -44, velo.Z)
				end
			end)
		else
			pcall(function()
				flycon:Disconnect()
				removeUI()
				countdownValue = 2.5
			end)
		end
	end,
})

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local PrimaryPart = Character:WaitForChild("HumanoidRootPart")
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local infFlyPart
local InfiniteFlyConnection

local function onCharacterAdded(newCharacter)
    Character = newCharacter
    PrimaryPart = Character:WaitForChild("HumanoidRootPart")
end

Player.CharacterAdded:Connect(onCharacterAdded)

local function onCharacterRemoving()
    if InfiniteFlyConnection then
        InfiniteFlyConnection:Disconnect()
    end
    if infFlyPart then
        infFlyPart:Destroy()
    end
    CurrentCamera.CameraSubject = Player.Character
end

Player.CharacterRemoving:Connect(onCharacterRemoving)

InfiniteFly = Blatant.NewButton({
	Name = "InfiniteFly",
	Function = function(callback)
		if callback then
            CreateNotification2("InfiniteFly", 2.2, "Teleport UP")
            infFlyPart = Instance.new("Part", workspace)
            infFlyPart.Anchored = true
            infFlyPart.CanCollide = true
            infFlyPart.CFrame = PrimaryPart.CFrame
			infFlyPart.Transparency = 1
            infFlyPart.Size = Vector3.new(0.5, 0.5, 0.5)
            PrimaryPart.CFrame += Vector3.new(0, 1000000, 0)
            CurrentCamera.CameraSubject = infFlyPart
            InfiniteFlyConnection = RunService.Heartbeat:Connect(function()
                if PrimaryPart.Position.Y < infFlyPart.Position.Y then
                    PrimaryPart.CFrame += Vector3.new(0, 1000000, 0)
                end

                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    infFlyPart.CFrame += Vector3.new(0, 0.45, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    infFlyPart.CFrame += Vector3.new(0, -0.45, 0)
                end

                infFlyPart.CFrame = CFrame.new(PrimaryPart.CFrame.X, infFlyPart.CFrame.Y, PrimaryPart.CFrame.Z)
            end)
        else
            pcall(function()
                InfiniteFlyConnection:Disconnect()
                for i = 1, 15 do
                    task.wait(0.01)
                    PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                    PrimaryPart.CFrame = infFlyPart.CFrame
                end
                infFlyPart:Destroy()
            end)
            CurrentCamera.CameraSubject = Character
        end
    end,
})

RootPartShow = InfiniteFly.NewToggle({
	Name = "ShowRoot",
	Function = function() end
})


local GroundHit = getRemote("GroundHit")
NoFall = Blatant.NewButton({
	Name = "NoFall",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
					GroundHit:FireServer()
				until (not NoFall.Enabled)
			end)
		end
	end,
})

local cloneref = cloneref or function(data: userdata) return data end;
local enchanttoggled  = false;
local getservice = function(service: string)
    return cloneref(game:FindService(service));
end;

local getrandomvalue = function(tab: table)
    return #tab > 0 and tab[math.random(1, #tab)] or ''
end;

local replicatedstorage = getservice('ReplicatedStorage');
local lplr = getservice('Players').LocalPlayer;
local inputservice = getservice('UserInputService');
local remote = replicatedstorage:WaitForChild('rbxts_include'):WaitForChild('node_modules'):WaitForChild('@rbxts'):WaitForChild('net'):WaitForChild('out'):WaitForChild('_NetManaged'):WaitForChild('RequestFortuneDoubleDown');
local effects = {
    'fire_3', 'forest_3', 'cloud_3', 'void_3', 'static_3', 'updraft_2', 
    'shield_gen_3', 'anti_knockback_2', 'rapid_regen_3', 'execute_3', 
    'wind_3', 'plunder_2', 'critical_strike_3', 'volley_3', 
    'grounded_3', 'clingy_3', 'life_steal_3', 'fortune_1'
}

if renderexploit then 
    pcall(task.cancel, renderexploit)
end;

renderexploit = task.spawn(function()
    repeat 
        task.wait()
        if not enchanttoggled then 
            continue
        end;
        for i,v in effects do 
            remote:FireServer({statusEffectType = v})
        end
        task.wait(0.8)
    until false;
end);

DupeExploit = Blatant.NewButton({
	Name = "DupeExploit",
	Function = function(callback)
		if callback then
            DupeExploit.Enabled = true
            enchanttoggled = callback
            task.spawn(function()
                repeat
                    task.wait(0.1)
                    
                    local cloneref = cloneref or function(data)
                        return data
                    end
                    
                    local getservice = function(service)
                        return cloneref(game:FindService(service))
                    end
                    
                    local getrandomvalue = function(tab)
                        return #tab > 0 and tab[math.random(1, #tab)] or ''
                    end
                    
                    local remote = getservice('ReplicatedStorage'):WaitForChild('rbxts_include'):WaitForChild('node_modules'):WaitForChild('@rbxts'):WaitForChild('net'):WaitForChild('out'):WaitForChild('_NetManaged'):WaitForChild('RequestFortuneCashOut')
                    remote:FireServer({
                        statusEffectType = 'fortune_1',
                        fortuneStacks = getrandomvalue({999999, 9e9})
                    })
                until not DupeExploit.Enabled
            end)
        else
        end
    end,
})

GodMode = Blatant.NewButton({
	Name = "MelodyGodMode",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					local args = {
                        [1] = {
                            ["healTarget"] = game.Players.LocalPlayer
                        }
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("PlayGuitar"):FireServer(unpack(args))
				until (not GodMode.Enabled)
			end)
		end
	end,
})

jellyfishExploit = Blatant.NewButton({
	Name = "jellyfishExploit",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
					local args = {
                        [1] = "electrify_jellyfish"
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"):WaitForChild("useAbility"):FireServer(unpack(args))
				until (not jellyfishExploit.Enabled)
			end)
		end
	end,
})

local function Invisfunc()
    if IsAlive(LocalPlayer) then
        LocalPlayer.Character.LowerTorso.CollisionGroup = "Participants"
        LocalPlayer.Character.UpperTorso.CollisionGroup = "Participants"
        local Animation = Instance.new("Animation")
        Animation.AnimationId = "rbxassetid://11360825341"
        local PlayerAnimation = LocalPlayer.Character.Humanoid.Animator:LoadAnimation(Animation)
        if PlayerAnimation then
            LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 3 / -2, 0)
            LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(2, 3, 1.1)

            PlayerAnimation.Priority = Enum.AnimationPriority.Action4
            PlayerAnimation.Looped = true
            PlayerAnimation:Play()
            PlayerAnimation:AdjustSpeed(0 / 10)
        end
    end
end



InvisibleExploit = Blatant.NewButton({
	Name = "InvisibleExploit",
	Function = function(callback)
		if callback then
            task.spawn(function()
                repeat task.wait(0.2)
            Invisfunc()

                until (not InvisibleExploit.Enabled)
            end)
        end
    end,
})

local damageboost = {}
local currenthp = 100
Speed = Blatant.NewButton({
	Name = "Speed",
	Function = function(callback)
		if callback then
			task.spawn(function()
				currenthp = LocalPlayer.Character.Humanoid.Health
				repeat task.wait(0.2)
                    LocalPlayer.Character.Humanoid.WalkSpeed = 23.2
					LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(v)
						task.spawn(function()
							if damageboost.Enabled then
								LocalPlayer.Character.Humanoid.WalkSpeed = 30
								task.wait(2)
								LocalPlayer.Character.Humanoid.WalkSpeed = 23.2
							end
						end)
						task.wait(0.1)
						currenthp = v
					end)
				until (not Speed.Enabled)
            end)
        end
	end,
})
damageboost = Speed.NewToggle({
	Name = 'Damage Boost',
	Function = function(call) end
})

FOV = Blatant.NewButton({
	Name = "FOV",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
                game.Workspace.CurrentCamera.FieldOfView = 135
				until (not FOV.Enabled)
			end)
		end
	end,
})

local function placeBlock(pos,block)
	local blockenginemanaged = game.ReplicatedStorage.rbxts_include.node_modules:WaitForChild("@easy-games"):WaitForChild("block-engine").node_modules:WaitForChild("@rbxts").net.out:WaitForChild("_NetManaged")
	local args = { [1] = { ['blockType'] = block, ['position'] = Vector3.new(pos.X / 3,pos.Y / 3,pos.Z / 3), ['blockData'] = 0 } }
	blockenginemanaged.PlaceBlock:InvokeServer(unpack(args))
end

local function getWool()
	for i,v in pairs(inventory:GetChildren()) do
		if v.Name:lower():find("wool") then
			return v.Name
		end
	end
end

local scaffoldRun
Scaffold = Blatant.NewButton({
	Name = "Scaffold",
	Function = function(callback)
		if callback then
			task.spawn(function()
				scaffoldRun = game["Run Service"].RenderStepped:Connect(function()
					if game.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
						local velo = lplr.Character.PrimaryPart.Velocity
						lplr.Character.PrimaryPart.Velocity = Vector3.new(velo.X,10,velo.Z)
					end
					local block = getWool()
					placeBlock((lplr.Character.PrimaryPart.CFrame + lplr.Character.PrimaryPart.CFrame.LookVector * 1) - Vector3.new(0,4.5,0),block)
					if not Scaffold.Enabled then return end
					placeBlock((lplr.Character.PrimaryPart.CFrame + lplr.Character.PrimaryPart.CFrame.LookVector * 2) - Vector3.new(0,4.5,0),block)
					if not Scaffold.Enabled then return end
					placeBlock((lplr.Character.PrimaryPart.CFrame + lplr.Character.PrimaryPart.CFrame.LookVector * 3) - Vector3.new(0,4.5,0),block)
				end)
			end)
		else
			pcall(function()
				scaffoldRun:Disconnect()
			end)
		end
	end,
})

InfiniteJump = Blatant.NewButton({
	Name = "InfiniteJump",
	Function = function(callback)
		if callback then
            local InfiniteJumpEnabled = true
            
            local function onJumpRequest()
                if InfiniteJumpEnabled then
                    local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState("Jumping")
                    end
                end
            end

            game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)
        else
            InfiniteJumpEnabled = false
        end
    end,
})


local ConsumeRemote = getRemote("ConsumeItem")
AutoConsume = Blatant.NewButton({
	Name = "AutoConsume",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					if hasItem("speed_potion") then
						ConsumeRemote:InvokeServer({
							["item"] = inventory:WaitForChild("speed_potion")
						})
					end
					if hasItem("pie") then
						ConsumeRemote:InvokeServer({
							["item"] = inventory:WaitForChild("pie")
						})
					end
				until (not AutoConsume.Enabled)
			end)
		end
	end,
})

AutoHeal = Blatant.NewButton({
	Name = "AutoHeal",
	Function = function(callback)
		if callback then
            task.spawn(function()
                repeat
                    task.wait()
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:FindFirstChildOfClass("Humanoid")

                    if humanoid and humanoid.Health < 75 then
                        if hasItem("apple") then
                            ConsumeRemote:InvokeServer({
                                ["item"] = inventory:WaitForChild("apple")
                            })
                        end
                    end
                until not AutoHeal.Enabled
            end)
        end
    end,
})

AutoUpgradeEra = Blatant.NewButton({
	Name = "AutoUpgradeEra",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
                    local args = {
                        [1] = {
                            ["era"] = "iron_era"
                        }
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("RequestPurchaseEra"):InvokeServer(unpack(args))

                    local args = {
                        [1] = {
                            ["era"] = "diamond_era"
                        }
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("RequestPurchaseEra"):InvokeServer(unpack(args))

                    local args = {
                        [1] = {
                            ["era"] = "emerald_era"
                        }
                    }
                    
                    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("RequestPurchaseEra"):InvokeServer(unpack(args))
				until (not AutoUpgradeEra.Enabled)
			end)
		end
	end,
})

local function Buystonesword()
    local args = {
        [1] = {
            ["shopItem"] = {
                ["ignoredByKit"] = {
                    [1] = "barbarian",
                    [2] = "dasher",
                    [3] = "frost_hammer_kit",
                    [4] = "tinker"
                },
                ["itemType"] = "stone_sword",
                ["price"] = 70,
                ["superiorItems"] = {
                    [1] = "iron_sword",
                },
                ["currency"] = "iron",
                ["amount"] = 1,
                ["lockAfterPurchase"] = true,
                ["category"] = "Combat",
                ["disabledInQueue"] = {
                    [1] = "tnt_wars"
                }
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem"):InvokeServer(unpack(args))
end

local function Buyironsword()
    local args = {
        [1] = {
            ["shopItem"] = {
                ["ignoredByKit"] = {
                    [1] = "barbarian",
                    [2] = "dasher",
                    [3] = "frost_hammer_kit",
                    [4] = "tinker"
                },
                ["itemType"] = "iron_sword",
                ["price"] = 70,
                ["superiorItems"] = {
                    [1] = "diamond_sword",
                },
                ["currency"] = "iron",
                ["amount"] = 1,
                ["lockAfterPurchase"] = true,
                ["category"] = "Combat",
                ["disabledInQueue"] = {
                    [1] = "tnt_wars"
                }
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem"):InvokeServer(unpack(args))
end

local function BuyDiamondsword()
    local args = {
        [1] = {
            ["shopItem"] = {
                ["ignoredByKit"] = {
                    [1] = "barbarian",
                    [2] = "dasher",
                    [3] = "frost_hammer_kit",
                    [4] = "tinker"
                },
                ["itemType"] = "diamond_sword",
                ["price"] = 70,
                ["superiorItems"] = {
                    [1] = "emerald_sword",
                },
                ["currency"] = "emerald",
                ["amount"] = 1,
                ["lockAfterPurchase"] = true,
                ["category"] = "Combat",
                ["disabledInQueue"] = {
                    [1] = "tnt_wars"
                }
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem"):InvokeServer(unpack(args))
end

local function BuyleatherArmor()
    local args = {
        [1] = {
            ["shopItem"] = {
                ["lockAfterPurchase"] = true,
                ["itemType"] = "leather_chestplate",
                ["price"] = 50,
                ["customDisplayName"] = "Leather Armor",
                ["superiorItems"] = {
                    [1] = "iron_chestplate"
                },
                ["currency"] = "iron",
                ["amount"] = 1,
                ["category"] = "Combat",
                ["ignoredByKit"] = {
                    [1] = "bigman",
                    [2] = "tinker"
                },
                ["spawnWithItems"] = {
                    [1] = "leather_helmet",
                    [2] = "leather_chestplate",
                    [3] = "leather_boots"
                },
                ["nextTier"] = "iron_chestplate"
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem"):InvokeServer(unpack(args))
end

local function BuyIronArmor()
    local args = {
        [1] = {
            ["shopItem"] = {
                ["lockAfterPurchase"] = true,
                ["itemType"] = "iron_chestplate",
                ["price"] = 120,
                ["prevTier"] = "leather_chestplate",
                ["customDisplayName"] = "Iron Armor",
                ["currency"] = "iron",
                ["ignoredByKit"] = {
                    [1] = "bigman",
                    [2] = "tinker"
                },
                ["category"] = "Combat",
                ["tiered"] = true,
                ["nextTier"] = "diamond_chestplate",
                ["spawnWithItems"] = {
                    [1] = "iron_helmet",
                    [2] = "iron_chestplate",
                    [3] = "iron_boots"
                },
                ["amount"] = 1
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem"):InvokeServer(unpack(args))
end

local function BuyDiamondArmor()
    local args = {
        [1] = {
            ["shopItem"] = {
                ["lockAfterPurchase"] = true,
                ["itemType"] = "Diamond_chestplate",
                ["price"] = 8,
                ["customDisplayName"] = "Diamond Armor",
                ["superiorItems"] = {
                    [1] = "iron_chestplate"
                },
                ["currency"] = "iron",
                ["amount"] = 1,
                ["category"] = "Combat",
                ["ignoredByKit"] = {
                    [1] = "bigman",
                    [2] = "tinker"
                },
                ["spawnWithItems"] = {
                    [1] = "diamond_helmet",
                    [2] = "diamond_chestplate",
                    [3] = "diamond_boots"
                },
                ["nextTier"] = "diamond_chestplate"
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem"):InvokeServer(unpack(args))
end

AutoBuy = Blatant.NewButton({
	Name = "AutoBuy",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.1)
					if hasItem("wood_sword") then
						Buystonesword()
					end
                    if hasItem("stone_sword") and not hasItem("iron_chestplate") and not hasItem("diamond_chestplate") and not hasItem("emerald_chestplate") then
                        BuyleatherArmor()
                    end
                    if hasItem("leather_chestplate") then
				        BuyIronArmor()
			        end
                    if hasItem("iron_sword") or hasItem("stone_sword") or hasItem("wood_sword") then
				        BuyDiamondsword()
			        end
                    if hasItem("iron_chestplate") then
				        BuyDiamondArmor()
			        end

				until (not AutoBuy.Enabled)
			end)
		end
	end,
})

ChatSpammer = Utility.NewButton({
	Name = "ChatSpammer",
	Function = function(callback)
		if callback then
			task.spawn(function()
			repeat task.wait(4)

                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("///nvl///", "All")
				task.wait(4)
				game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Break some beds with HvHClub // Nvl | HvHClub On Top", "All")
				task.wait(4)
				game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Get some wins with HvHClub //Nvl// | HvHClub On Top", "All")
                task.wait(4)
				game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("CocoSkid? Never heard of it | HvHClub On Top", "All")
                task.wait(4)
				game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Aether better than HvHClub | HvHClub On Top", "All")
					
				until (not ChatSpammer.Enabled)
			end)
        end
    end,
})

local player = game.Players.LocalPlayer
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local sayMessageRequest = replicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest

local function onPlayerDeath(deadPlayer)
    if deadPlayer.Team ~= player.Team then
        local messages = {
            "HvHClub On Top " .. deadPlayer.Name .. " ",
            "My gaming chair is too powerful " .. deadPlayer.Name .. " ",
            "I have a good gaming chair " .. deadPlayer.Name .. " ",
            "// Nvl //" .. deadPlayer.Name .. " ",
            " " .. deadPlayer.Name .. " ? Never heard of it!",
            "L " .. deadPlayer.Name .. " ",
            "Hahaha " .. deadPlayer.Name .. " "
        }
        local message = messages[math.random(1, #messages)] -- 随机选择一个消息
        sayMessageRequest:FireServer(message, "All")
    end
end

local function monitorPlayers()
    for _, otherPlayer in pairs(players:GetPlayers()) do
        if otherPlayer ~= player then
            local character = otherPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Died:Connect(function()
                        onPlayerDeath(otherPlayer)
                    end)
                end
            end

            otherPlayer.CharacterAdded:Connect(function(character)
                local humanoid = character:WaitForChild("Humanoid")
                humanoid.Died:Connect(function()
                    onPlayerDeath(otherPlayer)
                end)
            end)
        end
    end

    players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.Died:Connect(function()
                onPlayerDeath(newPlayer)
            end)
        end)
    end)
end

AutoToxic = Utility.NewButton({
	Name = "AutoToxic",
	Function = function(callback)
		if callback then
            task.spawn(function()
                monitorPlayers()
                wait(3)
                repeat task.wait()
                until (not AutoToxic.Enabled)
            end)
        end
    end,
})

AutoReport = Utility.NewButton({
	Name = "AutoReport",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
					-- 获取所有玩家的 PlayerId
local players = game:GetService("Players"):GetPlayers()

-- 创建一个空的参数表
local args = {}

-- 遍历所有玩家，除了本地玩家外，将每个玩家的 PlayerId 添加到参数表中
for _, player in ipairs(players) do if player ~= game.Players.LocalPlayer then table.insert(args, player.UserId) end end

-- 发送服务器请求
game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("ReportPlayer"):FireServer(unpack(args))

				until (not AutoReport.Enabled)
			end)
		end
	end,
})

local words = {
    ['gay'] = 'Bullying',
    ['trans'] = 'Bullying',
    ['lgbt'] = 'Bullying',
    ['lesbian'] = 'Bullying',
    ['suicide'] = 'Bullying',
    ['cum'] = 'Swearing',
    ['f@g0t'] = 'Bullying',
    ['cock'] = 'Swearing',
    ['penis'] = 'Swearing',
    ['furry'] = 'Bullying',
    ['furries'] = 'Bullying',
    ['dick'] = 'Swearing',
    ['nigger'] = 'Bullying',
    ['bible'] = 'Bullying',
    ['nigga'] = 'Bullying',
    ['cheat'] = 'Scamming',
    ['report'] = 'Bullying',
    ['niga'] = 'Bullying',
    ['bitch'] = 'Bullying',
    ['sex'] = 'Swearing',
    ['cringe'] = 'Bullying',
    ['trash'] = 'Bullying',
    ['allah'] = 'Bullying',
    ['dumb'] = 'Bullying',
    ['idiot'] = 'Bullying',
    ['kid'] = 'Bullying',
    ['clown'] = 'Bullying',
    ['bozo'] = 'Bullying',
    ['faggot'] = 'Bullying',
    ['autist'] = 'Bullying',
    ['autism'] = 'Bullying',
    ['get a life'] = 'Bullying',
    ['nolife'] = 'Bullying',
    ['no life'] = 'Bullying',
    ['adopted'] = 'Bullying',
    ['skill issue'] = 'Bullying',
    ['muslim'] = 'Bullying',
    ['gender'] = 'Bullying',
    ['parent'] = 'Bullying',
    ['islam'] = 'Bullying',
    ['christian'] = 'Bullying',
    ['noob'] = 'Bullying',
    ['retard'] = 'Bullying',
    ['burn'] = 'Bullying',
    ['stupid'] = 'Bullying',
    ['wthf'] = 'Swearing',
    ['pride'] = 'Bullying',
    ['mother'] = 'Bullying',
    ['father'] = 'Bullying',
    ['homo'] = 'Bullying',
    ['hate'] = 'Bullying',
    ['exploit'] = 'Scamming',
    ['hack'] = 'Scamming',
    ['download'] = 'Scamming',
    ['youtube'] = 'Offsite Links'
}

-- 创建报告通知函数
local function ReportPlayer(player, reason)
    CreateNotification2("AutoReport", 2.3, "Reported " .. player.Name .. " for " .. reason)
end

AutoReportV2 = Utility.NewButton({
	Name = "AutoReportV2",
	Function = function(callback)
		if callback then
            task.spawn(function()
                game.Players.PlayerAdded:Connect(function(player)
                    player.Chatted:Connect(function(message)
                        -- 检查消息中是否包含关键字
                        for keyword, reason in pairs(words) do
                            if string.find(message:lower(), keyword) then
                                -- 执行报告
                                ReportPlayer(player, reason)
                            end
                        end
                    end)
                end)
                repeat task.wait() until (not AutoReportV2.Enabled)
            end)
        end
    end,
})

ScytheDisabler = Utility.NewButton({
	Name = "ScytheDisabler",
	Function = function(callback)
		if callback then
            local Bypassmode = Bypassmode.Option
            CreateNotification("Scythe AC Disabler", 1.2, "Scythe AC Disabler has been enabled")
            task.spawn(function()
                repeat task.wait()
                    if Bypassmode == "Bypass" then
                        local args = {
                            [1] = {
                                ["direction"] = Vector3.new(0.46722307801246643, -1.769954627306447e-09, -0.8841394782066345)
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.ScytheDash:FireServer(unpack(args))
                     isEnabled = true

                    elseif Bypassmode == "Walkspeed" then
                        isEnabled = false
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 26
                        local args = {
                            [1] = {
                                ["direction"] = Vector3.new(0.46722307801246643, -1.769954627306447e-09, -0.8841394782066345)
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.ScytheDash:FireServer(unpack(args))
                    end
                until (not ScytheDisabler.Enabled)
                isEnabled = false
                CreateNotification("Scythe AC Disabler", 1.2, "Scythe AC Disabler has been disabled")
                resetSpeed()
            end)
        end
    end,
})
Bypassmode = ScytheDisabler.NewPicker({
	Name = "Mode",
	Options = {"Bypass", "Walkspeed"}
})

local function getGroupRank(plr:Player)
	return plr:GetRankInGroup(5774246)
end

local staffdetectorcon
StaffDetector = Utility.NewButton({
	Name = "StaffDetector",
	Function = function(callback)
		if callback then
			task.wait(1)

			staffdetectorcon = game.Players.PlayerAdded:Connect(function(plr)

				if getGroupRank(plr) >= 2 then
					CreateNotificationStaffDetector("StaffDetector", 30, "Staff " .. plr.Name .. " Has Joined The Game !!!")
					writefile("Staff_Detection_GroupID", plr.Name)
				end
			end)
		else
			pcall(function()
				staffdetectorcon:Disconnect()
			end)
		end
	end,
})

local hackerdetectorcon
local heightCheckConnection
local notifiedPlayers = {} 

HackerDetector = Utility.NewButton({
	Name = "HackerDetector",
	Function = function(callback)
		if callback then
            task.wait(1)

            local function checkPlayerHeight(plr)
                if plr and plr.Character then
                    plr.CharacterAdded:Connect(function(character)
                        task.wait(1)
                        while character and character:FindFirstChild("HumanoidRootPart") do
                            local rootPart = character:FindFirstChild("HumanoidRootPart")
                            if rootPart and rootPart.Position.Y > 999 then
                                if not notifiedPlayers[plr.Name] then
                                    sound = Instance.new("Sound",workspace)
                                    sound.Name = "Noooooooooooooooot noooooooooooooooooooooooot"
                                    sound.SoundId = "rbxassetid://7383525713"
                                    sound:Play()
                                    CreateNotification2("HackerDetector", 30, plr.Name .. " is using InfiniteFly!")
                                    writefile("HackerDetector_log", plr.Name)
                                    notifiedPlayers[plr.Name] = true
                                end
                            end
                            task.wait(1)
                        end
                    end)
                end
            end

            for _, plr in pairs(game.Players:GetPlayers()) do
                checkPlayerHeight(plr)
            end

            hackerdetectorcon = game.Players.PlayerAdded:Connect(function(plr)
                checkPlayerHeight(plr)
            end)

            heightCheckConnection = game:GetService("RunService").Stepped:Connect(function()
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart.Position.Y > 999 then
                            if not notifiedPlayers[plr.Name] then
                                sound = Instance.new("Sound",workspace)
                                sound.Name = "Noooooooooooooooot noooooooooooooooooooooooot"
                                sound.SoundId = "rbxassetid://7383525713"
                                sound:Play()
								CreateNotification2("HackerDetector", 30, plr.Name .. " is using InfiniteFly!")
                                writefile("HackerDetector_log", plr.Name)
                                notifiedPlayers[plr.Name] = true
                            end
                        end
                    end
                end
            end)
        else
            
            if hackerdetectorcon then
                hackerdetectorcon:Disconnect()
            end
            if heightCheckConnection then
                heightCheckConnection:Disconnect()
            end
            notifiedPlayers = {}
        end
    end,
})

function IsAlive(Player)
	Player = Player or LocalPlayer

	if not Player.Character then return false end
	if not Player.Character:FindFirstChild("Humanoid") then return false end
	if Player.Character:GetAttribute("Health") <= 0 then return false end
	if not Player.Character.PrimaryPart then return false end	

	return true
end	

local function GetServerPosition(Position)
	local X = math.round(Position.X / 3)
	local Y = math.round(Position.Y / 3)
	local Z = math.round(Position.Z / 3)

	return Vector3.new(X, Y, Z)
end

function FindNearestBed(MaxDistance)
	local MaxDistance = MaxDistance or math.huge
	local NearestBed = nil

	for i, v in next, CollectionService:GetTagged("bed")do
		if v:FindFirstChild("Blanket").BrickColor ~= LocalPlayer.Team.TeamColor then			
			if v:GetAttribute("BedShieldEndTime") then 				
				if v:GetAttribute("BedShieldEndTime") < Workspace:GetServerTimeNow() then
					local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

					if Distance < MaxDistance then
						MaxDistance = Distance
						NearestBed = v
					end
				end
			end

			if not v:GetAttribute("BedShieldEndTime") then
				local Distance = (v.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude

				if Distance < MaxDistance then
					MaxDistance = Distance
					NearestBed = v
				end
			end
		end
	end

	return NearestBed
end

local DamageBlockRemote = game.ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@easy-games"):WaitForChild("block-engine"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("DamageBlock")
local NearestBedFound = false
local CanSeeNearestBed = false

local function Nuker(NearestBed)
	task.spawn(function()
		if NearestBed then
			NearestBedFound = true

			local NukerRaycastParameters = RaycastParams.new()
			local TargetBlock = nil

			NukerRaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
			NukerRaycastParameters.FilterDescendantsInstances = {LocalPlayer.Character}
			NukerRaycastParameters.IgnoreWater = true

			local RaycastResult = game.Workspace:Raycast(NearestBed.Position + Vector3.new(0, 30, 0), Vector3.new(0, -35, 0), NukerRaycastParameters)

			task.spawn(function()
				if RaycastResult then
					if RaycastResult.Instance then
						TargetBlock = RaycastResult.Instance
					end

					if not RaycastResult.Instance then
						TargetBlock = NearestBed
					end				

					DamageBlockRemote:InvokeServer({
						blockRef = {
							blockPosition = GetServerPosition(TargetBlock.Position)
						},

						hitPosition = GetServerPosition(TargetBlock.Position),
						hitNormal = GetServerPosition(TargetBlock.Position)
					})
				end
			end)			

			task.spawn(function()
				local _, Value = CurrentCamera:WorldToScreenPoint(NearestBed.Position)

				CanSeeNearestBed = Value
			end)
		end
	end)
end

BedNuker = Utility.NewButton({
	Name = "BedNuker",
	Function = function(callback)
		if callback then
            task.spawn(function()
                repeat
                    task.wait(0.1)

                    if IsAlive(LocalPlayer) then
                        local NearestBed = FindNearestBed(30)

                        if NearestBed then
                            Nuker(NearestBed)
                        end
                    end
                until not BedNuker.Enabled
            end)
        end
    end
})

local ESPboxes = {}
local RunService = game:GetService("RunService")

local function isVisible(targetPos)
    local targetScreenPos, onScreen = workspace.Camera:WorldToScreenPoint(targetPos)
    return onScreen and targetScreenPos.Z > 0
end

local function CreateOutline(Player)
    local BillBoard = Instance.new("BillboardGui")

    BillBoard.Size = UDim2.new(4, 0, 4, 0)
    BillBoard.AlwaysOnTop = true
    BillBoard.Name = "Esp"

    local Frame = Instance.new("Frame")

    Frame.Size = UDim2.new(1, 0, 1.5, 0)
    Frame.Position = UDim2.new(0, 0, -Player.Character.LowerTorso.Size.Y / 2 or -Player.PrimaryPart.Size.Y / 2, 0)
    Frame.BackgroundTransparency = 1

    local Stroke = Instance.new("UIStroke")

    Stroke.Thickness = 1.5
    Stroke.Color = Color3.new(1, 0.666667, 0)
    Stroke.Transparency = 0

    task.spawn(function()
        repeat
            task.wait(0.001)
            Stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        until not Stroke
    end)

    local UICorner = Instance.new("UICorner")

    UICorner.Parent = Frame
    UICorner.CornerRadius = UDim.new(0, 3)

    Stroke.Parent = Frame
    Frame.Parent = BillBoard
    BillBoard.Parent = Player.Character.PrimaryPart

    ESPboxes[Player] = BillBoard
end

local function RemoveOutline(Player)
    if ESPboxes[Player] then
        ESPboxes[Player]:Destroy()
        ESPboxes[Player] = nil
    end
end

local function updateESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = player.Character.HumanoidRootPart.Position
            if isVisible(targetPosition) then
                if not ESPboxes[player] then
                    CreateOutline(player)
                end
            else
                RemoveOutline(player)
            end
        else
            RemoveOutline(player)
        end
    end
end

ESP = Visuals.NewButton({
	Name = "ESP",
	Function = function(callback)
		if callback then
            RunService:BindToRenderStep("ESPUpdate", Enum.RenderPriority.Camera.Value + 1, updateESP)
        else
            RunService:UnbindFromRenderStep("ESPUpdate")
            for _, player in pairs(game.Players:GetPlayers()) do
                RemoveOutline(player)
            end
        end
    end,
})

local lighting = game:GetService("Lighting")

Night = Visuals.NewButton({
	Name = "Night",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
					lighting.ClockTime = 0 
					lighting.Brightness = 2  
					lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)  
				until (not Night.Enabled)
				lighting.ClockTime = 14
			end)
		end
	end,
})

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

Atmosphere = Visuals.NewButton({
	Name = "Atmosphere",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)

local existingEffect = camera:FindFirstChildOfClass("ColorCorrectionEffect")
if existingEffect then
    existingEffect:Destroy()
end


local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Parent = camera
colorCorrection.TintColor = Color3.fromRGB(138, 43, 226)  
colorCorrection.Brightness = 0  
colorCorrection.Contrast = 0  
				until (not Atmosphere.Enabled)
				
local existingEffect = camera:FindFirstChildOfClass("ColorCorrectionEffect")
if existingEffect then
    existingEffect:Destroy()
                end
			end)
		end
	end,
})

Trail = Visuals.NewButton({
	Name = "Trail",
	Function = function(callback)
		if callback then
            local ar=Instance.new("Trail")local as=Instance.new("Attachment")local at=Instance.new("Attachment")ar.Parent=game.Players.LocalPlayer.Character.HumanoidRootPart;color1=Color3.new(15/255,127/255,254/255)color2=Color3.new(255/255,255/255,255/25)ar.Color=ColorSequence.new(color1,color2)as.Parent=game.Players.LocalPlayer.Character.HumanoidRootPart;at.Parent=game.Players.LocalPlayer.Character.HumanoidRootPart;ar.Attachment0=as;ar.Attachment1=at;ar.Enabled=true;as.Position=Vector3.new(.1,-2.5,0)at.Position=Vector3.new(-.1,-2.5,0)
        end
    end
})

AntiVoid = World.NewButton({
	Name = "AntiVoid",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
					local player = game.Players.LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					
					local function spawnPartUnderPlayer()
						local part = game.Workspace:FindFirstChild("JumpPart")
					
						if not part then
							part = Instance.new("Part")
							part.Name = "JumpPart"
							part.Size = Vector3.new(2048, 1, 2048)
							part.Anchored = true
							local playerPosition = character.PrimaryPart.Position
							part.Position = Vector3.new(playerPosition.X, playerPosition.Y - 18, playerPosition.Z)
							part.BrickColor = BrickColor.new("Bright violet")
							part.Transparency = 0.7
							part.Parent = game.Workspace
						end
					
						local function onTouch(hit)
							local character = hit.Parent
							local humanoid = character and character:FindFirstChildOfClass("Humanoid")
							if humanoid then
								local jumpVelocity = Vector3.new(0, math.sqrt(2 * 100 * 196.25) * 0.5, 0)
								humanoid.RootPart.Velocity = jumpVelocity
							end
						end
					
						part.Touched:Connect(onTouch)
					
						function partDestroy()
							if part then
								part:Destroy()
								part = nil
							end
						end
					end
					
					spawnPartUnderPlayer()
					
					
				until (not AntiVoid.Enabled)
				partDestroy()
			end)
		end
	end,
})

local function teleportToRandomPlayer()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    wait(0.2)

    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local lplr = Players.LocalPlayer

    local function checkHealth()
        repeat
            wait()
        until lplr.Character and lplr.Character:FindFirstChild("Humanoid") and lplr.Character.Humanoid.Health == 100

        -- 停止偵測後執行以下代碼
        local availablePlayers = {}

        for _, player in pairs(Players:GetPlayers()) do
            if player.TeamColor ~= lplr.TeamColor then
                table.insert(availablePlayers, player)
            end
        end

        if #availablePlayers > 0 then
            local selectedPlayer = availablePlayers[math.random(1, #availablePlayers)]
            local part = selectedPlayer.Character.HumanoidRootPart
            local duration = 0.4 -- tp speed

            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = part.CFrame * CFrame.new(0, 5, 0)})
            tween:Play()
            tween.Completed:Wait()
        else
            print("There are no available players with different team color.")
        end
    end

    checkHealth()
end


local function moveToDifferentTeamPlayer()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")

    local lplr = Players.LocalPlayer

    game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
    wait(6.3)

    local availablePlayers = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player.TeamColor ~= lplr.TeamColor then
            table.insert(availablePlayers, player)
        end
    end

    if #availablePlayers > 0 then
        local selectedPlayer = availablePlayers[math.random(1, #availablePlayers)]
        local part = selectedPlayer.Character.HumanoidRootPart
        local duration = 0.4

        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)

        local moveTween = TweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = part.CFrame * CFrame.new(0, 5, 0)})
        moveTween:Play()
        moveTween.Completed:Wait()
    else
        print("There are no available players with different team color.")
    end
end

local tppp = false

RecallPlayerTp = World.NewButton({
	Name = "RecallPlayerTp",
	Function = function(callback)
		if callback then
            task.spawn(function()
                repeat
                    task.wait()
                    moveToDifferentTeamPlayer()
                until (not tppp)
            end)
        else
           
        end
    end,
})

DeathPlayerTp = World.NewButton({
	Name = "DeathPlayerTp",
	Function = function(callback)
		if callback then
            task.spawn(function()
                repeat
                    task.wait()
                    teleportToRandomPlayer()
                until (not tppp)
            end)
        else
            
        end
    end,
})

local function getfireball()
	local bows = {}
	for i,v in pairs(inventory:GetChildren()) do
		if v.Name:find("fireball") then
			table.insert(bows,v)
		end
	end
	return bows
end

local function getfireball()
	local bows = {}
	for i,v in pairs(inventory:GetChildren()) do
		if v.Name:find("fireball") then
			table.insert(bows,v)
		end
	end
	return bows
end

local lplr = game.GetService(game, 'Players').LocalPlayer;
local inventory = workspace[lplr.Name].InventoryFolder.Value;
local replicatedstorage = game.GetService(game, 'ReplicatedStorage');
local httpservice = game.GetService(game, 'HttpService');
local projectilefire = replicatedstorage.rbxts_include.node_modules['@rbxts'].net.out._NetManaged.ProjectileFire;
local oldpart = lplr.Character.PrimaryPart;
local newpart = lplr.Character.PrimaryPart;
local oldgrav = workspace.Gravity;
LongJump = World.NewButton({
	Name = "LongJump",
	Function = function(callback)
		if callback then
            if inventory.fireball then
				spoofHand("fireball")
				Speed.ToggleButton(false)
				task.wait(0.1)
                local stopped = false
                print('please walk to start longjump.')
				CreateNotification2("Longjump", 4, "Please walk to start longjump.")
                lplr.Character.Humanoid.WalkSpeed = 1
                repeat task.wait(2) until lplr.Character.Humanoid.MoveDirection ~= Vector3.zero
                projectilefire:InvokeServer(unpack({
                    [1] = inventory.fireball,
                    [2] = 'fireball',
                    [3] = 'fireball',
                    [4] = lplr.Character.PrimaryPart.Position,
                    [5] = (lplr.Character.PrimaryPart.Position + Vector3.new(0,-2,0)),
                    [6] = Vector3.new(0,-5,0),
                    [7] = httpservice:GenerateGUID(true),
                    [8] = {
                        drawDurationSeconds = 1,
                        shotId = httpservice:GenerateGUID(false)
                    },
                    [9] =  workspace:GetServerTimeNow() - 0.045
                }))
                task.wait(0.3)
				Fly.ToggleButton(true)
                lplr.Character.Humanoid.WalkSpeed = 50
                task.wait(2.1)
                lplr.Character.Humanoid.WalkSpeed = 23
				LongJump.ToggleButton(false)
				task.wait(0.2)
				Fly.ToggleButton(false)
				removeUI()
				removeUI()
                stopped = true
			else
				CreateNotification2("Longjump", 3, "Requires a fireball.")
            end
        end
    end,
})
HannahExploit = World.NewButton({
    Name = "HannahExploit",
    Function = function(callback)
        if callback then
            repeat wait()
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local HannahPromptTrigger = game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("NetManaged"):WaitForChild("HannahPromptTrigger")

                for  player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and (player.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude <= 20 then
                        local args = {
                            [1] = {
                                ["user"] = LocalPlayer,
                                ["victimEntity"] = player.Character
                            }
                        }
                        HannahPromptTrigger:InvokeServer(unpack(args))
                    end
                end
            until not HannahExploit.Enabled
        end
    end
})

FastFall = Blatant.NewButton({
	Name = "FastFall",
	Function = function(callback)
		if Character and PrimaryPart then
            if callback then
                if FallMode.Option == "Velocity" then
                    PrimaryPart.Velocity = Vector3.new(0, -999, 0)
                elseif FallMode.Option == "Gravity" then
                    workspace.Gravity = 999
                end
            else
                workspace.Gravity = 196.2
            end
		end
	end,
})
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    PrimaryPart = newCharacter:WaitForChild("PrimaryPart")
    if not FastFall.Enabled then
        workspace.Gravity = 196.2
    end
end)

LocalPlayer.CharacterRemoving:Connect(function()
    Character = nil
    PrimaryPart = nil
    workspace.Gravity = 196.2
end)

FallMode = FastFall.NewPicker({
    Name = "Mode",
    Options = {"Velocity", "Gravity"}
})

local TweenService = game:GetService("TweenService")
local NeonWaterMark = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

NeonWaterMark.Name = "NeonWaterMark"
NeonWaterMark.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
NeonWaterMark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NeonWaterMark.ResetOnSpawn = false

TextLabel.Parent = NeonWaterMark
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.Size = UDim2.new(0.2, 0, 0.15, 0)
TextLabel.Font = Enum.Font.RobotoMono
TextLabel.Text = "hvh.club discord.gg/nvl"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 28.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Add UITextSizeConstraint for dynamic text sizing
UITextSizeConstraint.MaxTextSize = 28
UITextSizeConstraint.MinTextSize = 14
UITextSizeConstraint.Parent = TextLabel

local function changeColor()
    local rainbowColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    local info = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(TextLabel, info, {TextColor3 = rainbowColor})
    tween:Play()
end

while true do
    changeColor()
    wait(1)
end
