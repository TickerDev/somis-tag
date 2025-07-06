local guildId = config.guild_id
local botToken = "Bot " .. config.token

local function GetPlayerDiscord(discordId, cb)
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

exports("IsUserUsingTag", function(src)
    local p = promise.new()

    local discordId = (GetPlayerIdentifierByType(src, "discord") or ""):sub(9)
    if discordId == "" then
        p:resolve(nil)
        return Citizen.Await(p)
    end

    GetPlayerDiscord(discordId, function(m)
        if not m or not m.user or not m.user.primary_guild or not m.user.primary_guild.tag then
            p:resolve(nil)
            return
        end

        if guildId == m.user.primary_guild.identity_guild_id then
            p:resolve(true)
        else
            p:resolve(false)
        end
    end)

    return Citizen.Await(p)
end)
