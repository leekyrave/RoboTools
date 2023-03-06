--[[
	Project: SA Memory
	File: lib/SAMemory/init.lua
	Authors: LUCHARE, FYP
	Website: blast.hk
	Copyright (c) 2018
]]

local shared = require 'SAMemory.shared'

local ffi = require 'ffi'

shared.defineall()

local ptr = {
	CPtrNodeSinglePool   = 0x00B74484;
	CPtrNodeDoublePool   = 0x00B74488;
	CEntryInfoNodePool   = 0x00B7448C;
	CPedPool 						 = 0x00B74490;
	CVehiclePool 				 = 0x00B74494;
	CBuildingPool 			 = 0x00B74498;
	CObjectPool 				 = 0x00B7449C;
	CDummyPool 					 = 0x00B744A0;
	CColModelPool 			 = 0x00B744A4;
	CTaskPool 					 = 0x00B744A8;
	EventPool 					 = 0x00B744AC;
	PointRoutePool 			 = 0x00B744B0;
	PatrolRoutePool 		 = 0x00B744B4;
	NodeRoutePool 			 = 0x00B744B8;
	TaskAllocatorPool    = 0x00B744CC;
	CPedIntelligencePool = 0x00B744C0;
	PedAttractorsPool    = 0x00B744C4;
	player_ped 				   = 0x00B6F5F0;
	player_vehicle  		 = 0x00BA18FC;
}

local module = {
	_ver 				= '1.0.3';

	code_pause	= ffi.cast('bool *', 0xB7CB48);
	user_pause 	= ffi.cast('bool *', 0xB7CB49);

	camera 			= 0x00B6F028;
	crosshairs 	= 0x00C8A838;
	require 		= shared.require;
}

function module.cast(ctype, ptr)
	return ffi.cast(ctype, ptr)
end

setmetatable(module, {
	__index = function(t, k)
		if ptr[k] ~= nil then
			return ffi.cast('uintptr_t *', ptr[k])
		else
			return rawget(t, k)
		end
	end
})

return module
