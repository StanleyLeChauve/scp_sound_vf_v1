SCPSNDVF = SCPSNDVF or {}
SCPSNDVF.CONFIG = SCPSNDVF.CONFIG or {}


/* 

-> VERSION 1.2.1 <- 

| > | Ajouts de sons
    | > | Roger Myers
    | > | Roger
    | > | Personnel Exterieur
    | > | Rappel Alpha 1
    | > | Rappel EP 11
    | > | Sortie Alpha 1
    | > | Sortie EP 11
    | > | Classe D - Fin d'alerte
    | > | Classe D - Evasion
    | > | Classe D - Prise d'otage
    | > | Classe D - Entrée confinement 
    | > | Classe D - Entrée confinement 2 
    | > | Classe D - Entrée confinement 3 
    | > | Classe D - Rupture de contrar

*/


// NE PAS TOUCHER // // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER // 

// MERCI DE VOUS RENDRE DANS VOS FICHIERS GARRY'S MOD ( garrysmod/garrysmod/data/scpsoundvf/sound_menu/config.json ) et remplacer les grades dans le fichier ( Attention à la syntaxe et l'orthographe )
if SERVER then 
    SCPSNDVF.CONFIG.PLANIFICATION = {

    }
    if not file.Exists("scpsoundvf/sound_menu/config/", "DATA") then
        file.CreateDir("scpsoundvf/sound_menu/config/")
    end
    // Configuration "grades"
    if not file.Exists("scpsoundvf/sound_menu/config/grades.json", "DATA") then
        SCPSNDVF.CONFIG.ALLOWED_RANKS = {
            ["superadmin"] = true, 
            ["admin"] = true,
            ["user"] = false
        }

        file.Write("scpsoundvf/sound_menu/config/grades.json", util.TableToJSON(SCPSNDVF.CONFIG.ALLOWED_RANKS, true))
    else
        local allowedRanks = util.JSONToTable(file.Read("scpsoundvf/sound_menu/config/grades.json", "DATA")) or {}
        SCPSNDVF.CONFIG.ALLOWED_RANKS = allowedRanks
    end

end
// NE PAS TOUCHER // // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER //  // NE PAS TOUCHER // 




-- Commande pour acceder au panel
SCPSNDVF.CONFIG.COMMANDE = "/sounds"

