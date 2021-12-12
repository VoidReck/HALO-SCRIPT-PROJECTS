--[[
--=====================================================================================================--
Script Name: Zombies 2021, for SAPP (PC & CE)
Description: A fully customizable zombie game.
            See the bottom of this script for recommended game type settings.

            todo: remove ammo from zombie weapons

Copyright (c) 2021, Jericho Crosby <jericho.crosby227@gmail.com>
* Notice: You can use this document subject to the following conditions:
https://github.com/Chalwk77/HALO-SCRIPT-PROJECTS/blob/master/LICENSE
--=====================================================================================================--
]]--

-- config starts --
local Zombies = {

    -- Time (in seconds) until a game begins:
    --
    game_start_delay = 5,

    -- Number of players required to start the game:
    --
    required_players = 2,

    -- Time (in seconds) until a human is selected to become a zombie:
    --
    no_zombies_delay = 5,

    -- Human Team:
    --
    human_team = "red",

    -- Zombie Team:
    --
    zombie_team = "blue",

    -- Player attributes:
    --
    attributes = {

        --[[

            ------------------------
            Notes on variables --
            ------------------------
            *   speed:          Set to 0 to use map settings (1 = normal speed).
            *   health:         Range from 0 to 99999, (1 = normal health).
            *   respawn_time:   Range from 0-999 (in seconds).
            *   weapons:        Leave the array blank to use default weapon sets.

            --- Notes ---
            You can add up to 4 stock weapon tag names at your discretion.
            For example:
            weapons = { "weapons\\flag\\flag", "weapons\\pistol\\pistol", "weapons\\shotgun\\shotgun", "weapons\\ball\\ball" }

        --]]

        ["Zombies"] = {
            speed = 1,
            health = 1,
            respawn_time = 1.5,
            weapons = { "weapons\\ball\\ball" }
        },

        ["Humans"] = {
            speed = 1,
            health = 1,
            weapons = { },
            respawn_time = 3
        },

        ["Last Man Standing"] = {
            speed = 1,
            health = 1,
            weapons = { },
            respawn_time = 3
        }
    },

    -- Game messages:
    --
    messages = {

        -- Continuous message announced when there aren't enough players:
        -- Custom variables:        $current (current players online [number])
        --                          $required (number of required players)
        --
        not_enough_players = "$current/$required players needed to start the game",

        -- Pre-Game message:
        -- Custom variables:        $time (time remaining until game begins)
        --                          $s placeholder to pluralize the word "seconds" (if $time is >1)
        --
        pre_game_message = "Game will begin in $time second$s",

        -- End of Game message:
        -- Custom variables:        $team (team name [string])
        --
        end_of_game = "The $team team won!",

        -- New Game message:
        -- Custom variables:        $team (team name)
        --
        on_game_begin = "The game has begun. You're on the $team team!",

        -- Message announced when you kill a human:
        -- Custom variables:        $victim (victim name)
        --                          $killer (killer name)
        --
        on_zombify = "$victim was zombified by $killer",

        -- Last Man Alive message:
        -- Custom variables:        $name (last man standing name)
        --
        on_last_man = "$name is the Last Human Alive!",

        -- Message announced when there are no zombies:
        -- Custom variables:        $time (time remaining until a random human is chosen to become a zombie)
        --                          $s placeholder to pluralize the word "seconds" (if $time is >1)
        --
        no_zombies = "No Zombies! Switching random human in $time second$s",

        -- Message announced when a human is selected to become a zombie:
        -- Custom variables:        $name (name of human who was switched to zombie team)
        --
        no_zombies_switch = "$name was switched to the Zombie team"
    },

    --
    -- Game objects to disable:
    -- Format: {tag type, tag name, team}
    -- Teams: 0 = both, 1 = red, 2 = blue
    --
    objects = {

        -- vehicles:
        --
        { "vehi", "vehicles\\ghost\\ghost_mp", 2 },
        { "vehi", "vehicles\\rwarthog\\rwarthog", 2 },
        { "vehi", "vehicles\\banshee\\banshee_mp", 2 },
        { "vehi", "vehicles\\scorpion\\scorpion_mp", 2 },
        { "vehi", "vehicles\\c gun turret\\c gun turret_mp", 2 },
        { "vehi", "vehicles\\warthog\\mp_warthog", "Warthog", 2 },

        -- weapons:
        --
        { "weap", "weapons\\flag\\flag", 0 },
        { "weap", "weapons\\ball\\ball", 2 },
        { "weap", "weapons\\pistol\\pistol", 2 },
        { "weap", "weapons\\shotgun\\shotgun", 2 },
        { "weap", "weapons\\needler\\mp_needler", 2 },
        { "weap", "weapons\\plasma rifle\\plasma rifle", 2 },
        { "weap", "weapons\\flamethrower\\flamethrower", 2 },
        { "weap", "weapons\\sniper rifle\\sniper rifle", 2 },
        { "weap", "weapons\\plasma_cannon\\plasma_cannon", 2 },
        { "weap", "weapons\\plasma pistol\\plasma pistol", 2 },
        { "weap", "weapons\\assault rifle\\assault rifle", 2 },
        { "weap", "weapons\\gravity rifle\\gravity rifle", 2 },
        { "weap", "weapons\\rocket launcher\\rocket launcher", 2 },

        -- equipment:
        --
        { "eqip", "powerups\\health pack", 2 },
        { "eqip", "powerups\\over shield", 2 },
        { "eqip", "powerups\\active camouflage", 2 },
        { "eqip", "weapons\\frag grenade\\frag grenade", 2 },
        { "eqip", "weapons\\plasma grenade\\plasma grenade", 2 },
    },

    -- A message relay function temporarily removes the server prefix
    -- and will restore it to this when the relay is finished
    server_prefix = "**SAPP**",
    --
}
-- config ends --
-- do not touch anything below this point --

