
/*


											╔══════════════════════════════════════════════════════════════════════════════════════════╗
											║                                      CREE PAR MAEL                                       ║
											║                                 POUR BEN & SCP SOUND VF                                  ║
											║                                                                                          ║
											║                             Avant  de modifier ce script                                 ║
											║                  pour un serveur, il est vivement recommandé                             ║
											║                        de demander l'autorisation a BEN                                  ║
											║                                                                                          ║
											║                       Il est important de respecter le travail                           ║
											║                                       des auteurs !                     				   ║
											╚══════════════════════════════════════════════════════════════════════════════════════════╝


*/
-- > Pas besoin de toucher à ce fichier < --


local titlecolorsh = Color(176, 138, 40) 
local titlecolorcl = Color(31, 255, 251)
local titlecolorsv = Color(17, 237, 68)
local colorbase = Color(255,255,255)
local nomaddon = "SCP SOUND VF "

local rootDirectory = "benprs_soundmenu"
local function AddFile( File, directory )
	local prefix = string.lower( string.Left( File, 3 ) )
	if SERVER and prefix == "sv_" then
		include( directory .. File )
		MsgC( titlecolorsv, nomaddon.." ", colorbase, "Chargement des fichiers serveurs : ", Color(156, 5, 108), File, Color(255,255,255), ". \n") 
	elseif prefix == "sh_" then
		if SERVER then
			AddCSLuaFile( directory .. File )
			MsgC(titlecolorsh, nomaddon.." ", colorbase, "Chargement des fichiers partagés : ", Color(156, 5, 108), File, Color(255,255,255), ". \n") 
		end
		include( directory .. File )
	elseif prefix == "cl_" then
		if SERVER then
			AddCSLuaFile( directory .. File )
			MsgC( titlecolorcl, nomaddon.." ", colorbase, "Chargement des fichiers client : ", Color(156, 5, 108), File, Color(255,255,255), ". \n") 
		elseif CLIENT then
			include( directory .. File )
		end
	end
end
local function IncludeDir( directory )
	directory = directory .. "/"
	local files, directories = file.Find( directory .. "*", "LUA" )

	for _, v in ipairs( files ) do
		if string.EndsWith( v, ".lua" ) then
			AddFile( v, directory )
		end
	end

	for _, v in ipairs( directories ) do
		if SERVER then 
			print("")
			MsgC( Color(85, 171, 0), nomaddon.." ", colorbase, "Répertoire : ", Color(156, 5, 108), v, Color(255,255,255), ". \n") 
		end
		IncludeDir( directory .. v )
	end
end

hook.Add("InitPostEntity", "ChargementFichiersAddon", function()
    IncludeDir(rootDirectory)
end)

IncludeDir(rootDirectory)