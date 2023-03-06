--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stSAMPPed {
		stSAMPEntity 				actor_info;
		int									usingCellPhone;
		unsigned char				byteUnk0[600];
		void* 							pGTA_Ped;
		unsigned char				byteUnk1[22];
		unsigned char				byteKeysId;
		unsigned short			ulGTA_UrinateParticle_ID;
		int									DrinkingOrSmoking;
		int									object_in_hand;
		int									drunkLevel;
		unsigned char				byteUnk2[5];
		int									isDancing;
		int									danceStyle;
		int									danceMove;
		unsigned char				byteUnk3[20];
		int									isUrinating;
	}__attribute__ ((packed));
]]
