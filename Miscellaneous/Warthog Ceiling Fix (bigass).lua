-- Warthog ceiling bug fix for the map Bigass
-- Copyright (c) 2021, Jericho Crosby <jericho.crosby227@gmail.com>

-- This script will automatically teleport a glitched warthog back to its starting position (w/ proper rotation).

local vehicles = {
    { type = "vehi", -- red base
      name = "bourrin\\halo reach\\vehicles\\warthog\\reach gauss hog",
      pos = { -130.70635986328, -71.420547485352, -0.12882445752621 }, },

    { type = "vehi", -- red base
      name = "bourrin\\halo reach\\vehicles\\warthog\\h2 mp_warthog",
      pos = { -128.29974365234, -70.520027160645, -0.14425709843636 }, },

    { type = "vehi", -- blue base
      name = "bourrin\\halo reach\\vehicles\\warthog\\h2 mp_warthog",
      pos = { 149.50099182129, 40.949211120605, -0.79486745595932 }, },

    { type = "vehi", -- blue base
      name = "bourrin\\halo reach\\vehicles\\warthog\\reach gauss hog",
      pos = { 152.07527160645, 40.980175018311, -0.78609919548035 }, }
}

local delay = 1
local game_started

api_version = "1.12.0.0"

function Init()

    game_started = false

    if (get_var(0, "$gt") ~= "n/a") then
        game_started = true

        for _, v in pairs(vehicles) do
            v.object = 0
        end

        timer(1000 * delay, "CheckVehicles")
    end
end

function OnScriptLoad()
    register_callback(cb['EVENT_GAME_END'], "OnGameEnd")
    register_callback(cb['EVENT_GAME_START'], "OnGameStart")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "OnObjectSpawn")
    Init()
end

function OnGameStart()
    Init()
end

function OnGameEnd()
    game_started = false
end

-- Distance function using pythagoras theorem:
--
local function GetRadius(x1, y1, z1, x2, y2, z2, r)
    return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2) <= r
end

function CheckVehicles()

    for _, v in pairs(vehicles) do

        local object = get_object_memory(v.object)
        if (object ~= 0) then

            -- Where it currently is: x,y,z
            --
            local vx, vy, vz = read_vector3d(object + 0x5C)

            -- Where it should be: x,y,z
            --
            local x = v.pos[1]
            local y = v.pos[2]
            local z = v.pos[3]

            -- Check if the vehicle is near the location of its spawn point
            --
            local in_range = GetRadius(vx, vy, vz, x, y, z, 2)
            if (in_range) then

                local rotation = v.r

                --
                -- check if the vehicle's z axis is + 0.1-0.3 world units above where it should be
                -- (will add this logic when I have time)
                --

                -- TO DO:
                -- The above logic + ignore vehicles that are occupied.
            end
        end
    end
    return game_started
end

local function GetTag(Type, Name)
    local Tag = lookup_tag(Type, Name)
    return (Tag ~= 0 and read_dword(Tag + 0xC)) or nil
end

function OnObjectSpawn(_, MapID, _, ObjectID)
    for _, v in pairs(vehicles) do
        if (MapID == GetTag(v.type, v.name)) then

            -- Save this vehicles object id:
            --
            v.object = ObjectID

            -- Save this vehicles rotation angle (in radians):
            --
            v.r = read_float(ObjectID + 0x74)
        end
    end
end

function OnScriptUnload()
    -- N/A
end