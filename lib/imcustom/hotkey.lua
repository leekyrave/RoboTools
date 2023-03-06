local imgui = require 'imgui'
local vkeys = require 'vkeys'
local rkeys = require 'rkeys'
local wm = require 'lib.windows.message'

local tBlockKeys = {[vkeys.VK_RETURN] = true, [vkeys.VK_T] = true, [vkeys.VK_F6] = true, [vkeys.VK_F8] = true}
local tBlockChar = {[116] = true, [84] = true}
local tBlockNextDown = {}
local module = {}
module._VERSION = "1.1.5"
module._SETTINGS = {
    noKeysMessage = "No"
}

local tHotKeyData = {
    edit = nil,
    save = {}
}
local tKeys = {}

function module.HotKey(name, keys, lastkeys, width)
    local width = width or 90
    local name = tostring(name)
    local lastkeys = lastkeys or {}
    local keys, bool = keys or {}, false
    lastkeys.v = keys.v

    local sKeys = table.concat(rkeys.getKeysName(keys.v), " + ")

    if #tHotKeyData.save > 0 and tostring(tHotKeyData.save[1]) == name then
        keys.v = tHotKeyData.save[2]
        sKeys = table.concat(rkeys.getKeysName(keys.v), " + ")
        tHotKeyData.save = {}
        bool = true
    elseif tHotKeyData.edit ~= nil and tostring(tHotKeyData.edit) == name then
        if #tKeys == 0 then
            sKeys = os.time() % 2 == 0 and module._SETTINGS.noKeysMessage or " "
        else
            sKeys = table.concat(rkeys.getKeysName(tKeys), " + ")
        end
    end

    imgui.PushStyleColor(imgui.Col.Button, imgui.GetStyle().Colors[imgui.Col.FrameBg])
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.GetStyle().Colors[imgui.Col.FrameBgActive])
    if imgui.Button((tostring(sKeys):len() == 0 and module._SETTINGS.noKeysMessage or sKeys) .. name, imgui.ImVec2(width, 0)) then
        tHotKeyData.edit = name
    end
    imgui.PopStyleColor(3)
    return bool
end

function module.getCurrentEdit()
    return tHotKeyData.edit ~= nil
end

function module.getKeysList(bool)
   local bool = bool or false
   local tKeysList = {}
   if bool then
      for k, v in ipairs(tKeys) do
         tKeysList[k] = vkeys.id_to_name(v)
      end
   else
      tKeysList = tKeys
   end
   return tKeysList
end

function module.getKeyNumber(id)
   for k, v in ipairs(tKeys) do
      if v == id then
         return k
      end
   end
   return -1
end

local function reloadKeysList()
    local tNewKeys = {}
    for k, v in pairs(tKeys) do
       tNewKeys[#tNewKeys + 1] = v
    end
    tKeys = tNewKeys
    return true
 end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
    if tHotKeyData.edit ~= nil and msg == wm.WM_CHAR then
        if tBlockChar[wparam] then
            consumeWindowMessage(true, true)
        end
    end
    if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
        if tHotKeyData.edit ~= nil and wparam == vkeys.VK_ESCAPE then
            tKeys = {}
            tHotKeyData.edit = nil
            consumeWindowMessage(true, true)
        end
        if tHotKeyData.edit ~= nil and wparam == vkeys.VK_BACK then
            tHotKeyData.save = {tHotKeyData.edit, {}}
            tHotKeyData.edit = nil
            consumeWindowMessage(true, true)
        end
        local num = module.getKeyNumber(wparam)
        if num == -1 then
            tKeys[#tKeys + 1] = wparam
            if tHotKeyData.edit ~= nil then
                if not rkeys.isKeyModified(wparam) then
                    tHotKeyData.save = {tHotKeyData.edit, tKeys}
                    tHotKeyData.edit = nil
                    tKeys = {}
                    consumeWindowMessage(true, true)
                end
            end
        end
        reloadKeysList()
        if tHotKeyData.edit ~= nil then
            consumeWindowMessage(true, true)
        end
    elseif msg == wm.WM_KEYUP or msg == wm.WM_SYSKEYUP then
        local num = module.getKeyNumber(wparam)
        if num > -1 then
            tKeys[num] = nil
        end
        reloadKeysList()
        if tHotKeyData.edit ~= nil then
            consumeWindowMessage(true, true)
        end
    end
end)

return module