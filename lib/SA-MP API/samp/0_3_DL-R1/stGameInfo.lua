--[[
	Project: unnamed multihack

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stAudio
	{
		int	iSoundState; // 0 - Finished, 1 - Loaded, 2 - Playing
		bool bStopInteriourAmbientSounds;
	}__attribute__ ((packed));

	struct stCamera
	{
		void*	pEntity; // attached entity
		struct CMatrix_Padded* matrix;
	}__attribute__ ((packed));

	struct stGameInfo
	{
		struct stAudio  *pAudio;
		struct stCamera  *pCamera;
		stSAMPPed 			*pLocalPlayerPed;
		float						fRaceCheckpointPos[3];
		float						fRaceCheckpointNext[3];
		float						m_fRaceCheckpointSize;
		uint8_t					byteRaceType;
		int							bRaceCheckpointsEnabled;
		unsigned long		dwRaceCheckpointMarker;
		unsigned long		dwRaceCheckpointHandle;
		float						fCheckpointPos[3];
		float						fCheckpointExtent[3];
		int							bCheckpointsEnabled;
		unsigned long		dwCheckpointMarker;
		uint32_t				ulUnk2;
		int							bHeadMove;
		uint32_t    		ulFpsLimit;
		int							iCursorMode;
		uint32_t				ulUnk1;
		int							bClockEnabled;
		uint8_t					byteUnk3;
		uint8_t					byteVehicleModels[212];
	}__attribute__ ((packed));
]]
