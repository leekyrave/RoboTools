--[[
	Project: SA-MP API

	Author: LUCHARE


	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	typedef		struct 		stSAMP 							stSAMP;
	typedef 	struct 		stServerPresets 		stServerPresets;
	typedef 	struct 		stChatEntry 		 		stChatEntry;
	typedef 	struct 		stChatInfo 					stChatInfo;
	typedef 	struct 		stFontRenderer 			stFontRenderer;
	typedef 	struct 		stInputBox 					stInputBox;
	typedef 	struct 		stInputInfo 				stInputInfo;
	typedef 	struct 		stKillEntry		 			stKillEntry;
	typedef 	struct 		stKillInfo 					stKillInfo;
	typedef 	struct 		stSAMPPools 				stSAMPPools;
	typedef 	struct 		stScoreboardInfo 		stScoreboardInfo;
	typedef 	struct 		stServerInfo 				stServerInfo;
	typedef 	struct 		stDialogInfo 				stDialogInfo;
	typedef 	struct 		stLocalPlayer	   		stLocalPlayer;
	typedef 	struct 		stPlayerPool 				stPlayerPool;
	typedef 	struct 		stRemotePlayerData 	stRemotePlayerData;
	typedef 	struct 		stRemotePlayer 			stRemotePlayer;
	typedef 	struct 		stSAMPPed						stSAMPPed;
	typedef 	struct 		stSAMPEntity 				stSAMPEntity;
	typedef 	struct 		stSAMPKeys 					stSAMPKeys;
	typedef 	struct 		stOnFootData 				stOnFootData;
	typedef 	struct 		stInCarData 				stInCarData;
	typedef 	struct 		stAimData 					stAimData;
	typedef 	struct 		stTrailerData 			stTrailerData;
	typedef 	struct 		stPassengerData 		stPassengerData;
	typedef 	struct 		stDamageData 				stDamageData;
	typedef 	struct 		stSurfData 					stSurfData;
	typedef 	struct 		stUnoccupiedData 		stUnoccupiedData;
	typedef 	struct 		stBulletData 				stBulletData;
	typedef 	struct 		stStatsData 				stStatsData;
	typedef 	struct 		stHeadSync 					stHeadSync;
	typedef 	struct 		stTargetInfo 				stTargetInfo;
	typedef 	struct 		stSpawnInfo				 	stSpawnInfo;
	typedef 	struct		stSAMPVehicle				stSAMPVehicle;
	typedef 	struct		stVehiclePool				stVehiclePool;
	typedef		struct 		stPickupPool				stPickupPool;
	typedef 	struct		stPickup						stPickup;
	typedef		struct		stTextdrawPool			stTextdrawPool;
	typedef		struct		stTextdraw					stTextdraw;
	typedef		struct		stTextLabelPool 		stTextLabelPool;
	typedef		struct		stTextLabel					stTextLabel;
	typedef 	struct 		stGangzonePool			stGangzonePool;
	typedef 	struct		stGangzone					stGangzone;
	typedef 	struct		stObjectPool	 			stObjectPool;
	typedef 	struct		stObject						stObject;
	typedef		struct 		stActorPool					stActorPool;
	typedef   struct 		stGameInfo					stGameInfo;
	typedef		struct 		RakClientInterface	RakClientInterface;
]]

return function( ver )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stSAMP' )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stChatInfo' )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stInputInfo' )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stKillInfo' )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stScoreboardInfo' )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stDialogInfo' )
	sys.safely_include ( 'SA-MP API.samp.'..ver..'.stGameInfo' )
end
