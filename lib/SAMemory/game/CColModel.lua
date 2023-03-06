--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CCollisionData')
shared.require('RenderWare')

shared.ffidef[[
	struct CColModel {
		void* _vtbl;
		RwBBox BoundBox;
		RwSphere   BoundSphere;
		CCollisionData *pColData;
	};
]]

shared.validate_size('CColModel', 0x30)
