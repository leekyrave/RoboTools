--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stSAMPEntity {
		void		*pVTBL;
		unsigned char		byteUnk0[60];
		void			*pGTAEntity;
		unsigned int	ulGTAEntityHandle;
	}__attribute__ ((packed));
]]
