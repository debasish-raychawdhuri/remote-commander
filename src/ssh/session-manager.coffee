fs = require 'fs'
sshclient = require 'sshclient'
laeh2 = require 'laeh2'
_x = laeh2._x

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
                callback out, err if callback
        session: (serverOpts.commands.concat commands).map (command) ->
            opt = 
                op: 'exec'
                command: command
            

    cb = (err) -> callback(null,err)
    _x (sshclient.session opts, cb), true, cb