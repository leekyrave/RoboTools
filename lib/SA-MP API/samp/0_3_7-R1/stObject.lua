--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]


local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stObject {
		stSAMPEntity  object_info;
		unsigned char				byteUnk0[2];
		unsigned int			ulUnk1;
		int						iModel;
		unsigned short			byteUnk2;
		float					fDrawDistance;
		float					fUnk;
		float					fPos[3];
		unsigned char				byteUnk3[68];
		unsigned char				byteUnk4;
		float					fRot[3];
	}__attribute__ ((packed));
]]
