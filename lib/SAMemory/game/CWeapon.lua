--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

shared.require('FxSystem_c')

shared.ffidef[[
	enum eWeaponState {
    WEAPONSTATE_READY,
    WEAPONSTATE_FIRING,
    WEAPONSTATE_RELOADING,
    WEAPONSTATE_OUT_OF_AMMO,
    WEAPONSTATE_MELEE_MADECONTACT
	};

	struct CWeapon {
		unsigned int nType;
		unsigned int nState;
		unsigned int nAmmoInClip;
		unsigned int nTotalAmmo;
		unsigned int nTimeForNextShot;
		char field_14;
		char field_15;
		char field_16;
		char field_17;
    FxSystem_c *pFxSystem;
	};
]]

shared.validate_size('CWeapon', 0x1C)
