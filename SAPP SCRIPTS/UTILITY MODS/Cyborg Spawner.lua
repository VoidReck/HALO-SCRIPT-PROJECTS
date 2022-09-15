--[[
--=====================================================================================================--
Script Name: Cyborg Spawner, for SAPP (PC & CE)
Description: A useless script that spawns cyborgs at pre-defined locations, on a per-map basis.

Copyright (c) 2016-2022, Jericho Crosby <jericho.crosby227@gmail.com>
Notice: You can use this document subject to the following conditions:
https://github.com/Chalwk77/HALO-SCRIPT-PROJECTS/blob/master/LICENSE
--=====================================================================================================--
]]

local objects = {

    ['bloodgulch'] = {
        { 95.68, -155.46, 2.92 },
        { 79.05, -141.19, 2.16 },
        { 74.23, -106.13, 3.87 },
        { 22.67, -81.11, 1.46 },
        { 66.25, -64.81, 2.52 },
        { 92.09, -156.02, 2.92 },
        { 90.51, -158.73, 2.53 },
        { 90.51, -160.36, 2.53 },
        { 92.12, -163.19, 2.92 },
        { 94.77, -164.60, 2.53 },
        { 96.33, -164.53, 2.53 },
        { 99.10, -162.94, 2.92 },
        { 100.57, -160.38, 2.53 },
        { 100.58, -158.76, 2.53 },
        { 99.07, -155.82, 2.92 },
        { 96.39, -154.52, 2.53 },
        { 83.14, -154.16, -0.11 }
    },


    ['longest'] = {
        { -16.68, -13.25, -0 },
        { -6.48, -10.83, 2.06 },

        { 6.05, -10.42, 2.06 },
        { 13.67, -7.64, -0.6 },
        { 3.44, -19.45, 2.06 }
    },

    ['beavercreek'] = {
        { 29.03, 13.56, 0.84 },
        { 18.02, 7.73, -0.22 },
        { 13.87, 20.15, -0.97 },
        { 4.77, 16.61, 1.8 },
        { 17.14, 19.12, 5.18 }
    },

    ['beavercreek'] = {
        { 1.97, 0.59, 0.42 },
        { 17.63, 14.12, 2.72 },
        { 3.16, -9.81, -4.78 },
        { 18.76, -16.37, -2.28 },
        { 4.17, -19, 5.22 }
    },

    ['carousel'] = {
        { 2.45, -6.89, -2.79 },
        { -0.65, 5.3, -2.56 },
        { -1.58, -11.39, -0.86 },
        { -10.75, 3.4, -0.86 },
        { 11.4, 9.92, -0.86 }
    },

    ['dangercanyon'] = {
        { -30.3, -6.81, -2.28 },
        { -9.22, 54.35, 0.33 },
        { -0.61, 44.16, -6.63 },
        { 24.51, -10.22, -3.93 },
        { 0.72, 18.71, -0.92 }
    },

    ['deathisland'] = {
        { 29.49, 16.53, 8.29 },
        { 44.67, -37.26, 13.67 },
        { -10.26, 28.14, 22.79 },
        { -30.87, 34.35, 14.27 },
        { -31.86, 66.06, 3.02 }
    },

    ['gephyrophobia'] = {
        { 28.97, -26.05, -18.33 },
        { 26.43, -110.51, -18.33 },
        { -24.12, -99.21, -1.25 },
        { -21.58, -32.52, -1.25 },
        { -26.13, -81.17, -1.25 }
    },

    ['icefields'] = {
        { -71.18, 94.65, 0.86 },
        { -76.92, 87.91, 0.8 },
        { 14.4, -20.08, 0.76 },
        { 26.2, -21.82, 0.8 },
        { -26.92, 27.75, 8.96 }
    },

    ['infinity'] = {
        { -0.31, -164.72, 15.01 },
        { -3.33, 48.08, 11.7 },
        { -15.48, -64.3, 21.87 },
        { -42.35, -135.46, 12.7 },
        { 47.26, -123.08, 11.18 }
    },

    ['sidewinder'] = {
        { -33.51, -35.13, 0.56 },
        { -9.06, -12.35, 0.16 },
        { -43.49, 31.26, 0.16 },
        { 39.82, 30.19, 0.16 },
        { 30.71, -37.71, 0.56 }
    },

    ['timberland'] = {
        { -14.74, 44.9, -18.04 },
        { 17.05, -52.32, -11.75 },
        { -35.03, -28.4, -20.64 },
        { -7.18, -5.38, -18.71 },
        { 41.34, -27.9, -20.64 }
    },

    ['hangemhigh'] = {
        { 28.21, -18.87, -3.91 },
        { 15.79, 8.98, -3.36 },
        { 16.15, -5.03, -3.47 },
        { 20.59, -2.28, -4.38 },
        { 32.74, -4.97, -5.58 }
    },

    ['ratrace'] = {
        { 14.02, -19.72, -3.61 },
        { 3.01, -10.84, 0.22 },
        { -6.62, -2.3, -0.59 },
        { 19.81, 0.7, -2.13 },
        { 8.57, -13.93, -2.9 }
    },

    ['damnation'] = {
        { 5.13, 10.28, 3.4 },
        { -1.6, 1.5, -0.2 },
        { -12.44, -5.56, -0.2 },
        { -5.04, -5.67, 3.4 },
        { 4.9, -10.12, 4.5 }
    },

    ['putput'] = {
        { 30.76, -25.42, 1 },
        { 17.87, -3.97, 1.7 },
        { -2.05, -1.22, 0.9 },
        { -16.26, -19.55, 2.3 },
        { -16.69, -22.04, 0.9 }
    },

    ['prisoner'] = {
        { -5.13, 7.15, 1.39 },
        { -1.62, -6.68, 1.39 },
        { 9.79, 4.43, 5.59 },
        { -9.61, -5.48, 5.59 },
        { -8.47, -1.55, 2.52 }
    },

    ['wizard'] = {
        { 8.84, -9.08, -2.75 },
        { -7.36, -6.34, -4.5 },
        { -8.96, 9.24, -2.75 },
        { 7.22, 6.4, -4.5 },
        { 0.08, -1.15, -2.3 }
    }
}

api_version = '1.12.0.0'
local cyborg = { 'bipd', 'characters\\cyborg_mp\\cyborg_mp' }

function OnScriptLoad()
    register_callback(cb['EVENT_GAME_START'], 'OnStart')
end

local function GetTag(Class, Name)
    local tag = lookup_tag(Class, Name)
    return (tag ~= 0 and read_dword(tag + 0xC)) or nil
end

function OnStart()

    if (get_var(0, '$gt') ~= 'n/a') then

        local map = get_var(0, '$map')
        local spawns = objects[map]
        local tag = GetTag(unpack(cyborg))

        if (spawns and tag) then
            for _, v in ipairs(spawns) do
                spawn_object('', '', v[1], v[2], v[3], 0, tag)
            end
        end
    end
end

function OnScriptUnload()
    -- N/A
end