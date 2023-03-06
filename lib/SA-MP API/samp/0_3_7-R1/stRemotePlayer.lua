--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stRemotePlayerData {
		struct stSAMPPed		*pSAMP_Actor;
		struct stSAMPVehicle	*pSAMP_Vehicle;
		unsigned char					byteTeamID;
		unsigned char					bytePlayerState;
		unsigned char					byteSeatID;
		unsigned int				ulUnk3;
		int						iPassengerDriveBy;
		void					*pUnk0;
		unsigned char					byteUnk1[60];
		float					fSomething[3];
		float					fVehicleRoll[4];
		unsigned int				ulUnk2[3];
		float					fOnFootPos[3];
		float					fOnFootMoveSpeed[3];
		float					fVehiclePosition[3];
		float					fVehicleMoveSpeed[3];
		unsigned short				sPlayerID;
		unsigned short				sVehicleID;
		unsigned int				ulUnk5;
		int						iShowNameTag;
		int						iHasJetPack;
		unsigned char					byteSpecialAction;
		unsigned int				ulUnk4[3];
		struct stOnFootData		onFootData;
		struct stInCarData		inCarData;
		struct stTrailerData	trailerData;
		struct stPassengerData	passengerData;
		struct stAimData		aimData;
		float					fActorArmor;
		float					fActorHealth;
		unsigned int				ulUnk10;
		unsigned char					byteUnk9;
		unsigned int				dwTick;
		unsigned int				dwLastStreamedInTick;
		unsigned int				ulUnk7;
		int						iAFKState;
		struct stHeadSync		headSyncData;
		int						iGlobalMarkerLoaded;
		int						iGlobalMarkerLocation[3];
		unsigned int				ulGlobalMarker_GTAID;
	}__attribute__ ((packed));

	struct stRemotePlayer {
		stRemotePlayerData	*pPlayerData;
		int									iIsNPC;
		void								*pVTBL_txtHandler;
		char								strPlayerName[24];
		int									iScore;
		int									iPing;
	}__attribute__ ((packed));
]]
