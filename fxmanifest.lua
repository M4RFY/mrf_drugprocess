fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Simple drug processing system for FiveM'
version '1.5.0'

shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua'
}

server_scripts {
    'sv_config.lua',
    'server/main.lua',
    'server/*.lua'
}

client_scripts {
    'client/functions.lua',
    'client/main.lua',
    'client/*.lua'
}

files {
    'stream/mw_props.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/mw_props.ytyp'