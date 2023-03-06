--[[
   Author: DonHomka
   E-mail: a.skinfy@gmail.com
   VK: http://vk.com/DonHomka
   TeleGramm: http://t.me/DonHomka
   Discord: DonHomka#2534
]]
local imgui, ffi = require 'mimgui', require 'ffi'
local new, str = imgui.new, ffi.string
local vkeys = require 'vkeys'
local wm = require 'lib.windows.message'

local module = {}
module._VERSION = "1.0.0"
module._SETTINGS = {
    HotKey = {
        noKeysMessage = "No"
    }
}

imgui.OnInitialize(function()
    module._SETTINGS.ToggleButton = {
        scale = 1.0,
        AnimSpeed = 0.13,
        colors = {
            imgui.GetStyle().Colors[imgui.Col.ButtonActive], -- Enable circle
            imgui.ImVec4(150 / 255, 150 / 255, 150 / 255, 1.0), -- Disable circle
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered], -- Enable rect
            imgui.ImVec4(100 / 255, 100 / 255, 100 / 255, 180 / 255) -- Disable rect
        }
    }
    module._SETTINGS.DropDownList = {
        colors = {
            imgui.GetStyle().Colors[imgui.Col.Button],
            imgui.GetStyle().Colors[imgui.Col.ButtonActive],
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered],
            imgui.GetStyle().Colors[imgui.Col.PopupBg]
        }
    }
end)

-- DropDownList:
local open = nil
module.DropDownList = function(label, current_item, items, items_count, visible_limit, height)
    local visible_limit = visible_limit or 8
    local vl = items_count > visible_limit and visible_limit or items_count
    local p = imgui.GetCursorScreenPos()
    local width, tsize = 0, {}
    local bool = false
    local title = label:gsub("%#%#.*", "")
    for i = 1, items_count do
        if items[i] then
            local tw = imgui.CalcTextSize(items[i])
            if width < tw.x then
                width = tw.x
                tsize = tw
            end
        end
    end
    if title:len() > 0 then
        local tw = imgui.CalcTextSize(title)
        if width < tw.x then
            width = tw.x
            tsize = tw
        end
    end
    width = width + 25
    local size = imgui.ImVec2(width, height or imgui.GetFrameHeightWithSpacing())

    local btnHovered = imgui.IsMouseHoveringRect(p, imgui.ImVec2(p.x + size.x, p.y + size.y))
    local btnActive = open == label and imgui.IsPopupOpen(label)
    local btnClicked = btnHovered and imgui.IsMouseClicked(0)
    if btnClicked then
        if imgui.IsPopupOpen(label) then
            imgui.CloseCurrentPopup()
        else
            imgui.OpenPopup(label)
        end
        open = open ~= label and label or nil
    end

    local DrawList = imgui.GetWindowDrawList()
    DrawList:AddRectFilled(p, imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.ColorConvertFloat4ToU32(module._SETTINGS.DropDownList.colors[open == label and 4 or (btnHovered and 2 or 1)]))
    if open == label then
        DrawList:AddLine(imgui.ImVec2(p.x, p.y + size.y - 0.3), imgui.ImVec2(p.x + size.x - 0.7, p.y + size.y - 0.3), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 0.5)), 0.7)
        DrawList:AddLine(imgui.ImVec2(p.x + (size.x - 10), p.y + (size.y * 0.4)), imgui.ImVec2(p.x + (size.x - 15), p.y + (size.y * 0.6)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 1.0)), 1.2)
        DrawList:AddLine(imgui.ImVec2(p.x + (size.x - 10), p.y + (size.y * 0.4)), imgui.ImVec2(p.x + (size.x - 5), p.y + (size.y * 0.6)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 1.0)), 1.2)
    else
        DrawList:AddLine(imgui.ImVec2(p.x + (size.x - 15), p.y + (size.y * 0.4)), imgui.ImVec2(p.x + (size.x - 10), p.y + (size.y * 0.6)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 1.0)), 1.2)
        DrawList:AddLine(imgui.ImVec2(p.x + (size.x - 5), p.y + (size.y * 0.4)), imgui.ImVec2(p.x + (size.x - 10), p.y + (size.y * 0.6)), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 1.0, 1.0, 1.0)), 1.2)
    end
    local index = current_item[0]
    DrawList:AddText(imgui.ImVec2(p.x + 6.0, p.y + ((size.y - tsize.y) / 2) - 1), imgui.ColorConvertFloat4ToU32(imgui.GetStyle().Colors[imgui.Col.Text]), items[index] and tostring(items[index]) or title and tostring(title))

    if open == label and imgui.IsPopupOpen(label) then
        imgui.SetNextWindowPos(imgui.ImVec2(p.x, p.y + size.y))
        imgui.SetNextWindowSize(imgui.ImVec2(size.x, size.y * vl))
        imgui.BeginPopup(label)
        local DrawList = imgui.GetWindowDrawList()
        DrawList:AddRectFilled(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + (size.y * items_count) + size.y), imgui.ColorConvertFloat4ToU32(module._SETTINGS.DropDownList.colors[4]))
        imgui.SetCursorScreenPos(imgui.ImVec2(p.x, p.y + size.y))
        for i = 1, items_count do
            if items[i] then
                local p = imgui.GetCursorScreenPos()
                local hovered = imgui.IsMouseHoveringRect(p, imgui.ImVec2(p.x + size.x, p.y + size.y))
                if hovered and imgui.IsMouseClicked(0) then
                    current_item[0] = i
                    open = nil
                    bool = true
                end
                if hovered then
                    DrawList:AddRectFilled(p, imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.ColorConvertFloat4ToU32(module._SETTINGS.DropDownList.colors[3]))
                end
                DrawList:AddText(imgui.ImVec2(p.x + 3.0, p.y + ((size.y - tsize.y) / 2) - 1), imgui.ColorConvertFloat4ToU32(imgui.GetStyle().Colors[imgui.Col.Text]), tostring(items[i]))
                imgui.SetCursorScreenPos(imgui.ImVec2(p.x, p.y + size.y))
            end
        end
        imgui.EndPopup()
    end
    return bool

