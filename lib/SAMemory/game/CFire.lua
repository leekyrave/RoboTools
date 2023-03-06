--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')
shared.require('CEntity')
shared.require('FxSystem_c')

shared.ffidef[[
	struct CFire {
		struct {
			unsigned char bActive : 1;
			unsigned char bCreatedByScript : 1;
			unsigned char bMakesNoise : 1;
			unsigned char bBeingExtinguished : 1;
			unsigned char bFirstGeneration : 1;
		} nFlags;
		char _pad0;
		short nScriptReferenceIndex;
		RwV3D vecPosition;
		CEntity *pEntityTarget;
		CEntity *pEntityCreator;
		unsigned int nTimeToBurn;
		float fStrength;
		char nNumGenerationsAllowed;
		unsigned char nRemovalDist;
		char _pad1[2];
		FxSystem_c *pFxSystem;
	};
]]

shared.validate_size('CFire', 0x28)
