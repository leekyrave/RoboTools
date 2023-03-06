local ffi = require('ffi')
local screenshotLibrary = ffi.load('Screenshot.asi')

ffi.cdef([[
	int __cdecl GetPluginVersion();
	const char* __cdecl GetUserDirectoryPath();
	void __cdecl RequestScreenshot();
	void __cdecl RequestScreenshotEx(const char* filePath, const char* fileName);
]])

local screenshot = {}
function screenshot.getPluginVersion()
	return screenshotLibrary.GetPluginVersion()
end

function screenshot.getUserDirectoryPath()
	return ffi.string(screenshotLibrary.GetUserDirectoryPath())
end

function screenshot.request()
	screenshotLibrary.RequestScreenshot()
end

function screenshot.requestEx(filePath, fileName)
	screenshotLibrary.RequestScreenshotEx(filePath, fileName)
end
return screenshot