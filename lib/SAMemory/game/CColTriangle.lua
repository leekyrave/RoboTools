--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CColTriangle {
		unsigned short nVertA;
		unsigned short nVertB;
		unsigned short nVertC;
		unsigned char nMaterial;
		unsigned char nLight;
	};
]]

shared.validate_size('CColTriangle', 8)
