--[[
	Project: SA Memory
	File: lib/SAMemory/Kernel.lua
	Authors: LUCHARE, FYP
	Website: blast.hk
	Copyright (c) 2018
]]

local ffi = require 'ffi'

local module = {}

function module.require(mod)
	if not package.loading then package.loading = {} end
	mod = 'SAMemory.game.' .. mod
	if package.loading[mod] == nil then
		package.loading[mod] = true
		local v = {require(mod)}
		package.loading[mod] = nil
		return unpack(v)
	end
end

function module.ffidef(def)
	local ok, err = pcall(ffi.cdef, def)
	if not ok then
		print('warning: '..err)
	end
end

function module.validate_size(struct, size)
	local sizeof = ffi.sizeof(struct) or 0
	assert(sizeof == size, ("validate_size('%s', %d) assertion failed! Expected size 0x%X, got 0x%X."):format(struct, size, size, sizeof))
end

function module.defineall()
	require('SAMemory.game.definitions')
end

return module