local kill_message_address, original_kill_message

api_version = "1.12.0.0"

-- This function registers needed event callbacks:
--
function OnScriptLoad()

    register_callback(cb["EVENT_TICK"], "OnTick")
    register_callback(cb["EVENT_DIE"], "OnPlayerDeath")
    register_callback(cb["EVENT_SPAWN"], "OnPlayerSpawn")
    register_callback(cb["EVENT_JOIN"], "OnPlayerConnect")
    register_callback(cb["EVENT_GAME_START"], "OnGameEnd")
    register_callback(cb["EVENT_GAME_START"], "OnGameStart")
    register_callback(cb["EVENT_LEAVE"], "OnPlayerDisconnect")
    register_callback(cb["EVENT_WEAPON_DROP"], "OnWeaponDrop")

    kill_message_address = sig_scan("8B42348A8C28D500000084C9") + 3
    original_kill_message = read_dword(kill_message_address)
    DisableDeathMessages()

    Zombies:Init()
end

function OnScriptUnload()
    execute_command("sv_map_reset")
    EnableDeathMessages()
end

-- Sets up pre-game parameters:
--
function Zombies:Init()

    self.players = { }
    self.last_man = nil
    self.game_started = false

    self.timers = {

        ["Not Enough Players"] = {
            timer = 0,
            init = false
        },

        ["Pre-Game Countdown"] = {
            timer = 0,
            init = false,
            enough_players = false,
            delay = self.game_start_delay + 1
        },

        ["No Zombies"] = {
            timer = 0,
            init = false,
            delay = self.no_zombies_delay + 1
        }
    }

    if (get_var(0, "$gt") ~= "n/a") then

        -- Disable game objects:
        --
        for _, v in pairs(self.objects) do
            execute_command("disable_object '" .. v[2] .. "' " .. v[3])
        end

        -- Init new players array for each player:
        --
        for i = 1, 16 do
            if player_present(i) then
                self:InitPlayer(i, false)
            end
        end
    end
end

-- Create (new) or delete (old) player array:
-- @param Ply (player index) [int]
-- @param Reset (reset players array for this player) [boolean]
--
function Zombies:InitPlayer(Ply, Reset)

    if (not Reset) then
        self.players[Ply] = {
            drones = {},
            assign = false,
            name = get_var(Ply, "$name")
        }
        return
    end

    self:CleanUpDrones(Ply)
    self.players[Ply] = nil