end

-- Spinner:
module.Spinner = function(label, radius, thickness, color)
    local style = imgui.GetStyle()
    local pos = imgui.GetCursorScreenPos()
    local size = imgui.ImVec2(radius * 2, (radius + style.FramePadding.y) * 2)

    imgui.Dummy(imgui.ImVec2(size.x + style.ItemSpacing.x, size.y))

    local DrawList = imgui.GetWindowDrawList()
    DrawList:PathClear()

    local num_segments = 30
    local start = math.abs(math.sin(imgui.GetTime() * 1.8) * (num_segments - 5))

    local a_min = 3.14 * 2.0 * start / num_segments
    local a_max = 3.14 * 2.0 * (num_segments - 3) / num_segments

    local centre = imgui.ImVec2(pos.x + radius, pos.y + radius + style.FramePadding.y)

    for i = 0, num_segments do
        local a = a_min + (i / num_segments) * (a_max - a_min)
        DrawList:PathLineTo(imgui.ImVec2(centre.x + math.cos(a + imgui.GetTime() * 8) * radius, centre.y + math.sin(a + imgui.GetTime() * 8) * radius))
    end

    DrawList:PathStroke(color, false, thickness)
    return true
end

-- BufferingBar:
module.BufferingBar = function(label, value, size_arg, bg_col, fg_col)
    local style = imgui.GetStyle()
    local size = size_arg;

    local DrawList = imgui.GetWindowDrawList()
    size.x = size.x - (style.FramePadding.x * 2);

    local pos = imgui.GetCursorScreenPos()

    imgui.Dummy(imgui.ImVec2(size.x, size.y))

    local circleStart = size.x * 0.91;
    local circleEnd = size.x;
    local circleWidth = circleEnd - circleStart;

    DrawList:AddRectFilled(pos, imgui.ImVec2(pos.x + circleStart, pos.y + size.y), bg_col)
    DrawList:AddRectFilled(pos, imgui.ImVec2(pos.x + circleStart * value, pos.y + size.y), fg_col)

    local t = imgui.GetTime()
    local r = size.y / 2;
    local speed = 1.5;

    local a = speed * 0;
    local b = speed * 0.333;
    local c = speed * 0.666;

    local o1 = (circleWidth - r) * (t + a - speed * math.floor((t + a) / speed)) / speed;
    local o2 = (circleWidth - r) * (t + b - speed * math.floor((t + b) / speed)) / speed;
    local o3 = (circleWidth - r) * (t + c - speed * math.floor((t + c) / speed)) / speed;

    DrawList:AddCircleFilled(imgui.ImVec2(pos.x + circleEnd - o1, pos.y + r), r, bg_col);
    DrawList:AddCircleFilled(imgui.ImVec2(pos.x + circleEnd - o2, pos.y + r), r, bg_col);
    DrawList:AddCircleFilled(imgui.ImVec2(pos.x + circleEnd - o3, pos.y + r), r, bg_col);
    return true
end

-- HotKey:
local tBlockKeys = {[vkeys.VK_RETURN] = true, [vkeys.VK_T] = true, [vkeys.VK_F6] = true, [vkeys.VK_F8] = true}
local tBlockChar = {[116] = true, [84] = true}
local tModKeys = {[vkeys.VK_MENU] = true, [vkeys.VK_SHIFT] = true, [vkeys.VK_CONTROL] = true}
local tBlockNextDown = {}

local tHotKeyData = {
    edit = nil,
	save = {},
   lastTick = os.clock(),
   tickState = false
}
local tKeys = {}