SCPSNDVF.CONFIG.BUTTONS = {
    ["Autre"] = {
        commands = {
            { title = "Autre | Backrooms projet KV-31", sound = "benprs/autre/backrooms_kv31_try.wav" },
            { title = "Autre | Cantine", sound = "benprs/ambiance/cantine_burger.wav" },
            { title = "Autre | Decontamination", sound = "benprs/autre/decontamination.wav" },
            { title = "Autre | Decontamination ( Sans Musique )", sound = "benprs/autre/decontamination_no_music.wav" },
            { title = "Autre | Ogives Alpha", sound = "benprs/autre/warheads_music.wav" },
            { title = "Autre | Ogives Alpha ( Sans Musique )", sound = "benprs/autre/warheads_nomusic.wav" },
            { title = "Autre | Personnel Exterieur", sound = "benprs/autre/personnel_ext.wav" },
            { title = "Autre | Roger", sound = "benprs/autre/roger.wav" },
            { title = "Autre | Roger Myers zone 106", sound = "benprs/autre/roger_myers.wav" },
        }
    },

    ["Déconfinement"] = {
        commands = {
            { title = "Déconfinement | Brèche Générale", sound = "benprs/deconf/bigbreach.wav" },
            { title = "Déconfinement | Intrusion", sound = "benprs/deconf/securitybreach.wav" },
            { title = "Déconfinement | SCP-008", sound = "benprs/deconf/008.wav" },
            { title = "Déconfinement | SCP-035", sound = "benprs/deconf/035.wav" },
            { title = "Déconfinement | SCP-049", sound = "benprs/deconf/049.wav" },
            { title = "Déconfinement | SCP-079", sound = "benprs/deconf/079.wav" },
            { title = "Déconfinement | SCP-096", sound = "benprs/deconf/096.wav" },
            { title = "Déconfinement | SCP-1048", sound = "benprs/deconf/1048.wav" },
            { title = "Déconfinement | SCP-106", sound = "benprs/deconf/106.wav" },
            { title = "Déconfinement | SCP-173", sound = "benprs/deconf/173.wav" },
            { title = "Déconfinement | SCP-457", sound = "benprs/deconf/457.wav" },
            { title = "Déconfinement | SCP-682", sound = "benprs/deconf/682.wav" },
            { title = "Déconfinement | SCP-966", sound = "benprs/deconf/966.wav" },
        }
    },

    ["FIM"] = {
        commands = {
            { title = "FIM | Alpha-1", sound = "benprs/fim/entreemtf1.wav" },
            { title = "FIM | Epsilon-11", sound = "benprs/fim/entreemtf2.wav" },
            { title = "FIM | Sortie", sound = "benprs/fim/sortiefim.wav" },

            { title = "FIM | Alpha-1 | Rappel", sound = "benprs/fim/rappel_a1.wav" },
            { title = "FIM | Epsilon-11 | Rappel", sound = "benprs/fim/rappel_ep11.wav" },
            { title = "FIM | Alpha-1 | Sortie", sound = "benprs/fim/ep11_leave.wav" },
            { title = "FIM | Epsilon-11 | Sortie", sound = "benprs/fim/a1_leave.wav" },
        }
    },

    ["Reconfinement"] = {
        commands = {
            { title = "Reconfinement | Femur Breaker", sound = "benprs/reconf/106_femurbreaker.wav" },
            { title = "Reconfinement | SCP-049", sound = "benprs/reconf/049.wav" },
            { title = "Reconfinement | SCP-096", sound = "benprs/reconf/096.wav" },
            { title = "Reconfinement | SCP-106", sound = "benprs/reconf/106.wav" },
            { title = "Reconfinement | SCP-173", sound = "benprs/reconf/173.wav" },
            { title = "Reconfinement | SCP-457", sound = "benprs/reconf/457.wav" },
            { title = "Reconfinement | SCP-939", sound = "benprs/reconf/939.wav" },
        }
    },

    ["Incidents"] = {
        commands = {
            { title = "Prob Tech | Point de contrôle", sound = "benprs/incidents/checkpoint.wav" },
            { title = "Prob Tech | Intercoms", sound = "benprs/incidents/maintenance_intercoms.wav" },
            { title = "Prob Tech | Panne electrique", sound = "benprs/incidents/panne_electrique.wav" },
            { title = "Prob Tech | Fuite de gaz", sound = "benprs/incidents/fuite_gaz.wav" },
            { title = "Alerte | Incendie", sound = "benprs/incidents/feu.wav" },
        }
    },

    ["Classe-D"] = {
        commands = {
            { title = "Zone Carcérale | Fin d'alerte", sound = "benprs/classe_d/classd_fin.wav" },
            { title = "Zone Carcérale | Evasion", sound = "benprs/classe_d/evasion.wav" },
            { title = "Zone Carcérale | Prise d'otage", sound = "benprs/classe_d/prise_otage.wav" },
            { title = "Hauts-Parleurs | Entrez dans le confinement ", sound = "benprs/classe_d/hp_entreecellule.wav" },
            { title = "Hauts-Parleurs | Entrez avertissement 1", sound = "benprs/classe_d/entree_avert_1.wav" },
            { title = "Hauts-Parleurs | Entrez avertissement 2", sound = "benprs/classe_d/entree_avert_2.wav" },
            { title = "Hauts-Parleurs | Rupture de contrat", sound = "benprs/classe_d/fin_contrat.wav" },
        }
    },
}
--[[ v !! NE PAS RETIRER && NE PAS TOUCHER !! v ]] 

            if SERVER then return end

--[[ ^ !! NE PAS RETIRER && NE PAS TOUCHER !! ^ ]] 


-- trais bleu blanc et rouge au dessus du panel
SCPSNDVF.CONFIG.FRENCHFLAG = true 

-- Mode développement ( Affiches en plus )
SCPSNDVF.CONFIG.DEVMODE = false 

-- Afficher la durée de l'audio à côté du titre
SCPSNDVF.CONFIG.TIMESOUNDS = true

-- Texte titre affiché en haut à gauche
SCPSNDVF.CONFIG.TEXTTITLE = "SCP SOUND VF"

-- Texte titre affiché en haut à gauche ( Panel Admin )
SCPSNDVF.CONFIG.TEXTTITLEADMIN = "SCP SOUND VF | Menu Administratif"

-- Texte titre affiché en haut à gauche ( Panel Planification )
SCPSNDVF.CONFIG.TEXTTITLEPLANIFICATION = "SCP SOUND VF | Planification"

-- Logo SCPSOUNDVF ( Non recommandé )
SCPSNDVF.CONFIG.LOGO = true