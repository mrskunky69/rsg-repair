local RSGCore = exports['rsg-core']:GetCoreObject()
local ret = SetVehicleFixed(vehicle)

--- ped crouch
function CrouchAnim()
    local dict = "mini_games@story@mud1@fix_wheel"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "wheelfix_exit", 0.1, 4.0, -1, 1, 0, false, false, false)
end


RegisterNetEvent('rsg-repair', function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local nearbyWagon = GetClosestWagon(playerPos)
	local playerData = RSGCore.Functions.GetPlayerData()
	CrouchAnim()
	Wait(6000)
    ClearPedTasks(PlayerPedId())
	
	

    if nearbyWagon and DoesEntityExist(nearbyWagon) then
        -- Check if the wagon is damaged
        if SetVehicleFixed(nearbyWagon) < 1.0 then
			
            TriggerServerEvent("repairWagon", NetworkGetNetworkIdFromEntity(nearbyWagon))
			
			
        else
            TriggerEvent('rNotify:NotifyLeft', "You have fixed the Wagon", "nice one", "generic_textures", "tick", 4000)
			
        end
    else
            TriggerEvent('rNotify:NotifyLeft', "no wagon", "nearby", "generic_textures", "tick", 4000)
    end
end, false)

function IsWagonModel(modelName)
    local wagonModels = {
        "CART01", "CART02", "CART03", "CART04", "CART05", "CART06", "CART07", "CART08",
        "ARMYSUPPLYWAGON", "BUGGY01", "BUGGY02", "BUGGY03", "CHUCKWAGON000X", "CHUCKWAGON002X",
        "COACH2", "COACH3", "COACH4", "COACH5", "COACH6", "coal_wagon", "OILWAGON01X",
        "POLICEWAGON01X", "WAGON02X", "WAGON04X", "LOGWAGON", "WAGON03X", "WAGON05X", "WAGON06X",
        "WAGONPRISON01X", "STAGECOACH001X", "STAGECOACH002X", "STAGECOACH003X", "STAGECOACH004X",
        "STAGECOACH005X", "STAGECOACH006X", "UTILLIWAG", "GATCHUCK", "GATCHUCK_2", "wagonCircus01x",
        "WAGONDAIRY01X", "WAGONWORK01X", "WAGONTRAVELLER01X", "SUPPLYWAGON", "CABOOSE01X",
        "northpassenger01x", "NORTHSTEAMER01X", "HANDCART", "HUNTERCART01", "CANOE", "CANOETREETRUNK",
        "PIROGUE", "RCBOAT", "rowboat", "ROWBOATSWAMP", "SKIFF", "SHIP_GUAMA02", "SHIP_NBDGUAMA",
        "horseBoat", "BREACH_CANNON", "GATLING_GUN", "GATLINGMAXIM02", "SMUGGLER02", "turbineboat",
        "HOTAIRBALLOON01", "hotchkiss_cannon", "wagonCircus02x", "wagonDoc01x", "PIROGUE2",
        "PRIVATECOALCAR01X", "PRIVATESTEAMER01X", "PRIVATEDINING01X", "ROWBOATSWAMP02",
        "midlandboxcar05x", "coach3_cutscene", "privateflatcar01x", "privateboxcar04x",
        "privatebaggage01X", "privatepassenger01x", "trolley01x", "northflatcar01x", "supplywagon",
        "northcoalcar01x", "northpassenger03x", "privateboxcar02x", "armoredcar03x",
        "privateopensleeper02x", "WINTERSTEAMER", "wintercoalcar", "privateboxcar01x",
        "privateobservationcar", "gatchuck_2","privatearmoured"
    }

    for _, wagonModel in ipairs(wagonModels) do
        if GetHashKey(wagonModel) == modelName then
            return true
        end
    end

    return false
end

function GetClosestWagon(playerPos)
    local vehicles = RSGCore.Functions.GetVehicles()

    local closestWagon = nil
    local closestDistance = -1

    for _, vehicle in ipairs(vehicles) do
        local model = GetEntityModel(vehicle)
        if IsWagonModel(model) then
            local distance = #(playerPos - GetEntityCoords(vehicle))
            if closestDistance == -1 or distance < closestDistance then
                closestWagon = vehicle
                closestDistance = distance
            end
        end
    end

    return closestWagon
end


