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
	struct tFlyingHandlingData {
		int nVehicleId;
		float fThrust;
		float fThrustFallOff;
		float fYaw;
		float fYawStab;
		float fSideSlip;
		float fRoll;
		float fRollStab;
		float fPitch;
		float fPitchStab;
		float fFormLift;
		float fAttackLift;
		float fGearUpR;
		float fGearDownL;
		float fWindMult;
		float fMoveRes;
		RwV3D vecTurnRes;
		RwV3D vecSpeedRes;
	};
]]

shared.validate_size('tFlyingHandlingData', 0x58)
