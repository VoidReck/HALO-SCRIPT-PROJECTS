--[[
--=====================================================================================================--
Script Name: Zombies 2021, for SAPP (PC & CE)
Description: A fully customizable zombie game

Copyright (c) 2021, Jericho Crosby <jericho.crosby227@gmail.com>
* Notice: You can use this document subject to the following conditions:
https://github.com/Chalwk77/HALO-SCRIPT-PROJECTS/blob/master/LICENSE
--=====================================================================================================--
]]--

-- config starts --
local Zombies = {

    -- Time (in seconds) until a game begins:
    --
    game_start_delay = 10,

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

        --
        ------------------------
        -- Notes on variables --
        ------------------------
        -- speed: Set to 0 to disable (1 = normal speed).
        -- health: Range from 0 to 99999, (1 = normal health).
        -- weapons: Leave the array blank to use default weapon sets.
        --

        ["Zombies"] = {
            speed = 1,
            health = 1,
            weapons = { "weapons\\ball\\ball" }
        },

        ["Humans"] = {
            speed = 1,
            health = 1,
            weapons = { } -- blank by default!
        },

        ["Last Man Standing"] = {
            speed = 1,
            health = 1,
            weapons = { } -- blank by default!
        }
    },

    -- Game messages:
    --
    messages = {

        -- Continuous message announced when there aren't enough players:
        --
        not_enough_players = "$current/$required players needed to start the game",

        -- Pre-Game message:
        --
        pre_game_message = "Game will begin in $time second$s",

        -- End of Game message:
        --
        end_of_game = "The $team team won!",

        -- New Game message:
        --
        on_game_begin = "The game has begun. You're on the $team team!",

        -- Message announced when you kill a human:
        --
        on_zombify = "$victim was zombified by $killer",

        -- Last Man Alive message:
        --
        on_last_man = "$name is the Last Human Alive!",

        -- Message announced when there are no zombies:
        --
        no_zombies = "No Zombies! Switching random human in $time second$s",

        -- Message announced when a human is selected to become a zombie:
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
    }
}
-- config ends --
-- do not touch anything below this point --

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

    Zombies:Init()
end

function OnScriptUnload()
    execute_command("sv_map_reset")
end

-- Sets up pre-game parameters:
--
function Zombies:Init()

    self.players = { }
    self.last_man = nil
    self.game_started = false

    self.timers = {
        ["Pre-Game Countdown"] = {
            timer = 0,
            init = false,
            enough_players = false,
            delay = self.game_start_delay
        },
        ["Not Enough Players"] = {
            timer = 0,
            init = false
        },
        ["No Zombies"] = {
            timer = 0,
            init = false,
            delay = self.no_zombies_delay
        }
    }

    if (get_var(0, "$gt") ~= "n/a") then

        -- Disable game objects:
        for _, v in pairs(self.objects) do
            execute_command("disable_object '" .. v[2] .. "' " .. v[3])
        end

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
            assign = false
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

-- @param n (time remaining) [number]
-- @return char "s" if n>0 [string]
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

-- Check if we need to show the pre-game countdown message or "not enough players" message:
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

    -- Show pre-game countdown message:
    --
    if (enough_players and not countdown1.init and not self.game_started) then

        self:StartTimer(countdown1, "StartPreGameTimer")
        self:StopTimer(countdown2)
        self:StopTimer(countdown3)

        -- Show "not enough players" message:
        --
    elseif (not enough_players) then
        self:StopTimer(countdown1)
        self:StartTimer(countdown2, "NotEnoughPlayers")
    end

    -- Game has already begun.
    -- Set this player to zombie team:
    if (self.game_started) then

        self:SwitchTeam(Ply, self.zombie_team)

        -- Stop the No Zombies timer:
        --
        if (countdown3.init) then
            local _, zombies = self:GetTeamCounts()
            if (zombies >= 1) then
                self:StopTimer(countdown3)
            end
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
-- @return blue/red team player counts
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

