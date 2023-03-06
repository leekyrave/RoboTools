--[[
	Project: unnamed multihack

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_7-R1.stSAMPPed'

sys.ffi.cdef[[
	struct stAudio
	{
		int	iSoundState; // 0 - Finished, 1 - Loaded, 2 - Playing
	}__attribute__ ((packed));

	struct stCamera
	{
		void*	pEntity;
		struct CMatrix_Padded* matrix;
	}__attribute__ ((packed));

	struct stGameInfo
	{
		struct stAudio*	pAudio;
		struct stCamera*	pCamera;
		stSAMPPed*	pLocalPlayerPed;
		float		fCheckpointPos[3];
		float		fCheckpointExtent[3];
		int			bCheckpointsEnabled;
		// not tested
		unsigned long		dwCheckpointMarker;
		float		fRaceCheckpointPos[3];
		float		fRaceCheckpointNext[3];
		float		m_fRaceCheckpointSize;
		uint8_t		byteRaceType;
		int			bRaceCheckpointsEnabled;
		// not tested
		unsigned long		dwRaceCheckpointMarker;
		unsigned long		dwRaceCheckpointHandle;
		int			iCursorMode;
		uint32_t	ulUnk1;
		int			bClockEnabled;
		uint32_t	ulUnk2;
		int			bHeadMove;
		uint32_t		ulFpsLimit;
		uint8_t		byteUnk3;
		uint8_t		byteVehicleModels[212];
	}__attribute__ ((packed));
]]
