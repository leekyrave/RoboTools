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
	struct CStoredCollPoly {
		RwV3D        aMeshVertices[3];
		bool         bIsActual;
		unsigned int nLighting;
	};
]]

shared.validate_size('CStoredCollPoly', 0x2C)
