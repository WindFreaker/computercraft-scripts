-- wget https://raw.githubusercontent.com/WindFreaker/computercraft-tests/main/Botania/auto-hydroangeas.lua

-- this doesn't work yet (figuring out best placement for hydroangeas first)

local function replaceDeadBushes()
    -- do not need to dig, simply place over dead bushes
end

local function checkIfDecayed()
    -- go to location of closest hydroangeas
    local exists, data = turtle.inspect()
    if data.name == "minecraft:dead_bush" then
        replaceDeadBushes()
    else
        -- do nothing
    end
end

return {

}
