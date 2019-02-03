--[[
--=====================================================================================================--
Script Name: Base Game Settings, for SAPP (PC & CE)
Description: An all-in-one package that combines many of my scripts into one place. 
             Also, most of the scripts have been heavily refined and improved in this version.

Combined Scripts:
    - Admin Chat
    - Chat IDs
    - Message Board
    - Chat Logging
    - Command Spy
    - Custom Weapons
    - Anti Impersonator
    - Console Logo
    - List Players
    - Alias System
    - Respawn Time
    - Teleport Manager
    - Get Coords
             
Copyright (c) 2016-2019 Jericho Crosby <jericho.crosby227@gmail.com>
You do not have permission to use this document.

* Written by Jericho Crosby (Chalwk)
--=====================================================================================================--
]]--

api_version = "1.12.0.0"
local function GameSettings()
    -- CONFIGURAITON [begins] >> ------------------------------------------------------------
    settings = {
        -- Enabled = true, Disabled = false
        mod = {
            ["Admin Chat"] = {
                enabled = true,
                base_command = "achat",
                permission_level = 1,
                prefix = "[ADMIN CHAT]",
                restore_previous_state = true,
                environment = "rcon",
                message_format = { "%prefix% %sender_name% [%index%] %message%" }
            },
            ["Chat IDs"] = {
                enabled = true,
                global_format = { "%sender_name% [%index%]: %message%" },
                team_format = { "[%sender_name%] [%index%]: %message%" },
                use_admin_prefixes = true,
                trial_moderator = {
                    "[T-MOD] %sender_name% [%index%]: %message%", -- global 
                    "[T-MOD] [%sender_name%] [%index%]: %message%" -- team
                },
                moderator = {
                    "[MOD] %sender_name% [%index%]: %message%", -- global 
                    "[MOD] [%sender_name%] [%index%]: %message%" -- team 
                },
                admin = {
                    "[ADMIN] %sender_name% [%index%]: %message%", -- global 
                    "[ADMIN] [%sender_name%] [%index%]: %message%" -- team 
                },
                senior_admin = {
                    "[S-ADMIN] %sender_name% [%index%]: %message%", -- global 
                    "[S-ADMIN] [%sender_name%] [%index%]: %message%" -- team 
                },
                ignore_list = {
                    "skip",
                    "rtv"
                },
            },
            ["Message Board"] = {
                enabled = true,
                duration = 3,
                alignment = "l",
                messages = {
                    "Welcome to $SERVER_NAME",
                    "Bug reports and suggestions:",
                    "https://github.com/Chalwk77/HALO-SCRIPT-PROJECTS",
                    "This is a development & test server only!",
                }
            },
            ["Chat Logging"] = {
                enabled = true,
                dir = "sapp\\Server Chat.txt",
            },
            ["Command Spy"] = {
                enabled = true,
                permission_level = 1,
                prefix = "[SPY]",
                hide_commands = false,
                commands_to_hide = {
                    "/afk",
                    "/lead",
                }
            },
            ["Custom Weapons"] = {
                enabled = true,
                assign_weapons = true,
                assign_custom_frags = true,
                assign_custom_plasmas = true,
                weapons = {
                    -- Weap 1,Weap 2,Weap 3,Weap 4, , frags, plasmas
                    ["beavercreek"] = { sniper, pistol, rocket_launcher, shotgun, 4, 2 },
                    ["bloodgulch"] = { sniper, pistol, nil, nil, 2, 2 },
                    ["boardingaction"] = { plasma_cannon, rocket_launcher, flamethrower, nil, 1, 3 },
                    ["carousel"] = { nil, nil, pistol, needler, 3, 3 },
                    ["dangercanyon"] = { nil, plasma_rifle, nil, pistol, 4, 4 },
                    ["deathisland"] = { assault_rifle, nil, plasma_cannon, sniper, 1, 1 },
                    ["gephyrophobia"] = { nil, nil, nil, shotgun, 3, 3 },
                    ["icefields"] = { plasma_rifle, nil, plasma_rifle, nil, 2, 3 },
                    ["infinity"] = { assault_rifle, nil, nil, nil, 2, 4 },
                    ["sidewinder"] = { nil, rocket_launcher, nil, assault_rifle, 3, 2 },
                    ["timberland"] = { nil, nil, nil, pistol, 2, 4 },
                    ["hangemhigh"] = { flamethrower, nil, flamethrower, nil, 3, 3 },
                    ["ratrace"] = { nil, nil, nil, nil, 3, 2 },
                    ["damnation"] = { plasma_rifle, nil, nil, plasma_rifle, 1, 3 },
                    ["putput"] = { nil, rocket_launcher, assault_rifle, pistol, 4, 1 },
                    ["prisoner"] = { nil, nil, pistol, plasma_rifle, 2, 1 },
                    ["wizard"] = { rocket_launcher, nil, shotgun, nil, 1, 2 }

                }
            },
            ["Anti Impersonator"] = {
                enabled = true,
                action = "kick",
                reason = "impersonating",
                bantime = 10,
                namelist = { "Chalwk" },
                hashlist = { "6c8f0bc306e0108b4904812110185edd" },
            },
            ["Console Logo"] = {
                enabled = true,
            },
            ["List Players"] = {
                enabled = true,
                permission_level = 1,
                alignment = "l",
                command_aliases = {
                    "pl",
                    "players",
                    "playerlist",
                    "playerslist"
                }
            },
            ["Alias System"] = {
                enabled = true,
                base_command = "alias",
                dir = "sapp\\alias.lua",
                permission_level = 1,
                alignment = "l",
                duration = 10,
            },
            ["Respawn Time"] = {
                enabled = true,
                maps = {
                    -- CTF, SLAYER, TEAM-S, KOTH, TEAM-KOTH, ODDBALL, TEAM-ODDBALL, RACE, TEAM-RACE
                    ["beavercreek"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["bloodgulch"] = { 0, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["boardingaction"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["carousel"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["dangercanyon"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["deathisland"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["gephyrophobia"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["icefields"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["infinity"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["sidewinder"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["timberland"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["hangemhigh"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["ratrace"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["damnation"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["putput"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["prisoner"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["wizard"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                    ["longest"] = { 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5 },
                }
            },
            ["Teleport Manager"] = {
                enabled = true,
                dir = "sapp\\teleports.txt",
                permission_level = {
                 setwarp = 1,
                 warp = -1,
                 back = -1,
                 warplist = -1,
                 warplistall = -1,
                 delwarp = 1
                },
                commands = {
                    "setwarp", -- set command
                    "warp", -- go to command
                    "back", -- go back command
                    "warplist", --list command
                    "warplistall", -- list all command
                    "delwarp" -- delete command
                }
            },
            ["Get Coords"] = {
                enabled = true,
                base_command = "coords",
                permission_level = 1,
                environment = "console",
            },
        },
        global = {
            server_prefix = "**SERVER**",
            permission_level = {
                trial_moderator = 1,
                moderator = 2,
                admin = 3,
                senior_admin = 4
            },
            player_data = {
                "Player: %name%",
                "CD Hash: %hash%",
                "IP Address: %ip_address%",
                "Index ID: %index_id%",
            },
        }
    }
    -- CONFIGURAITON [ends] << ------------------------------------------------------------
end

-- Tables used Globally
players = { }
player_data = { }
quit_data = { }
mapname = ""

-- #Message Board
welcome_timer = { }
message_board_timer = { }

-- #Admin Chat
data = { }
adminchat = { }
stored_data = { }
boolean = { }
game_over = nil

-- #Custom Weapons
weapon = { }
frags = { }
plasmas = { }

-- #Alias System
trigger = { }
alias_timer = { }
index = nil
alias_bool = {}

-- Teleport Manager
canset = { }
wait_for_response = { }
previous_location = { }
for i = 1, 16 do previous_location[i] = { } end

function OnScriptLoad()
    loadWeaponTags()
    GameSettings()
    printEnabled()
    register_callback(cb['EVENT_TICK'], "OnTick")

    register_callback(cb['EVENT_CHAT'], "OnPlayerChat")
    register_callback(cb['EVENT_COMMAND'], "OnServerCommand")

    register_callback(cb['EVENT_PREJOIN'], "OnPlayerPrejoin")
    register_callback(cb['EVENT_JOIN'], "OnPlayerJoin")
    register_callback(cb['EVENT_LEAVE'], "OnPlayerLeave")

    register_callback(cb['EVENT_SPAWN'], "OnPlayerSpawn")

    register_callback(cb['EVENT_GAME_START'], "OnNewGame")
    register_callback(cb['EVENT_GAME_END'], "OnGameEnd")

    register_callback(cb['EVENT_DIE'], "OnPlayerKill")

    -- #Message Board
    if (settings.mod["Message Board"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                players[p_table].message_board_timer = 0
            end
        end
    end

    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                players[p_table].alias_timer = 0
            end
        end
    end

    -- Used OnPlayerJoin()
    if halo_type == "PC" then
        ce = 0x0
    else
        ce = 0x40
    end

    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        if not (game_over) then
            for i = 1, 16 do
                if player_present(i) then
                    if tonumber(get_var(i, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                        local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                        players[p_table].adminchat = nil
                        players[p_table].boolean = nil
                    end
                end
            end
        end
    end

    -- #Custom Weapons
    if (settings.mod["Custom Weapons"].enabled == true) then
        if not (game_over) then
            if get_var(0, "$gt") ~= "n/a" then
                mapname = get_var(0, "$map")
            end
        end
    end
end

function OnScriptUnload()
    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                if tonumber(get_var(i, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                    local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                    players[p_table].adminchat = false
                    players[p_table].boolean = false
                end
            end
        end
    end
end

function OnNewGame()
    -- Used Globally
    game_over = false
    local network_struct = read_dword(sig_scan("F3ABA1????????BA????????C740??????????E8????????668B0D") + 3)
    servername = read_widestring(network_struct + 0x8, 0x42)
    mapname = get_var(0, "$map")

    -- #Message Board
    if (settings.mod["Message Board"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                players[p_table].message_board_timer = 0
            end
        end
    end

    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                alias_bool[i] = false
                trigger[i] = false
                local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                players[p_table].alias_timer = 0
            end
        end
    end

    -- #Console Logo
    if (settings.mod["Console Logo"].enabled == true) then
        local function consoleLogo()
            local network_struct = read_dword(sig_scan("F3ABA1????????BA????????C740??????????E8????????668B0D") + 3)
            local servername = read_widestring(network_struct + 0x8, 0x42)
            -- Logo: ascii: 'kban'
            cprint("================================================================================", 2 + 8)
            cprint(os.date("%A, %d %B %Y - %X"), 6)
            cprint("")
            cprint("          ..|'''.| '||'  '||'     |     '||'      '|| '||'  '|' '||'  |'    ", 4 + 8)
            cprint("          .|'     '   ||    ||     |||     ||        '|. '|.  .'   || .'    ", 4 + 8)
            cprint("          ||          ||''''||    |  ||    ||         ||  ||  |    ||'|.    ", 4 + 8)
            cprint("          '|.      .  ||    ||   .''''|.   ||          ||| |||     ||  ||   ", 4 + 8)
            cprint("          ''|....'  .||.  .||. .|.  .||. .||.....|     |   |     .||.  ||.  ", 4 + 8)
            cprint("                  ->-<->-<->-<->-<->-<->-<->-<->-<->-<->-<->-<->-<->-")
            cprint("                         " .. servername)
            cprint("                  ->-<->-<->-<->-<->-<->-<->-<->-<->-<->-<->-<->-<->-")
            cprint("")
            cprint("================================================================================", 2 + 8)
        end
        consoleLogo()
    end

    -- #Chat Logging
    if (settings.mod["Chat Logging"].enabled == true) then
        local dir = settings.mod["Chat Logging"].dir
        local file = io.open(dir, "a+")
        if file ~= nil then
            local map = get_var(0, "$map")
            local gt = get_var(0, "$mode")
            local n1 = "\n"
            local t1 = os.date("[%A %d %B %Y] - %X - A new game has started on " .. tostring(map) .. ", Mode: " .. tostring(gt))
            local n2 = "\n---------------------------------------------------------------------------------------------\n"
            file:write(n1, t1, n2)
            file:close()
        end
    end

    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                if tonumber(get_var(i, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                    local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                    players[p_table].adminchat = false
                    players[p_table].boolean = false
                end
            end
        end
    end
    -- #Teleport Manager
    if (settings.mod["Teleport Manager"].enabled == true) then
        check_file_status(PlayerIndex)
    end
end

function OnGameEnd()
    -- Used Globally
    game_over = true

    -- #Weapon Settings
    for i = 1, 16 do
        if player_present(i) then
            weapon[i] = false
        end
    end

    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                alias_bool[i] = false
                trigger[i] = false
                local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                players[p_table].alias_timer = 0
            end
        end
    end

    -- #Message Board
    if (settings.mod["Message Board"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                welcome_timer[i] = false
                local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                players[p_table].message_board_timer = 0
            end
        end
    end

    -- #Chat Logging
    if (settings.mod["Chat Logging"].enabled == true) then
        local dir = settings.mod["Chat Logging"].dir
        local file = io.open(dir, "a+")
        if file ~= nil then
            local data = os.date("[%A %d %B %Y] - %X - The game is ending - ")
            file:write(data)
            file:close()
        end
    end

    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                if tonumber(get_var(i, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                    local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                    if (Restore_Previous_State == true) then
                        if players[p_table].adminchat == true then
                            bool = "true"
                        else
                            bool = "false"
                        end
                        data[i] = get_var(i, "$name") .. ":" .. bool
                        stored_data[data] = stored_data[data] or { }
                        table.insert(stored_data[data], tostring(data[i]))
                    else
                        players[p_table].adminchat = false
                        players[p_table].boolean = false
                    end
                end
            end
        end
    end
end

function OnTick()
    -- #Message Board
    if (settings.mod["Message Board"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                if (welcome_timer[i] == true) then
                    local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                    players[p_table].message_board_timer = players[p_table].message_board_timer + 0.030
                    cls(i)
                    local message_board = settings.mod["Message Board"].messages
                    for k, v in pairs(message_board) do
                        for j = 1, #message_board do
                            if string.find(message_board[j], "$SERVER_NAME") then
                                message_board[j] = string.gsub(message_board[j], "$SERVER_NAME", servername)
                            elseif string.find(message_board[j], "$PLAYER_NAME") then
                                message_board[j] = string.gsub(message_board[j], "$PLAYER_NAME", get_var(i, "$name"))
                            end
                        end
                        rprint(i, "|" .. settings.mod["Message Board"].alignment .. " " .. v)
                    end
                    if players[p_table].message_board_timer >= math.floor(settings.mod["Message Board"].duration) then
                        welcome_timer[i] = false
                        players[p_table].message_board_timer = 0
                    end
                end
            end
        end
    end
    -- Custom Weapons
    if (settings.mod["Custom Weapons"].enabled == true and settings.mod["Custom Weapons"].assign_weapons == true) then
        for i = 1, 16 do
            if (player_alive(i)) then
                local player = get_dynamic_player(i)
                if (weapon[i] == true) then
                    execute_command("wdel " .. i)
                    local x, y, z = read_vector3d(player + 0x5C)
                    if settings.mod["Custom Weapons"].weapons[mapname] ~= nil then

                        local primary, secondary, tertiary, quaternary, Slot = select(1, determineWeapon())

                        if (secondary) then
                            assign_weapon(spawn_object("weap", secondary, x, y, z), i)
                        end

                        if (primary) then
                            assign_weapon(spawn_object("weap", primary, x, y, z), i)
                        end

                        if (Slot == 3 or Slot == 4) then
                            timer(100, "delayAssign", player, x, y, z)
                        end

                        function delayAssign()
                            if (quaternary) then
                                assign_weapon(spawn_object("weap", quaternary, x, y, z), i)
                            end

                            if (tertiary) then
                                assign_weapon(spawn_object("weap", tertiary, x, y, z), i)
                            end
                        end

                    end
                    weapon[i] = false
                end
            end
        end
    end
    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        for i = 1, 16 do
            if player_present(i) then
                if (trigger[i] == true) then
                    local p_table = get_var(i, "$name") .. ", " .. get_var(i, "$hash")
                    players[p_table].alias_timer = players[p_table].alias_timer + 0.030
                    cls(i)
                    concatValues(i, 1, 6)
                    concatValues(i, 7, 12)
                    concatValues(i, 13, 18)
                    concatValues(i, 19, 24)
                    concatValues(i, 25, 30)
                    concatValues(i, 31, 36)
                    concatValues(i, 37, 42)
                    concatValues(i, 43, 48)
                    concatValues(i, 49, 55)
                    concatValues(i, 56, 61)
                    concatValues(i, 62, 67)
                    concatValues(i, 68, 73)
                    concatValues(i, 74, 79)
                    concatValues(i, 80, 85)
                    concatValues(i, 86, 91)
                    concatValues(i, 92, 97)
                    concatValues(i, 98, 100)
                    if (alias_bool[i] == true) then
                        local alignment = settings.mod["Alias System"].alignment
                        rprint(i, "|" .. alignment .. " " .. 'Showing aliases for: "' .. target_hash .. '"')
                    end
                    local duration = settings.mod["Alias System"].duration
                    if players[p_table].alias_timer >= math.floor(duration) then
                        trigger[i] = false
                        alias_bool[i] = false
                        players[p_table].alias_timer = 0
                    end
                end
            end
        end
    end
end

function determineWeapon()
    local primary, secondary, tertiary, quaternary, Slot
    for i = 1, 4 do
        local weapon = settings.mod["Custom Weapons"].weapons[mapname][i]
        if (weapon ~= nil) then
            if (i == 1 and settings.mod["Custom Weapons"].weapons[mapname][1] ~= nil) then
                primary = settings.mod["Custom Weapons"].weapons[mapname][1]
                Slot = 1
            end
            if (i == 2 and settings.mod["Custom Weapons"].weapons[mapname][2] ~= nil) then
                secondary = settings.mod["Custom Weapons"].weapons[mapname][2]
                Slot = 2
            end
            if (i == 3 and settings.mod["Custom Weapons"].weapons[mapname][3] ~= nil) then
                tertiary = settings.mod["Custom Weapons"].weapons[mapname][3]
                Slot = 3
            end
            if (i == 4 and settings.mod["Custom Weapons"].weapons[mapname][4] ~= nil) then
                quaternary = settings.mod["Custom Weapons"].weapons[mapname][4]
                Slot = 4
            end
        end
    end
    return primary, secondary, tertiary, quaternary, Slot
end

function OnPlayerPrejoin(PlayerIndex)
    -- #CONSOLE OUTPUT
    os.execute("echo \7")
    local ns = read_dword(sig_scan("F3ABA1????????BA????????C740??????????E8????????668B0D") + 3)
    local cns = ns + 0x1AA + ce + to_real_index(PlayerIndex) * 0x20
    local name, hash, ip, id = read_widestring(cns, 12), get_var(PlayerIndex, "$hash"), get_var(PlayerIndex, "$ip"), get_var(PlayerIndex, "$n")
    savePlayerData(name, hash, ip, id)
    for k, v in ipairs(player_data) do
        if (string.match(v, name) and string.match(v, hash) and string.match(v, id)) then
            cprint("--------------------------------------------------------------------------------")
            cprint("Player attempting to connect to the server...", 5 + 8)
            cprint(v, 2 + 8)
            break
        end
    end
end

function OnPlayerJoin(PlayerIndex)
    local name = get_var(PlayerIndex, "$name")
    local hash = get_var(PlayerIndex, "$hash")
    local id = get_var(PlayerIndex, "$n")
    local ip = get_var(PlayerIndex, "$ip")

    -- #CONSOLE OUTPUT
    for k, v in ipairs(player_data) do
        if (v:match(name) and v:match(hash) and v:match(id)) then
            cprint("Join Time: " .. os.date("%A %d %B %Y - %X"), 2 + 8)
            cprint("Status: " .. name .. " connected successfully.", 5 + 8)
            cprint("--------------------------------------------------------------------------------")
        end
    end

    -- Used Globally
    local p_table = name .. ", " .. hash
    players[p_table] = { }

    -- #Message Board
    if (settings.mod["Message Board"].enabled == true) then
        players[p_table].message_board_timer = 0
        welcome_timer[PlayerIndex] = true
    end

    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        addAlias(name, hash)
        players[p_table].alias_timer = 0
        welcome_timer[PlayerIndex] = true
    end

    -- #Anti Impersonator
    if (settings.mod["Anti Impersonator"].enabled == true) then

        local name_list = settings.mod["Anti Impersonator"].namelist
        local hash_list = settings.mod["Anti Impersonator"].hashlist

        for i = 1, #name_list do
            for j = 1, #hash_list do
                if (name_list[i]:match(name)) and not (hash_list[i]:match(hash)) then
                    local action = settings.mod["Anti Impersonator"].action
                    local reason = settings.mod["Anti Impersonator"].reason
                    if (action == "kick") then
                        execute_command("k" .. " " .. id .. " \"" .. reason .. "\"")
                        cprint(name .. " was kicked for " .. reason, 4 + 8)
                    elseif (action == "ban") then
                        local bantime = settings.mod["Anti Impersonator"].bantime
                        execute_command("b" .. " " .. id .. " " .. bantime .. " \"" .. reason .. "\"")
                        cprint(name .. " was banned for " .. bantime .. " minutes for " .. reason, 4 + 8)
                    end
                    break
                end
            end
        end
    end

    -- #Chat Logging
    if (settings.mod["Chat Logging"].enabled == true) then
        local dir = settings.mod["Chat Logging"].dir
        local file = io.open(dir, "a+")
        if file ~= nil then
            local timestamp = os.date("[%d/%m/%Y - %H:%M:%S]")
            file:write(timestamp .. "    [JOIN]    Name: " .. name .. "    ID: [" .. id .. "]    IP: [" .. ip .. "]    CD-Key Hash: [" .. hash .. "]\n")
            file:close()
        end
    end


    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        players[p_table].adminchat = nil
        players[p_table].boolean = nil
        if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
            if (settings.mod["Admin Chat"].restore_previous_state == true) then
                local t = tokenizestring(tostring(data[PlayerIndex]), ":")
                if t[2] == "true" then
                    rprint(PlayerIndex, "Your admin chat is on!")
                    players[p_table].adminchat = true
                    players[p_table].boolean = true
                else
                    players[p_table].adminchat = false
                    players[p_table].boolean = false
                end
            else
                players[p_table].adminchat = false
                players[p_table].boolean = false
            end
        end
    end
end

function OnPlayerLeave(PlayerIndex)
    local name = get_var(PlayerIndex, "$name")
    local hash = get_var(PlayerIndex, "$hash")
    local id = get_var(PlayerIndex, "$n")
    local ip

    -- Used Globally
    local p_table = name .. ", " .. hash

    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        alias_bool[PlayerIndex] = false
        trigger[PlayerIndex] = false
        players[p_table].alias_timer = 0
    end

    -- #CONSOLE OUTPUT
    for k, v in ipairs(player_data) do
        if (v:match(name) and v:match(hash) and v:match(id)) then
            ip = settings.global.player_data[3]
            cprint("--------------------------------------------------------------------------------")
            cprint(v, 4 + 8)
            cprint("--------------------------------------------------------------------------------")
            table.remove(player_data, k)
            break
        end
    end


    -- #Message Board
    if (settings.mod["Message Board"].enabled == true) then
        welcome_timer[PlayerIndex] = false
        players[p_table].message_board_timer = 0
    end


    -- #Chat Logging
    if (settings.mod["Chat Logging"].enabled == true) then
        local dir = settings.mod["Chat Logging"].dir
        local file = io.open(dir, "a+")
        if file ~= nil then
            local timestamp = os.date("[%d/%m/%Y - %H:%M:%S]")
            file:write(timestamp .. "    [QUIT]    Name: " .. name .. "    ID: [" .. id .. "]    IP: [" .. ip .. "]    CD-Key Hash: [" .. hash .. "]\n")
            file:close()
        end
    end

    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
            if PlayerIndex ~= 0 then
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                    if (settings.mod["Admin Chat"].restore_previous_state == true) then
                        if players[p_table].adminchat == true then
                            bool = "true"
                        else
                            bool = "false"
                        end
                        data[PlayerIndex] = get_var(PlayerIndex, "$name") .. ":" .. bool
                        stored_data[data] = stored_data[data] or { }
                        table.insert(stored_data[data], tostring(data[PlayerIndex]))
                    else
                        players[p_table].adminchat = false
                        players[p_table].boolean = false
                    end
                end
            end
        end
    end
    
    -- #Teleport Manager
    if (settings.mod["Teleport Manager"].enabled == true) then
        wait_for_response[PlayerIndex] = false
        for i = 1, 3 do previous_location[PlayerIndex][i] = nil end
    end
end

function OnPlayerSpawn(PlayerIndex)
    -- #Custom Weapons
    if (settings.mod["Custom Weapons"].enabled == true) then
        weapon[PlayerIndex] = true
        if player_alive(PlayerIndex) then
            local player_object = get_dynamic_player(PlayerIndex)
            if (player_object ~= 0) then
                if (settings.mod["Custom Weapons"].assign_custom_frags == true) then
                    local frags = settings.mod["Custom Weapons"].weapons[mapname][5]
                    write_word(player_object + 0x31E, tonumber(frags))
                end
                if (settings.mod["Custom Weapons"].assign_custom_plasmas == true) then
                    local plasmas = settings.mod["Custom Weapons"].weapons[mapname][6]
                    write_word(player_object + 0x31F, tonumber(plasmas))
                end
            end
        end
    end
end

function OnPlayerKill(PlayerIndex)
    -- #Respawn Time
    if (settings.mod["Respawn Time"].enabled == true) then
        local player = get_player(PlayerIndex)
        write_dword(player + 0x2C, tonumber(getSpawnTime()) * 33)
    end
end

-- #Respawn Time
function getSpawnTime()
    local spawntime
    if (get_var(1, "$gt") == "ctf") then
        spawntime = settings.mod["Respawn Time"].maps[mapname][1]
    elseif (get_var(1, "$gt") == "slayer") then
        if not getTeamPlay() then
            spawntime = settings.mod["Respawn Time"].maps[mapname][2]
        else
            spawntime = settings.mod["Respawn Time"].maps[mapname][3]
        end
    elseif (get_var(1, "$gt") == "koth") then
        if not getTeamPlay() then
            spawntime = settings.mod["Respawn Time"].maps[mapname][4]
        else
            spawntime = settings.mod["Respawn Time"].maps[mapname][5]
        end
    elseif (get_var(1, "$gt") == "oddball") then
        if not getTeamPlay() then
            spawntime = settings.mod["Respawn Time"].maps[mapname][6]
        else
            spawntime = settings.mod["Respawn Time"].maps[mapname][7]
        end
    elseif (get_var(1, "$gt") == "race") then
        if not getTeamPlay() then
            spawntime = settings.mod["Respawn Time"].maps[mapname][8]
        else
            spawntime = settings.mod["Respawn Time"].maps[mapname][9]
        end
    end
    return spawntime
end

function OnPlayerChat(PlayerIndex, Message, type)
    local name = get_var(PlayerIndex, "$name")
    local hash = get_var(PlayerIndex, "$hash")
    local id = get_var(PlayerIndex, "$n")
    local response

    -- Used Globally
    local p_table = name .. ", " .. hash

    -- #Command Spy
    if (settings.mod["Command Spy"].enabled == true) then
        local command
        local iscommand = nil
        local message = tostring(Message)
        local String = tokenizestring(message)
        if string.sub(String[1], 1, 1) == "/" then
            command = String[1]:gsub("\\", "/")
            iscommand = true
        else
            iscommand = false
        end

        local hidden_messages = settings.mod["Command Spy"].commands_to_hide
        for k, v in pairs(hidden_messages) do
            if (command == k) then
                hidden = true
                break
            else
                hidden = false
            end
        end

        if (tonumber(get_var(PlayerIndex, "$lvl")) == -1) and (iscommand) then
            local hidden_status = settings.mod["Command Spy"].hide_commands
            if (hidden_status == true and hidden == true) then
                response = false
            elseif (hidden_status == true and hidden == false) or (hidden_status == false) then
                CommandSpy(settings.mod["Command Spy"].prefix .. " " .. name .. ":    \"" .. message .. "\"")
                response = true
            end
        end
    end


    -- #Chat Logging
    if (settings.mod["Chat Logging"].enabled == true) then
        local message = tostring(Message)
        local command = tokenizestring(message)
        iscommand = nil
        if string.sub(command[1], 1, 1) == "/" or string.sub(command[1], 1, 1) == "\\" then
            iscommand = true
            chattype = "[COMMAND] "
        else
            iscommand = false
        end

        local chat_type = nil

        if type == 0 then
            chat_type = "[GLOBAL]  "
        elseif type == 1 then
            chat_type = "[TEAM]    "
        elseif type == 2 then
            chat_type = "[VEHICLE] "
        end

        if (player_present(PlayerIndex) ~= nil) then
            local dir = settings.mod["Chat Logging"].dir
            local function LogChat(dir, value)
                local timestamp = os.date("[%d/%m/%Y - %H:%M:%S]")
                local file = io.open(dir, "a+")
                if file ~= nil then
                    local chatValue = string.format("%s\t%s\n", timestamp, tostring(value))
                    file:write(chatValue)
                    file:close()
                end
            end
            if iscommand then
                LogChat(dir, "   " .. chattype .. "     " .. name .. " [" .. id .. "]: " .. message)
                cprint(chattype .. " " .. name .. " [" .. id .. "]: " .. message, 3 + 8)
            else
                LogChat(dir, "   " .. chat_type .. "     " .. name .. " [" .. id .. "]: " .. message)
                cprint(chat_type .. " " .. name .. " [" .. id .. "]: " .. message, 3 + 8)
            end
        end
    end

    -- #Chat IDs
    if (settings.mod["Chat IDs"].enabled == true) then
        if not (game_over) then
            local data
            local message = tokenizestring(Message)
            if (#message == 0) then
                return nil
            end
            local messages_to_ignore = settings.mod["Chat IDs"].ignore_list

            for a = 1, #messages_to_ignore do
                data = messages_to_ignore[a]
            end
            
            local privilege_level = tonumber(get_var(PlayerIndex, "$lvl"))
            
            -- GLOBAL FORMAT
            local GlobalDefault = settings.mod["Chat IDs"].global_format[1]
            local Global_TModFormat = settings.mod["Chat IDs"].trial_moderator[1]
            local Global_ModFormat = settings.mod["Chat IDs"].moderator[1]
            local Global_AdminFormat = settings.mod["Chat IDs"].admin[1]
            local Global_SAdminFormat = settings.mod["Chat IDs"].senior_admin[1]
            
            --TEAM FORMAT
            
            local TeamDefault = settings.mod["Chat IDs"].team_format[1]
            local Team_TModFormat = settings.mod["Chat IDs"].trial_moderator[2]
            local Team_ModFormat = settings.mod["Chat IDs"].moderator[2]
            local Team_AdminFormat = settings.mod["Chat IDs"].admin[2]
            local Team_SAdminFormat = settings.mod["Chat IDs"].senior_admin[2]
            
            if not data:match(message[1]) then
                local function ChatHandler(PlayerIndex, Message)
                
                    local function SendToTeam(Message, PlayerIndex, Global, Tmod, Mod, Admin, sAdmin)
                          for i = 1, 16 do
                              if player_present(i) then
                                if (get_var(i, "$team")) == (get_var(PlayerIndex, "$team")) then
                                    local message = ""
                                    execute_command("msg_prefix \"\"")
                                    if (Global == true) then
                                        for k, v in pairs(settings.mod["Chat IDs"].team_format) do
                                            TeamDefault = string.gsub(TeamDefault, "%%sender_name%%", name)
                                            TeamDefault = string.gsub(TeamDefault, "%%index%%", id)
                                            TeamDefault = string.gsub(TeamDefault, "%%message%%", Message)
                                            message = TeamDefault
                                        end
                                        
                                    elseif (Tmod == true) then
                                        for k, v in pairs(settings.mod["Chat IDs"].trial_moderator) do
                                            Team_TModFormat = string.gsub(Team_TModFormat, "%%sender_name%%", name)
                                            Team_TModFormat = string.gsub(Team_TModFormat, "%%index%%", id)
                                            Team_TModFormat = string.gsub(Team_TModFormat, "%%message%%", Message)
                                            message = Team_TModFormat
                                        end
                                        
                                    elseif (Mod == true) then
                                        for k, v in pairs(settings.mod["Chat IDs"].moderator) do
                                            Team_ModFormat = string.gsub(Team_ModFormat, "%%sender_name%%", name)
                                            Team_ModFormat = string.gsub(Team_ModFormat, "%%index%%", id)
                                            Team_ModFormat = string.gsub(Team_ModFormat, "%%message%%", Message)
                                            message = Team_ModFormat
                                        end
                                        
                                    elseif (Admin == true) then
                                        for k, v in pairs(settings.mod["Chat IDs"].admin) do
                                            Team_AdminFormat = string.gsub(Team_AdminFormat, "%%sender_name%%", name)
                                            Team_AdminFormat = string.gsub(Team_AdminFormat, "%%index%%", id)
                                            Team_AdminFormat = string.gsub(Team_AdminFormat, "%%message%%", Message)
                                            message = Team_AdminFormat
                                        end
                                        
                                    elseif (sAdmin == true) then
                                        for k, v in pairs(settings.mod["Chat IDs"].senior_admin) do
                                            Team_SAdminFormat = string.gsub(Team_SAdminFormat, "%%sender_name%%", name)
                                            Team_SAdminFormat = string.gsub(Team_SAdminFormat, "%%index%%", id)
                                            Team_SAdminFormat = string.gsub(Team_SAdminFormat, "%%message%%", Message)
                                            message = Team_SAdminFormat
                                        end
                                    end
                                    say(i, message)
                                    execute_command("msg_prefix \" " .. settings.global.server_prefix .. "\"")
                                    response = false
                                end
                            end
                        end
                    end
                    
                    local function SendToAll(Message, Global, Tmod, Mod, Admin, sAdmin)
                        local message = ""
                        execute_command("msg_prefix \"\"")
                        if (Global == true) then
                            for k, v in pairs(settings.mod["Chat IDs"].global_format) do
                                GlobalDefault = string.gsub(GlobalDefault, "%%sender_name%%", name)
                                GlobalDefault = string.gsub(GlobalDefault, "%%index%%", id)
                                GlobalDefault = string.gsub(GlobalDefault, "%%message%%", Message)
                                message = GlobalDefault
                            end
                            
                        elseif (Tmod == true) then
                            for k, v in pairs(settings.mod["Chat IDs"].trial_moderator) do
                                Global_TModFormat = string.gsub(Global_TModFormat, "%%sender_name%%", name)
                                Global_TModFormat = string.gsub(Global_TModFormat, "%%index%%", id)
                                Global_TModFormat = string.gsub(Global_TModFormat, "%%message%%", Message)
                                message = Global_TModFormat
                            end
                            
                        elseif (Mod == true) then
                            for k, v in pairs(settings.mod["Chat IDs"].moderator) do
                                Global_ModFormat = string.gsub(Global_ModFormat, "%%sender_name%%", name)
                                Global_ModFormat = string.gsub(Global_ModFormat, "%%index%%", id)
                                Global_ModFormat = string.gsub(Global_ModFormat, "%%message%%", Message)
                                message = Global_ModFormat
                            end
                            
                        elseif (Admin == true) then
                            for k, v in pairs(settings.mod["Chat IDs"].admin) do
                                Global_AdminFormat = string.gsub(Global_AdminFormat, "%%sender_name%%", name)
                                Global_AdminFormat = string.gsub(Global_AdminFormat, "%%index%%", id)
                                Global_AdminFormat = string.gsub(Global_AdminFormat, "%%message%%", Message)
                                message = Global_AdminFormat
                            end
                            
                        elseif (sAdmin == true) then
                            for k, v in pairs(settings.mod["Chat IDs"].senior_admin) do
                                Global_SAdminFormat = string.gsub(Global_SAdminFormat, "%%sender_name%%", name)
                                Global_SAdminFormat = string.gsub(Global_SAdminFormat, "%%index%%", id)
                                Global_SAdminFormat = string.gsub(Global_SAdminFormat, "%%message%%", Message)
                                message = Global_SAdminFormat
                            end
                        end
                        say_all(message)
                        execute_command("msg_prefix \" " .. settings.global.server_prefix .. "\"")
                        response = false
                    end
                    
                    for b = 0, #message do
                        if message[b] then
                            if not (string.sub(message[1], 1, 1) == "/" or string.sub(message[1], 1, 1) == "\\") then
                                if (GetTeamPlay() == true) then
                                    if (type == 0 or type == 2) then
                                        if (settings.mod["Chat IDs"].use_admin_prefixes == true) then
                                            if (privilege_level) == getPermLevel(nil, nil, "trial_moderator") then
                                                SendToAll(Message, nil,true,nil,nil,nil)
                                            elseif (privilege_level) == getPermLevel(nil, nil, "moderator") then
                                                    SendToAll(Message, nil,nil,true,nil,nil)
                                            elseif (privilege_level) == getPermLevel(nil, nil, "admin") then
                                                    SendToAll(Message, nil,nil,nil,true,nil)
                                            elseif (privilege_level) == getPermLevel(nil, nil, "senior_admin") then
                                                SendToAll(Message, nil,nil,nil,nil,true)
                                            else
                                               SendToAll(Message, true,nil,nil,nil,nil)
                                            end
                                        else
                                            SendToAll(Message, true, nil,nil,nil,nil)
                                        end
                                    elseif (type == 1) then
                                        if (settings.mod["Chat IDs"].use_admin_prefixes == true) then
                                            if (privilege_level) == getPermLevel(nil, nil, "trial_moderator") then
                                                SendToTeam(Message, PlayerIndex, nil, true, nil, nil, nil)
                                            elseif (privilege_level) == getPermLevel(nil, nil, "moderator") then
                                                SendToTeam(Message, PlayerIndex, nil, nil, true, nil, nil)
                                            elseif (privilege_level) == getPermLevel(nil, nil, "admin") then
                                                SendToTeam(Message, PlayerIndex, nil, nil, nil, true, nil)
                                            elseif (privilege_level) == getPermLevel(nil, nil, "senior_admin") then
                                                SendToTeam(Message, PlayerIndex, nil, nil, nil, nil, true)
                                            else
                                               SendToTeam(Message, PlayerIndex, true, nil, nil, nil, nil)
                                            end
                                        else
                                            SendToTeam(Message, PlayerIndex, true, nil, nil, nil, nil)
                                        end
                                    end
                                else
                                    SendToAll(Message)
                                end
                            else
                                response = true
                            end
                            break
                        end
                    end
                end
                if (settings.mod["Admin Chat"].enabled == true) then
                    if (players[p_table].adminchat ~= true) then
                        ChatHandler(PlayerIndex, Message)
                    end
                else
                    ChatHandler(PlayerIndex, Message)
                end
            end
        end
    end

    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        local function AdminChat(Message, PlayerIndex)
            for i = 1, 16 do
                if player_present(i) and tonumber(get_var(i, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                    if (settings.mod["Admin Chat"].environment == "rcon") then
                        rprint(i, "|l" .. Message)
                    elseif (settings.mod["Admin Chat"].environment == "chat") then
                        execute_command("msg_prefix \"\"")
                        say(i, Message)
                        execute_command("msg_prefix \" *  * SERVER *  * \"")
                    end
                end
            end
        end
        
        local message = tokenizestring(Message)
        if #message == 0 then
            return nil
        end

        if players[p_table].adminchat == true then
            if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                for c = 0, #message do
                    if message[c] then
                        if string.sub(message[1], 1, 1) == "/" or string.sub(message[1], 1, 1) == "\\" then
                            response = true
                        else
                            local AdminMessageFormat = settings.mod["Admin Chat"].message_format[1]
                            for k, v in pairs(settings.mod["Admin Chat"].message_format) do
                                local prefix = settings.mod["Admin Chat"].prefix
                                AdminMessageFormat = string.gsub(AdminMessageFormat, "%%prefix%%", prefix)
                                AdminMessageFormat = string.gsub(AdminMessageFormat, "%%sender_name%%", name)
                                AdminMessageFormat = string.gsub(AdminMessageFormat, "%%index%%", id)
                                AdminMessageFormat = string.gsub(AdminMessageFormat, "%%message%%", Message)
                                AdminChat(AdminMessageFormat)
                                response = false
                            end
                        end
                        break
                    end
                end
            end
        end
        
        -- #Teleport Manager
        if (settings.mod["Teleport Manager"].enabled == true) then
            if wait_for_response[PlayerIndex] then
                if Message == ("yes") then
                    local file_name = settings.mod["Teleport Manager"].dir
                    delete_from_file(file_name, response_starting_line, response_num_lines, PlayerIndex)
                    rprint(PlayerIndex, "Successfully deleted teleport id #" .. response_starting_line)
                    wait_for_response[PlayerIndex] = false
                    response = false
                elseif Message == ("no") then
                    rprint(PlayerIndex, "Process Cancelled")
                    wait_for_response[PlayerIndex] = false
                    response = false
                end
                if Message ~= "yes" or Message ~= "no" then
                    rprint(PlayerIndex, "That is not a valid response, please try again. Type yes|no")
                    wait_for_response[PlayerIndex] = true
                    response = false
                end
            end
        end
    end
    return response
end

function OnServerCommand(PlayerIndex, Command, Environment, Password)
    local name = get_var(PlayerIndex, "$name")
    local hash = get_var(PlayerIndex, "$hash")

    -- Used Globally
    local p_table = name .. ", " .. hash

    -- #List Players
    if (settings.mod["List Players"].enabled == true) then
        local t = tokenizestring(Command)
        local commands = settings.mod["List Players"].command_aliases
        local count = #t
        for k, v in pairs(commands) do
            local cmds = tokenizestring(v, ",")
            for i = 1, #cmds do
                if (t[1] == cmds[i]) then
                    if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("List Players", nil, nil) then
                        listPlayers(PlayerIndex, count)
                    else
                        rprint(PlayerIndex, "Insufficient Permission")
                    end
                    return false
                end
            end
        end
    end
    
    -- #Get Coords
    if (settings.mod["Get Coords"].enabled == true) then
        if (string.lower(Command) == settings.mod["Get Coords"].base_command) then
            if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Get Coords", nil, nil) then
                local player_object = get_dynamic_player(PlayerIndex)
                if player_object ~= 0 then
                    local x, y, z = read_vector3d(player_object + 0x5C)
                    if settings.mod["Get Coords"].environment == "console" then 
                        cprint(x .. ", " .. y .. ", " .. z)
                    elseif settings.mod["Get Coords"].environment == "rcon" then
                        rprint(PlayerIndex, x .. ", " .. y .. ", " .. z)
                    elseif settings.mod["Get Coords"].environment == "both" then
                        rprint(PlayerIndex, x .. ", " .. y .. ", " .. z)
                        cprint(x .. ", " .. y .. ", " .. z)
                    end
                    kill(PlayerIndex)
                    local player = get_player(PlayerIndex)
                    write_dword(player + 0x2C, 0 * 33)
                    return false
                end
            end
        end
    end
    -- #Admin Chat
    if (settings.mod["Admin Chat"].enabled == true) then
        local t = tokenizestring(Command)
        local command = settings.mod["Admin Chat"].base_command
        if t[1] == (command) then
            if PlayerIndex ~= -1 and PlayerIndex >= 1 and PlayerIndex < 16 then
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Admin Chat", nil, nil) then
                    if t[2] == "on" or t[2] == "1" or t[2] == "true" or t[2] == '"1"' or t[2] == '"on"' or t[2] == '"true"' then
                        if players[p_table].boolean ~= true then
                            players[p_table].adminchat = true
                            players[p_table].boolean = true
                            rprint(PlayerIndex, "Admin Chat enabled.")
                            return false
                        else
                            rprint(PlayerIndex, "Admin Chat is already enabled.")
                            return false
                        end
                    elseif t[2] == "off" or t[2] == "0" or t[2] == "false" or t[2] == '"off"' or t[2] == '"0"' or t[2] == '"false"' then
                        if players[p_table].boolean ~= false then
                            players[p_table].adminchat = false
                            players[p_table].boolean = false
                            rprint(PlayerIndex, "Admin Chat disabled.")
                            return false
                        else
                            rprint(PlayerIndex, "Admin Chat is already disabled.")
                            return false
                        end
                    else
                        rprint(PlayerIndex, "Invalid Syntax: Type /achat on|off")
                        return false
                    end
                else
                    rprint(PlayerIndex, "You do not have permission to execute that command!")
                    return false
                end
            else
                cprint("The Server cannot execute this command!", 4 + 8)
            end
        end
    end
    -- #Alias System
    if (settings.mod["Alias System"].enabled == true) then
        local t = tokenizestring(Command)
        if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Alias System", nil, nil) then
            if t[1] == string.lower(settings.mod["Alias System"].base_command) then
                if t[2] ~= nil then
                    if t[2] == string.match(t[2], "^%d+$") and t[3] == nil then
                        if player_present(tonumber(t[2])) then
                            local index = tonumber(t[2])
                            target_hash = tostring(get_var(index, "$hash"))
                            if trigger[PlayerIndex] == true then
                                -- aliases already showing (clear console then show again)
                                cls(PlayerIndex)
                                players[p_table].alias_timer = 0
                                trigger[PlayerIndex] = true
                                alias_bool[PlayerIndex] = true
                            else
                                -- show aliases (first time)
                                trigger[PlayerIndex] = true
                                alias_bool[PlayerIndex] = true
                            end
                        else
                            players[p_table].alias_timer = 0
                            trigger[PlayerIndex] = false
                            cls(PlayerIndex)
                            rprint(PlayerIndex, "Player not present")
                        end
                    else
                        players[p_table].alias_timer = 0
                        trigger[PlayerIndex] = false
                        cls(PlayerIndex)
                        rprint(PlayerIndex, "Invalid player id")
                    end
                    return false
                else
                    rprint(PlayerIndex, "Invalid syntax. Use /" .. base_command .. " [id]")
                    return false
                end
            end
        else
            rprint(PlayerIndex, "Insufficient Permission")
        end
    end
    -- #Teleport Manager
    if (settings.mod["Teleport Manager"].enabled == true) then
        local file_name = settings.mod["Teleport Manager"].dir
        local t = tokenizestring(Command)
        if t[1] ~= nil then
            if t[1] == string.lower(settings.mod["Teleport Manager"].commands[1]) then
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Teleport Manager", true, "setwarp") then
                    if t[2] ~= nil then
                        check_file_status(PlayerIndex)
                        if not empty_file then
                            local lines = lines_from(file_name)
                            for k, v in pairs(lines) do
                                if t[2] == v:match("[%a%d+_]*") then
                                    rprint(PlayerIndex, "That portal name already exists!")
                                    canset[PlayerIndex] = false
                                    break
                                else
                                    canset[PlayerIndex] = true
                                end
                            end
                        else
                            canset[PlayerIndex] = true
                        end
                        if t[2] == t[2]:match(mapname) then
                            rprint(PlayerIndex, "Teleport name cannot be the same as the current map name!")
                            canset[PlayerIndex] = false
                        end
                        if canset[PlayerIndex] == true then
                            if PlayerInVehicle(PlayerIndex) then
                                x1, y1, z1 = read_vector3d(get_object_memory(read_dword(get_dynamic_player(PlayerIndex) + 0x11C)) + 0x5c)
                            else
                                x1, y1, z1 = read_vector3d(get_dynamic_player(PlayerIndex) + 0x5C)
                            end
                            local file = io.open(file_name, "a+")
                            local line = t[2] .. " [Map: " .. mapname .. "] X " .. x1 .. ", Y " .. y1 .. ", Z " .. z1
                            file:write(line, "\n")
                            file:close()
                            rprint(PlayerIndex, "Teleport location set to: " .. x1 .. ", " .. y1 .. ", " .. z1)
                        end
                    else
                        rprint(PlayerIndex, "Invalid Syntax. Command Usage: /" .. settings.mod["Teleport Manager"].commands[1] .. " <teleport name>")
                    end
                else
                    rprint(PlayerIndex, "You're not allowed to execute /" .. settings.mod["Teleport Manager"].commands[1])
                end
                return false
            end
        end
        ---------------------------------------------------------
        -- GO TO COMMAND --
        if t[1] ~= nil then
            if t[1] == string.lower(settings.mod["Teleport Manager"].commands[2]) then
                check_file_status(PlayerIndex)
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Teleport Manager", true, "warp") then
                    if t[2] ~= nil then
                        if not empty_file then
                            local found = nil
                            local lines = lines_from(file_name)
                            for k, v in pairs(lines) do
                                local valid = nil
                                if t[2] == v:match("[%a%d+_]*") then
                                    if (player_alive(PlayerIndex)) then
                                        if string.find(v, mapname) then
                                            found = true
                                            -- numbers without decimal points -----------------------------------------------------------------------------
                                            if string.match(v, ("X%s*%d+,%s*Y%s*%d+,%s*Z%s*%d+")) then
                                                valid = true -- 0
                                                x = string.gsub(string.match(v, "X%s*%d+"), "X%s*%d+", string.match(string.match(v, "X%s*%d+"), "%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+"), "Y%s*%d+", string.match(string.match(v, "Y%s*%d+"), "%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+"), "Z%s*%d+", string.match(string.match(v, "Z%s*%d+"), "%d+"))
                                            elseif string.match(v, ("X%s*-%d+,%s*Y%s*-%d+,%s*Z%s*-%d+")) then
                                                valid = true -- *
                                                x = string.gsub(string.match(v, "X%s*-%d+"), "X%s*-%d+", string.match(string.match(v, "X%s*-%d+"), "-%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+"), "Y%s*-%d+", string.match(string.match(v, "Y%s*-%d+"), "-%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+"), "Z%s*-%d+", string.match(string.match(v, "Z%s*-%d+"), "-%d+"))
                                            elseif string.match(v, ("X%s*-%d+,%s*Y%s*%d+,%s*Z%s*%d+")) then
                                                valid = true -- 1
                                                x = string.gsub(string.match(v, "X%s*-%d+"), "X%s*-%d+", string.match(string.match(v, "X%s*-%d+"), "-%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+"), "Y%s*%d+", string.match(string.match(v, "Y%s*%d+"), "%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+"), "Z%s*%d+", string.match(string.match(v, "Z%s*%d+"), "%d+"))
                                            elseif string.match(v, ("X%s*%d+,%s*Y%s*-%d+,%s*Z%s*%d+")) then
                                                valid = true -- 2
                                                x = string.gsub(string.match(v, "X%s*%d+"), "X%s*%d+", string.match(string.match(v, "X%s*%d+"), "%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+"), "Y%s*-%d+", string.match(string.match(v, "Y%s*-%d+"), "-%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+"), "Z%s*%d+", string.match(string.match(v, "Z%s*%d+"), "%d+"))
                                            elseif string.match(v, ("X%s*%d+,%s*Y%s*%d+,%s*Z%s*-%d+")) then
                                                valid = true -- 3
                                                x = string.gsub(string.match(v, "X%s*%d+"), "X%s*%d+", string.match(string.match(v, "X%s*%d+"), "%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+"), "Y%s*%d+", string.match(string.match(v, "Y%s*%d+"), "%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+"), "Z%s*-%d+", string.match(string.match(v, "Z%s*-%d+"), "-%d+"))
                                            elseif string.match(v, ("X%s*-%d+,%s*Y%s*-%d+,%s*Z%s*%d+")) then
                                                valid = true -- 1 & 2
                                                x = string.gsub(string.match(v, "X%s*-%d+"), "X%s*-%d+", string.match(string.match(v, "X%s*-%d+"), "-%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+"), "Y%s*-%d+", string.match(string.match(v, "Y%s*-%d+"), "-%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+"), "Z%s*%d+", string.match(string.match(v, "Z%s*%d+"), "%d+"))
                                            elseif string.match(v, ("X%s*-%d+,%s*Y%s*%d+,%s*Z%s*-%d+")) then
                                                valid = true -- 1 & 3
                                                x = string.gsub(string.match(v, "X%s*-%d+"), "X%s*-%d+", string.match(string.match(v, "X%s*-%d+"), "-%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+"), "Y%s*%d+", string.match(string.match(v, "Y%s*%d+"), "%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+"), "Z%s*-%d+", string.match(string.match(v, "Z%s*-%d+"), "-%d+"))
                                            elseif string.match(v, ("X%s*%d+,%s*Y%s*-%d+,%s*Z%s*-%d+")) then
                                                valid = true -- 2 & 3
                                                x = string.gsub(string.match(v, "X%s*%d+"), "X%s*%d+", string.match(string.match(v, "X%s*%d+"), "%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+"), "Y%s*-%d+", string.match(string.match(v, "Y%s*-%d+"), "-%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+"), "Z%s*-%d+", string.match(string.match(v, "Z%s*-%d+"), "-%d+"))
                                                -- numbers with decimal points -----------------------------------------------------------------------------
                                            elseif string.match(v, ("X%s*%d+.%d+,%s*Y%s*%d+.%d+,%s*Z%s*%d+.%d+")) then
                                                valid = true -- 0
                                                x = string.gsub(string.match(v, "X%s*%d+.%d+"), "X%s*%d+.%d+", string.match(string.match(v, "X%s*%d+.%d+"), "%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+.%d+"), "Y%s*%d+.%d+", string.match(string.match(v, "Y%s*%d+.%d+"), "%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+.%d+"), "Z%s*%d+.%d+", string.match(string.match(v, "Z%s*%d+.%d+"), "%d+.%d+"))
                                            elseif string.match(v, ("X%s*-%d+.%d+,%s*Y%s*-%d+.%d+,%s*Z%s*-%d+.%d+")) then
                                                valid = true -- *
                                                x = string.gsub(string.match(v, "X%s*-%d+.%d+"), "X%s*-%d+.%d+", string.match(string.match(v, "X%s*-%d+.%d+"), "-%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+.%d+"), "Y%s*-%d+.%d+", string.match(string.match(v, "Y%s*-%d+.%d+"), "-%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+.%d+"), "Z%s*-%d+.%d+", string.match(string.match(v, "Z%s*-%d+.%d+"), "-%d+.%d+"))
                                            elseif string.match(v, ("X%s*-%d+.%d+,%s*Y%s*%d+.%d+,%s*Z%s*%d+.%d+")) then
                                                valid = true -- 1
                                                x = string.gsub(string.match(v, "X%s*-%d+.%d+"), "X%s*-%d+.%d+", string.match(string.match(v, "X%s*-%d+.%d+"), "-%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+.%d+"), "Y%s*%d+.%d+", string.match(string.match(v, "Y%s*%d+.%d+"), "%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+.%d+"), "Z%s*%d+.%d+", string.match(string.match(v, "Z%s*%d+.%d+"), "%d+.%d+"))
                                            elseif string.match(v, ("X%s*%d+.%d+,%s*Y%s*-%d+.%d+,%s*Z%s*%d+.%d+")) then
                                                valid = true -- 2
                                                x = string.gsub(string.match(v, "X%s*%d+.%d+"), "X%s*%d+.%d+", string.match(string.match(v, "X%s*%d+.%d+"), "%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+.%d+"), "Y%s*-%d+.%d+", string.match(string.match(v, "Y%s*-%d+.%d+"), "-%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+.%d+"), "Z%s*%d+.%d+", string.match(string.match(v, "Z%s*%d+.%d+"), "%d+.%d+"))
                                            elseif string.match(v, ("X%s*%d+.%d+,%s*Y%s*%d+.%d+,%s*Z%s*-%d+.%d+")) then
                                                valid = true -- 3
                                                x = string.gsub(string.match(v, "X%s*%d+.%d+"), "X%s*%d+.%d+", string.match(string.match(v, "X%s*%d+.%d+"), "%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+.%d+"), "Y%s*%d+.%d+", string.match(string.match(v, "Y%s*%d+.%d+"), "%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+.%d+"), "Z%s*-%d+.%d+", string.match(string.match(v, "Z%s*-%d+.%d+"), "-%d+.%d+"))
                                            elseif string.match(v, ("X%s*-%d+.%d+,%s*Y%s*-%d+.%d+,%s*Z%s*%d+.%d+")) then
                                                valid = true -- 1 & 2
                                                x = string.gsub(string.match(v, "X%s*-%d+.%d+"), "X%s*-%d+.%d+", string.match(string.match(v, "X%s*-%d+.%d+"), "-%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+.%d+"), "Y%s*-%d+.%d+", string.match(string.match(v, "Y%s*-%d+.%d+"), "-%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*%d+.%d+"), "Z%s*%d+.%d+", string.match(string.match(v, "Z%s*%d+.%d+"), "%d+.%d+"))
                                            elseif string.match(v, ("X%s*-%d+.%d+,%s*Y%s*%d+.%d+,%s*Z%s*-%d+.%d+")) then
                                                valid = true -- 1 & 3
                                                x = string.gsub(string.match(v, "X%s*-%d+.%d+"), "X%s*-%d+.%d+", string.match(string.match(v, "X%s*-%d+.%d+"), "-%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*%d+.%d+"), "Y%s*%d+.%d+", string.match(string.match(v, "Y%s*%d+.%d+"), "%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+.%d+"), "Z%s*-%d+.%d+", string.match(string.match(v, "Z%s*-%d+.%d+"), "-%d+.%d+"))
                                            elseif string.match(v, ("X%s*%d+.%d+,%s*Y%s*-%d+.%d+,%s*Z%s*-%d+.%d+")) then
                                                valid = true  -- 2 & 3
                                                x = string.gsub(string.match(v, "X%s*%d+.%d+"), "X%s*%d+.%d+", string.match(string.match(v, "X%s*%d+.%d+"), "%d+.%d+"))
                                                y = string.gsub(string.match(v, "Y%s*-%d+.%d+"), "Y%s*-%d+.%d+", string.match(string.match(v, "Y%s*-%d+.%d+"), "-%d+.%d+"))
                                                z = string.gsub(string.match(v, "Z%s*-%d+.%d+"), "Z%s*-%d+.%d+", string.match(string.match(v, "Z%s*-%d+.%d+"), "-%d+.%d+"))
                                            else
                                                rprint(PlayerIndex, "Script Error! Coordinates for that teleport do not match the regex expression!")
                                                cprint("Script Error! Coordinates for that teleport do not match the regex expression!", 4 + 8)
                                            end
                                            if (v ~= nil and valid == true) then
                                                if not PlayerInVehicle(PlayerIndex) then
                                                    local prevX, prevY, prevZ = read_vector3d(get_dynamic_player(PlayerIndex) + 0x5C)
                                                    previous_location[PlayerIndex][1] = prevX
                                                    previous_location[PlayerIndex][2] = prevY
                                                    previous_location[PlayerIndex][3] = prevZ
                                                    write_vector3d(get_dynamic_player(PlayerIndex) + 0x5C, tonumber(x), tonumber(y), tonumber(z))
                                                    rprint(PlayerIndex, "Teleporting to [" .. t[2] .. "] " .. math.floor(x) .. ", " .. math.floor(y) .. ", " .. math.floor(z))
                                                    valid = false
                                                else
                                                    TeleportPlayer(read_dword(get_dynamic_player(PlayerIndex) + 0x11C), tonumber(x), tonumber(y), tonumber(z) + 0.5)
                                                    rprint(PlayerIndex, "Teleporting to [" .. t[2] .. "] " .. math.floor(x) .. ", " .. math.floor(y) .. ", " .. math.floor(z))
                                                    valid = false
                                                end
                                            end
                                        else
                                            found = true
                                            rprint(PlayerIndex, "That warp is not linked to this map!")
                                        end
                                    else
                                        found = true
                                        rprint(PlayerIndex, "You cannot teleport when dead!")
                                    end
                                end
                            end
                            if found ~= true then
                                rprint(PlayerIndex, "That teleport name is not valid!")
                            end
                        else
                            rprint(PlayerIndex, "The teleport list is empty!")
                        end
                    else
                        rprint(PlayerIndex, "Invalid Syntax. Command Usage: /" .. settings.mod["Teleport Manager"].commands[2] .. " <teleport name>")
                    end
                else
                    rprint(PlayerIndex, "You're not allowed to execute /" .. settings.mod["Teleport Manager"].commands[2])
                end
                return false
                ---------------------------------------------------------
                -- BACK COMMAND --
            elseif t[1] == string.lower(settings.mod["Teleport Manager"].commands[3]) then
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Teleport Manager", true, "back") then
                    if not PlayerInVehicle(PlayerIndex) then
                        if previous_location[PlayerIndex][1] ~= nil then
                            write_vector3d(get_dynamic_player(PlayerIndex) + 0x5C, previous_location[PlayerIndex][1], previous_location[PlayerIndex][2], previous_location[PlayerIndex][3])
                            rprint(PlayerIndex, "Returning to previous location!")
                            for i = 1, 3 do
                                previous_location[PlayerIndex][i] = nil
                            end
                        else
                            rprint(PlayerIndex, "Unable to teleport back! You haven't been anywhere!")
                        end
                    end
                else
                    rprint(PlayerIndex, "You're not allowed to execute /" .. settings.mod["Teleport Manager"].commands[3])
                end
                return false
                ---------------------------------------------------------
                -- LIST COMMAND --
            elseif t[1] == string.lower(settings.mod["Teleport Manager"].commands[4]) then
                local found = false
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Teleport Manager", true, "warplist") then
                    check_file_status(PlayerIndex)
                    if not empty_file then
                        local lines = lines_from(file_name)
                        for k, v in pairs(lines) do
                            if string.find(v, mapname) then
                                found = true
                                rprint(PlayerIndex, "[" .. k .. "] " .. v)
                            end
                        end
                        if not found then 
                            rprint(PlayerIndex, "There are no warps for the current map.")
                        end
                    else
                        rprint(PlayerIndex, "The teleport list is empty!")
                    end
                else
                    rprint(PlayerIndex, "You're not allowed to execute /" .. settings.mod["Teleport Manager"].commands[4])
                end
                return false
                ---------------------------------------------------------
                -- LIST ALL COMMAND --
            elseif t[1] == string.lower(settings.mod["Teleport Manager"].commands[5]) then
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Teleport Manager", true, "warplistall") then
                    check_file_status(PlayerIndex)
                    if not empty_file then
                        local lines = lines_from(file_name)
                        for k, v in pairs(lines) do
                            rprint(PlayerIndex, "[" .. k .. "] " .. v)
                        end
                    else
                        rprint(PlayerIndex, "The teleport list is empty!")
                    end
                else
                    rprint(PlayerIndex, "You're not allowed to execute /" .. settings.mod["Teleport Manager"].commands[5])
                end
                return false
                ---------------------------------------------------------
                -- DELETE COMMAND --
            elseif t[1] == string.lower(settings.mod["Teleport Manager"].commands[6]) then
                local command = t[1]
                if tonumber(get_var(PlayerIndex, "$lvl")) >= getPermLevel("Teleport Manager", true, "delwarp") then
                    if t[2] ~= nil then
                        check_file_status(PlayerIndex)
                        if not empty_file then
                            local lines = lines_from(file_name)
                            local del_found = nil
                            for k, v in pairs(lines) do
                                if k ~= nil then
                                    if t[2] == v:match(k) then
                                        del_found = true
                                        response_starting_line = nil
                                        response_num_lines = nil
                                        if string.find(v, mapname) then
                                            delete_from_file(file_name, k, 1, PlayerIndex)
                                            rprint(PlayerIndex, "Successfully deleted teleport id #" .. k)
                                        else
                                            wait_for_response[PlayerIndex] = true
                                            rprint(PlayerIndex, "Warning: That teleport is not linked to this map.")
                                            rprint(PlayerIndex, "Type 'YES' to delete, type 'NO' to cancel.")
                                            response_starting_line = k
                                            response_num_lines = 1
                                        end
                                    end
                                end
                            end
                            if del_found ~= true then
                                rprint(PlayerIndex, "Teleport Index ID does not exist!")
                            end
                        else
                            rprint(PlayerIndex, "The teleport list is empty!")
                        end
                    else
                        rprint(PlayerIndex, "Invalid Syntax. Command Usage: /" .. settings.mod["Teleport Manager"].commands[6] .. " <index id>")
                    end
                else
                    rprint(PlayerIndex, "You're not allowed to execute /" .. settings.mod["Teleport Manager"].commands[6])
                end
                return false
            end
        end
    end
end

-- #List Players
function listPlayers(PlayerIndex, count)
    if (count == 1) then
        rprint(PlayerIndex, "|" .. settings.mod["List Players"].alignment .. " [ ID.    -    Name.    -    Team.    -    IP. ]")
        for i = 1, 16 do
            if player_present(i) then
                local name = get_var(i, "$name")
                local id = get_var(i, "$n")
                local team = get_var(i, "$team")
                local ip = get_var(i, "$ip")
                local hash = get_var(i, "$hash")
                if get_var(0, "$ffa") == "0" then
                    if team == "red" then
                        team = "Red Team"
                    elseif team == "blue" then
                        team = "Blue Team"
                    else
                        team = "Hidden"
                    end
                else
                    team = "FFA"
                end
                rprint(PlayerIndex, "|" .. settings.mod["List Players"].alignment .. id .. ".   " .. name .. "   |   " .. team .. "  -  IP: " .. ip)
            end
        end
    else
        rprint(PlayerIndex, "Invalid Syntax")
        return false
    end
end

-- #Command Spy
function CommandSpy(Message)
    for i = 1, 16 do
        if (tonumber(get_var(i, "$lvl"))) >= getPermLevel("Command Spy", nil, nil) then
            rprint(i, Message)
        end
    end
end

-- #Message Board
function read_widestring(address, length)
    local count = 0
    local byte_table = {}
    for i = 1, length do
        if read_byte(address + count) ~= 0 then
            byte_table[i] = string.char(read_byte(address + count))
        end
        count = count + 2
    end
    return table.concat(byte_table)
end

-- #Anti Impersonator
function table.match(table, value)
    for k, v in pairs(table) do
        if v == value then
            return k
        end
    end
end

-- Clears the players console
function cls(PlayerIndex)
    for _ = 1, 25 do
        rprint(PlayerIndex, " ")
    end
end

-- Used Globally
function tokenizestring(inputString, Separator)
    if Separator == nil then
        Separator = "%s"
    end
    local t = {};
    i = 1
    for str in string.gmatch(inputString, "([^" .. Separator .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- Used Globally
function getPermLevel(script, bool, args)
    local level = 0
    
    if (script ~= nil and bool == nil and args == nil) then
        level = settings.mod[script].permission_level
        
    elseif (script == nil and bool == nil and args ~= nil) then
        -- Global Permissions
        local permission_table = settings.global.permission_level
        for k, v in pairs(permission_table) do
            local words = tokenizestring(v, ",")
            for i = 1, #words do
                if (tostring(k) == args) then 
                    level = words[i]
                    break
                end
            end
        end
    elseif (script ~= nil and bool == true and args ~= nil) then
        -- Teleport Manager
        if (settings.mod["Teleport Manager"].enabled == true) then
            local permission_table = settings.mod["Teleport Manager"].permission_level
            for k, v in pairs(permission_table) do
                local words = tokenizestring(v, ",")
                for i = 1, #words do
                    if (tostring(k) == args) then 
                        level = words[i]
                        break
                    end
                end
            end
        end
    end
    return tonumber(level)
end

-- Used Globally
function GetTeamPlay()
    if get_var(0, "$ffa") == "0" then
        return true
    else
        return false
    end
end

-- Used Globally
function lines_from(file)
    lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

-- Used Globally
function PlayerInVehicle(PlayerIndex)
    if (get_dynamic_player(PlayerIndex) ~= 0) then
        local VehicleID = read_dword(get_dynamic_player(PlayerIndex) + 0x11C)
        if VehicleID == 0xFFFFFFFF then
            return false
        else
            return true
        end
    else
        return false
    end
end

-- Used Globally
function TeleportPlayer(ObjectID, x, y, z)
    if get_object_memory(ObjectID) ~= 0 then
        local veh_obj = get_object_memory(read_dword(get_object_memory(ObjectID) + 0x11C))
        write_vector3d((veh_obj ~= 0 and veh_obj or get_object_memory(ObjectID)) + 0x5C, x, y, z)
    end
end

-- Saves player join data (name, hash, ip address, id)
function savePlayerData(name, hash, ip, id)
    local a = string.gsub(settings.global.player_data[1], "%%name%%", name)
    local b = string.gsub(settings.global.player_data[2], "%%hash%%", hash)
    local c = string.gsub(settings.global.player_data[3], "%%ip_address%%", ip)
    local d = string.gsub(settings.global.player_data[4], "%%index_id%%", id)
    local data = a .. "\n" .. b .. "\n" .. c .. "\n" .. d
    table.insert(player_data, data)
end

-- Prints enabled scripts | Called by OnScriptLoad()
function printEnabled()
    for k, v in pairs(settings.mod) do
        if (settings.mod[k].enabled == true) then
            cprint(k .. " is enabled", 2 + 8)
        else
            cprint(k .. " is disabled", 4 + 8)
        end
    end
end

-- #Weapon Settings
function loadWeaponTags()
    pistol = "weapons\\pistol\\pistol"
    sniper = "weapons\\sniper rifle\\sniper rifle"
    plasma_cannon = "weapons\\plasma_cannon\\plasma_cannon"
    rocket_launcher = "weapons\\rocket launcher\\rocket launcher"
    plasma_pistol = "weapons\\plasma pistol\\plasma pistol"
    plasma_rifle = "weapons\\plasma rifle\\plasma rifle"
    assault_rifle = "weapons\\assault rifle\\assault rifle"
    flamethrower = "weapons\\flamethrower\\flamethrower"
    needler = "weapons\\needler\\mp_needler"
    shotgun = "weapons\\shotgun\\shotgun"
end

function table.val_to_str (v)
    if "string" == type(v) then
        v = string.gsub(v, "\n", "\\n")
        if string.match(string.gsub(v, "[^'\"]", ""), '^"+$') then
            return "'" .. v .. "'"
        end
        return '"' .. string.gsub(v, '"', '\\"') .. '"'
    else
        return "table" == type(v) and table.tostring(v) or
                tostring(v)
    end
end

function table.key_to_str (k)
    if "string" == type(k) and string.match(k, "^[_%a][_%a%d]*$") then
        return k
    else
        return "[" .. table.val_to_str(k) .. "]"
    end
end

function table.tostring(tbl)
    local result, done = {}, {}
    for k, v in ipairs(tbl) do
        table.insert(result, table.val_to_str(v))
        done[k] = true
    end
    for k, v in pairs(tbl) do
        if not done[k] then
            table.insert(result,
                    table.key_to_str(k) .. "=" .. table.val_to_str(v))
        end
    end
    return "{" .. table.concat(result, ",") .. "}"
end

-- #Alias System
function addAlias(name, hash)
    local file_name = settings.mod["Alias System"].dir
    local file = io.open(file_name, "r")
    local data = file:read("*a")
    file:close()
    if string.match(data, hash) then
        local lines = lines_from(file_name)
        for k, v in pairs(lines) do
            if string.match(v, hash) then
                if not v:match(name) then
                    local alias = v .. ", " .. name
                    local f = io.open(file_name, "r")
                    local content = f:read("*all")
                    f:close()
                    content = string.gsub(content, v, alias)
                    local f = io.open(file_name, "w")
                    f:write(content)
                    f:close()
                end
            end
        end
    else
        local file = assert(io.open(file_name, "a+"))
        file:write("\n" .. hash .. ":" .. name, "\n")
        file:close()
    end
end

-- #Alias System
function checkFile()
    local file_name = settings.mod["Alias System"].dir
    local file = io.open(file_name, "rb")
    if file then
        file:close()
    else
        local file = io.open(file_name, "a+")
        if file then
            file:close()
        end
    end
end

-- #Alias System
function concatValues(PlayerIndex, start_index, end_index)
    local file_name = settings.mod["Alias System"].dir
    local lines = lines_from(file_name)
    for k, v in pairs(lines) do
        if v:match(target_hash) then
            local aliases = string.match(v, (":(.+)"))
            local words = tokenizestring(aliases, ", ")
            local word_table = {}
            local row
            for i = tonumber(start_index), tonumber(end_index) do
                if words[i] ~= nil then
                    table.insert(word_table, words[i])
                    row = table.concat(word_table, ", ")
                end
            end
            if row ~= nil then
                rprint(PlayerIndex, "|" .. settings.mod["Alias System"].alignment .. " " .. row)
            end
            for _ in pairs(word_table) do
                word_table[_] = nil
            end
            break
        end
    end
end

-- #Teleport Manager
function check_file_status(PlayerIndex)
    local file_name = settings.mod["Teleport Manager"].dir
    local fileX = io.open(file_name, "rb")
    if fileX then
        fileX:close()
    else
        local fileY = io.open(file_name, "a+")
        if fileY then
            fileY:close()
        end
        if player_present(PlayerIndex) then
            rprint(PlayerIndex, file_name .. " doesn't exist. Creating...")
            cprint(file_name .. " doesn't exist. Creating...")
        end
    end
    local fileZ = io.open(file_name, "r")
    local line = fileZ:read()
    if line == nil then
        empty_file = true
    else
        empty_file = false
    end
    fileZ:close()
end

-- #Teleport Manager
function delete_from_file(filename, starting_line, num_lines, PlayerIndex)
    local fp = io.open(filename, "r")
    if fp == nil then
        check_file_status(PlayerIndex)
    end
    content = {}
    i = 1;
    for line in fp:lines() do
        if i < starting_line or i >= starting_line + num_lines then
            content[#content + 1] = line
        end
        i = i + 1
    end
    if i > starting_line and i < starting_line + num_lines then
        rprint(PlayerIndex, "Warning: End of File! No entries to delete.")
        cprint("Warning: End of File! No entries to delete.")
    end
    fp:close()
    fp = io.open(filename, "w+")
    for i = 1, #content do
        fp:write(string.format("%s\n", content[i]))
    end
    fp:close()
end

function OnError(Message)
    print(debug.traceback())
end
