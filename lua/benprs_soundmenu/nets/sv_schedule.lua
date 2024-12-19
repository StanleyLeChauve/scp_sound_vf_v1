util.AddNetworkString("BENPRS:SCPSOUNDVF::SAUVER_PLANIFICATION")
util.AddNetworkString("BENPRS:SCPSOUNDVF::SEND_PLANIFICATION")
util.AddNetworkString("BENPRS:SCPSOUNDVF::VERIFY_PLANIFICATION")
util.AddNetworkString("BENPRS:SCPSOUNDVF::SUPP_PLANIFICATION")
util.AddNetworkString("BENPRS:SCPSOUNDVF::AUTOMATIQUE_PLAY")

if not file.Exists("scpsoundvf/sound_menu/planification/", "DATA") then
    file.CreateDir("scpsoundvf/sound_menu/planification/")
end

if file.Exists("scpsoundvf/sound_menu/planification/sons.json", "DATA") then
    local sons = util.JSONToTable(file.Read("scpsoundvf/sound_menu/planification/sons.json", "DATA")) or {}
    SCPSNDVF.CONFIG.PLANIFICATION = sons
end



net.Receive("BENPRS:SCPSOUNDVF::SAUVER_PLANIFICATION", function(_, ply)
    local heure = net.ReadString()
    local minutes = net.ReadString()
    local son = net.ReadString()

    if not SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
        ply:ChatPrint("Vous n'avez pas la permission d'effectuer cette action.")
        return
    end

    local timestamp = os.time()
    local number = #SCPSNDVF.CONFIG.PLANIFICATION + 1
    local id = timestamp .. "_" .. number

    if SCPSNDVF.CONFIG.PLANIFICATION[id] == nil then
        SCPSNDVF.CONFIG.PLANIFICATION[id] = {}
    end

    local planification = {
        heure = heure,
        minutes = minutes,
        son = son
    }

    table.insert(SCPSNDVF.CONFIG.PLANIFICATION[id], planification)
    file.Write("scpsoundvf/sound_menu/planification/sons.json", util.TableToJSON(SCPSNDVF.CONFIG.PLANIFICATION, true))
end)

net.Receive("BENPRS:SCPSOUNDVF::VERIFY_PLANIFICATION", function(_, ply)
    if not SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
        ply:ChatPrint("Vous n'avez pas la permission d'effectuer cette action.")
        return
    end

    net.Start("BENPRS:SCPSOUNDVF::SEND_PLANIFICATION")
    net.WriteTable(SCPSNDVF.CONFIG.PLANIFICATION)
    net.Send(ply)
end)

net.Receive("BENPRS:SCPSOUNDVF::SUPP_PLANIFICATION", function(_, ply)
    if not SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
        ply:ChatPrint("Vous n'avez pas la permission d'effectuer cette action.")
        return
    end

    local cle = net.ReadString()

    for k, _ in pairs(SCPSNDVF.CONFIG.PLANIFICATION) do
        if k == cle then
            table.remove(SCPSNDVF.CONFIG.PLANIFICATION[k])
        end
    end

    timer.Simple(1, function()
        file.Write("scpsoundvf/sound_menu/planification/sons.json", util.TableToJSON(SCPSNDVF.CONFIG.PLANIFICATION, true))
    end)
end)

local fileContent = file.Read("scpsoundvf/sound_menu/planification/sons.json", "DATA")
local date = nil

if file.Exists("scpsoundvf/sound_menu/planification/sons.json") then 
    data = util.JSONToTable(fileContent) or {} 
else
    data = {} 
end

timer.Create("TIMER:LAUNCH_SHEDULE:SOUND", 1, 0, function()
    local c_heure = tonumber(os.date("%H"))
    local c_minutes = tonumber(os.date("%M"))
    local c_secondes = tonumber(os.date("%S"))

    for key, value in pairs(SCPSNDVF.CONFIG.PLANIFICATION) do
        for _, v in pairs(value) do
            local heure = v.heure:gsub("[^%d]", "")
            local minute = v.minutes:gsub("[^%d]", "")


            if tonumber(heure) == c_heure and tonumber(minute) == c_minutes and c_secondes == 1 then
                for category, data in pairs(SCPSNDVF.CONFIG.BUTTONS) do
                    for _, command in ipairs(data.commands) do
                        if v.son == command.title then
                            net.Start("BENPRS:SCPSOUNDVF::AUTOMATIQUE_PLAY")
                            net.WriteString(command.sound)
                            net.Broadcast()
                            print("[ SON PROGRAMMÉ ] Un son de SCP SOUND VF a été lancé :", command.sound)
                        end
                    end
                end
            end
        end
    end
end)
