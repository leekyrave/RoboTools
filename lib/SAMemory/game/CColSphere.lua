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
	struct CColSphere {
		RwSphere      Sphere;
		unsigned char nMaterial;
		unsigned char nFlags;
		unsigned char nLighting;
		unsigned char nLight;
	};
]]

shared.validate_size('CColSphere', 0x14)
