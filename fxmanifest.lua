fx_version "cerulean"
game "gta5"

lua54 "yes"
use_experimental_fxv2_oal "yes"

author "Z"
description "library"
version "1.2.0"

shared_scripts { "@ox_lib/init.lua" }
server_scripts { "server/*.lua" }

client_scripts {
    'config.lua',
    'client/*.lua'
}

export 'ShowFloatingHelpText'





-- Example usage of helptext
-- exports['t_lib']:ShowFloatingHelpText("Police Armory", 481.3466, -995.2707, 25.7297, 10.0)
