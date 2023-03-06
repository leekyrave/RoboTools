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

shared.ffidef[[
	enum eAudioPedType {
		PED_TYPE_GEN = 0,
		PED_TYPE_EMG = 1,
		PED_TYPE_PLAYER = 2,
		PED_TYPE_GANG = 3,
		PED_TYPE_GFD = 4,
		PED_TYPE_SPC = 5
	};

	struct CAEPedSpeechAudioEntity {
		CAEAudioEntity AudioEntity;
		char field_7C[20];
		char field_90;
		char field_91;
		short nVoiceType;
		short nVoiceID;
		short nVoiceGender;
		char field_98;
		bool bEnableVocalType;
		bool bMuted;
		char nVocalEnableFlag;
		char field_9C;
		char field_9D;
		char field_9E;
		char field_9F;
		CAESound *pSound;
		short field_A4;
		short field_A6;
		short field_A8;
		short field_AA;
		float fVoiceVolume;
		short nCurrentPhraseId;
		short field_B2;
		int field_B4[19];
	};
]]

shared.validate_size('CAEPedSpeechAudioEntity', 0x100)
