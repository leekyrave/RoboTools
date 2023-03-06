--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CQueuedMode {
		unsigned short nMode;
		float 				 fDuration;
		unsigned short nMinZoom;
		unsigned short nMaxZoom;
	};
]]

shared.validate_size('CQueuedMode', 0xC)
