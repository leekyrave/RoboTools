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
	struct tColLighting
	{
		unsigned char day : 4;
		unsigned char night : 4;
	};

	struct CColPoint {
		RwV3D       		vecPoint;
		float 					field_C;
		RwV3D       		vecNormal;
		float 					field_1C;
		unsigned char		nSurfaceTypeA;
		unsigned char 	nPieceTypeA;
	  struct tColLighting nLightingA;
	  char 						_pad;
		unsigned char 	nSurfaceTypeB;
		unsigned char 	nPieceTypeB;
	  struct tColLighting nLightingB;
	  char 						_pad2;
		float         	fDepth;
	};
]]

shared.validate_size('CColPoint', 0x2C)
