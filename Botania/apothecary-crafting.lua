-- wget https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/Botania/apothecary-crafting.lua

-- some things of note
-- the bucket should always be slot 1
-- seeds should always occupy slot 2
-- costs 6 fuel per craft

local function apothecaryCrafting(ingredientCount)
    -- drop and retrieve the filled water bucket
    turtle.select(1)
    turtle.down()
    turtle.dropDown()
    turtle.suckDown()
    turtle.up()

    -- drop the crafting ingredients
    for i = 1, #ingredientCount, 1 do
        local count = ingredientCount[i]
        turtle.select(i + 2)
        turtle.dropDown(count)
    end

    -- drop the seed to finalize the crafting process
    turtle.select(2)
    turtle.dropDown(1)

    -- pick up the crafted item
    turtle.select(16)
    turtle.suckDown()
    turtle.down()
    turtle.suckDown()
    turtle.up()
end

local function fillBucket()
    turtle.select(1)
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.place()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
end

-- testing below

for i = 1, 32, 1 do
    fillBucket()
    apothecaryCrafting({ 2, 2 })
end
