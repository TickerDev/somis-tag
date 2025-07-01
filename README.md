# 🔎 FiveM Discord Tag Checker

A simple FiveM server-side script that uses the **Discord API** to check if a player is using your server's **Discord tag** (also known as a **clan tag** or **guild identity tag**) on their profile.

## ✅ Features

- Checks a player’s Discord profile for your server’s tag (clan identity)
- Uses the Discord API via the player’s identifier
- Also available as a server export for use in your own scripts
- Clean and easily customizable

## ⚙️ Requirements

- FiveM server with access to player Discord identifiers
- A Discord bot with `GUILD_MEMBERS` and `GUILD_PRESENCES` intents enabled
- Discord bot token
- Your server’s Discord guild ID

## 📦 Installation

1. Place the script in your `resources` folder.
2. Add to your `server.cfg`:

## Example 

exports["somis-tag"]:isusingmytag(playerid, function(tag)
    print("Using my tag?", tag)
end)
