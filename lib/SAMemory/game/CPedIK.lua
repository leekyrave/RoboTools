--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CPed')

shared.ffidef[[
	struct CPedIK {
		CPed *pPed;
    float TorsoOrien[2];
    float fSlopePitch;
    float fSlopePitchLimitMult;
    float fSlopeRoll;
    float fBodyRoll;
    unsigned int nFlags;
	};
]]

shared.validate_size('CPedIK', 0x20)