-- Shows the pre-game countdown message:
--
function Zombies:StartPreGameTimer()

    local countdown = self.timers["Pre-Game Countdown"]
    countdown.timer = countdown.timer + 1

    local time_remaining = (self.game_start_delay - countdown.timer)
    if (time_remaining <= 0) then

        -- Stop the timer:
        countdown.init = false
        countdown.timer = 0

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
                    say(i, msg:gsub("$team", team))

                else
                    -- Set player to human team:
                    --
                    self:SwitchTeam(i, self.human_team)

                    -- Tell player what team they are on:
                    --
                    local msg = self.messages.on_game_begin
                    local team = self:GetTeamType(i)
                    say(i, msg:gsub("$team", team))
                end
            end
        end

        self:GamePhaseCheck(nil, nil)
        return false
    end

    local msg = self.messages.pre_game_message
    msg = msg:gsub("$time", time_remaining):gsub("$s", Plural(time_remaining))
    say_all(msg)

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

    local time_remaining = (self.no_zombies_delay - countdown.timer)
    if (time_remaining <= 0) then

        countdown.init = false
        countdown.timer = 0

        local humans = {}
        for i = 1, 16 do
            local team = get_var(i, "$team")
            if (team == self.human_team) then
                humans[#humans + 1] = i
            end
        end

        math.randomseed(os.clock())
        local new_zombie = humans[math.random(1, #humans)]
        local name = get_var(new_zombie, "$name")

        local msg = self.messages.no_zombies_switch
        msg = msg:gsub("$name", name)
        say_all(msg)
        self:SwitchTeam(new_zombie, self.zombie_team)

        return false
    end

    local msg = self.messages.no_zombies
    msg = msg:gsub("$time", time_remaining):gsub("$s", Plural(time_remaining))
    say_all(msg)

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
    say_all(msg:gsub("$team", Team))
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
                    local msg = self.messages.on_last_man
                    say_all(msg:gsub("$name", get_var(i, "$name")))
                    self:SetSpeed(i, self.attributes["Humans"].speed)
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
                local team = self:GetTeamType(i)
                self:EndTheGame(team)
            end
        end

        -- No zombies left | Select random player to become zombie:
    elseif (zombies <= 0 and humans >= 1) then
        local countdown = self.timers["No Zombies"]
        countdown.timer = 0
        countdown.init = true
        timer(1000, "SwitchHumanToZombie")
    end
end

-- This function is called every time a player dies:
-- @param Victim (victim index) [int]
-- @param Killer (killer index) [int]
function Zombies:OnPlayerDeath(Victim, Killer)

    if (self.game_started) then

        local killer = tonumber(Killer)
        local victim = tonumber(Victim)
        local victim_team = get_var(victim, "$team")

        -- PvP & Suicide:
        if (killer > 0 and victim_team == self.human_team) then
            self:SwitchTeam(victim, self.zombie_team)
            self:GamePhaseCheck(nil, nil)
        end

        self:CleanUpDrones(Victim, true)
    end
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
            countdown.timer = 0
            countdown.init = false

            countdown = Zombies.timers["No Zombies"]
            countdown.timer = 0
            countdown.init = false
        end

        Zombies:GamePhaseCheck(Ply, player_count)
    else
        Zombies:GameStartCheck(Ply, true)
        --local countdown = Zombies.timers["Pre-Game Countdown"]
        --if (countdown.init) then
        --    countdown.timer = 0
        --    countdown.init = false
        --end
    end
end

--
-- This function returns the relevant speed a player should be:
-- @param Ply (player index) [int]
--
function Zombies:GetSpeed(Ply)

    local speed = 1  -- default speed
    local team = get_var(Ply, "$team")

    -- Zombie Speed:
    if (team == self.zombie_team) then
        speed = self.attributes["Zombies"].speed

        -- Human Speed:
    elseif (team == self.human_team) then
        speed = self.attributes["Humans"].speed

        -- Last man speed (relevant in the case of guardians):
        --
        local humans, _ = self:GetTeamCounts()
        if (humans == 1) then
            speed = self.attributes["Last Man Standing"].speed
        end
    end
    return speed
end

--
-- Sets the player speed:
-- @param Ply (player index) [int]
--
function Zombies:SetSpeed(Ply)
    local speed = self:GetSpeed(Ply)
    execute_command("s " .. Ply .. " " .. speed)
end

--
-- This function is called when a player has finished spawning:
-- @param Ply (player index) [int]
--
function OnPlayerSpawn(Ply)
    Zombies.players[Ply].assign = true
    if (Zombies.game_started) then
        Zombies:SetSpeed(Ply)
    end
end

-- This function is called every time a player drops a weapon:
-- @param Ply (player index) [int]
--
function OnWeaponDrop(Ply)
    Zombies:CleanUpDrones(Ply, true)
end

-- Functions with a call to another function:
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