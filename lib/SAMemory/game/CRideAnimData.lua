--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CRideAnimData {
		unsigned int nAnimGroup;
		int dword4;
		float        fAnimLean;
		int dwordC;
		float dword10;
		float        fHandlebarsAngle;
		float        fAnimPercentageState;
	};
]]

shared.validate_size('CRideAnimData', 0x1C)
