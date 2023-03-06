--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CTask')
shared.require('CPed')

shared.ffidef[[
	struct CTaskManager {
		CTask *aPrimaryTasks[5];
    CTask *aSecondaryTasks[6];
    CPed  *pPed;
	};
]]

shared.validate_size('CTaskManager', 0x30)
