-- This file is part of SA MoonLoader package.
-- Licensed under the MIT License.
-- Copyright (c) 2018, BlastHack Team <blast.hk>

local workdir = getWorkingDirectory()

local config = {
	PREFIX          = workdir..[[\luarocks]],
	WIN_TOOLS       = workdir..[[\luarocks\tools]],
	SYSCONFDIR      = workdir..[[\luarocks]],
	LUA_DIR         = workdir..[[\luajit]],
	LUA_INCDIR      = workdir..[[\luajit\inc]],
	LUA_LIBDIR      = workdir..[[\luajit\lib]],
	LUA_BINDIR      = workdir..[[\luajit\bin]],
	LUA_INTERPRETER = [[luajit.exe]],
	SYSTEM          = [[windows]],
	PROCESSOR       = [[x86]],
	FORCE_CONFIG    = true,
}

local function rewrite_hardcoded_config()
	local hc = assert(io.open(config.PREFIX..[[\lua\luarocks\core\hardcoded.lua]], 'w'))
	hc:write('return {\n')
	for k, v in pairs(config) do
		if type(v) == 'string' then
			hc:write(('\t%s = [[%s]],\n'):format(k, v))
		else
			hc:write(('\t%s = %s,\n'):format(k, v))
		end
	end
	hc:write('}\n')
	hc:close()
end

local function configure()
	local f = io.open(workdir..[[\luarocks\path.txt]], 'r')
	local path
	if f then
		path = f:read('*all')
		f:close()
	end
	if workdir ~= path then
		rewrite_hardcoded_config()
		f = assert(io.open(workdir..[[\luarocks\path.txt]], 'w'))
		f:write(workdir)
		f:close()
	end
end

local function parse_package_string(dep)
	local verpos = dep:find('@[^@]*$')
	local version, server
	if verpos then
		version = dep:sub(verpos + 1)
		dep = dep:sub(1, verpos - 1)
	end
	local srvpos = dep:find(':[^:]*$')
	if srvpos then
		server = dep:sub(1, srvpos - 1)
		dep = dep:sub(srvpos + 1)
	end
	local name = dep
	return name, version, server
end

local function concat_args(sep, ...)
	local strings = {}
	for i, v in ipairs({...}) do
		table.insert(strings, tostring(v))
	end
	return table.concat(strings, sep)
end

local function shallow_copy(t, dest)
	local copy = dest or {}
	for k, v in pairs(t) do
		copy[k] = v
	end
	return copy
end

