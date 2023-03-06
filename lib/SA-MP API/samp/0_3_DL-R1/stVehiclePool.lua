--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stSAMPVehicle'

sys.ffi.cdef[[
	struct stVehiclePool {
		int						iVehicleCount;
		void					*pUnk0;
		unsigned char					byteSpace1[0x112C];
		stSAMPVehicle			*pSAMP_Vehicle[2000];
		int						iIsListed[2000];
		struct vehicle_info		*pGTA_Vehicle[2000];
		unsigned char					byteSpace2[2000 * 6];
		unsigned int				ulShit[2000];
		int						iIsListed2[2000];
		unsigned int				byteSpace3[2000 * 2];
		float					fSpawnPos[2000][3];
		int						iInitiated;
	}__attribute__ ((packed));
]]