end

-- Used to clear a players rcon console:
-- @param Ply (player index) [int]
--
local function ClearConsole(Ply)
    for _ = 1, 25 do
        rprint(Ply, " ")
    end
end

-- Used to pluralize a string based on whether n>0.
-- @param n (time remaining) [number]
-- @return char n [string]
local function Plural(n)
    return (n > 0 and "s") or ""
end

-- Starts a given timer:
-- @param t (timer table) [table]
function Zombies:StartTimer(t, Callback)
    t.timer = 0
    t.init = true
    timer(1000, Callback)
end

-- Stops a given timer:
-- @param t (timer table) [table]
function Zombies:StopTimer(t)
    t.timer = 0
    t.init = false
end

-- Game Start Check logic:
-- @param Ply (player index) [int]
-- @param Deduct (deduct 1 from player count) [boolean]
--
function Zombies:GameStartCheck(Ply, Deduct)

    local player_count = tonumber(get_var(0, "$pn"))
    if (Deduct) then
        player_count = player_count - 1
    end

    local countdown1 = self.timers["Pre-Game Countdown"]
    local countdown2 = self.timers["Not Enough Players"]
    local countdown3 = self.timers["No Zombies"]
    local enough_players = (player_count >= self.required_players)
    local show_countdown = (enough_players and not countdown1.init and not self.game_started)

    -- Show pre-game countdown or "not enough players" message:
    --
    if (not enough_players) then
        self:StopTimer(countdown1) -- in case it was running
        self:StartTimer(countdown2, "NotEnoughPlayers")
    elseif (show_countdown) then
        self:StartTimer(countdown1, "StartPreGameTimer")
        self:StopTimer(countdown2)
        self:StopTimer(countdown3)
    elseif (self.game_started) then

        -- Game has already begun.
        -- Switch this player (Ply) to zombie team:
        --
        self:SwitchTeam(Ply, self.zombie_team)

        -- Stop No Zombies timer (in case it was running when this player joined):
        --
        if (countdown3.init) then
            self:StopTimer(countdown3)
        end
    end
end

-- Returns player memory address and X,Y,Z coordinates:
-- @param Ply (player index) [int]
-- @return memory address (DyN) of a player (Ply) and three 32-bit floating point numbers (x,y,z)
--
local function GetPos(Ply)
    local DyN = get_dynamic_player(Ply)
    if (DyN ~= 0 and player_alive(Ply)) then
        local x, y, z = read_vector3d(DyN + 0x5C)
        return DyN, x, y, z
    end
end

-- This function returns the number of players in each team:
-- @return humans [number], zombies [number]
--
function Zombies:GetTeamCounts()

    local human_team = self.human_team
    local zombie_team = self.zombie_team

    local humans, zombies
    if (human_team == "red" and zombie_team == "blue") then
        humans = get_var(0, "$reds")
        zombies = get_var(0, "$blues")
    elseif (human_team == "blue" and zombie_team == "red") then
        humans = get_var(0, "$blues")
        zombies = get_var(0, "$reds")
    end

    return tonumber(humans), tonumber(zombies)
end

-- Returns the appropriate weapon table for a given player:
-- @param Ply (player index) [int]
-- @return, weapon table [table]
--
function Zombies:GetWeaponTable(Ply)
    local team = get_var(Ply, "$team")
    if (team == "blue") then
        return self.attributes["Zombies"].weapons
    elseif tonumber(get_var(0, "$reds")) > 1 then
        return self.attributes["Humans"].weapons
    else
        return self.attributes["Last Man Standing"].weapons
    end
end

