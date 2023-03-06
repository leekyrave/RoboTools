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
	struct CColDisk {
		RwV3D VecStart;
		float fStartRadius;
		unsigned char nMaterial;
		unsigned char nPiece;
		unsigned char nLighting;
		char _pad13;
		RwV3D VecEnd;
		float fEndRadius;
	};
]]

shared.validate_size('CColDisk', 0x24)
