local event = {}

function event:onCommand(id, command)

    local args = self:stringSplit(command)
    local target_command = args[1]

    local admin = self.players[id]
    command = self.management[target_command]
    if (not target_command) then
        return
    elseif (command) then
        admin:commandSpy(target_command)
        return false, command:run(id, args)
    end

    -- All other commands:
    local current_level = admin.level
    local required_level, enabled = self:findCommand(target_command)

    --- Check if command exists, is enabled, and if the player has permission:
    if (required_level == nil) then
        admin:send('Command (' .. target_command .. ') does not exist.')
        self:log(admin.name .. ' is attempting to execute (' .. target_command
                .. ') but it does not exist.', self.logging.default)
        return false

    elseif (not enabled) then
        admin:send('Command (' .. target_command .. ') is disabled.')
        self:log(admin.name .. ' is attempting to execute (' .. target_command
                .. ') but it is disabled.', self.logging.default)
        return false

    elseif (enabled and current_level < required_level) then
        admin:send('Insufficient Permission.')
        admin:send('You must be level (' .. required_level .. ') or higher.')
        self:log(admin.name .. ' is attempting to execute (' .. target_command
                .. ') but is not a high enough level (current level: '
                .. admin.level .. ') (Required level: '
                .. required_level .. ')' , self.logging.default)
        return false
    end

    self:log('Command: (' .. target_command .. ') was executed by: ' .. admin.name .. ' (' .. id .. ') ' .. '(' .. admin.ip .. ')', self.logging.default)
    admin:commandSpy(target_command)

    return true
end

register_callback(cb['EVENT_COMMAND'], 'OnCommand')

return event