if SCPSNDVF.CONFIG.DEVMODE then 
    print("sv_openui chargé")
end
util.AddNetworkString("BENPRS:SCPSOUNDVF::CLOPENMENU")
hook.Add( "PlayerSay", "playurlmenu", function( ply, text )
	if ( string.lower( text ) == SCPSNDVF.CONFIG.COMMANDE ) then
        if SCPSNDVF.CONFIG.ALLOWED_RANKS[ply:GetUserGroup()] then
            net.Start("BENPRS:SCPSOUNDVF::CLOPENMENU")
            net.Send(ply)
        else
            ply:ChatPrint("Vous n'avez pas la permission d'acceder au panel.")
        end
        return ""
    end 
end) 
