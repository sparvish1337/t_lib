local HelpConfig = HelpTextConfig
local BlipConfig = BlipConfig
local PedConfig = PedConfig
local MarkerConfig = MarkerConfig

Citizen.CreateThread(function()
    if type(HelpConfig) ~= 'table' then
        print("Error: HelpTextConfig is not loaded or is not a table.")
        return
    end

    for _, helpText in ipairs(HelpConfig) do
        ShowFloatingHelpText(helpText.text, helpText.coords.x, helpText.coords.y, helpText.coords.z, helpText.radius)
    end
end)

Citizen.CreateThread(function()
    if type(BlipConfig) ~= 'table' then
        print("Error: BlipConfig is not loaded or is not a table.")
        return
    end

    for _, blipData in ipairs(BlipConfig) do
        local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
        SetBlipSprite(blip, blipData.sprite)
        SetBlipScale(blip, blipData.scale or 1.0)
        SetBlipColour(blip, blipData.color)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipData.name)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    if type(PedConfig) ~= 'table' then
        print("Error: PedConfig is not loaded or is not a table.")
        return
    end

    for _, pedData in ipairs(PedConfig) do
        local modelHash = GetHashKey(pedData.model)

        if not IsModelInCdimage(modelHash) or not IsModelValid(modelHash) then
            print("Error: Model " .. pedData.model .. " is invalid or does not exist.")
            return
        end

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end

        local ped = CreatePed(4, modelHash, pedData.coords.x, pedData.coords.y, pedData.coords.z, pedData.heading, false, true)

        if DoesEntityExist(ped) then
            if pedData.invincible then
                SetEntityInvincible(ped, true)
            end

            if pedData.freeze then
                FreezeEntityPosition(ped, true)
            end

            if pedData.weapon then
                GiveWeaponToPed(ped, GetHashKey(pedData.weapon), 999, false, true)
                SetPedCurrentWeaponVisible(ped, true, true, true, true)
            end

            if pedData.isFriendly then
                SetPedCanRagdoll(ped, false)
                SetPedCanRagdollFromPlayerImpact(ped, false)
                SetPedFleeAttributes(ped, 0, false)
                SetPedCombatAttributes(ped, 46, true)
                SetPedRelationshipGroupHash(ped, GetHashKey("player"))
                SetPedAsEnemy(ped, false)

                if pedData.isDefensive then
                    SetPedCombatAttributes(ped, 1, true)
                    SetPedCombatAttributes(ped, 2, false)
                end
            else
                SetPedRelationshipGroupHash(ped, GetHashKey("hostile"))
                SetPedAsEnemy(ped, true)
                SetPedCombatAttributes(ped, 1, true)
                SetPedCombatAttributes(ped, 2, true)
                SetPedCombatAttributes(ped, 3, true)
                SetPedCombatAttributes(ped, 4, true)
            end

            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)

                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local distance = #(playerCoords - vector3(pedData.coords.x, pedData.coords.y, pedData.coords.z))

                    if distance < 4.0 then

                        ShowFloatingHelpText(pedData.helpText or "Press [E] to interact", pedData.coords.x, pedData.coords.y, pedData.coords.z + 1.9, 4.0)

                        if IsControlJustPressed(1, 51) then
                            TriggerEvent(pedData.interactionEvent)
                        end
                    end
                end
            end)
        else
            print("Error: Ped could not be created.")
        end

        SetModelAsNoLongerNeeded(modelHash)
    end
end)



-- Marker Creation
Citizen.CreateThread(function()
    if type(MarkerConfig) ~= 'table' then
        print("Error: MarkerConfig is not loaded or is not a table.")
        return
    end

    while true do
        Citizen.Wait(0)

        for _, markerData in ipairs(MarkerConfig) do
            DrawMarker(markerData.type, markerData.coords.x, markerData.coords.y, markerData.coords.z,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                markerData.scale.x, markerData.scale.y, markerData.scale.z,
                markerData.color.r, markerData.color.g, markerData.color.b, markerData.color.a,
                false, true, 2, nil, nil, false
            )
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - vector3(markerData.coords.x, markerData.coords.y, markerData.coords.z))

            if distance < markerData.scale.x then
                ShowFloatingHelpText("Press [E] to interact", markerData.coords.x, markerData.coords.y, markerData.coords.z, markerData.scale.x)

                if IsControlJustPressed(1, 51) then
                    TriggerEvent(markerData.triggerEvent)
                end
            end
        end
    end
end)

function ShowFloatingHelpText(text, x, y, z, radius)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - vector3(x, y, z))

            if distance < radius then
                SetFloatingHelpTextWorldPosition(1, x, y, z)
                SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)

                BeginTextCommandDisplayHelp("STRING")
                AddTextComponentSubstringPlayerName(text)
                EndTextCommandDisplayHelp(2, false, false, -1)
            end
        end
    end)
end

RegisterNetEvent("startMission")
AddEventHandler("startMission", function()
    print("Mission started!")
end)

RegisterNetEvent("openMenu")
AddEventHandler("openMenu", function()
    print("Menu opened!")
end)


exports.mt_lib:createInteractionPoint(
    "unique_id",          -- Replace with your unique ID
    vec3(-47.2559, -1113.3199, 26.4358), -- Coordinates
    10.0,                 -- Distance within which the interaction can be triggered
    "Interact Here",      -- Label displayed for the interaction point
    "32",                  -- Key required to interact
    "Press E",            -- Label for the key
    function()            -- Action to execute on click
        print("Interaction point clicked!")
        -- Add your interaction logic here
    end,
    true                  -- Set to true if the interaction point can be interacted with
)