--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CompressedVector')

shared.ffidef[[
	struct CColTrianglePlane {
		CompressedVector normal;
		unsigned short nDistance;
		unsigned char nOrientation;
	};
]]

shared.validate_size('CColTrianglePlane', 0xA)
