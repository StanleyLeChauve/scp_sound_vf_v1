
if SCPSNDVF.CONFIG.DEVMODE then 
    print("cl_launchsound chargé")
end

net.Receive("BENPRS:SCPSOUNDVF::LAUNCHSOUNDCL", function() 
    local sound_patch = net.ReadString()

        sound.PlayFile("sound/"..sound_patch, "noblock", function(soundChannel)
            VAR_SYSTEM_BENSOUNDMENU_PLAYSOUND = soundChannel
            VAR_SYSTEM_BENSOUNDMENU_PLAYSOUND:EnableLooping(SCPSOUNDVF_SYSTEME_BOUCLAGE_ENABLE)
            VAR_SYSTEM_BENSOUNDMENU_PLAYSOUND:Play()
        end)
end)


net.Receive("BENPRS:SCPSOUNDVF::AUTOMATIQUE_PLAY", function() 
    local sound_patch = net.ReadString()

        sound.PlayFile("sound/"..sound_patch, "", function(soundChannel)
            VAR_SYSTEM_BENSOUNDMENU_PLAYSOUND = soundChannel
            VAR_SYSTEM_BENSOUNDMENU_PLAYSOUND:Play()
        end)
end)