module.HotKey = function(name, keys, width, height, disabled)
    local width = width or 90
    local height = height or 0
    local disabled = disabled or false
    local name = tostring(name)
    local keys, bool = keys or {}, false
    local thisEdit = false

    local sKeys = table.concat(module.getKeysName(keys.v), " + ")

    if #tHotKeyData.save > 0 and tostring(tHotKeyData.save[1]) == name then
        keys.v = tHotKeyData.save[2]
        sKeys = table.concat(module.getKeysName(keys.v), " + ")
        tHotKeyData.save = {}
        bool = true
    elseif tHotKeyData.edit ~= nil and tostring(tHotKeyData.edit) == name then
        thisEdit = true
		if #tKeys == 0 then
			if os.clock() - tHotKeyData.lastTick > 0.5 then
            tHotKeyData.lastTick = os.clock()
            tHotKeyData.tickState = not tHotKeyData.tickState
         end
         sKeys = tHotKeyData.tickState and module._SETTINGS.HotKey.noKeysMessage or " "
        else
            sKeys = table.concat(module.getKeysName(tKeys), " + ")
        end
    end
    local colText = imgui.GetStyle().Colors[imgui.Col.Text]
    imgui.PushStyleColor(imgui.Col.Button, imgui.GetStyle().Colors[imgui.Col.FrameBg])
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.GetStyle().Colors[imgui.Col.FrameBgActive])
    imgui.PushStyleColor(imgui.Col.Text, (disabled and not thisEdit) and imgui.ImVec4(colText.x, colText.y, colText.z, 0.5) or colText)
    imgui.PushStyleVarVec2(imgui.StyleVar.ButtonTextAlign, imgui.ImVec2(0.04, 0.4))
    if imgui.Button((tostring(sKeys):len() == 0 and module._SETTINGS.HotKey.noKeysMessage or sKeys) .. name, imgui.ImVec2(width, height)) then
        tHotKeyData.edit = name
    end
    imgui.PopStyleVar()
    imgui.PopStyleColor(4)
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

function module.getKeysName(keys)
    if type(keys) ~= "table" then
       return false
    else
       local tKeysName = {}
       for k, v in ipairs(keys) do
          tKeysName[k] = vkeys.id_to_name(v)
       end
       return tKeysName
    end
 end

local function getKeyNumber(id)
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

function module.isKeyModified(id)
if type(id) ~= "number" then
   return false
end
return (tModKeys[id] or false) or (tBlockKeys[id] or false)
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
        local num = getKeyNumber(wparam)
        if num == -1 then
            tKeys[#tKeys + 1] = wparam
            if tHotKeyData.edit ~= nil then
                if not module.isKeyModified(wparam) then
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
        local num = getKeyNumber(wparam)
        if num > -1 then
            tKeys[num] = nil
        end
        reloadKeysList()
        if tHotKeyData.edit ~= nil then
            consumeWindowMessage(true, true)
        end
    end
end)

-- Toggle Button:
LastActiveTime = {}
LastActive = {}
module.ToggleButton = function(str_id, bool)
	local rBool = false

	local function ImSaturate(f)
		return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
	end

	local p = imgui.GetCursorScreenPos()
	local draw_list = imgui.GetWindowDrawList()

	local height = imgui.GetTextLineHeightWithSpacing() * module._SETTINGS.ToggleButton.scale
	local width = height * 1.2
	local radius = height * 0.50

	if imgui.InvisibleButton(str_id, imgui.ImVec2(width + radius, height)) then
		bool[0] = not bool[0]
		rBool = true
		LastActiveTime[tostring(str_id)] = os.clock()
		LastActive[tostring(str_id)] = true
	end

	local t = bool[0] and 1.0 or 0.0

	if LastActive[tostring(str_id)] then
		local time = os.clock() - LastActiveTime[tostring(str_id)]
		if time <= module._SETTINGS.ToggleButton.AnimSpeed then
			local t_anim = ImSaturate(time / module._SETTINGS.ToggleButton.AnimSpeed)
			t = bool[0] and t_anim or 1.0 - t_anim
		else
			LastActive[tostring(str_id)] = false
		end
	end

	local col_bg = imgui.ColorConvertFloat4ToU32(module._SETTINGS.ToggleButton.colors[bool[0] and 3 or 4])

	draw_list:AddRectFilled(imgui.ImVec2(p.x + (radius * 0.65), p.y + (height / 6)), imgui.ImVec2(p.x + (radius * 0.65) + width, p.y + (height - (height / 6))), col_bg, 10.0)
	draw_list:AddCircleFilled(imgui.ImVec2(p.x + (radius * 1.3) + t * (width - (radius * 1.3)), p.y + radius), radius - 1.0, imgui.ColorConvertFloat4ToU32(module._SETTINGS.ToggleButton.colors[bool[0] and  1 or 2]))

	return rBool
end

return module
