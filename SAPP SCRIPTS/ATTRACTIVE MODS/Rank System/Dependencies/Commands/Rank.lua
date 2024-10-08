-- Rank System [Rank Command File] (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

local Command = {
    command_name = 'rank',
    admin_level = -1,
    help = 'Syntax: /rank (player [number])',
    description = 'Check your current rank',
    no_perm = 'You need to be level -1 or higher to use this command.'
}

function Command:Run(Ply, Args)
    if (Ply == 0) then
        cprint('Sorry, you cannot execute this command from terminal.', 12)
        return false
    elseif (self.permission(Ply, self.admin_level, self.no_perm)) then
        local t = self:GetPlayer(Ply)
        local player = Args[2]
        if (not Args[2] or tonumber(Args[2] == Ply)) then
            if (t.logged_in) then
                t:ShowExtRankInfo(t.username)
            else
                t:Send("Unable to show stats. You're not logged into your service record.")
                t:Send(' ')
                t:Send('To create an account: /c (username) (password)')
                t:Send(' ')
                t:Send('To log into an account: /l (username) (password)')
            end
        elseif (player:match('%d+')) then
            if player_present(player) then
                player = self:GetPlayer(tonumber(player))
                if (t.logged_in) then
                    t:ShowExtRankInfo(player.username)
                else
                    t:Send('Unable to show stats. ' .. player.name .. ' is not logged in')
                end
            else
                t:Send('Player #' .. player .. ' is not online.')
            end
        else
            t:Send(self.help)
        end
    end
    return false
end

return Command