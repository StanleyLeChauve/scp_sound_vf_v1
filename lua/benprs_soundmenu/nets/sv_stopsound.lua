if SCPSNDVF.CONFIG.DEVMODE then 
    print("sv_stopsound chargé")
end

util.AddNetworkString("BENPRS:SCPSOUNDVF::STOPSOUND")
util.AddNetworkString("BENPRS:SCPSOUNDVF::STOPSOUND_CL")

net.Receive("BENPRS:SCPSOUNDVF::STOPSOUND", function(_, ply)
    if not SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
        ply:ChatPrint("Vous n'avez pas la permission d'effectuer cette action.")
        return 
    end

    net.Start("BENPRS:SCPSOUNDVF::STOPSOUND_CL")
    net.Broadcast()
end)

