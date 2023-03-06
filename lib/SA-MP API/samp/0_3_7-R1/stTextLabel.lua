--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stTextLabel {
		char				*pText;
		unsigned int		color;
		float				fPosition[3];
		float				fMaxViewDistance;
		unsigned char			byteShowBehindWalls;
		unsigned short		sAttachedToPlayerID;
		unsigned short		sAttachedToVehicleID;
	}__attribute__ ((packed));
]]
