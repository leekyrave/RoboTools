--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')
shared.require('CAutomobile')
shared.require('FxSystem_c')

shared.ffidef[[
	struct CHeli {
		CAutomobile        Automobile;
		char               nHeliFlags;
		char _pad1[3];
		float              fLeftRightSkid;
		float              fSteeringUpDown;
		float              fSteeringLeftRight;
		float              fAccelerationBreakStatus;
		int field_99C;
		float              fRotorZ;
		float              fSecondRotorZ;
		float              fMaxAltitude;
		float field_9AC;
		float              fMinAltitude;
		int field_9B4;
		char field_9B8;
		char               nNumSwatOccupants;
		char               anSwatIDs[4];
		char _pad2[2];
		int field_9C0[4];
		int field_9D0;
		FxSystem_c         **pParticlesList;
		char field_9D8[24];
		int field_9F0;
		RwV3D              vecSearchLightTarget;
		float              fSearchLightIntensity;
		int field_A04;
		int field_A08;
		FxSystem_c         **ppGunflashFx;
		char               nFiringMultiplier;
		char               bSearchLightEnabled;
		char _pad3[2];
		float field_A14;
	};
]]

shared.validate_size('CHeli', 0xA18)
