ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("robberyshop:sellItem", item, Sellprice)

AddEventHandler("robberyshop:sellItem", function(item, Sellprice)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem(item).count >= 1 then -- Checks to ensure the player has that item
		xPlayer.removeInventoryItem(item, 1) -- Removes item
		xPlayer.addMoney(Sellprice) -- Adds the money
	else
		xPlayer.showNotification("~r~[ERROR]~w~ You do not have that item to sell", false, true, 90) -- Shows notification
	end
end)