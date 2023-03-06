--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_7-R1.stPickup'

sys.ffi.cdef[[
	struct stPickupPool {
		int					iPickupsCount;
		unsigned int		ul_GTA_PickupID[4096];
		int					iPickupID[4096];
		int					iTimePickup[4096];
		unsigned char			unk[4096 * 3];
		stPickup 		pickup[4096];
	}__attribute__ ((packed));
]]
