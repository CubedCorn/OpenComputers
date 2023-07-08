local shell = require('shell')
local internet = component.internet
local program, options = shell.parse(...); program = program[1]
local link = string.format('https://raw.githubusercontent.com/CubedCorn/OpenComputers/main/%s.lua', program)

local timeout = computer.uptime() + 5
if options[1] and string.sub(options[1], 7):lower() == 'timeout' then
    timeout = computer.uptime() + tonumber(string.sub(options[1], 8, 9))
end

local response = internet.request(link) -- request returns a response function
    while response() == nil do
        if computer.uptime() < timeout then
            os.sleep()
        else
            print('response timed out')
            return
        end
    end
if response() == nil then
    print('program was invalid.')
    return
end

local data = response()
local file = io.open(string.lower(program), 'w')
file:write(data)
file:close()
