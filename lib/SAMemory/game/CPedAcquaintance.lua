--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CPedAcquaintance {
		unsigned int nRespect;
		unsigned int nLike;
		unsigned int field_8;
		unsigned int nDislike;
		unsigned int nHate;
	};
]]

shared.validate_size('CPedAcquaintance', 0x14)
