-- @madrasso | Thanks Imring, remade your chat

local effil = require 'effil'
local encoding = require('lib.encoding')
encoding.default 										= 'CP1251'
u8 														= encoding.UTF8
cp1251 													= encoding.CP1251
local site = "https://mdx-ahk.ru/bots/SAMPtoVK.php?"

local function asyncHttpRequest(method, url, args, resolve, reject)
	local request_thread = effil.thread(function (method, url, args)
        local requests = require 'requests'
        local result, response = pcall(requests.request, method, url, args)
        if result then
            response.json, response.xml = nil, nil
            return true, response
        else
            return false, response
        end
	end)(method, url, args)
	if not resolve then resolve = function() end end
	if not reject then reject = function() end end
	lua_thread.create(function()
        local runner = request_thread
        while true do
            local status, err = runner:status()
            if not err then
                if status == 'completed' then
                    local result, response = runner:get()
                    if result then resolve(response)
					else reject(response) end
                    return
                elseif status == 'canceled' then
                    return reject(status)
                end
            else
                return reject(err)
            end
            wait(0)
        end
	end)
end

local function toSendGet(str)
    local diff = urlencode(u8:encode(str, 'CP1251'))
    return diff
end

local function urlencode(str)
    if (str) then
        str = string.gsub (str, "\n", "\r\n")
        str = string.gsub (str, "([^%w ])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
        str = string.gsub (str, " ", "+")
    end
    return str
end

local mdx = {}

function mdx.request(params, func)
    local a = ''
    for i, k in pairs(params) do
        a = a .. i .. '=' .. toSendGet(k) .. '&'
    end
    a = a:gsub('&$', '')
    func = func or function() end
    asyncHttpRequest('GET', site .. a, nil, function(response) 
        func(response.text) 
    end)
end

function mdx.sendmessage(message, id, func)
    mdx.request({type = 'send', message = message, id = id}, func)
end

function mdx.getmessage(id, func)
    mdx.request({type = 'get', id = id}, func)
end

return mdx