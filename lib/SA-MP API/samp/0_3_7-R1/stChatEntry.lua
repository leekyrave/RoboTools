--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stChatEntry {
		unsigned int	SystemTime;
		char			szPrefix[28];
		char			szText[144];
		unsigned char		unknown[64];
		int				iType;
		unsigned int	clTextColor;
		unsigned int	clPrefixColor;
	} __attribute__ ((packed));
]]
