--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CAEAudioEntity')

shared.ffidef[[
	struct CAEPoliceScannerAudioEntity {
		CAEAudioEntity AudioEntity;
	};
]]

shared.validate_size('CAEPoliceScannerAudioEntity', 0x7C)
