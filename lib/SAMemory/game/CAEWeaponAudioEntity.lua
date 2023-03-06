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
shared.require('CPed')

shared.ffidef[[
	struct CAEWeaponAudioEntity {
		CAEAudioEntity AudioEntity;
		char bPlayedMiniGunFireSound;
		char field_7D;
		char field_7E;
		char field_7F;
		char nChainsawSoundState;
		char field_81[3];
		int dwFlameThrowerLastPlayedTime;
		int dwSpraycanLastPlayedTime;
		int dwExtinguisherLastPlayedTime;
		int dwMiniGunFireSoundPlayedTime;
		int dwTimeChainsaw;
		int dwTimeLastFired;
		CAESound *pSounds;
		char bActive;
		char field_A1[3];
		CPed* pPed;
	};
]]

shared.validate_size('CAEWeaponAudioEntity', 0xA8)
