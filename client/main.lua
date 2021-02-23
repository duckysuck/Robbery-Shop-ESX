ESX              = nil
local PlayerData = {}
local isNear = false
local isMenuOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded') --ESX Player Loaded Event
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob') --ESX Set Player Job Event
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function() --Checks to see if player is near the coords and if so, displays the text.
	local location = Config.Location
	local ped = PlayerPedId()
	while true do
		Citizen.Wait(4)
		if isNear then
			DrawMarker(25, location.x, location.y, location.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.0, 255, 255, 255, 155, false, false, 2, false)
			Draw3DText(location.x, location.y, location.z, "Press ~y~[E]~w~ to sell items", 0.4)
			if Vdist(GetEntityCoords(ped), Config.Location) < 1 and IsControlJustReleased(1,38) then --Checks to see if player hits E while near the text
				OpenMenu()
			end
		end
	end
end)

Citizen.CreateThread(function() --Sets near the sell point to either true or false
	local ped = PlayerPedId()
	while true do
		local coords = GetEntityCoords(ped)
		Citizen.Wait(500)
		if Vdist(coords, Config.Location) < Config.Distance then
			isNear = true
		else
			isNear = false
		end
	end
end)

-- Sell Menu Options
local options = {
	{label = "Laptop", value = 'laptop'},
	{label = "Phone", value = 'phone'},
	{label = "Saffron", value = 'saffron'},
	{label = "Speaker", value = 'speaker'},
	{label = "Coke Pouch", value = 'coke_pouch'},
	{label = "Diamond", value = 'diamond'},
	{label = "Toothpaste", value = 'toothpaste'}
}

function OpenMenu() --OPen the sell menu
	isMenuOpen = true
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title    = "Sell Items",
		align    = "left",
		elements = options
	}, function(data, menu)
		isMenuOpen = false
		
		if data.current.value == "laptop" then
			local item = "laptop"
			local price = Config.LaptopPrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
		if data.current.value == "phone" then
			local item = "phone"
			local price = Config.PhonePrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
		if data.current.value == "saffron" then
			local item = "saffron"
			local price = Config.SaffronPrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
		if data.current.value == "speaker" then
			local item = "speaker"
			local price = Config.SpeakerPrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
		if data.current.value == "coke_pouch" then
			local item = "coke_pooch"
			local price = Config.CokePrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
		if data.current.value == "diamond" then
			local item = "diamond"
			local price = Config.DiamondPrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
		if data.current.value == "toothpaste" then
			local item = "toothpaste"
			local price = Config.ToothpastePrice
			TriggerServerEvent("robberyshop:sellItem", item, price)
		end
	end,
	function(data, menu)
		menu.close()
		isMenuOpen = false
	end)
end

function Draw3DText(x, y, z, text, scale) --Function to draw 3D text
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 215)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 700
	DrawRect(_x, _y + 0.0150, 0.06 + factor, 0.03, 41, 11, 41, 100)
end