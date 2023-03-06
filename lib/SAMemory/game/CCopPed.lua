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
	enum eCopType {
		COP_TYPE_CITYCOP,
		COP_TYPE_LAPDM1,
		COP_TYPE_SWAT1,
		COP_TYPE_SWAT2,
		COP_TYPE_FBI,
		COP_TYPE_ARMY,
		COP_TYPE_CSHER = 7
	};

	struct CCopPed {
		CPed          Ped;
		int 					field_79C;
		unsigned int  copType;
    int 					field_7A4;
		CCopPed       *pCopPartner;
		CPed          *apCriminalsToKill[5];
		char 					field_7C0;
	};
]]

shared.validate_size('CCopPed', 0x7C4)
