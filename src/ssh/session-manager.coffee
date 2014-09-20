fs = require 'fs'
sshclient = require 'sshclient'

exports.runCommandInServer = (serverName, commands, callback) ->
    serverConfigFile = serverName + '.json'
    serverOptsString =  fs.readFileSync serverConfigFile, 
        encoding: 'UTF-8'
    serverOpts = JSON.parse serverOptsString
    opts = 
        host: serverOpts.host
        port: serverOpts.port
        username: serverOpts.username
        privateKey: fs.readFileSync(serverOpts.keyFile)
        readyTimeout: 99999

        debug: true # optional
        console: 
            log :  ->
                out = arguments[4] if 0 == arguments[0].indexOf 'command:'
                err = arguments[3] if 0 == arguments[0].indexOf 'command:'
                callback out, err if callback?
        session: (serverOpts.commands.concat commands).map (command) ->
            op: 'exec'
            command: command
            

    cb = (err) -> callback(null,err)
    sshclient.session opts, cb