-- This function is called once every 1/30th second (1 tick):
-- Used for weapon assignments.
--
function Zombies:GameTick()

    for i, player in pairs(self.players) do
        if (i and self.game_started) then

            if (player.assign) then
                local DyN, x, y, z = GetPos(i)
                if (DyN ~= 0 and x) then

                    player.assign = false

                    -- Get the appropriate weapon array for this player:
                    -- If the weapons array is empty, the player will receive default weapons.
                    --
                    local weapons = self:GetWeaponTable(i)
                    if (#weapons > 0) then

                        -- Delete this players inventory:
                        --
                        execute_command("wdel " .. i)

                        -- Assign Weapons:
                        --
                        for slot, v in pairs(weapons) do

                            -- Assign primary & secondary weapons:
                            --
                            if (slot == 1 or slot == 2) then
                                -- Spawn the weapon:
                                --
                                local weapon = spawn_object("weap", v, x, y, z)

                                -- Store a copy of this weapon to the drones table:
                                --
                                player.drones[#player.drones + 1] = weapon

                                -- Assign this weapon:
                                --
                                assign_weapon(weapon, i)

                                -- Assign tertiary & quaternary weapons:
                                --
                            elseif (slot >= 3) then
                                timer(250, "DelaySecQuat", i, v, x, y, z)
                                --
                                -- Technical note:
                                -- It's important that we delay the logic responsible for assigning tertiary and quaternary weapon
                                -- assignments otherwise they will fall to the ground and never be assigned.
                                --
                            end
                        end
                    end
                end
            end
        end
    end
end

--
-- Deletes player weapon drones:
-- @param Victim (player index) [int]
-- @param Assign (assign new weapons) [boolean]
--
function Zombies:CleanUpDrones(Ply, Assign)
    local team = get_var(Ply, "$team")
    if (team == self.zombie_team) then
        local drones = self.players[Ply].drones
        if (#drones > 0) then
            for _, weapon in pairs(drones) do
                destroy_object(weapon)
            end
            if (Assign) then
                self.players[Ply].assign = true
            end
        end
    end
end

--
-- Returns the team type (red = human, blue = zombie):
-- @param Ply (player index) [int]
-- @return player team type [string]
function Zombies:GetTeamType(Ply)
    local team = get_var(Ply, "$team")
    return (team == self.human_team and "human") or "zombie"
end

-- Shows the pre-game countdown message,
-- resets the map and sorts players into teams:
--
function Zombies:StartPreGameTimer()

    local countdown = self.timers["Pre-Game Countdown"]
    countdown.timer = countdown.timer + 1

    local time_remaining = (countdown.delay - countdown.timer)
    if (time_remaining <= 0) then

        -- Stop the timer:
        self:StopTimer(countdown)

        -- Reset the map:
        execute_command("sv_map_reset")
        self.game_started = true

        -- Sort players into teams:
        --
        local players = {}
        for i = 1, 16 do
            if player_present(i) then
                players[#players + 1] = i
            end
        end
        if (#players > 0) then

            math.randomseed(os.clock())
            local new_zombie = players[math.random(1, #players)]
            for i, _ in pairs(players) do
                if (i == new_zombie) then

                    -- Set player to zombie team:
                    self:SwitchTeam(i, self.zombie_team)

                    -- Tell player what team they are on:
                    local msg = self.messages.on_game_begin
                    local team = self:GetTeamType(i)
                    self:Broadcast(i, msg:gsub("$team", team))
                else
                    -- Set player to human team:
                    --
                    self:SwitchTeam(i, self.human_team)

                    -- Tell player what team they are on:
                    --
                    local msg = self.messages.on_game_begin
                    local team = self:GetTeamType(i)
                    self:Broadcast(i, msg:gsub("$team", team))
                end
            end
        end

        self:GamePhaseCheck(nil, nil)
        return false
    end

    local msg = self.messages.pre_game_message
    msg = msg:gsub("$time", time_remaining):gsub("$s", Plural(time_remaining))
    self:Broadcast(nil, msg)

    return countdown.init
end

-- Broadcasts self.messages.not_enough_players:
--
function Zombies:NotEnoughPlayers()
    local countdown = self.timers["Not Enough Players"]
    if (countdown.init) then
        for i = 1, 16 do
            if player_present(i) then
                local msg = self.messages.not_enough_players
                msg = msg:gsub("$current", get_var(0, "$pn"))
                msg = msg:gsub("$required", self.required_players)
                ClearConsole(i)
                rprint(i, msg)
            end
        end
    end
    return (countdown.init)
end

-- This function shows the "not enough players" message:
--
function Zombies:SwitchHumanToZombie()
    local countdown = self.timers["No Zombies"]
    countdown.timer = countdown.timer + 1

    local time_remaining = (countdown.delay - countdown.timer)
    if (time_remaining <= 0) then

        self:StopTimer(countdown)

        -- Save all players on the human team to the humans array:
        --
        local humans = {}
        for i = 1, 16 do
            local team = get_var(i, "$team")
            if (team == self.human_team) then
                humans[#humans + 1] = i
            end
        end

        --Pick a random human to become the zombie:
        --
        math.randomseed(os.clock())
        local new_zombie = humans[math.random(1, #humans)]
        local name = self.players[new_zombie].name

        -- Tell player what team they're on:
        --
        local msg = self.messages.no_zombies_switch
        msg = msg:gsub("$name", name)
        self:Broadcast(nil, msg)
        self:SwitchTeam(new_zombie, self.zombie_team)

        return false
    end

    local msg = self.messages.no_zombies
    msg = msg:gsub("$time", time_remaining):gsub("$s", Plural(time_remaining))
    self:Broadcast(nil, msg)

    return countdown.init
end

-- @param Ply (player index) [int]
-- @param Team (new team) [string]
function Zombies:SwitchTeam(Ply, Team)
    execute_command("st " .. Ply .. " " .. Team)
end

-- This function ends the game:
-- @param Team (player team) [string]
function Zombies:EndTheGame(Team)
    Team = Team or ""
    local msg = self.messages.end_of_game
    self:Broadcast(nil, msg:gsub("$team", Team))
    execute_command("sv_map_next")
end

--
-- Assigns tertiary & quaternary weapons:
-- Stores a copy of the weapon object to a table called drones.
--
-- @param Ply (player index) [int]
-- @param Tag (weapon tag type) [string]
-- @param x,y,z (three 32-bit floating point numbers (player coordinates)) [float]
--
function DelaySecQuat(Ply, Tag, x, y, z)
    local weapon = spawn_object("weap", Tag, x, y, z)
    local drones = Zombies.players[Ply].drones
    drones[#drones + 1] = weapon
    assign_weapon(weapon, Ply)
end

function Zombies:GamePhaseCheck(Ply, PlayerCount)

    -- Returns the number of humans and zombies:
    --
    local humans, zombies = self:GetTeamCounts()

    -- Returns the total player count:
    --
    local player_count = (PlayerCount or tonumber(get_var(0, "$pn")))
    local team = (Ply ~= nil and get_var(Ply, "$team")) or ""
    if (team == self.human_team) then
        humans = humans - 1
    elseif (team == self.zombie_team) then
        zombies = zombies - 1
    end

    -- Check for (and set) last man alive:
    --
    if (humans == 1 and zombies > 0) then
        for i = 1, 16 do
            if player_present(i) then
                local last_man_team = get_var(i, "$team")
                if (last_man_team == self.human_team and not self.last_man) then
                    self.last_man = i
                    local name = self.players[i].name
                    local msg = self.messages.on_last_man
                    self:Broadcast(nil, msg:gsub("$name", name))
                    self:SetAttributes(i, true)
                end
            end
        end

        -- Announce zombie team won:
        --
    elseif (humans == 0 and zombies >= 1) then
        self:EndTheGame("Zombie")

        -- One player remains | end the game:
        --
    elseif (player_count == 1 and Ply ~= nil) then

        for i = 1, 16 do
            if (i ~= Ply and player_present(i)) then
                local team_type = self:GetTeamType(i)
                self:EndTheGame(team_type)
            end
        end

        -- No zombies left | Select random player to become zombie:
    elseif (zombies <= 0 and humans >= 1) then
        local countdown = self.timers["No Zombies"]
        self:StartTimer(countdown, "SwitchHumanToZombie")
    end
end

-- This function is called every time a player dies:
-- @param Victim (victim index) [int]
-- @param Killer (killer index) [int]
function Zombies:OnPlayerDeath(Victim, Killer)

    local killer = tonumber(Killer)
    local victim = tonumber(Victim)
    local v_name = self.players[victim].name
    local k_name = (self.players[killer] ~= nil and self.players[killer].name) or "UNKNOWN"
    local victim_team = get_var(victim, "$team")

    if (self.game_started) then

        -- PvP & Suicide:
        if (killer > 0 and victim_team == self.human_team) then

            -- Switch victim to the zombie team:
            --
            self:SwitchTeam(victim, self.zombie_team)

            -- Check game phase:
            --
            self:GamePhaseCheck(nil, nil)

            -- Broadcast "self.messages.on_zombify" message:
            --
            if (victim ~= killer) then
                local msg = self.messages.on_zombify
                msg = msg:gsub("$victim", v_name)
                msg = msg:gsub("$killer", k_name)
                self:Broadcast(nil, msg)
            else
                -- Suicide Message override:
                --
                self:Broadcast(nil, v_name .. " committed suicide")
            end
        else
            -- Every other death (message) override:
            --
            self:Broadcast(nil, v_name .. " died")
        end

        self:CleanUpDrones(Victim, true)


        -- Death Message overrides (pre-game):
        --
    elseif (killer > 0) then
        if (victim == killer) then
            self:Broadcast(nil, v_name .. " committed suicide")
        else
            self:Broadcast(nil, v_name .. " was killed by " .. k_name)
        end
    else
        self:Broadcast(nil, v_name .. " died")
    end
end

-- This function returns the relevant respawn time for this player:
-- @param Ply (player index) [int]
-- @param return (respawn time) [number]
--
function Zombies:GetRespawnTime(Ply)
    local time
    local team = get_var(Ply, "$team")
    if (team == self.zombie_team) then
        time = self.attributes["Zombies"].respawn_time
    elseif (team == self.human_team) then
        time = self.attributes["Humans"].respawn_time
        if (self.last_man == Ply) then
            time = self.attributes["Last Man Standing"].respawn_time
        end
    end
    return time
end

-- This function sets this players speed:
-- @param Ply (player index) [int]
-- @param Instant (affect immediately) [boolean]
--
function Zombies:SetSpeed(Ply, Instant)
    local speed
    local team = get_var(Ply, "$team")
    local time = (Instant and 0) or self:GetRespawnTime(Ply)
    if (team == self.zombie_team) then
        speed = self.attributes["Zombies"].speed
    elseif (team == self.human_team) then
        speed = self.attributes["Humans"].speed
        if (self.last_man == Ply) then
            speed = self.attributes["Last Man Standing"].speed
        end
    end
    if (speed ~= 0) then
        execute_command_sequence("w8 " .. time .. ";s " .. Ply .. " " .. speed)
    end
end

-- This function sets this players health:
-- @param Ply (player index) [int]
-- @param Instant (affect immediately) [boolean]
--
function Zombies:SetHealth(Ply, Instant)
    local health
    local team = get_var(Ply, "$team")
    local time = (Instant and 0) or self:GetRespawnTime(Ply)
    if (team == self.zombie_team) then
        health = self.attributes["Zombies"].health
    elseif (team == self.human_team) then
        health = self.attributes["Humans"].health
        if (self.last_man == Ply) then
            health = self.attributes["Last Man Standing"].health
        end
    end

    if (health ~= 0) then
        execute_command_sequence("w8 " .. time .. ";hp " .. Ply .. " " .. health)
    end
end

--
-- This function Sets player attributes:
-- @param Ply (player index) [int]
--
function Zombies:SetAttributes(Ply, Instant)

    if (Zombies.game_started) then
        -- Set respawn time:
        --
        local time = Zombies:GetRespawnTime(Ply)
        local Player = get_player(Ply)
        if (Player ~= 0) then
            write_dword(Player + 0x2C, time * 33)
        end

        -- Set Player Health:
        Zombies:SetHealth(Ply, Instant)

        -- Set Player Speed:
        Zombies:SetSpeed(Ply, Instant)
    end
end

--
-- This function broadcasts a custom server message:
-- @param Msg (message) [string]
--
function Zombies:Broadcast(Ply, Msg)
    execute_command("msg_prefix \"\"")
    if (Ply) then
        say(Ply, Msg)
    else
        say_all(Msg)
    end
    execute_command("msg_prefix \" " .. self.server_prefix .. "\"")
end

-- This function is called every time a new game begins:
--
function OnGameStart()
    Zombies:Init()
end

-- This function is called every time a game ends:
--
function OnGameEnd()
    Zombies.game_started = false
end

-- This function is called when a player has connected:
-- @param Ply (player index) [int]
--
function OnPlayerConnect(Ply)
    Zombies:InitPlayer(Ply, false)
    Zombies:GameStartCheck(Ply)
end

-- This function is called when a player has disconnected:
-- @param Ply (player index) [int]
--
function OnPlayerDisconnect(Ply)
    Zombies:InitPlayer(Ply, true)

    if (Zombies.game_started) then

        local player_count = tonumber(get_var(0, "$pn"))
        player_count = player_count - 1

        -- Stop timers:
        --
        if (player_count <= 0) then

            local countdown = Zombies.timers["Pre-Game Countdown"]
            self:StopTimer(countdown)

            countdown = Zombies.timers["No Zombies"]
            self:StopTimer(countdown)
        end

        Zombies:GamePhaseCheck(Ply, player_count)
    else
        Zombies:GameStartCheck(Ply, true)
    end
end

--
-- This function is called when a player has finished spawning:
-- @param Ply (player index) [int]
--
function OnPlayerSpawn(Ply)
    Zombies.players[Ply].assign = true
    Zombies:SetAttributes(Ply)
end

-- This function is called every time a player drops a weapon:
-- @param Ply (player index) [int]
--
function OnWeaponDrop(Ply)
    Zombies:CleanUpDrones(Ply, true)
end

-- Enables the servers default death messages:
--
function EnableDeathMessages()
    safe_write(true)
    write_dword(kill_message_address, original_kill_message)
    safe_write(false)
end

-- Disables the servers default death messages:
--
function DisableDeathMessages()
    safe_write(true)
    write_dword(kill_message_address, 0x03EB01B1)
    safe_write(false)
end

-- Functions with a call to another function:
--
function OnTick()
    return Zombies:GameTick()
end
function StartPreGameTimer()
    return Zombies:StartPreGameTimer()
end
function NotEnoughPlayers()
    return Zombies:NotEnoughPlayers()
end
function SwitchHumanToZombie()
    return Zombies:SwitchHumanToZombie()
end
function OnPlayerDeath(V, K)
    return Zombies:OnPlayerDeath(V, K)
end

--[[

    -------------------------------
    RECOMMENDED GAME TYPE SETTINGS:
    -------------------------------

    ----------* Game Options * ----------
    SELECT GAME:                    SLAYER
    DEATH BONUS:                    NO
    KILL IN ORDER:                  NO
    KILL PENALTY:                   NO
    KILLS TO WIN:                   50
    TEAM PLAY                       YES
    TIME LIMIT:                     45 MINUTES

    ----------* Player Options * ----------
    NUMBER OF LIVES:                INFINITE
    MAXIMUM HEALTH:                 100%
    SHIELDS:                        NO
    RESPAWN TIME:                   INSTANT
    RESPAWN TIME GROWTH:            NONE
    ODD MAN OUT:                    NO
    INVISIBLE PLAYERS:              NO
    SUICIDE PENALTY:                NO

    ----------* Item Options * ----------
    INFINITE GRENADES:              NO
    WEAPON SET:                     NORMAL
    STARTING EQUIPMENT:             GENERIC

    ----------* Vehicle Options * ----------
    SIDE:                           BLUE TEAM
    VEHICLE SET:                    NONE
    SIDE:                           RED TEAM
    VEHICLE SET:                    NONE

    ----------* Indicator Options * ----------
    OBJECTIVES INDICATOR:           NONE
    OTHER PLAYERS ON RADAR:         NO
    FRIEND INDICATORS ON SCREEN:    YES

]]