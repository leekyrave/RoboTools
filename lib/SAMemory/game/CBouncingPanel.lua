--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('RenderWare')

shared.ffidef[[
	struct CBouncingPanel {
		unsigned short nFrameId;
		unsigned short nAxis;
		float          fAngleLimit;
		RwV3D        vecRotation;
		RwV3D        vecPos;
	};
]]

shared.validate_size('CBouncingPanel', 0x20)
