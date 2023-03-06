--[[
	Project: SA-MP API
	
	Author: LUCHARE
	

	All structures are taken from mod_s0beit_sa.
	Copyright: BlastHack
	mod_sa is available from https://github.com/BlastHackNet/mod_s0beit_sa/
]]

local sys = require 'SA-MP API.kernel'

sys.ffi.cdef[[
	struct stServerPresets {
		unsigned char byteCJWalk;
		int m_iDeathDropMoney;
		float	fWorldBoundaries[4];
		bool m_bAllowWeapons;
		float	fGravity;
		unsigned char byteDisableInteriorEnterExits;
		unsigned int ulVehicleFriendlyFire;
		bool m_byteHoldTime;
	  bool m_bInstagib;
	  bool m_bZoneNames;
	  bool m_byteFriendlyFire;
		int		iClassesAvailable;
		float	fNameTagsDistance;
		bool m_bManualVehicleEngineAndLight;
		unsigned char byteWorldTime_Hour;
		unsigned char byteWorldTime_Minute;
		unsigned char byteWeather;
		unsigned char byteNoNametagsBehindWalls;
		int iPlayerMarkersMode;
		float	fGlobalChatRadiusLimit;
		unsigned char byteShowNameTags;
	 	bool m_bLimitGlobalChatRadius;
	} __attribute__ ((packed));
]]
