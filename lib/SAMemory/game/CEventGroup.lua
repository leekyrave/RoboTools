--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CPed')

shared.ffidef[[
	struct CEventGroup {
		void        *vtable;
		CPed         *pPed;
		unsigned int  dwCount;
		void         *apEvents[16];
	};
]]

shared.validate_size('CEventGroup', 0x4C)
