fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'rsg-repair'
version '1.1.0'
author 'phil mcracken)'
description 'wagon repairs'


shared_scripts {
    'config.lua',
}

client_scripts {
    'client/client.lua'
}



dependencies {
    'rsg-core',
    
}

lua54 'yes'
