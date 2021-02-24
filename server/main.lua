ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local item_prices = {}
for k, v in pairs(Config.Items) do
	item_prices[v.item] = v.price
end

RegisterNetEvent("robberyshop:sellItem", item)
AddEventHandler("robberyshop:sellItem", function(item)
	local xPlayer = ESX.GetPlayerFromId(source)

	if item_prices[item] and xPlayer.getInventoryItem(item) then
		if xPlayer.getInventoryItem(item).count >= 1 then -- Checks to ensure the player has that item
			xPlayer.removeInventoryItem(item, 1) -- Removes item
			xPlayer.addMoney(item_prices[item]) -- Adds the money
		else
			xPlayer.showNotification("~r~[ERROR]~w~ You do not have that item to sell", false, true, 90) -- Shows notification
		end
	else
		xPlayer.showNotification("~r~[ERROR]~w~ The item doesn't seem to exist in the config", false, true, 90) -- Shows notification
	end
end)