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
	struct CShadowCamera {
		RwCamera  *m_pRwCamera;
		RwTexture *m_pRwRenderTexture;
	};
]]

shared.validate_size('CShadowCamera', 8)
