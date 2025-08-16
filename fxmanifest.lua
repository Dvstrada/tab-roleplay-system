fx_version 'cerulean'
game 'gta5'

author 'Dvstrada'
description 'Tab Roleplay System integrated with LSPD system (jobs, bank, phone, garage, dealerships, organizations, missions, properties, dealer, etc.)'
version '1.0.0'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
