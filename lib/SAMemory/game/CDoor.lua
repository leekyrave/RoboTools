--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CDoor {
		float         fOpenAngle;
		float         fClosedAngle;
		short         nDirn;
		unsigned char nAxis;
		unsigned char nDoorState;
		float         fAngle;
		float         fPrevAngle;
		float         fAngVel;
	};

]]

shared.validate_size('CDoor', 0x18)
