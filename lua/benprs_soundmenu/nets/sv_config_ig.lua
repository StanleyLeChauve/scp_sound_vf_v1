util.AddNetworkString("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_GRADES")
util.AddNetworkString("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_GRADES_RENVOIS")
util.AddNetworkString("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_ENVOIS_GRADE")
util.AddNetworkString("BENPRS:SCPSOUNDVF::IGCONFIG_REMOVE_GRADE")


net.Receive("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_GRADES", function(_,ply)
    if ply:GetUserGroup() ~= "superadmin" then 
        ply:ChatPrint("Bien essayé :)") 
        return 
    end

    for grades, etat in pairs(SCPSNDVF.CONFIG.ALLOWED_RANKS) do
        if etat then 
            net.Start("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_GRADES_RENVOIS")
            net.WriteString(grades)
            net.Send(ply)
        end
    end
end)

net.Receive("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_ENVOIS_GRADE", function(_, ply)
    if ply:GetUserGroup() ~= "superadmin" then
        ply:ChatPrint("Bien essayé :)")
        return
    end

    local grade = net.ReadString()

    SCPSNDVF.CONFIG.ALLOWED_RANKS[grade] = true

    file.Write("scpsoundvf/sound_menu/config/grades.json", util.TableToJSON(SCPSNDVF.CONFIG.ALLOWED_RANKS, true))
end)

net.Receive("BENPRS:SCPSOUNDVF::IGCONFIG_REMOVE_GRADE", function(_, ply)
    if ply:GetUserGroup() ~= "superadmin" then
        ply:ChatPrint("Bien essayé :)")
        return
    end

    local RemoveGrade = net.ReadString()

    if RemoveGrade == "superadmin" then 
        ply:ChatPrint("Vous ne pouvez pas retirer le grade superadmin.")
        return 
    end 

    SCPSNDVF.CONFIG.ALLOWED_RANKS[RemoveGrade] = false

    file.Write("scpsoundvf/sound_menu/config/grades.json", util.TableToJSON(SCPSNDVF.CONFIG.ALLOWED_RANKS, true))
end)
