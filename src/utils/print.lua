local _, pkg = ...

pkg.enterSafeEnv()

local string, print = string, print;

function pkg.printf(...)
   print(string.format(...))
end

local Types = {
   FUNCTION = "function",
   TABLE = "table"
}

function pkg.tprint(table)
   print("= tprint start =", table)
   for k, v in pairs(table) do
      local _type = type(v)
      if _type == Types.TABLE then
         print(k)
         pkg.tprint(v)
      else
         print(k, v)
      end
   end
   print("= tprint end =")
end