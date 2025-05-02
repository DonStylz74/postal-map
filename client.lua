local EnableCayoMiniMap = true

Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end
    end
end)

if EnableCayoMiniMap then
    local function CreateBlip()
        local BlipCoords = {
            vec3(4800.85, -6159.22, 0.0),
            vec3(6420.60, -5169.87, 37.43),
        }
        for coords=1, #BlipCoords do
            local coords = BlipCoords[coords]
            print(json.encode(coords.x))
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 1)
            SetBlipAlpha(blip, 0)
            SetBlipScale(blip, 0.1)
            SetBlipAsShortRange(blip, true)
        end
    end
    CreateThread(function()
        CreateBlip()
        while true do
            SetRadarAsExteriorThisFrame()
            local coords = vec(4700.0, -5145.0)
            SetRadarAsInteriorThisFrame(`h4_fake_islandx`, coords.x, coords.y, 0, 0)
            Wait(0)
        end
    end)
end