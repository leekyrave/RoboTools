--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stSAMPVehicle {
		stSAMPEntity  vehicle_info;
		unsigned int			bUnk0;
		struct vehicle_info *pGTA_Vehicle;
		unsigned char				byteUnk1[8];
		int					iIsMotorOn;
		int					iIsLightsOn;
		int					iIsLocked;
		unsigned char				byteIsObjective;
		int					iObjectiveBlipCreated;
		unsigned char				byteUnk2[16];
		unsigned char				byteColor[2];
		int					iColorSync;
		int					iColor_something;
	} __attribute__ ((packed));
]]
