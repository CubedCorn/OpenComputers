local shell = require('shell')
local internet = component.internet
local program, options = shell.parse(...)[1]
local link = string.format('https://raw.githubusercontent.com/CubedCorn/OpenComputers/main/%s.lua', program)

local timeout = computer.uptime() + 5
if options[1] and string.sub(options[1], 7):lower() == 'timeout' then
    timeout = computer.uptime() + tonumber(string.sub(options[1], 8, 10))
end

local response = internet.request(link) -- request returns a response function
    while response() == nil and computer.uptime() < timeout do
        os.sleep()
    end
if computer.uptime() > timeout then
    print('program was invalid or request timed out.')
    return
end

local data = response()
local file = io.open(program:lower(), 'w')
file:write(data)
file:close()
