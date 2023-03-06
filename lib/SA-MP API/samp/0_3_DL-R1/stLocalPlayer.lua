--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stTargetInfo'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stSpawnInfo'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.sync'

sys.ffi.cdef[[
	struct stLocalPlayer {
		stSAMPPed					*pSAMP_Actor;
		stTrailerData			trailerData;
		stOnFootData			onFootData;
		stPassengerData		passengerData;
		stInCarData				inCarData;
		stAimData					aimData;
		int								iIsActive;
		int								iIsWasted;
		unsigned short					sCurrentVehicleID;
		unsigned short					sLastVehicleID;
		unsigned short					sCurrentAnimID;
		unsigned short					sAnimFlags;
		unsigned int					ulUnk0;
		stTargetInfo cameraTarget;
		unsigned int					ulCameraTargetTick;
		stHeadSync				headSyncData;
		unsigned int					ulHeadSyncTick;
		int								iIsSpectating;
		unsigned char						byteTeamID2;
		unsigned short					usUnk2;
		unsigned int					ulSendTick;
		unsigned int					ulSpectateTick;
		unsigned int					ulAimTick;
		unsigned int					ulStatsUpdateTick;
		int								iSpawnClassLoaded;
		unsigned int					ulSpawnSelectionTick;
		unsigned int					ulSpawnSelectionStart;
		stSpawnInfo spawnInfo;
		int								iIsActorAlive;
		unsigned int					ulWeapUpdateTick;
		unsigned short					sAimingAtPlayerID;
		unsigned short					sAimingAtActorID;
		unsigned char						byteCurrentWeapon;
		unsigned char						byteWeaponInventory[13];
		int								iWeaponAmmo[13];
		int								iPassengerDriveBy;
		unsigned char						byteCurrentInterior;
		int								iIsInRCVehicle;
		char              szPlayerName[256];
		stSurfData				surfData;
		int								iClassSelectionOnDeath;
		int								iSpawnClassID;
		int								iRequestToSpawn;
		int								iIsInSpawnScreen;
		unsigned int					ulDisplayZoneTick;
		unsigned char						byteSpectateMode;
		unsigned char						byteSpectateType;
		int								iSpectateID;
		int								iInitiatedSpectating;
		stDamageData			vehicleDamageData;
	} __attribute__ ((packed));
]]
