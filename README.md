# 🛡️ DONxDEV Anti-Prop Guard v1.0.0

A high-performance FiveM anti-prop script designed to automatically detect, delete, log, and action against unauthorized or crash-inducing blacklisted props.

---

## 🌟 Key Features

* **⚡ Optimized Detection Engine:** Pre-hashes the entire blacklisted prop list at initialization for $O(1)$ fast lookups without client FPS drops.
* **📦 Massive Blacklist Base:** Out-of-the-box protection covering over 500+ known lag, crash, and troll props (yachts, UFOs, giant boulders, stunt tracks, etc.).
* **📸 Screenshot Integration:** Hooks directly into `screenshot-basic` to capture player screens upon prop detection.
* **📢 Discord Webhooks:** Sends detailed alerts containing player details, IDs, detected prop names, and screenshots directly to your Discord.
* **🧹 Local Cleanup:** Instantly deletes blacklisted props client-side to prevent server crashes or map disruption.

---

## 🛠️ Configuration Overview (`config.lua`)

```lua
Config = {}

Config.WebhookURL = "YOUR_DISCORD_WEBHOOK_URL_HERE"
Config.BotName = "DONxDEV Anti-Prop Guard"
Config.KickReason = "[DONxDEV Anti-Prop] Blacklisted prop detected."

Config.BlacklistedProps = {
    "hei_prop_carrier_radar_1_l1",
    "v_res_mexball",
    "prop_rock_1_a",
    -- Full list included in config.lua
}