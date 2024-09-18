HelpTextConfig = {
    -- HelpText section
    {
        text = "Police Armory",
        coords = {x = 481.3466, y = -995.2707, z = 25.7297},
        radius = 10.0
    },
    --{
    --    text = "Locker Room",
    --    coords = {x = 480.0, y = -1000.0, z = 26.0},
    --    radius = 10.0
    --}
}

BlipConfig = {
    -- Blip section
    --{
    --    name = "Police Armory", -- Name of the blip
    --    coords = {x = 481.3466, y = -995.2707, z = 25.7297}, -- Blip coordinates
    --    sprite = 110, -- Blip sprite (icon)
    --    color = 29, -- Blip color
    --    scale = 0.8 -- Blip size
    --}
}

PedConfig = {
    -- Ped section
    {
        model = "s_m_m_security_01", -- Ped model
        coords = {x = 448.7699, y = -975.0513, z = 24.73},
        heading = 90.0, -- Direction the ped is facing
        invincible = true, -- Ped cannot take damage
        freeze = false, -- Ped stays in one place
        helpText = "Talk to the Security Guard",
        weapon = "WEAPON_PISTOL",
        interactionEvent = "startMission",
        isFriendly = true,  -- true for friendly, false for hostile
        isDefensive = false  -- true for defensive, false for aggressive | Not working for the moment
    },
    --{
    --    model = "s_m_m_security_01", -- Ped model
    --    coords = {x = 448.7699, y = -975.0513, z = 24.73},
    --    heading = 90.0, -- Direction the ped is facing
    --    invincible = true, -- Ped cannot take damage
    --    freeze = true, -- Ped stays in one place
    --    helpText = "Talk to the Security Guard",
    --    weapon = "WEAPON_PISTOL",
    --    interactionEvent = "startMission"
    --    isFriendly = true,  -- true for friendly, false for hostile
    --    isDefensive = true  -- true for defensive, false for aggressive | Not working for the moment
    --}
}

MarkerConfig = {
    -- Marker section
    {
        type = 1, -- Marker type (1 = cylinder)
        coords = {x = 400.0, y = -1000.0, z = 25.0}, -- Marker location
        color = {r = 255, g = 0, b = 0, a = 150}, -- Marker color (RGBA)
        scale = {x = 1.5, y = 1.5, z = 1.0}, -- Marker size
        triggerEvent = "openMenu" -- Event triggered when a player enters the marker
    }
}
