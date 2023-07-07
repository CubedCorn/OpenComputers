local shell = require('shell')
local internet = component.internet
local program = shell.parse(...)[1]
local link = string.format('https://raw.githubusercontent.com/CubedCorn/OpenComputers/main/%s.lua', program)

local data = internet.request(link)() -- request returns a response function
print(data)
return
if not data then print('program not found, please try again with a valid program.') end

local file = io.open(program:lower(), 'w')
file:write(data)
file:close()
