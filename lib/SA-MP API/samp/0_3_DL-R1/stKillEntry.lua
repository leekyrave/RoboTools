--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stKillEntry {
		char			szKiller[25];
		char			szVictim[25];
		unsigned int	clKillerColor;
		unsigned int	clVictimColor;
		unsigned char		byteType;
	}__attribute__ ((packed));
]]
