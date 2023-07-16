local event = {}
local date = os.date
local time = os.time

function event:onTick()

    local update
    for group, v in pairs(self.bans) do

        for ID, entry in pairs(v) do
            local expiration = entry.time
            if (expiration) then

                local ref = time {
                    year = expiration.year,
                    month = expiration.month,
                    day = expiration.day,
                    hour = expiration.hour,
                    min = expiration.min,
                    sec = expiration.sec
                }



                update = true
                self.bans[group][ID] = nil
                cprint('Ban expired: ' .. ID .. ' (' .. entry.offender .. ') (' .. entry.ip .. ')', 12)
            end
        end
    end

    if (update) then
        self:updateBans()
    elseif (self.ban_file_timer) then
        local interval = self.ban_file_timer.interval
        if (time_now() >= interval) then
            self.ban_file_timer.interval = time_now() + self.ban_file_update_interval
            self:updateBans()
        end
    end

    -- Level delete confirmation timeout:
    for _, v in pairs(self.players) do
        if (v.confirm and time_now() > v.confirm.timeout) then
            v.confirm = nil
            v:send('Admin level deletion timed out.')
        end
    end
end

register_callback(cb['EVENT_TICK'], 'OnTick')

return event