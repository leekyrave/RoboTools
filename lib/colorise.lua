local c = {}

c.hex2rgb = function (hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

c.hex2rgba = function (hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)), tonumber("0x"..hex:sub(7,8))
end

c.rgb2hex = function (rgb)
	local hexadecimal = '#'

	for key = 1, #rgb do
	    local value = rgb[key] 
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'
		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

c.rgba2hex = function(rgb)
   return c.rgb2hex (rgb) 
end

return c
