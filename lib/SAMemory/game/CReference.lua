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
	struct CReference {
		CReference *pNext;
		CEntity   **ppEntity;
	};
]]

shared.validate_size('CReference', 8)
