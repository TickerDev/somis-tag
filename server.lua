local guildId = config.guild_id
local botToken = "Bot " .. config.token

function getplayerinfo(discordId, cb)
    local url = ("https://discord.com/api/v10/guilds/%s/members/%s"):format(guildId, discordId)

    PerformHttpRequest(url, function(code, res)
        if code == 200 then
            cb(json.decode(res))
        else
            print("discord api failed", code, res)
            cb(nil)
        end
    end, "GET", "", {
        ["Authorization"] = botToken,
        ["Content-Type"] = "application/json"
    })
end

exports("isusingmytag", function(src, cb)
    local discordId = (GetPlayerIdentifierByType(src, "discord") or ""):sub(9)
    if discordId == "" then return cb(nil) end

    getplayerinfo(discordId, function(m)
        if not m or not m.user or not m.user.clan or not m.user.clan.tag then
            return cb(nil)
        end
        if guildId == m.user.clan.identity_guild_id then
        cb(true)
        else
        cb(false)
        end
    end)
end)