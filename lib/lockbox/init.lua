local Lockbox = {};

--[[
package.path =  "./?.lua;"
				.. "./cipher/?.lua;"
				.. "./digest/?.lua;"
				.. "./kdf/?.lua;"
				.. "./mac/?.lua;"
				.. "./padding/?.lua;"
				.. "./test/?.lua;"
				.. "./util/?.lua;"
				.. package.path;
]]--
Lockbox.ALLOW_INSECURE = false;

Lockbox.insecure = function()
	assert(Lockbox.ALLOW_INSECURE,"This module is insecure!  It should not be used in production.  If you really want to use it, set Lockbox.ALLOW_INSECURE to true before importing it");
end

return Lockbox;
