--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stSpawnInfo {
		char byteTeam;
		int iSkin;
		int iCustomModel;
		char unk;
		float vecPos[3];
		float fRotation;
		int iSpawnWeapons[3];
		int iSpawnWeaponsAmmo[3];
	}__attribute__ ((packed));
]]
