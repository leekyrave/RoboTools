--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stActorPool {
		int					iLastActorID;
		stSAMPEntity		*pActor[1000];
		int					iIsListed[1000];
		struct actor_info	*pGTAPed[1000];
		unsigned int			ulUnk0[1000];
		unsigned int			ulUnk1[1000];
	}__attribute__((packed));
]]
