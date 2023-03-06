--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct tTransmissionGear {
		float fMaxVelocity;
		float fChangeUpVelocity;
		float fChangeDownVelocity;
	};
]]

shared.validate_size('tTransmissionGear', 0xC)
