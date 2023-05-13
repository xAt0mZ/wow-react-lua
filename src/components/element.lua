local _, pkg = ...
pkg.enterSafeEnv()

local tprint = pkg.tprint
local clone = SafeClone
local table = table

--[[ 
    type definition of element metatable
    __call: func
        = used when creating an element `el {}`
 ]]--
local ElementMT = {
    __call = function(self, content)
        local new = clone(self)
		if type(content) == 'table' then
			local oldlen = #new.children -- number of existing childrens if any
			for k, v in pairs(content) do
				if type(k) == 'number' then -- if direct child (div{} or smth)
					new.children[oldlen + k] = v -- add it to children
				else
					new.children[k] = v
				end
			end
		else
            table.insert(new.children, content) -- support element'some text'
		end
		return new
    end
}

--[[
    Fields of Element

    _tag: string
        -- public ref of the element in the library

    props: string[]
        -- list of props when building an element

    children: {}
        -- children of the element

    _validate: function
        -- used to validate that the props passed are valid

    _render: function
        -- used to render to component e.g. create Blizzard Frame

    _frame: BlizzardFrame
        -- defaults to nil
        -- has a value after _render()
        -- saves the Blizzard Frame associated to the element

]]--
local function Element(config)
    local element = {
        _tag = 
    }
    return setmetatable(el, ElementMT)
end

local Window = Element({name = 'Window', attributes={}, })

local function render(func)
    print("render:", func)
end

local function useX()
    return "from used", function()
        print("do smth from used")
    end
end

local function Custom()
    local val, setVal = useX()
    print(val)
    setVal()
    return Window { "custom attrs" } { "custom body" }
end

-- Window {
--     width=2,
--     height=2,
--     {
--         "first body",
--         Window {
--             "Some string",
--             {
--                 "Body"
--             }
--         }

--     }
-- }

Window {
    Window {

    }
}

-- print("-- render full window")
-- render(Window({ "root attrs" }, Window({ "root body" })))
-- print("-- render window")
-- render(Window{})
-- print("-- render custom")
-- render(Custom)


local pack = SafePack
