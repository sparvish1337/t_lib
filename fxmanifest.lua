fx_version "cerulean"
game "gta5"

lua54 "yes"
use_experimental_fxv2_oal "yes"

author "yiruzu"
description "Cloud Service - Rental"
version "1.2.0"

discord "https://discord.gg/jAnEnyGBef"
repository "https://github.com/yiruzu/cloud-rental"
license "CC BY-NC"

shared_scripts { "@ox_lib/init.lua" }
server_scripts { "server/*.lua" }

-- Ensure config.lua is loaded before client scripts
client_scripts {
    'config.lua',   -- Load config first
    'client/*.lua'  -- Load all client scripts after
}

export 'ShowFloatingHelpText'





-- Example usage of the ShowFloatingHelpText export
-- exports['your_script_name']:ShowFloatingHelpText("Police Armory", 481.3466, -995.2707, 25.7297, 10.0)
