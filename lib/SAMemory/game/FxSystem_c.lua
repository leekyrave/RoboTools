--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')

shared.ffidef[[
	enum eFxSystemKillStatus {
		FX_NOT_KILLED = 0,
		FX_PLAY_AND_KILL = 1,
		FX_KILLED = 2
	};

	enum eFxSystemPlayStatus {
		FX_PLAYING = 0,
		FX_STOPPED = 1
	};

	struct FxSystem_c {
		void *pBlueprint;
		RwMatrix *pParentMatrix;
		RwMatrix localMatrix;
		unsigned char nPlayStatus;
		unsigned char nKillStatus;
		unsigned char bConstTimeSet;
		char field_53;
		int field_54;
		float fCameraDistance;
		unsigned short nConstTime;
		unsigned short nRateMult;
		unsigned short nTimeMult;
		struct {
				unsigned char bOwnedParentMatrix: 1;
				unsigned char blocalParticles : 1;
				unsigned char bZTestEnabled : 1;
				unsigned char bUnknown4 : 1;
				unsigned char bUnknown5 : 1;
				unsigned char bMustCreatePtrs : 1;
		} nFlags;
		char field_63;
		float fUnkRandom;
		RwV3D vecVelAdd;
		void *pBounding;
		void **pPrimsPtrList;
		char fireAudio[0x88];
	};
]]
