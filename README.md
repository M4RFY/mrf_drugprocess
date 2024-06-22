## mrf_drugprocess
- Advanced drug processing
- No support will be provided

# Add to qb-core > shared.lua

```lua
Items = {
    weed_seed         = { name = 'weed_seed', label = 'Weed Seed', weight = 100, type = 'item', image = 'weedplant_seed.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Male Weed Seed' },
    coke              = { name = 'coke', label = 'Cocaine', weight = 1000, type = 'item', image = 'coke.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Processed cocaine' },
    coke_small_brick  = { name = 'coke_small_brick', label = 'Coke Package', weight = 350, type = 'item', image = 'coke_small_brick.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'Small package of cocaine, mostly used for deals and takes a lot of space' },
    coca_leaf         = { name = 'coca_leaf', label = 'Cocaine leaves', weight = 1500, type = 'item', image = 'coca_leaf.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Cocaine leaves that must be processed !' },
    cannabis          = { name = 'cannabis', label = 'Cannabis', weight = 2500, type = 'item', image = 'cannabis.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Uncured cannabis' },
    marijuana         = { name = 'marijuana', label = 'Marijuana', weight = 500, type = 'item', image = 'weed_baggy.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'Some fine smelling buds.' },
    finescale         = { name = 'finescale', label = 'Fine Scale', weight = 200, type = 'item', image = 'finescale.png', unique = true, useable = false, shouldClose = false, combinable = nil, description = 'Scale Used for Fine Powders and Materials.' },
    chemicals         = { name = 'chemicals', label = 'Chemicals', weight = 1000, type = 'item', image = 'chemicals.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Chemicals, handle with care...' },
    poppyresin        = { name = 'poppyresin', label = 'Poppy resin', weight = 500, type = 'item', image = 'poppyresin.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'It sticks to your fingers when you handle it.' },
    heroin            = { name = 'heroin', label = 'Heroin', weight = 500, type = 'item', image = 'heroin.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Really addictive depressant...' },
    lsa               = { name = 'lsa', label = 'LSA', weight = 500, type = 'item', image = 'lsa.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Almost ready to party...' },
    lsd               = { name = 'lsd', label = 'LSD', weight = 500, type = 'item', image = 'lsd.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Lets get this party started!' },
    meth              = { name = 'meth', label = 'Meth', weight = 100, type = 'item', image = 'meth.png', unique = false, useable = true, shouldClose = false, combinable = nil, description = 'Really addictive stimulant...' },
    hydrochloric_acid = { name = 'hydrochloric_acid', label = 'Hydrochloric Acid', weight = 1000, type = 'item', image = 'hydrochloric_acid.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Chemicals, handle with care!' },
    sodium_hydroxide  = { name = 'sodium_hydroxide', label = 'Sodium Hydroxide', weight = 1000, type = 'item', image = 'sodium_hydroxide.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Chemicals, handle with care!' },
    sulfuric_acid     = { name = 'sulfuric_acid', label = 'Sulfuric Acid', weight = 1000, type = 'item', image = 'sulfuric_acid.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Chemicals, handle with care!' },
    thionyl_chloride  = { name = 'thionyl_chloride', label = 'Thionyl Chloride', weight = 500, type = 'item', image = 'thionyl_chloride.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Chemicals, handle with care!' },
    liquidmix         = { name = 'liquidmix', label = 'Liquid Chem Mix', weight = 500, type = 'item', image = 'liquidmix.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Chemicals, handle with care!' },
    bakingsoda        = { name = 'bakingsoda', label = 'Baking Soda', weight = 500, type = 'item', image = 'bakingsoda.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Household Baking Soda!' },
    chemicalvapor     = { name = 'chemicalvapor', label = 'Chemical Vapors', weight = 500, type = 'item', image = 'chemicalvapor.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'High Pressure Chemical Vapors, Explosive!' },
    trimming_scissors = { name = 'trimming_scissors', label = 'Trimming Scissors', weight = 500, type = 'item', image = 'trimming_scissors.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Very Sharp Trimming Scissors' },
    methtray          = { name = 'methtray', label = 'Meth Tray', weight = 200, type = 'item', image = 'meth_tray.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'make some meth' },
}
```

# Add icon images
- qb-inventory > html > images

# Add logs
- qb-smallresources > server > logs.lua
```lua
    ['chemicalslog'] = '',
    ['cokelogs'] = '',
    ['heroinlogs'] = '',
    ['lsdlogs'] = '',
    ['methlogs'] = '',
    ['weedlogs'] = '',
```

## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib/releases/tag/v3.22.2)
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [qb-target](https://github.com/BerkieBb/qb-target)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)
- [qb-smallresources](https://github.com/qbcore-framework/qb-smallresources)
- [ps-ui](https://github.com/Project-Sloth/ps-ui)
- [PolyZone](https://github.com/mkafrin/PolyZone)
- [bob74_ipl](https://github.com/Bob74/bob74_ipl/tree/master/dlc_tuner)

# Credits
- [ps-drugprocessing](https://github.com/Project-Sloth/ps-drugprocessing) Forked