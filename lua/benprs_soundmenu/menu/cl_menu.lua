local autre = true 
local deconf = true 
local fim = true 
local reconf = true
local timer_affichage = true 
if SCPSNDVF.CONFIG.DEVMODE then 
    print("cl_menu chargé")
end

SCPSOUNDVF_SYSTEME_BOUCLAGE_ENABLE = false
local bouclage_systeme = false
net.Receive("BENPRS:SCPSOUNDVF::CHANGELOOPBOOL",function()
    local bool = net.ReadBool()

    bouclage_systeme = bool
    SCPSOUNDVF_SYSTEME_BOUCLAGE_ENABLE = bool
end)
net.Receive("BENPRS:SCPSOUNDVF::CLOPENMENU",  function()
    local btnwave = Material("bsound_browser/icons/wave.png")
    
local positionlogo = ScrW()*0.01
local ply = LocalPlayer()
    local frame = vgui.Create("DFrame")
    frame:SetSize(0,0) 
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:MakePopup()
    frame:Center()
    local animationencours = true
    frame:SizeTo(ScrW() * 0.5, ScrH() * 0.5, 1.8, 0, .1, function()
        animationencours = false
    end)
    frame.Think = function(self) 
        if animationencours then 
            self:Center()
        end
    end

    frame.Paint = function(self,w,h) 
        draw.RoundedBox(0,0,0,w,h,Color(36,36,36))
        draw.RoundedBox(1,0,0,w,ScrH()*0.04,Color(27,27,27))
        if SCPSNDVF.CONFIG.FRENCHFLAG then 
            draw.RoundedBox(0,0,0,w,1,Color(0,28,153))
            draw.RoundedBox(0,ScrH()*0.35,0,w,1,Color(255,255,255))
            draw.RoundedBox(0,ScrH()*0.55,0,w,1,Color(153,35,35))
        end
        if SCPSNDVF.CONFIG.LOGO then 
            surface.SetMaterial( Material("bsound_browser/logos/logo_scpsoundvf.png") )
            surface.SetDrawColor( Color(255,255,255))
            surface.DrawTexturedRect( ScrW()*-0.001, ScrH()*-0.009, ScrW()*0.045, ScrH()*0.06 )
            positionlogo = ScrW()*0.04
        end
        draw.SimpleText(SCPSNDVF.CONFIG.TEXTTITLE, "BEN:SCPSOUNDVF:TITLE", positionlogo,ScrH()*0.02,Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end


    
    local CROSS = vgui.Create("DButton", frame)
    CROSS:SetSize(ScrW()*0.038, ScrH()*0.030)
    CROSS:SetPos(ScrW()*0.47, ScrH()*0.001)
    CROSS:SetText("×")
    CROSS:SetFont("BEN:SCPSOUNDVF:CROSS")
    CROSS.Paint = function(self,w,h)
        draw.RoundedBox(1,0,0,w,h,Color(34,34,34,0))
    end
    CROSS.Think = function(self,w,h)
        if self:IsHovered() then 
            self:SetColor(Color(207,49,28))
        else
            self:SetColor(Color(255,255,255))
        end
    end
    CROSS.DoClick = function()
        local animationencours = true
        frame:SetMouseInputEnabled(false)
        frame:SetKeyBoardInputEnabled(false)
        frame:SizeTo(0,0, 1.8, 0, .1, function()
            animationencours = false
            frame:Close()
        end)
        frame.Think = function(self) 
            if animationencours then 
                self:Center()
            end
        end
    end

    local STOPSOUND = vgui.Create("DButton", frame)
    STOPSOUND:SetSize(ScrW()*0.02, ScrH()*0.04)
    STOPSOUND:SetPos(ScrW()*0.46, ScrH()*0.007)
    STOPSOUND:SetText("")
    STOPSOUND.Paint = function(self,w,h)
        surface.SetMaterial( Material("bsound_browser/icons/mute.png") )
        if self:IsHovered() then 
            surface.SetDrawColor( Color(175,61,61))
        else 
            surface.SetDrawColor( Color(255,255,255))
        end
        surface.DrawTexturedRect( 0, 0, ScrW()*0.015, ScrH()*0.025 )
    end
    STOPSOUND.DoClick = function()
        net.Start("BENPRS:SCPSOUNDVF::STOPSOUND")
        net.SendToServer()
    end
    
    if ply:GetUserGroup() == "superadmin" then 

        local STNG = vgui.Create("DButton", frame)
        STNG:SetSize(ScrW()*0.02, ScrH()*0.04)
        STNG:SetPos(ScrW()*0.435, ScrH()*0.007)
        STNG:SetText("")
        STNG.Paint = function(self,w,h)
            surface.SetMaterial( Material("bsound_browser/icons/settings.png") )
            if self:IsHovered() then 
                surface.SetDrawColor( Color(0,119,255))
            else 
                surface.SetDrawColor( Color(255,255,255))
            end
            surface.DrawTexturedRect( 0, 0, ScrW()*0.015, ScrH()*0.025 )
        end
        STNG.DoClick = function()
            local nombre = 0
            for category, properties in pairs(SCPSNDVF.CONFIG.BUTTONS) do
                    for _, buttonInfo in ipairs(properties.commands) do
                        nombre = nombre + 1
                    end
            end

            net.Start("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_GRADES")
            net.SendToServer()
            local framesettings = vgui.Create("DFrame")
            framesettings:SetSize(ScrW() * 0.5, ScrH() * 0.5) 
            framesettings:SetPos(ScrW()*0.25, ScrH()*0.25)
            framesettings:ShowCloseButton(false)
            framesettings:SetTitle("")
            framesettings:SetDraggable(false)
            framesettings:MakePopup()
            framesettings.Paint = function(self,w,h) 
                
                // ui bas & ui HAUT 
                draw.RoundedBox(0,0,0,w,h,Color(36,36,36))
                draw.RoundedBox(1,0,0,w,ScrH()*0.04,Color(27,27,27))
                draw.RoundedBox(1,0,0,w,ScrH()*0.04,Color(27,27,27))    


                // BLEU BLANC ROUGE
                if SCPSNDVF.CONFIG.FRENCHFLAG then 
                    draw.RoundedBox(0,0,0,w,1,Color(0,28,153))
                    draw.RoundedBox(0,ScrH()*0.35,0,w,1,Color(255,255,255))
                    draw.RoundedBox(0,ScrH()*0.55,0,w,1,Color(255,0,0))
                end

                if SCPSNDVF.CONFIG.LOGO == true then 
                    surface.SetMaterial( Material("bsound_browser/logos/logo_scpsoundvf.png") )
                    surface.SetDrawColor( Color(255,255,255))
                    surface.DrawTexturedRect( ScrW()*-0.001, ScrH()*-0.009, ScrW()*0.045, ScrH()*0.06 )
                    positionlogo = ScrW()*0.04
                end
                draw.SimpleText(SCPSNDVF.CONFIG.TEXTTITLEADMIN, "BEN:SCPSOUNDVF:TITLE", positionlogo,ScrH()*0.02,Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                draw.RoundedBox(0,ScrW()*0.02,ScrH()*0.1,ScrW()*0.2,ScrH()*0.31,Color(29,29,29))

                draw.SimpleText("Catégories : ", "BEN:SCPSOUNDVF:TITLE", ScrW()*0.03 ,ScrH()*0.12,Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(tostring(table.Count(SCPSNDVF.CONFIG.BUTTONS)), "BEN:SCPSOUNDVF:TITLE", ScrW()*0.21 ,ScrH()*0.12,Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

                draw.SimpleText("Sons :", "BEN:SCPSOUNDVF:TITLE", ScrW()*0.03 ,ScrH()*0.17,Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(nombre, "BEN:SCPSOUNDVF:TITLE", ScrW()*0.21 ,ScrH()*0.17,Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

                draw.SimpleText("Bouclage : ", "BEN:SCPSOUNDVF:TITLE",  ScrW()*0.03 ,ScrH()*0.22,Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                draw.RoundedBox(0,ScrW()*0.28,ScrH()*0.1,ScrW()*0.2,ScrH()*0.31,Color(29,29,29))
                draw.RoundedBox(2,ScrW() * 0.29, ScrH() * 0.11,ScrW() * 0.18, ScrH() * 0.04, Color(36,33,33))
            end

            local entrergrade = vgui.Create( "DTextEntry", framesettings )
            entrergrade:SetSize(ScrW() * 0.18, ScrH() * 0.04)
            entrergrade:SetPos(ScrW() * 0.29, ScrH() * 0.112)
            entrergrade:SetPlaceholderText( "Grades autorisés" )
            entrergrade:SetDrawLanguageID(false)
            entrergrade:SetTextColor( Color(255,255,255) )
            entrergrade:SetPaintBackground(false)
            entrergrade:SetCursorColor(Color(45,113,214))
            entrergrade:SetFont("BEN:SCPSOUNDVF:TITLESUBBTN")
            entrergrade.OnEnter = function( self )
                net.Start("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_ENVOIS_GRADE")
                net.WriteString(self:GetValue())
                net.SendToServer()
                framesettings:Close()
            end 

            local DScrollPanel = vgui.Create("DScrollPanel", framesettings)
            DScrollPanel:SetSize(ScrW() * 0.18, ScrH() * 0.22)
            DScrollPanel:SetPos(ScrW() * 0.29, ScrH() * 0.16)
            local sbar = DScrollPanel:GetVBar()
            sbar:SetHideButtons(true)
        
            function sbar:Paint(w, h)
                draw.RoundedBox(66, 0, 0, ScrW() * 0.003, h, Color(0, 0, 0, 100))
            end
        
            function sbar.btnUp:Paint(w, h)
            end
        
            function sbar.btnDown:Paint(w, h)
            end
        
            function sbar.btnGrip:Paint(w, h)
                draw.RoundedBox(266, ScrW() * 0.00105, 0, ScrW() * 0.0015, h, Color(49, 49, 49, 100))
            end
            
            net.Receive("BENPRS:SCPSOUNDVF::CHANGEIGCONFIG_GRADES_RENVOIS", function()
                local grade = net.ReadString()
                local boutons_auto = DScrollPanel:Add( "DButton" )
                boutons_auto:SetSize(ScrW()*0.45, ScrH()*0.05)
                boutons_auto:Dock( TOP )
                boutons_auto:SetText(grade)
                boutons_auto:SetFont("BEN:SCPSOUNDVF:TITLE")
                boutons_auto:SetColor(Color(255,255,255))
                boutons_auto:DockMargin( 0, 0, 0, 5 )
                boutons_auto.Paint = function(self,w,h)
                    draw.RoundedBox(2,0, 0,w,h, Color(36,33,33))
                end
                boutons_auto.DoClick = function()
                    if boutons_auto:GetText() == "superadmin" then 
                        ply:ChatPrint("Vous ne pouvez pas retirer le grade superadmin.")
                        return
                    end
                    net.Start("BENPRS:SCPSOUNDVF::IGCONFIG_REMOVE_GRADE")
                    net.WriteString(boutons_auto:GetText())
                    net.SendToServer()
                    framesettings:Remove()
                end
                boutons_auto.Think = function(self,w,h)
                    if self:IsHovered() then 
                        self:SetColor(Color(182,63,63))
                    else
                        self:SetColor(Color(255,255,255))
                    end
                end
            end)
            
            local bouclage = vgui.Create("DButton", framesettings)
            bouclage:SetSize(ScrW()*0.13, ScrH()*0.04)
            bouclage:SetPos(ScrW()*0.13 ,ScrH()*0.205)
            bouclage:SetText("Valeur introuvable")
            bouclage:SetFont("BEN:SCPSOUNDVF:TITLE")
            bouclage:SetColor(Color(255,255,255))
            bouclage.Paint = function(self,w,h)
                draw.RoundedBox(1,0,0,w,h,Color(34,34,34,0))
            end
            bouclage.Think = function(self,w,h)
                if self:IsHovered() then 
                    self:SetColor(Color(255,255,255))
                else
                    if bouclage_systeme then 
                        self:SetColor(Color(63,173,137))
                        self:SetText("Actif")
                    else 
                        self:SetColor(Color(158,51,51))
                        self:SetText("Inactif")
                    end
                end
            end
            bouclage.DoClick = function()
                surface.PlaySound("garrysmod/balloon_pop_cute.wav")
                net.Start("BENPRS:SCPSOUNDVF::LOOPSOUND")
                net.SendToServer()
               
            end
            bouclage.DoRightClick = function() 
                notification.AddLegacy( "[Bouclage] Permet de relancer les sons en boucle", NOTIFY_HINT, 5 )
            end

            local CROSSSETTINGS = vgui.Create("DButton", framesettings)
            CROSSSETTINGS:SetSize(ScrW()*0.038, ScrH()*0.030)
            CROSSSETTINGS:SetPos(ScrW()*0.47, ScrH()*0.001)
            CROSSSETTINGS:SetText("×")
            CROSSSETTINGS:SetFont("BEN:SCPSOUNDVF:CROSS")
            CROSSSETTINGS.Paint = function(self,w,h)
                draw.RoundedBox(1,0,0,w,h,Color(34,34,34,0))
            end
            CROSSSETTINGS.Think = function(self,w,h)
                if self:IsHovered() then 
                    self:SetColor(Color(207,49,28))
                else
                    self:SetColor(Color(255,255,255))
                end
            end
            CROSSSETTINGS.DoClick = function()
                framesettings:Close()
            end
        end


        local CALENDAR = vgui.Create("DButton", frame)
        CALENDAR:SetSize(ScrW()*0.02, ScrH()*0.04)
        CALENDAR:SetPos(ScrW()*0.41, ScrH()*0.007)
        CALENDAR:SetText("")
        CALENDAR.Paint = function(self,w,h)
            surface.SetMaterial( Material("bsound_browser/icons/calendar.png") )
            if self:IsHovered() then 
                surface.SetDrawColor( Color(35,150,89))
            else 
                surface.SetDrawColor( Color(255,255,255))
            end
            surface.DrawTexturedRect( 0, 0, ScrW()*0.015, ScrH()*0.028 )
        end
        CALENDAR.DoClick = function()
            local framesettings = vgui.Create("DFrame")
            framesettings:SetSize(ScrW() * 0.5, ScrH() * 0.5)
            framesettings:SetPos(ScrW() * 0.25, ScrH() * 0.25)
            framesettings:ShowCloseButton(false)
            framesettings:SetTitle("")
            framesettings:SetDraggable(false)
            framesettings:MakePopup()
            framesettings.Paint = function(self, w, h)
                -- UI bas & UI haut 
                draw.RoundedBox(0, 0, 0, w, h, Color(36, 36, 36))
                draw.RoundedBox(1, 0, 0, w, ScrH() * 0.04, Color(27, 27, 27))
                draw.RoundedBox(1, 0, 0, w, ScrH() * 0.04, Color(27, 27, 27))    
        
                -- BLEU BLANC ROUGE
                if SCPSNDVF.CONFIG.FRENCHFLAG then 
                    draw.RoundedBox(0, 0, 0, w, 1, Color(0, 28, 153))
                    draw.RoundedBox(0, ScrH() * 0.35, 0, w, 1, Color(255, 255, 255))
                    draw.RoundedBox(0, ScrH() * 0.55, 0, w, 1, Color(255, 0, 0))
                end
        
                if SCPSNDVF.CONFIG.LOGO then 
                    surface.SetMaterial(Material("bsound_browser/logos/logo_scpsoundvf.png"))
                    surface.SetDrawColor(Color(255, 255, 255))
                    surface.DrawTexturedRect(ScrW() * -0.001, ScrH() * -0.009, ScrW() * 0.045, ScrH() * 0.06)
                    positionlogo = ScrW() * 0.04
                end
        
                draw.SimpleText("PLANIFIER DES SONS", "BEN:SCPSOUNDVF:TITLE", ScrW() * 0.25, ScrH() * 0.07, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(SCPSNDVF.CONFIG.TEXTTITLEPLANIFICATION, "BEN:SCPSOUNDVF:TITLE", positionlogo, ScrH() * 0.02, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.RoundedBox(6, ScrW() * 0.05, ScrH() * 0.1, ScrW() * 0.4, ScrH() * 0.05, Color(41, 41, 41))
            end
        
            local CROSSSETTINGS = vgui.Create("DButton", framesettings)
            CROSSSETTINGS:SetSize(ScrW() * 0.038, ScrH() * 0.030)
            CROSSSETTINGS:SetPos(ScrW() * 0.47, ScrH() * 0.001)
            CROSSSETTINGS:SetText("×")
            CROSSSETTINGS:SetFont("BEN:SCPSOUNDVF:CROSS")
            CROSSSETTINGS.Paint = function(self, w, h)
                draw.RoundedBox(1, 0, 0, w, h, Color(34, 34, 34, 0))
            end
            CROSSSETTINGS.Think = function(self)
                self:SetTextColor(self:IsHovered() and Color(207, 49, 28) or Color(255, 255, 255))
            end
            CROSSSETTINGS.DoClick = function()
                framesettings:Close()
            end
        
            local schedulePanel = vgui.Create("DPanel", framesettings)
            schedulePanel:SetSize(ScrW() * 0.4, ScrH() * 0.3)
            schedulePanel:SetPos(ScrW() * 0.05, ScrH() * 0.15)
            schedulePanel.Paint = nil
        
            local function CreateSoundSelector(parent, x, y, w, h, items)
                local selector = vgui.Create("DComboBox", parent)
                selector:SetSize(ScrW() * w, ScrH() * h)
                selector:SetPos(ScrW() * x, ScrH() * y)
                selector:SetSortItems(false)
                selector:SetTextColor(Color(222, 244, 240))
                selector:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
        
                for _, item in ipairs(items) do
                    selector:AddChoice(item)
                end
        
                selector.Paint = function(self, w, h)
                    surface.SetDrawColor(50, 50, 50, 255)
                    surface.DrawRect(0, 0, w, h)
                    surface.SetDrawColor(255, 255, 255, 50)
                    surface.DrawOutlinedRect(0, 0, w, h)
                end
        
                local originalOpenMenu = selector.OpenMenu
                selector.OpenMenu = function(self, pControlOpener)
                    originalOpenMenu(self)
                    for _, item in pairs(self.Menu:GetCanvas():GetChildren()) do
                        item:SetTextColor(Color(222, 244, 240))
                        item:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
                        item.Paint = function(self, w, h)
                            surface.SetDrawColor(self:IsHovered() and 52 or 70, self:IsHovered() and 77 or 70, self:IsHovered() and 92 or 70)
                            surface.DrawRect(0, 0, w, h)
                        end
                    end
                end
        
                return selector
            end
        
            local hoursSelector = CreateSoundSelector(framesettings, 0.06, 0.115, 0.09, 0.025, (function()
                local items = {}
                for i = 0, 23 do 
                    table.insert(items, string.format("%02d", i) .. " H")
                end
                return items
            end)())
        
            local minutesSelector = CreateSoundSelector(framesettings, 0.16, 0.115, 0.09, 0.025, (function()
                local items = {}
                for i = 0, 59 do 
                    table.insert(items, string.format("%02d", i) .. " MINUTES")
                end
                return items
            end)())
        
            local soundSelector = CreateSoundSelector(framesettings, 0.26, 0.115, 0.151, 0.025, (function()
                local items = {}
                for _, v in pairs(SCPSNDVF.CONFIG.BUTTONS) do
                    for _, f in pairs(v) do
                        for _, k in pairs(f) do
                            for _type, _sound in pairs(k) do
                                if _type == "title" then
                                    table.insert(items, _sound)
                                end
                            end
                        end
                    end
                end
                return items
            end)())
        
            local function UpdateSchedulePanel(schedules, cle)
                schedulePanel:Clear()
                for index, schedule in ipairs(schedules) do
                    local panel = vgui.Create("DPanel", schedulePanel)
                    panel:SetSize(schedulePanel:GetWide(), ScrH() * 0.03)
                    panel:SetPos(0, (index - 1) * ScrH() * 0.03)
                    panel:SetBackgroundColor(Color(70, 70, 70))
                    panel.Paint = nil
            
                    local hourLabel = vgui.Create("DLabel", panel)
                    hourLabel:SetPos(ScrW() * 0.01, ScrH() * 0.005)
                    hourLabel:SetSize(ScrW() * 0.09, ScrH() * 0.025)
                    hourLabel:SetText(" Heure : " .. schedule.hour)
                    hourLabel:SetTextColor(Color(222, 244, 240))
                    hourLabel:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
                    hourLabel.Paint = function(self, w, h)
                        surface.SetDrawColor(50, 50, 50, 255)
                        surface.DrawRect(0, 0, w, h)
                        surface.SetDrawColor(255, 255, 255, 50)
                        surface.DrawOutlinedRect(0, 0, w, h)
                    end
            
                    local minutesLabel = vgui.Create("DLabel", panel)
                    minutesLabel:SetPos(ScrW() * 0.11, ScrH() * 0.005)
                    minutesLabel:SetSize(ScrW() * 0.09, ScrH() * 0.025)
                    minutesLabel:SetText(" Minutes : " .. schedule.minutes)
                    minutesLabel:SetTextColor(Color(222, 244, 240))
                    minutesLabel:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
                    minutesLabel.Paint = function(self, w, h)
                        surface.SetDrawColor(50, 50, 50, 255)
                        surface.DrawRect(0, 0, w, h)
                        surface.SetDrawColor(255, 255, 255, 50)
                        surface.DrawOutlinedRect(0, 0, w, h)
                    end
            
                    local soundLabel = vgui.Create("DLabel", panel)
                    soundLabel:SetPos(ScrW() * 0.21, ScrH() * 0.005)
                    soundLabel:SetSize(ScrW() * 0.151, ScrH() * 0.025)
                    soundLabel:SetText(" Audio : " .. schedule.sound)
                    soundLabel:SetTextColor(Color(222, 244, 240))
                    soundLabel:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
                    soundLabel.Paint = function(self, w, h)
                        surface.SetDrawColor(50, 50, 50, 255)
                        surface.DrawRect(0, 0, w, h)
                        surface.SetDrawColor(255, 255, 255, 50)
                        surface.DrawOutlinedRect(0, 0, w, h)
                    end

                    local deleteButton = vgui.Create("DButton", panel)
                    deleteButton:SetSize(ScrW() * 0.08, panel:GetTall())
                    deleteButton:SetPos(ScrW() * 0.342, 5)
                    deleteButton:SetText("Supprimer")
                    deleteButton:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
                    deleteButton:SetTextColor(Color(222, 244, 240))
                    deleteButton.DoClick = function(s)
                        net.Start("BENPRS:SCPSOUNDVF::SUPP_PLANIFICATION")
                        net.WriteString(cle)
                        net.SendToServer()
                        s:Remove()
                    end
                    deleteButton.Paint = nil
                    deleteButton.Think = function(self)
                        self:SetTextColor(self:IsHovered() and Color(131, 35, 18) or Color(222, 244, 240))
                    end
                end
            end
            
        
            net.Start("BENPRS:SCPSOUNDVF::VERIFY_PLANIFICATION")
            net.SendToServer()
        
            net.Receive("BENPRS:SCPSOUNDVF::SEND_PLANIFICATION", function()
                local planificationTable = net.ReadTable()
                
                local schedules = {}
                local cles = {}  -- Tableau pour stocker toutes les clés
                
                for key, value in pairs(planificationTable) do
                    table.insert(cles, key)  -- Stocke chaque clé dans le tableau
                    if type(value) == "table" then
                        for _, schedule in pairs(value) do
                            table.insert(schedules, {
                                hour = schedule["heure"],
                                minutes = schedule["minutes"],
                                sound = schedule["son"]
                            })
                        end
                    end
                end
            
                SCPSNDVF_CLIENT = SCPSNDVF_CLIENT or {}
                SCPSNDVF_CLIENT.PLANIFICATION = schedules
                
                -- Maintenant, passons toutes les clés à UpdateSchedulePanel
                for _, cle in ipairs(cles) do
                    UpdateSchedulePanel(schedules, cle)
                end
            end)
            
        
            local okButton = vgui.Create("DButton", framesettings)
            okButton:SetText("ENVOYER")
            okButton:SetPos(ScrW() * 0.41, ScrH() * 0.115)
            okButton:SetSize(ScrW() * 0.04, ScrH() * 0.025)
            okButton:SetFont("BEN:SCPSOUNDVF:PLANIF_1")
            okButton:SetTextColor(Color(255, 255, 255))
            okButton.DoClick = function()
                local hour = hoursSelector:GetSelected()
                local minutes = minutesSelector:GetSelected() 
                local sound = soundSelector:GetSelected()
        
                if not hour then
                    notification.AddLegacy("L'heure doit être sélectionnée!", NOTIFY_ERROR, 5)
                    return
                end
        
                if not minutes then
                    notification.AddLegacy("Les minutes doivent être sélectionnées !", NOTIFY_ERROR, 5)
                    return
                end
        
                if not sound then
                    notification.AddLegacy("Le son doit être sélectionné!", NOTIFY_ERROR, 5)
                    return
                end
        
                net.Start("BENPRS:SCPSOUNDVF::SAUVER_PLANIFICATION")
                net.WriteString(hour)
                net.WriteString(minutes)
                net.WriteString(sound)
                net.SendToServer()
        
                framesettings:Close()
            end
        
            okButton.Paint = nil
            okButton.Think = function(self)
                self:SetTextColor(self:IsHovered() and Color(64, 202, 168) or Color(255, 255, 255))
            end
        end
        

    end



        local DScrollPanel = vgui.Create("DScrollPanel", frame)
        DScrollPanel:SetSize(ScrW() * 0.45, ScrH() * 0.38)
        DScrollPanel:SetPos(ScrW() * 0.025, ScrH() * 0.1)
        
        local sbar = DScrollPanel:GetVBar()
        sbar:SetHideButtons(true)
        
        function sbar:Paint(w, h)
            draw.RoundedBox(66, 0, 0, ScrW() * 0.003, h, Color(0, 0, 0, 100))
        end
        
        function sbar.btnUp:Paint(w, h)
        end
        
        function sbar.btnDown:Paint(w, h)
        end
        
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(266, ScrW() * 0.00105, 0, ScrW() * 0.0015, h, Color(49, 49, 49, 100))
        end
        
        local DHorizontalScroller = vgui.Create("DHorizontalScroller", frame)
        DHorizontalScroller:SetPos(ScrW() * 0.03, ScrH() * 0.05)
        DHorizontalScroller:SetSize(ScrW() * 0.45, ScrH() * 0.04)
        DHorizontalScroller:SetOverlap(ScrW() * -0.013)
        
        DHorizontalScroller.btnRight:SetText(">")
        DHorizontalScroller.btnLeft:SetText("<")
        DHorizontalScroller.btnRight:SetSize(ScrW() * 0.005, ScrH() * 0.3)
        DHorizontalScroller.btnLeft:SetSize(ScrW() * 0.005, ScrH() * 0.1)
        DHorizontalScroller.btnRight:SetFont("BEN:SCPSOUNDVF:ARROW")
        DHorizontalScroller.btnLeft:SetFont("BEN:SCPSOUNDVF:ARROW")
        DHorizontalScroller.btnRight:SetColor(Color(255, 255, 255))
        DHorizontalScroller.btnLeft:SetColor(Color(255, 255, 255))
        
        local function drawButton(panel, w, h, color)
            draw.RoundedBox(0, 0, 0, w, h, color)
            surface.SetDrawColor(255, 255, 255, 50)
            surface.DrawOutlinedRect(0, 0, w, h)
        end
        
        DHorizontalScroller.btnRight.Paint = function(panel, w, h)
            local color = Color(41, 41, 41)
        
            if panel:IsHovered() then
                color = Color(52, 77, 92)
            end
        
            drawButton(panel, w, h, color)
        end
        
        DHorizontalScroller.btnLeft.Paint = function(panel, w, h)
            local color = Color(41, 41, 41)
        
            if panel:IsHovered() then
                color = Color(52, 77, 92)
            end
        
            drawButton(panel, w, h, color)
        end
        
        local originalPerformLayout = DHorizontalScroller.PerformLayout
        
        function DHorizontalScroller:PerformLayout()
            originalPerformLayout(self)
        
            self.btnLeft:SetSize(ScrW() * 0.01, ScrH() * 0.035)
            self.btnLeft:AlignLeft(0)
            self.btnLeft:AlignBottom(2.5)
        
            self.btnRight:SetSize(ScrW() * 0.01, ScrH() * 0.035)
            self.btnRight:AlignRight(0)
            self.btnRight:AlignBottom(2.5)
        
            self.btnLeft:SetVisible(self.pnlCanvas.x < 0)
            self.btnRight:SetVisible(self.pnlCanvas.x + self.pnlCanvas:GetWide() > self:GetWide())
        end
    
        
        
        local function button_categorie(text, functionbtn)
            local STNG = vgui.Create("DButton", DHorizontalScroller)
            STNG:SetText(text)
            STNG:SetFont("BEN:SCPSOUNDVF:TITLEBTN")
            STNG:SetColor(Color(255, 255, 255))
            STNG:SetSize(ScrW() * 0.1, ScrH() * 0.035)
            STNG:DockMargin(0, 0, 0, 0) 
            DHorizontalScroller:AddPanel( STNG )
            STNG.Paint = function(self, w, h)
                if self:IsHovered() then
                    draw.RoundedBox(6, 0, 0, w, h, Color(52, 77, 92))
                else
                    draw.RoundedBox(6, 0, 0, w, h, Color(41, 41, 41))
                end
            end
            STNG.DoClick = functionbtn
        end
        
    
        local function button(title, son)
            local temps = "?"
            if SCPSNDVF.CONFIG.TIMESOUNDS then 
                local duree = math.Round(NewSoundDuration("sound/"..son), 0)
                local minutes = math.floor(duree / 60)
                local seconds = duree % 60
                if tonumber(minutes) > 0 then 
                    temps = string.format("%dm%02ds", minutes, seconds)
                else 
                    temps = string.format("%02ds", seconds) 
                end
            end
            local STNG = DScrollPanel:Add( "DButton" )
            STNG:SetSize(ScrW()*0.45, ScrH()*0.05)
            STNG:Dock( TOP )
            STNG:SetText("")
            STNG:DockMargin( 0, 0, 0, 5 )
            STNG.Paint = function(self,w,h)
                draw.RoundedBox(6, ScrW()*0.04,0,ScrW()*0.40,h, Color(41,41,41))
                draw.RoundedBox(6, 0,0,ScrW()*0.03,h, Color(41,41,41))
    
                surface.SetMaterial( btnwave )
                if self:IsHovered() then 
                    surface.SetDrawColor( Color(74,135,206))
                else
                    surface.SetDrawColor( Color(255,255,255))
                end
                surface.DrawTexturedRect( ScrW()*0.0025, ScrH()*0.01, ScrW()*0.025, ScrH()*0.035 )
                
                draw.SimpleText(title, "BEN:SCPSOUNDVF:TITLEBTN", ScrW()*0.05, ScrH()*0.025, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                if SCPSNDVF.CONFIG.TIMESOUNDS then 
                    draw.SimpleText(temps, "BEN:SCPSOUNDVF:TITLEBTN", ScrW() * 0.43, ScrH() * 0.025, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                end
            end
            STNG.DoClick = function()
                net.Start("BENPRS:SCPSOUNDVF::LAUNCHSOUND")
                net.WriteString(son)
                net.SendToServer()
                frame:Close()
            end
            return STNG
        end
    
    
        for category, properties in pairs(SCPSNDVF.CONFIG.BUTTONS) do
            button_categorie(category, function()
                DScrollPanel:GetCanvas():Clear()
                local DLabel = vgui.Create( "DLabel", frame )
                DLabel:SetPos(ScrW()*0.16, ScrH()*0.25)
                DLabel:SetText( "Recherche des sons...." )
                DLabel:SetFont("BEN:SCPSOUNDVF:LOADING")
                DLabel:SizeToContents()
                    DLabel:Remove()
                    for _, buttonInfo in ipairs(properties.commands) do
                        if not timer_affichage then return end
                        timer_affichage = false 
                        button(buttonInfo.title, buttonInfo.sound):SetPos(properties.position, ScrH() * 0.05)
                        timer_affichage = true 
                    end
            end)
        end
end) 

