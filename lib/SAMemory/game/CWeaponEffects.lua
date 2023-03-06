--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require 'RenderWare'

shared.ffidef[[
	struct CWeaponEffects {
		bool    bActive;
		char 		_pad01[3];
		int     nTimeWhenToDeactivate;
		RwV3D 	vecPosn;
		unsigned int color;
		float   fSize;
		int 		field_1C;
		int 		field_20;
		float   m_fRotation;
		char 		field_28;
		char 		_pad29[3];
	};
]]

shared.validate_size('CWeaponEffects', 0x2C)
