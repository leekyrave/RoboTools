--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stSAMPEntity'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stSAMPPed'

sys.ffi.cdef[[
	struct stRemotePlayerData {
		unsigned short				sPlayerID;
		unsigned short				sVehicleID;
		stSAMPPed				*pSAMP_Actor;
		stSAMPVehicle		*pSAMP_Vehicle;
		int							iHasJetPack;
		int							iShowNameTag;
		int            bUsingJetPack;
		unsigned char					byteSpecialAction;
		unsigned char					byteTeamID;
		unsigned char					bytePlayerState;
		unsigned char					byteSeatID;
		int            bIsNpc;
		int							iPassengerDriveBy;
		stPassengerData	passengerData;
		stOnFootData		onFootData;
		stInCarData			inCarData;
		stTrailerData		trailerData;
		stAimData				aimData;
		unsigned int				ulUnk0[3];
		float						fOnFootPos[3];
		float						fOnFootMoveSpeed[3];
		float						fVehiclePosition[3];
		float						fVehicleMoveSpeed[3];
		void						*pUnk0;
		unsigned char					byteUnk1[60];
		float						vecVehiclePosOffset[3];
		float						fVehicleRoll[4];
		float						fActorArmor;
		float						fActorHealth;
		unsigned int				ulUnk1[3];
		int							iLastAnimationID;
		unsigned char					byteUpdateFromNetwork;
		unsigned int				dwTick;
		unsigned int				dwLastStreamedInTick;
		unsigned int      	ulUnk2;
		int							iAFKState;
		stHeadSync			headSyncData;
		int							iGlobalMarkerLoaded;
		int							iGlobalMarkerLocation[3];
		unsigned int				ulGlobalMarker_GTAID;
	}__attribute__ ((packed));

	struct stRemotePlayer {
		int										iScore;
		int										iIsNPC;
		stRemotePlayerData		*pPlayerData;
		int										iPing;
		void									*pVTBL_txtHandler;
		char									strPlayerName[24];
	}__attribute__ ((packed));
]]
