--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CEntity')

shared.ffidef[[
	struct CEntityScanner {
		void *vtable;
		int field_4;
		unsigned int   nCount;
		CEntity *apEntities[16];
		int field_4C;
	};
]]

shared.validate_size('CEntityScanner', 0x50)
