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
	struct CEventHandler {
		CPed *m_pPed;
		int field_4;
		int field_8;
		int field_C;
		int field_10;
		int field_14;
		int field_18;
		char field_1C;
		char field_1D;
		short field_1E;
		int field_20;
		int field_24;
		int field_28;
		int field_2C;
		int field_30;
	};
]]

shared.validate_size('CEventHandler', 0x34)
