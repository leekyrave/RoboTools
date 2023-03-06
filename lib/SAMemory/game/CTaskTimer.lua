--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.ffidef[[
	struct CTaskTimer {
		int  m_nStartTime;
		int  m_nInterval;
		bool m_bStarted;
		bool m_bStopped;
		char _pad[2];
	};
]]

shared.validate_size('CTaskTimer', 0xC)