local package_backup
local function create_luarocks_environment()
	local env = {errorlog={},require=require,coroutine={wrap=coroutine.wrap,yield=coroutine.yield,resume=coroutine.resume,status=coroutine.status,isyieldable=coroutine.isyieldable,running=coroutine.running,create=coroutine.create},assert=assert,tostring=tostring,tonumber=tonumber,io={input=io.input,stdin=io.stdin,tmpfile=io.tmpfile,read=io.read,output=io.output,open=io.open,close=io.close,write=io.write,popen=io.popen,flush=io.flush,type=io.type,lines=io.lines,stdout=io.stdout,stderr=io.stderr},rawget=rawget,xpcall=xpcall,ipairs=ipairs,print=print,pcall=pcall,gcinfo=gcinfo,module=module,setfenv=setfenv,jit={arch=jit.arch,version=jit.version,version_num=jit.version_num,status=jit.status,on=jit.on,os=jit.os,off=jit.off,flush=jit.flush,attach=jit.attach,opt={start=jit.opt.start}},pairs=pairs,bit={rol=bit.rol,rshift=bit.rshift,ror=bit.ror,bswap=bit.bswap,bxor=bit.bxor,bor=bit.bor,arshift=bit.arshift,bnot=bit.bnot,tobit=bit.tobit,lshift=bit.lshift,tohex=bit.tohex,band=bit.band},debug={setupvalue=debug.setupvalue,getregistry=debug.getregistry,traceback=debug.traceback,setlocal=debug.setlocal,getupvalue=debug.getupvalue,gethook=debug.gethook,sethook=debug.sethook,getlocal=debug.getlocal,upvaluejoin=debug.upvaluejoin,getinfo=debug.getinfo,getfenv=debug.getfenv,setmetatable=debug.setmetatable,upvalueid=debug.upvalueid,getuservalue=debug.getuservalue,debug=debug.debug,getmetatable=debug.getmetatable,setfenv=debug.setfenv,setuservalue=debug.setuservalue},package=package,error=error,load=load,loadfile=loadfile,rawequal=rawequal,string={find=string.find,format=string.format,rep=string.rep,gsub=string.gsub,len=string.len,gmatch=string.gmatch,dump=string.dump,match=string.match,reverse=string.reverse,byte=string.byte,char=string.char,upper=string.upper,lower=string.lower,sub=string.sub},unpack=unpack,table={maxn=table.maxn,move=table.move,pack=table.pack,foreach=table.foreach,sort=table.sort,remove=table.remove,foreachi=table.foreachi,getn=table.getn,concat=table.concat,insert=table.insert},_VERSION=_VERSION,newproxy=newproxy,dofile=dofile,collectgarbage=collectgarbage,loadstring=loadstring,next=next,math={ceil=math.ceil,tan=math.tan,log10=math.log10,randomseed=math.randomseed,cos=math.cos,sinh=math.sinh,random=math.random,huge=math.huge,pi=math.pi,max=math.max,atan2=math.atan2,ldexp=math.ldexp,floor=math.floor,sqrt=math.sqrt,deg=math.deg,atan=math.atan,fmod=math.fmod,acos=math.acos,pow=math.pow,abs=math.abs,min=math.min,sin=math.sin,frexp=math.frexp,log=math.log,tanh=math.tanh,exp=math.exp,modf=math.modf,cosh=math.cosh,asin=math.asin,rad=math.rad},rawset=rawset,os={execute=os.execute,rename=os.rename,setlocale=os.setlocale,getenv=os.getenv,difftime=os.difftime,remove=os.remove,date=os.date,exit=os.exit,time=os.time,clock=os.clock,tmpname=os.tmpname},select=select,rawlen=rawlen,type=type,getmetatable=getmetatable,getfenv=getfenv,setmetatable=setmetatable}
	env._G = env
	-- there is no way to control the environment of `require` properly,
	-- so we have to backup the `package` table and let `require` to change it.
	-- the backed-up table is restored when all work is done.
	package_backup = shallow_copy(package)
	package_backup.preload = shallow_copy(package.preload)
	package_backup.loaded = shallow_copy(package.loaded)
	package_backup.loaders = shallow_copy(package.loaders)
	package_backup.searchers = package_backup.loaders
	package_backup.loaded._G = env
	env.package.path = ([[%s\lua\?.lua;%s\lua\?\init.lua]]):format(config.PREFIX, config.PREFIX)
	env.package.cpath = config.PREFIX..'\\?.dll' -- not needed actually
	return env
end

local function initialize_luarocks()
	-- redefine logging functions
	local util = require('luarocks.util')
	util.warning = function(msg)
		if msg and #tostring(msg) > 0 then
			print('[luarocks] [warning]', msg)
		end
	end
	util.printerr = function(...)
		local str = concat_args('   ', ...)
		if #str > 0 then
			table.insert(errorlog, str)
			print('[luarocks] [error]', str)
		end
	end
	util.printout = function(...)
		local str = concat_args('   ', ...)
		if #str > 0 then
			print('[luarocks]', str)
		end
	end
	-- initialize luarocks
	local cfg = require('luarocks.core.cfg')
	require('luarocks.loader')
	local fs = require('luarocks.fs')
	local ok, err = cfg.init()
	if not ok then
		error(err)
	end
	fs.init()
end

local luarocks
local function run_luarocks(fn, ...)
	if not luarocks then
		luarocks = create_luarocks_environment()
		setfenv(initialize_luarocks, luarocks)
		initialize_luarocks()
	end
	setfenv(fn, luarocks)
	return fn(...)
end

local function test_installed_package(name, version)
	return run_luarocks(function()
		local queries = require('luarocks.queries')
		local search = require('luarocks.search')

		local query = queries.new(name:lower(), version, nil, nil, '>=')
		local rock_name, rock_version = search.pick_installed_rock(query)
		if rock_name then
			return true
		end
		-- `rock_version` is error message
		if rock_version:find('cannot find package') then
			return false
		end
		error(rock_version)
	end)
end

local function find_rock_tree(trees, name)
	for _, tree in ipairs(trees) do
	   if type(tree) == 'table' and name == tree.name then
		  if not tree.root then
			 error('Configuration error: tree "'..tree.name..'" has no "root" field.')
		  end
		  return tree
	   end
	end
end

