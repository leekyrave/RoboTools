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
	struct CColLine {
		RwV3D m_vecStart;
		float field_C;
		RwV3D m_vecEnd;
		float field_1C;
	};
]]

shared.validate_size('CColLine', 0x20)
