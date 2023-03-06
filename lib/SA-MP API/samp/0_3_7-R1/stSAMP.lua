--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_7-R1.stServerInfo'
sys.safely_include 'SA-MP API.samp.0_3_7-R1.stServerPresets'
sys.safely_include 'SA-MP API.samp.0_3_7-R1.stSAMPPools'

sys.ffi.cdef[[
	struct stSAMP {
		void								*pUnk0;
		stServerInfo				*pServerInfo;
		unsigned char				byteSpace[24];
		char								szIP[257];
		char								szHostname[259];
		bool								bNametagStatus;
		unsigned int				ulPort;
		unsigned int				ulMapIcons[100];
		int									iLanMode;
		int									iGameState;
		unsigned int				ulConnectTick;
		stServerPresets		 *pSettings;
		void 							 *pRakClientInterface;
		stSAMPPools				 *pPools;
	} __attribute__ ((packed));
]]
