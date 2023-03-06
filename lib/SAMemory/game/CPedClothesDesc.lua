--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CPedClothesDesc {
		unsigned int anModelKeys[10];
		unsigned int anTextureKeys[18];
		float fFatStat;
		float fMuscleStat;
	};
]]

shared.validate_size('CPedClothesDesc', 0x78)
