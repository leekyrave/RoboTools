--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('tTransmissionGear')

shared.ffidef[[
	struct CTransmission {
		tTransmissionGear aGears[6];
		unsigned char nDriveType;
		unsigned char nEngineType;
		unsigned char nNumberOfGears;
		char field_4B;
		unsigned int  nHandlingFlags;
		float         fEngineAcceleration;
		float         fEngineInertia;
		float         fMaxGearVelocity;
		int field_5C;
		float         fMinGearVelocity;
		float         fCurrentSpeed;
	};
]]

shared.validate_size('CTransmission', 0x68)
