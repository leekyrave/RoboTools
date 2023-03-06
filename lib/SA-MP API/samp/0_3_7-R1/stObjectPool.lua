--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]


local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_7-R1.stObject'

sys.ffi.cdef[[
	struct stObjectPool {
		int				iObjectCount;
		int				iIsListed[1000];
		stObject 	*object[1000];
	}__attribute__ ((packed));
]]
