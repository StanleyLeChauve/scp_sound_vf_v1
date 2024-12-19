if SCPSNDVF.CONFIG.DEVMODE then 
    print("sv_sendsoundall chargé")
end
local SCPSOUNDVF_SYSTEM_BOUCLAGE = false

util.AddNetworkString("BENPRS:SCPSOUNDVF::LAUNCHSOUND")
util.AddNetworkString("BENPRS:SCPSOUNDVF::LAUNCHSOUNDCL")
util.AddNetworkString("BENPRS:SCPSOUNDVF::LOOPSOUND")
util.AddNetworkString("BENPRS:SCPSOUNDVF::CHANGELOOPBOOL")

net.Receive("BENPRS:SCPSOUNDVF::LAUNCHSOUND", function(_, ply)
    if not ply:IsValid() or not ply:IsPlayer() then
        return
    end
    local link = net.ReadString()

    if not SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
        ply:ChatPrint("Vous n'avez pas la permission d'effectuer cette action.")
        return 
    end
        net.Start("BENPRS:SCPSOUNDVF::LAUNCHSOUNDCL")
        net.WriteString(link)
        net.Broadcast()
end)


net.Receive("BENPRS:SCPSOUNDVF::LOOPSOUND", function(_, ply)
    if not ply:IsValid() or not ply:IsPlayer() then
        return
    end
    

    if not SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
        ply:ChatPrint("Vous n'avez pas la permission d'effectuer cette action.")
        return 
    end

    net.Start("BENPRS:SCPSOUNDVF::CHANGELOOPBOOL")
    if SCPSOUNDVF_SYSTEM_BOUCLAGE then 
        net.WriteBool(false)
        SCPSOUNDVF_SYSTEM_BOUCLAGE = false 
    else 
        net.WriteBool(true) 
        SCPSOUNDVF_SYSTEM_BOUCLAGE = true
    end
    net.Broadcast()

end)
