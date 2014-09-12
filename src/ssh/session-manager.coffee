fs = require 'fs'
sshclient = require 'sshclient'
laeh2 = require 'laeh2'
_x = laeh2._x
_ = require 'underscore'

exports.connectSSH = (serverName, commands) ->
    serverConfigFile = serverName + '.json'
    serverOptsString =  fs.readFileSync serverConfigFile, 
        encoding: 'UTF-8'
    serverOpts = JSON.parse serverOptsString
    opts = 
        host: serverOpts.host
        port: serverOpts.port
        username: serverOpts.username
        privateKey: fs.readFileSync(serverOpts.keyFile)

        debug: true # optional
        console: 
            log :  ->
                console.log arguments[4] if 0 == arguments[0].indexOf 'command:'
        session: _.map commands, (command) ->
            opt = 
                op: 'exec'
                command: command
            

    cb = (err) -> console.log "Wow "+err
    _x (sshclient.session opts, cb), true, cb