--[[
	Project: SA Memory
	Authors: LUCHARE, FYP
	Website: blast.hk

	All structures are taken from plugin-sdk.
	plugin-sdk is available from https://github.com/DK22Pac/plugin-sdk
]]

local shared = require 'SAMemory.shared'

--[[
	Validate only for:
		PedPool
		VehiclePool
		BuildingPool
		ObjectPool
		DummyPool
		ColModelPool
		TaskPool
		PedIntelligencePool
		PtrNodeSingleLinkPool
		PtrNodeDoubleLinkPool
]]

shared.ffidef[[
	union tPoolObjectFlags {
		struct {
			unsigned char nId : 7;
			bool bEmpty : 1;
		};
	};

	struct CPool {
		void             *pObjects;
		tPoolObjectFlags *byteMap;
		int               nSize;
		int               nFirstFree;
		bool              bOwnsAllocations;
		bool field_11;
	};
]]

shared.validate_size('CPool', 0x14)
