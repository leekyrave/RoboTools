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
	struct CCrimeBeingQd {
		unsigned int nCrimeType;
		unsigned int nCrimeID;
		unsigned int nTimeOfQing;
		RwV3D        vecCoors;
		bool         bAlreadyReported;
		bool         bPoliceDontReallyCare;
		char _pad1A[2];
	};
]]

shared.validate_size('CCrimeBeingQd', 0x1C)
