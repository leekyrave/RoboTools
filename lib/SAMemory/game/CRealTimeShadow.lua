--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CPhysical')
shared.require('CShadowCamera')
shared.require('RenderWare')

shared.ffidef[[
	struct CRealTimeShadow {
		struct CPhysical 	 *Owner;
		bool 					Created;
		unsigned char Intensity;
		CShadowCamera Camera;
		bool 					Blurred;
		CShadowCamera BlurCamera;
		unsigned int 	BlurPasses;
		bool 					DrawMoreBlur;
		unsigned int 	RwObjectType;
		RpLight 		 *Light;
		RwSphere 			BoundingSphere;
		RwSphere 			BaseSphere;
	};
]]

shared.validate_size('CRealTimeShadow', 0x4C)