local luarocks_install_flags
local function install_package(name, version, server)
	if server and not server:match('^[^:]+://(.*)') then
		server = 'http://luarocks.org/manifests/'..server
	end
	return run_luarocks(function()
		if not luarocks_install_flags then
			local dir = require('luarocks.dir')
			local path = require('luarocks.path')
			local cfg = require('luarocks.core.cfg')
			local flags = {
				['deps-mode'] = 'order',
				['no-doc'] = true,
				['timeout'] = 10,
			}
			cfg.connection_timeout = 10
			-- initialize rock tree paths
			local tree = find_rock_tree(cfg.rocks_trees, 'lib')
			if not tree then
				error('Configuration error: no tree "lib".')
			end
			flags['tree'] = dir.normalize(tree.root)
			path.use_tree(tree)
			cfg.variables.ROCKS_TREE = cfg.rocks_dir
			cfg.variables.SCRIPTS_DIR = cfg.deploy_bin_dir

			default_rock_servers = cfg.rocks_servers
			luarocks_install_flags = flags
		end
		local cfg
		if server then
			cfg = require('luarocks.core.cfg')
			local util = require('luarocks.core.util')
			cfg.rocks_servers = shallow_copy(default_rock_servers)
			table.insert(cfg.rocks_servers, 1, server)
		end
		local install = require('luarocks.cmd.install')
		local ok, err = install.command(luarocks_install_flags, name, version)
		if not ok then
			error(err)
		end
		if server then
			cfg.rocks_servers = default_rock_servers
		end
		return true
	end)
end

local function run_scheduled_functions()
	run_luarocks(function()
		local util = require('luarocks.util')
		util.run_scheduled_functions()
	end)
end

local ffi
local function msgbox(text, title, style)
	if not ffi then
		ffi = require('ffi')
		ffi.cdef [[int MessageBoxA(void* hWnd, const char* lpText, const char* lpCaption, unsigned int uType);]]
	end
	local hwnd = nil
	if readMemory then
		-- game window
		hwnd = ffi.cast('void*', readMemory(0x00C8CF88, 4, false))
	end
	showCursor(true)
	local ret = ffi.C.MessageBoxA(hwnd, text, '[MoonLoader] '..script.this.filename..': '..title, (style or 0) + 0x50000)
	showCursor(false)
	return ret
end

local function failure(msg)
	if luarocks_install_flags then
		run_scheduled_functions()
	end
	if luarocks then
		local errorlog = table.concat(luarocks.errorlog, '\n')
		msg = errorlog..'\n'..msg
	end
	msgbox(msg, 'Failed to install dependencies', 0x10)
	error(msg)
end

local function cleanup()
	shallow_copy(package_backup, package)
	package_backup = nil
	luarocks = nil
	luarocks_install_flags = nil
	collectgarbage()
	collectgarbage()
end

local function batch_install(packages)
	print('Requested packages: '..table.concat(packages, ', '))
	local to_install = {}
	local time_test, time_install = os.clock(), nil
	for i, dep in ipairs(packages) do
		local name, version, server = parse_package_string(dep)
		local ok, result = pcall(test_installed_package, name, version)
		if ok then
			if result == false then
				table.insert(to_install, {name = name, ver = version, svr = server, full = dep})
			end
		else
			failure(dep..'\n'..result)
		end
	end
	time_test = os.clock() - time_test
	if #to_install > 0 then
		local list = ''
		for i, pkg in ipairs(to_install) do
			list = list..pkg.full..'\n'
		end
		if 7 --[[IDNO]] == msgbox('Script "'..script.this.filename..'" asks to install the following packages:\n\n'..
			list..'\nInstallation process will take some time.\nProceed?', 'Package installation', 0x04 + 0x20 --[[MB_YESNO+MB_ICONQUESTION]])
		then
			error('Dependency installation was interrupted by user.')
		end
		time_install = os.clock()
		for i, pkg in ipairs(to_install) do
			local ok, err = pcall(install_package, pkg.name, pkg.ver, pkg.svr)
			if not ok then
				failure(pkg.full..'\n'..err)
			end
		end
		time_install = os.clock() - time_install
	end
	-- DEBUG
	local dbgmsg = ('Installed check took %.3fs.'):format(time_test)
	if #to_install > 0 then
		logdebug(dbgmsg, ('Installation of %d packages took %.2fs. Total %.2fs.'):format(#to_install, time_install, time_test + time_install))
		run_scheduled_functions()
		-- v.027 feature: suspend main thread until all scripts are loaded
		coroutine.yield()
	else
		logdebug(dbgmsg)
	end
	cleanup()
end

-- API

local mod = {
	_VERSION = '0.2.0'
}

function mod.install(...)
	return batch_install({...})
end

function mod.test(...)
	local results = {}
	for i, dep in ipairs({...}) do
		local name, version, server = parse_package_string(dep)
		local ok, result = pcall(test_installed_package, name, version)
		if not ok then
			cleanup()
			return nil, result
		end
		results[dep] = result
	end
	cleanup()
	return results
end

setmetatable(mod, {
	__call = function(t, a1, ...)
		if type(a1) == 'table' then
			return batch_install(a1)
		end
		return batch_install({a1, ...})
	end
})

configure()

return mod
