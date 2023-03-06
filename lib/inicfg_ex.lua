-- The ini file config library.
-- 
-- This file is part of SA MoonLoader package.
-- Licensed under the MIT License.
-- Copyright (c) 2019, BlastHack Team <blast.hk>

-- Mod by Double Tap Inside of inicfg.lua v 1.0.1


local inicfg_ex = {}
local qstr = {}

function qstr.value_tostring(v)
	if "string" == type(v) then
		v = v:gsub("\n", "\\n" )
		
		if string.match(v:gsub("[^'\"]", ""), '^"+$') then
			return "'"..v.."'"
		end
		
		return '"'..v:gsub('"', '\\"')..'"'
		
	elseif "table" == type(v) then
		return qstr.table_tostring(v)
	
	elseif "number" == type(v) then
		return tostring(v)
	
	else
		return qstr.value_tostring(tostring(v))
	end
end

function qstr.value_fromstring(str)
	local lstr = str:lower()

	if lstr == "true"
	or lstr == "false"
	or tonumber(str)
	or str:match("^{.*}$")
	or str:match('^".*"$')
	or str:match("^'.*'$") then
		local code = load("return "..str)
		
		if code then
			return code()
		end
	end
end

function qstr.key_tostring(k)
	if "string" == type(k) and k:match("^[_%a][_%a%d]*$") then
		return k
		
	else
		return "["..qstr.value_tostring(k).."]"
	end
end

function qstr.table_tostring(tbl)
	local result, done = {}, {}
  
	for k, v in ipairs(tbl) do
		table.insert(result, qstr.value_tostring(v))
		done[ k ] = true
	end
  
	for k, v in pairs(tbl) do
		if not done[k] then
			table.insert(result, qstr.key_tostring(k).." = "..qstr.value_tostring(v))
		end
	end
	
	return "{"..table.concat(result, ", ").."}"
end



local function find_config(file)
    local workdir = getWorkingDirectory()
    local paths = {
        workdir..[[\config\]]..file..'.ini',
        workdir..[[\config\]]..file,
        file,
    }
    for _, path in ipairs(paths) do
        if doesFileExist(path) then
            return path
        end
    end
    return nil
end

function inicfg_ex.load(default, file)
    local path = find_config(file or (script.this.filename..'.ini'))
    if not path then return default end
    local f = io.open(path, 'r')
    if not f then return nil end
    local data = default or {}
    local cursec
    for line in f:lines() do
        local secname = string.match(line, '^%s*%[([^%[%]]+)%]%s*$')
        if secname then
            local section = tonumber(secname) or secname
            if data[section] then
                cursec = data[section]
            else
                cursec = {}
                data[section] = cursec
            end
        else
            local key, value = line:match('^%s*([^=%s]+)%s-=%s*(.*)$')
            if key and value then
                if not cursec then
                    error('parameter out of section')
                end
                cursec[tonumber(key) or key] = qstr.value_fromstring(value)
            end
        end
    end
	f:close()
    return data
end

function inicfg_ex.save(data, file)
	assert(type(data) == 'table')
    local file = file or (script.this.filename..'.ini')
    local path = find_config(file)
    local dir
    if not path then
        if file:match('^%a:[\\/]') then
            dir = file:match('(.+[\\/]).-')
            path = file
        else
            if file:sub(-4):lower() ~= '.ini' then
                file = file..'.ini'
            end
            dir = getWorkingDirectory()..[[\config\]]
            path = dir..file
			dir = path:match('(.+[\\/]).-')
        end
    end
	
    if dir and not doesDirectoryExist(dir) then
        createDirectory(dir)
    end
    local f = io.open(path, 'w')
    if f then
        for secname, secdata in pairs(data) do
            assert(type(secdata) == 'table')
            f:write('['..tostring(secname)..']\n')
            for key, value in pairs(secdata) do
				f:write(tostring(key)..' = '..qstr.value_tostring(value)..'\n')
            end
            f:write('\n')
        end
		f:close()
        return true
    end
    return false
end

return inicfg_ex
