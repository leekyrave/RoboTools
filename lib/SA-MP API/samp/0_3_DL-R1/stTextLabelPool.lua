--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stTextLabel'

sys.ffi.cdef[[
	struct stTextLabelPool {
		stTextLabel	textLabel[2048];
		int					iIsListed[2048];
	}__attribute__ ((packed));
]]
