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
	struct CMatrix {
		RwV3D      right;
	 	unsigned int flags;
	 	RwV3D      up;
	 	unsigned int pad1;
	 	RwV3D      at;
	 	unsigned int pad2;
	 	RwV3D      pos;
	 	unsigned int pad3;

 		RwMatrix *pAttachMatrix;
 		bool bOwnsAttachedMatrix;
	};
]]

shared.validate_size('CMatrix', 0x48)
