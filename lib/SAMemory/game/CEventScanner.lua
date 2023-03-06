--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CTaskTimer')
shared.require('CAttractorScanner')

shared.ffidef[[
	struct CEventScanner {
		int field_0;
		CTaskTimer field_4;
		CTaskTimer field_10;
		CAttractorScanner m_attractorScanner;
		CTaskTimer field_AC;
		char field_B8;
		char field_B9;
		char field_BA;
		char field_BB;
		CTaskTimer field_BC;
		CTaskTimer field_C8;
	};
]]

shared.validate_size('CEventScanner', 0xD4)
