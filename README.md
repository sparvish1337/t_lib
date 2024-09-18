
# t_lib

Right now just a simple library with export for help text & configuration for peds



## Help Text

Usage of the export can look something like this:
```lua
exports['t_lib']:ShowFloatingHelpText("Text", 481, -995, 25, 10.0)
```
More options will come in the future for styling etc
## Ped Options

- Changing Models
- Setting coords for the peds location
- Invincible true/false
- Freeze - The ped is frozen at the coords
- helpText - Setting a help text above the head for interactions
- Weapon - Setting the weapon the ped is holding
- interactionEvent - The event on interaction
- isFriendly true/false - If false the ped attacks on sight
- isDefensive true/false - If true the ped will defent itself if being attacked
More about this is in the config.lua file

