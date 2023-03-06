--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stScoreboardInfo {
		int					iIsEnabled;
		int					iPlayersCount;
		float				fTextOffset[2];
		float				fScalar;
		float				fSize[2];
		float				fUnk0[5];
		void				*pDirectDevice;
		void				*pDialog;
		void 				*pList;
		int					iOffset;
		int					iIsSorted;
	}__attribute__ ((packed));
]]
