--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('CAEAudioEntity')
shared.require('CAESound')

shared.ffidef[[
	struct CAETwinLoopSoundEntity {
		CAEAudioEntity  AudioEntity;
		short           nBankSlotId;
    short           nSoundType[2];
    char _pad1[2];
    CAEAudioEntity *pBaseAudio;
    short field_88;
    short field_8A;
    short field_8C;
    short           nPlayTimeMin;
    short           nPlayTimeMax;
    char _pad2[2];
    unsigned int    nTimeToSwapSounds;
    bool            bPlayingFirstSound;
    char _pad3;
    short           anStartingPlayPercentage[2];
    short field_9E;
    CAESound       *apSounds[2];
	};
]]

shared.validate_size('CAETwinLoopSoundEntity', 0xA8)
