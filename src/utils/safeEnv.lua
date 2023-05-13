local _, pkg = ...

-- global imports
local _G = _G
local setmetatable, setfenv = setmetatable, setfenv

--[[
Enter a safe environment to avoid polluting the global namespace

Method created to:
* create a unified environment for the library files
* avoid the following boilerplate in every file
```
setfenv(1, setmetatable({}, { __index = _G }))
```
]]
--
function pkg.enterSafeEnv()
    setfenv(2, setmetatable({}, {
        __index = _G
    }))
end

--[[
Exit the safe env entered with `pkg.enterSafeEnv()`

The function restores the global env to the original `_G`
]]
--
function pkg.exitSafeEnv()
    setfenv(2, _G)
end
