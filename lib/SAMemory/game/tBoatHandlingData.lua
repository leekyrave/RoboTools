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
	struct tBoatHandlingData {
		int nVehicleId;
		float fThrustY;
		float fThrustZ;
		float fThrustAppZ;
		float fAqPlaneForce;
		float fAqPlaneLimit;
		float fAqPlaneOffset;
		float fWaveAudioMult;
		float fLookLRBehindCamHeight;
		RwV3D vecMoveRes;
		RwV3D vecTurnRes;
	};
]]

shared.validate_size('tBoatHandlingData', 0x3C)
