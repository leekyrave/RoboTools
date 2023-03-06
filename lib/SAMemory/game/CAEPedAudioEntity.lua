--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CAESound')
shared.require('CAEAudioEntity')
shared.require('CAETwinLoopSoundEntity')

shared.ffidef[[
	struct CAEPedAudioEntity {
		CAEAudioEntity AudioEntity;
		char field_7C;
    char field_7D;
    short field_7E;
    int field_80;
    float field_84;
    float field_88;
    char field_8C[8];
    CPed *pPed;
    char field_98;
    char field_99[3];
    CAESound *field_9C;
    int field_A0;
    CAESound *field_A4;
		CAETwinLoopSoundEntity TwinLoopSoundEntity;
    CAESound *field_150;
    float field_154;
    float field_158;
	};
]]

shared.validate_size('CAEPedAudioEntity', 0x15C)
