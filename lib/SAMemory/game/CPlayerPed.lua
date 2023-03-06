--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]


local shared = require 'SAMemory.shared'

shared.require 'CPed'

shared.ffidef[[
	struct CPlayerPed {
		CPed 		Ped;
		CPed 		*pPlayerTargettedPed;
		int 		field_7A0;
	};
]]

shared.validate_size('CPlayerPed', 0x7A4)
