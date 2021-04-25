mainMenu = RageUI.CreateMenu("Agence Immo",  "Cindy pour vous servir !")
local subStudio =  RageUI.CreateSubMenu(mainMenu, "Studio", "Les premiers prix !")
local subAppart =  RageUI.CreateSubMenu(mainMenu, "Appart", "De beau appartement déjà !")
local subMaison =  RageUI.CreateSubMenu(mainMenu, "Maison", "Pour les villa de Luxe !")
local prix = nil
local itemName = " "
local Duree = 0

Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button('Studio', "", {}, true, {}, subStudio);
            RageUI.Button('Appart', "", {}, true, {}, subAppart);
            RageUI.Button('Maison', "", {}, true, {}, subMaison);
        end, function()end)

        --> SubMenu studio : 
        RageUI.IsVisible(subStudio, function()
            for shop = 1, #Config.Locations do
                local item = Config.Locations[shop]["clefs"]
                local sPed = Config.Locations[shop]["sPed"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)
                local player = GetPlayerPed(-1)
                local Blip = AddBlipForCoord(item.pos.x, item.pos.y, item.pos.z)

                if dist <= 6.0 then
                    Duree = 0
                    for _, v in pairs(item.itemNameStudio) do
                        itemName = v
                        for _, j in pairs(item.prix) do 
                            prix = j
                        end

                        RageUI.Button(v, "", {RightLabel = prix .. "~g~$"}, true, { 
                        onSelected = function()
                            local quantityItems =  InputNombre("Montant : ")
                            if tonumber(quantityItems) == nil then
                                exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                return nil
                            end
                            SetBlipColour(Blip, 83)
                            SetBlipRoute(Blip, true)
                            TriggerServerEvent("GTASuperette:RecevoirItem", quantityItems, itemName, prix)
                       
                        end});
                    end
                end
            end
        end, function() end)

        --> SubMenu appart : 
        RageUI.IsVisible(subAppart, function()
            for shop = 1, #Config.Locations do
                local item = Config.Locations[shop]["clefs"]
                local sPed = Config.Locations[shop]["sPed"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, storage["x"], storage["y"], storage["z"], true)
                local player = GetPlayerPed(-1)
                local Blip = AddBlipForCoord(item.pos.x, item.pos.y, item.pos.z)

                if dist <= 5.0 then
                    for _, v in pairs(item.itemNameAppart) do
                        itemName = v
                        for _, j in pairs(item.prix) do 
                            prix = j
                        end

                        RageUI.Button(v, "", {RightLabel = prix .. "~g~$"}, true, { 
                        onSelected = function()
                            local quantityItems =  InputNombre("Montant : ")
                            if tonumber(quantityItems) == nil then
                                exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                return nil
                            end
                            SetBlipColour(Blip, 83)
                            SetBlipRoute(Blip, true)
                            TriggerServerEvent("GTASuperette:RecevoirItem", quantityItems, itemName, prix)
                        end});
                    end
                end
            end
        end, function() end)

        --> SubMenu Maison : 
        RageUI.IsVisible(subMaison, function()
            for shop = 1, #Config.Locations do
                local item = Config.Locations[shop]["clefs"]
                local sPed = Config.Locations[shop]["sPed"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)
                local player = GetPlayerPed(-1)
                local Blip = AddBlipForCoord(item.pos.x, item.pos.y, item.pos.z)

                if dist <= 5.0 then
                    for _, v in pairs(item.itemNameMaison) do
                        itemName = v
                        for _, j in pairs(item.prix) do 
                            prix = j
                        end

                        RageUI.Button(v, "", {RightLabel = prix .. "~g~$"}, true, { 
                        onSelected = function()
                            local quantityItems =  InputNombre("Montant : ")
                            if tonumber(quantityItems) == nil then
                                exports.nCoreGTA:ShowNotification("Veuillez inserer un nombre correct !")
                                return nil
                            end
                            SetBlipColour(Blip, 83)
                            SetBlipRoute(Blip, true)
                            TriggerServerEvent("GTASuperette:RecevoirItem", quantityItems, itemName, prix)
                        end});
                    end
                end
            end
        end, function()end)
    Citizen.Wait(Duree)
    end
end)

Citizen.CreateThread(function()
    while true do
        Duree = 250
        for shop = 1, #Config.Locations do
           local sPed = Config.Locations[shop]["sPed"]
           local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dist = GetDistanceBetweenCoords(plyCoords, sPed["x"], sPed["y"], sPed["z"], true)

            if dist <= 2.0 then
                Duree = 0
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
                end
           
               if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then 
                    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
               end
            end
        end

        if RageUI.Visible(mainMenu) or RageUI.Visible(subFood) or RageUI.Visible(subBoissons) or RageUI.Visible(subMutlimedia) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end
       Citizen.Wait(Duree)
   end
end) 