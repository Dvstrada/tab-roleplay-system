local Players = {}

-- Initialize player data on connection
AddEventHandler('playerConnecting', function()
    local src = source
    Players[src] = {
        bank = Config.InitialBankBalance,
        job = 'unemployed',
        organization = nil,
        gang = nil
    }
end)

AddEventHandler('playerDropped', function()
    local src = source
    Players[src] = nil
end)

-- Send bank balance to client
RegisterNetEvent('rp:getBank')
AddEventHandler('rp:getBank', function()
    local src = source
    local balance = Players[src] and Players[src].bank or 0
    TriggerClientEvent('rp:bankBalance', src, balance)
end)

-- Deposit money into bank
RegisterNetEvent('rp:deposit')
AddEventHandler('rp:deposit', function(amount)
    local src = source
    amount = tonumber(amount)
    if amount and amount > 0 then
        local player = Players[src]
        if player then
            player.bank = player.bank + amount
            TriggerClientEvent('rp:bankBalance', src, player.bank)
        end
    end
end)

-- Withdraw money from bank
RegisterNetEvent('rp:withdraw')
AddEventHandler('rp:withdraw', function(amount)
    local src = source
    amount = tonumber(amount)
    if amount and amount > 0 then
        local player = Players[src]
        if player and player.bank >= amount then
            player.bank = player.bank - amount
            TriggerClientEvent('rp:bankBalance', src, player.bank)
        end
    end
end)

-- Send list of available jobs
RegisterNetEvent('rp:getJobs')
AddEventHandler('rp:getJobs', function()
    local src = source
    TriggerClientEvent('rp:jobsList', src, Config.Jobs)
end)

-- Change player's job
RegisterNetEvent('rp:setJob')
AddEventHandler('rp:setJob', function(jobName)
    local src = source
    local player = Players[src]
    if player and Config.Jobs[jobName] then
        player.job = jobName
        TriggerClientEvent('rp:jobChanged', src, jobName)
    end
end)

-- Send a random dealer location and item list
RegisterNetEvent('rp:requestDealer')
AddEventHandler('rp:requestDealer', function()
    local src = source
    local idx = math.random(#Config.Dealer.locations)
    local loc = Config.Dealer.locations[idx]
    TriggerClientEvent('rp:dealerLocation', src, loc, Config.Dealer.items)
end)

-- Send available garage vehicles (filtered by job if required)
RegisterNetEvent('rp:getGarageVehicles')
AddEventHandler('rp:getGarageVehicles', function()
    local src = source
    local player = Players[src]
    local vehicles = {}
    for _,v in ipairs(Config.GarageVehicles) do
        if not v.job or (player and player.job == v.job) then
            table.insert(vehicles, v)
        end
    end
    TriggerClientEvent('rp:garageVehicles', src, vehicles)
end)

-- Purchase vehicle from dealership or garage
RegisterNetEvent('rp:purchaseVehicle')
AddEventHandler('rp:purchaseVehicle', function(model, price)
    local src = source
    price = tonumber(price)
    local player = Players[src]
    if player and price and player.bank >= price then
        player.bank = player.bank - price
        TriggerClientEvent('rp:bankBalance', src, player.bank)
        TriggerClientEvent('rp:vehiclePurchased', src, model)
    end
end)

-- Purchase property
RegisterNetEvent('rp:purchaseProperty')
AddEventHandler('rp:purchaseProperty', function(propertyId)
    local src = source
    local player = Players[src]
    for _,prop in ipairs(Config.Properties) do
        if prop.id == propertyId then
            if player.bank >= prop.price then
                player.bank = player.bank - prop.price
                -- In a full implementation we would save ownership in a database
                TriggerClientEvent('rp:bankBalance', src, player.bank)
                TriggerClientEvent('rp:propertyPurchased', src, prop)
            end
            break
        end
    end
end)

-- Create a new business organization
RegisterNetEvent('rp:createOrganization')
AddEventHandler('rp:createOrganization', function(name)
    local src = source
    local player = Players[src]
    if player and player.bank >= Config.OrganizationCreationPrice then
        player.bank = player.bank - Config.OrganizationCreationPrice
        Config.Organizations.business[name] = { label = name, ranks = { [1] = 'Owner' } }
        player.organization = name
        TriggerClientEvent('rp:bankBalance', src, player.bank)
        TriggerClientEvent('rp:organizationCreated', src, name)
    end
end)

-- Create a new gang
RegisterNetEvent('rp:createGang')
AddEventHandler('rp:createGang', function(name)
    local src = source
    local player = Players[src]
    if player and player.bank >= Config.GangCreationPrice then
        player.bank = player.bank - Config.GangCreationPrice
        Config.Organizations.gangs[name] = { label = name, ranks = { [1] = 'Leader' } }
        player.gang = name
        TriggerClientEvent('rp:bankBalance', src, player.bank)
        TriggerClientEvent('rp:gangCreated', src, name)
    end
end)
