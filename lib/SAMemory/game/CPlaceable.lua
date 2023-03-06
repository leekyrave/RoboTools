--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')
shared.require('CSimpleTransform')

shared.ffidef[[
	struct CPlaceable {
		void* _vtbl;
		CSimpleTransform Placement;
		RwMatrix        *Matrix;
	};
]]

shared.validate_size('CPlaceable', 0x18)
