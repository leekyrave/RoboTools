--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CEntity')
shared.require('CAESound')

shared.ffidef[[
	struct CAEAudioEntity {
		void   **vtable;
		CEntity *pEntity;
		CAESound tempSound;
	};
]]

shared.validate_size('CAEAudioEntity', 0x7C)
