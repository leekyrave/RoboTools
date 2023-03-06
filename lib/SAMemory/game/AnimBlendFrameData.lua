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
	struct AnimBlendFrameData {
		unsigned char  nFlags;
		RwV3D          vecOffset;
		void				  *pIFrame;
		unsigned int   nNodeId;
	};
]]

shared.validate_size('AnimBlendFrameData', 0x18)
