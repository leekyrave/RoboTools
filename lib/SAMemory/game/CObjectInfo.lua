--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')
shared.require('FxSystem_c')

shared.ffidef[[
	struct CObjectInfo {
		float          fMass;
		float          fTurnMass;
		float          fAirResistance;
		float          fElasticity;
		float          fBuoyancyConstant;
		float          fUprootLimit;
		float          fColDamageMultiplier;
		unsigned char  nColDamageEffect;
		unsigned char  nSpecialColResponseCase;
		unsigned char  nCameraAvoidObject;
		unsigned char  bCausesExplosion;
		unsigned char  nFxType;
		RwV3D          vFxOffset;
		FxSystem_c    *pFxSystem;
		float          fSmashMultiplier;
		RwV3D          vecBreakVelocity;
		float          fBreakVelocityRand;
		unsigned int   nGunBreakMode;
		unsigned int   nSparksOnImpact;
	};
]]

shared.validate_size('CObjectInfo', 0x50)
