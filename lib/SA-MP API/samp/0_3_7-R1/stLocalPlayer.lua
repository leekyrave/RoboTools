--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_7-R1.stSAMPPed'
sys.safely_include 'SA-MP API.samp.0_3_7-R1.sync'

sys.ffi.cdef[[
	struct stLocalPlayer {
		stSAMPPed						*pSAMP_Actor;
		unsigned short						sCurrentAnimID;
		unsigned short						sAnimFlags;
		unsigned int						ulUnk0;
		int									iIsActive;
		int									iIsWasted;
		unsigned short						sCurrentVehicleID;
		unsigned short						sLastVehicleID;
		stOnFootData				onFootData;
		stPassengerData			passengerData;
		stTrailerData				trailerData;
		stInCarData					inCarData;
		stAimData						aimData;
		unsigned char							byteTeamID;
		int									iSpawnSkin;
		unsigned char							byteUnk1;
		float								fSpawnPos[3];
		float								fSpawnRot;
		int									iSpawnWeapon[3];
		int									iSpawnAmmo[3];
		int									iIsActorAlive;
		int									iSpawnClassLoaded;
		unsigned int						ulSpawnSelectionTick;
		unsigned int						ulSpawnSelectionStart;
		int									iIsSpectating;
		unsigned char							byteTeamID2;
		unsigned short						usUnk2;
		unsigned int						ulSendTick;
		unsigned int						ulSpectateTick;
		unsigned int						ulAimTick;
		unsigned int						ulStatsUpdateTick;
		unsigned int						ulWeapUpdateTick;
		unsigned short						sAimingAtPid;
		unsigned short						usUnk3;
		unsigned char							byteCurrentWeapon;
		unsigned char							byteWeaponInventory[13];
		int									iWeaponAmmo[13];
		int									iPassengerDriveBy;
		unsigned char							byteCurrentInterior;
		int									iIsInRCVehicle;
		unsigned short						sTargetObjectID;
		unsigned short						sTargetVehicleID;
		unsigned short						sTargetPlayerID;
		stHeadSync					headSyncData;
		unsigned int						ulHeadSyncTick;
		char								byteSpace3[260];
		stSurfData					surfData;
		int									iClassSelectionOnDeath;
		int									iSpawnClassID;
		int									iRequestToSpawn;
		int									iIsInSpawnScreen;
		unsigned int						ulUnk4;
		unsigned char							byteSpectateMode;
		unsigned char							byteSpectateType;
		int									iSpectateID;
		int									iInitiatedSpectating;
		stDamageData				vehicleDamageData;
	} __attribute__ ((packed));
]]
