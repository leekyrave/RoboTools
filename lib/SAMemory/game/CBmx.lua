--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CBike')

shared.ffidef[[
	struct CBmx {
		CBike Bike;
		float field_814;
		float field_818;
		float field_81C;
		float field_820;
		float field_824;
		float field_828;
		float m_fDistanceBetweenWheels;
		float m_fWheelsBalance;
		unsigned char field_834;
		char _pad[3];
	};
]]

shared.validate_size('CBmx', 0x838)
