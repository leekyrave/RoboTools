--[[
	Project: SA-MP API

	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stServerInfo'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stServerPresets'
sys.safely_include 'SA-MP API.samp.0_3_DL-R1.stSAMPPools'

sys.ffi.cdef[[
	struct stSAMP {
		unsigned char                 _pad0[20];
		void										*pUnk0;
		stServerInfo						*pServerInfo;
		unsigned char									_pad1[16];
		void										*pRakClientInterface;
		char										szIP[256 + 1];
		char										szHostname[256 + 1];
		unsigned char                 _pad2;
		bool                    bUpdateCameraTarget;
		bool										bNoNameTagStatus;
		unsigned int								ulPort;
		int										bLanMode;
		unsigned int								ulMapIcons[100];
		unsigned int						iGameState;
		unsigned int								ulConnectTick;
		stServerPresets					*pSettings;
		unsigned char                 _pad3[5];
		stSAMPPools							*pPools;
	} __attribute__ ((packed));
]]
