--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('C2dEffect')
shared.require('CTaskTimer')

shared.ffidef[[
	struct CAttractorScanner {
		char field_0;
		char _pad[3];
		CTaskTimer field_4;
		C2dEffect *pEffectInUse;
		int field_14;
		int field_18[10];
		int field_40[10];
		int field_68[10];
	};
]]

shared.validate_size('CAttractorScanner', 0x90)
