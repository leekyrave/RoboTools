
local mod = {}

local utf8 = {
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�',
	['�'] = '�'
}

function mod.upperCase(str)
	final = ""
	for i=1, #str do
		local c = str:sub(i,i)
		if utf8[c] ~= nil then
			final = final..utf8[c]
		else
			if getKey(c) ~= nil then
				final = final..utf8[getKey(c)]
			else
				final = final..c
			end
		end
	end
	return final
end

function getKey(val)
	for k,v in pairs(utf8) do
		if v == val then
			return k
		end
	end
	return nil
end

return mod