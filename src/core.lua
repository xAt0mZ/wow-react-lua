local _, pkg = ...

pkg.enterSafeEnv()

-- global imports
local _G = _G
local pairs, setmetatable, print = pairs, setmetatable, print;
--

-- consts
local INVALID_USAGE_ERROR = "Invalid usage of React lib. Use your own instance with 'local React = React()'"
--

local ReactProxy = _G.React or {} -- if lib is not available in global env create a new lib instance

local ReactProxyMetatable = {
    __metatable = false, -- deny `getmetatable(_G.React)`
    __index = function() -- deny accessing `_G.React.?`
        error(INVALID_USAGE_ERROR, 1)
    end,
    __newindex = function() -- deny usage of `_G.React.? = ?`
        error(INVALID_USAGE_ERROR)
    end,
    __call = function() -- called when using `React()`
        local instance = {}
        setmetatable(instance, { __index = pkg.React })
        return instance
    end
}

setmetatable(ReactProxy, ReactProxyMetatable)

pkg.exitSafeEnv()

-- expose the React proxy as instance generator
React = ReactProxy
return ReactProxy
