-- Client script for roleplay system integrated with LSPD Tab menu
local playerRank = 0
local playerJob = 'unemployed'

-- Key mapping to open the Tab menu (same as LSPD)
RegisterKeyMapping('openTabMenu', 'Abrir men\u00fa Tab', 'keyboard', 'TAB')

RegisterCommand('openTabMenu', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'openRPMenu'})
end)

-- Listen for bank balance update
RegisterNetEvent('rp:bankBalance')
AddEventHandler('rp:bankBalance', function(balance)
    SendNUIMessage({action='bankBalance', balance=balance})
end)

-- Listen for job change
RegisterNetEvent('rp:jobChanged')
AddEventHandler('rp:jobChanged', function(jobName)
    playerJob = jobName
    SendNUIMessage({action='jobChanged', job=jobName})
end)

-- Listen for garage vehicles list
RegisterNetEvent('rp:garageVehicles')
AddEventHandler('rp:garageVehicles', function(vehicles)
    SendNUIMessage({action='garageVehicles', vehicles=vehicles})
end)

-- Listen for property purchase result
RegisterNetEvent('rp:propertyPurchased')
AddEventHandler('rp:propertyPurchased', function(propertyId)
    SendNUIMessage({action='propertyPurchased', propertyId=propertyId})
end)

-- Listen for organization and gang events
RegisterNetEvent('rp:organizationCreated')
AddEventHandler('rp:organizationCreated', function(name)
    SendNUIMessage({action='organizationCreated', name=name})
end)

RegisterNetEvent('rp:gangCreated')
AddEventHandler('rp:gangCreated', function(name)
    SendNUIMessage({action='gangCreated', name=name})
end)

-- NUI callbacks from UI
RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
    TriggerServerEvent('rp:deposit', data.amount)
    cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
    TriggerServerEvent('rp:withdraw', data.amount)
    cb('ok')
end)

RegisterNUICallback('getJobs', function(_, cb)
    TriggerServerEvent('rp:getJobs')
    cb('ok')
end)

RegisterNetEvent('rp:jobsList')
AddEventHandler('rp:jobsList', function(jobs)
    SendNUIMessage({action='jobsList', jobs=jobs})
end)

RegisterNUICallback('setJob', function(data, cb)
    TriggerServerEvent('rp:setJob', data.job)
    cb('ok')
end)

RegisterNUICallback('getGarage', function(_, cb)
    TriggerServerEvent('rp:getGarageVehicles')
    cb('ok')
end)

RegisterNUICallback('purchaseVehicle', function(data, cb)
    TriggerServerEvent('rp:purchaseVehicle', data.price, data.model)
    cb('ok')
end)

RegisterNUICallback('purchaseProperty', function(data, cb)
    TriggerServerEvent('rp:purchaseProperty', data.propertyId)
    cb('ok')
end)

RegisterNUICallback('createOrganization', function(data, cb)
    TriggerServerEvent('rp:createOrganization', data.name)
    cb('ok')
end)

RegisterNUICallback('createGang', function(data, cb)
    TriggerServerEvent('rp:createGang', data.name)
    cb('ok')
end)

RegisterNUICallback('requestDealer', function(_, cb)
    TriggerServerEvent('rp:requestDealer')
    cb('ok')
end)

RegisterNetEvent('rp:dealerLocation')
AddEventHandler('rp:dealerLocation', function(loc, items)
    SendNUIMessage({action='dealer', location=loc, items=items})
end)
