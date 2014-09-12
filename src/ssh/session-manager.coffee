fs = require 'fs'
sshclient = require 'sshclient'
laeh2 = require 'laeh2'
_x = laeh2._x
_ = require 'underscore'

exports.connectSSH = (serverName) ->
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
                console.log arguments
        session: _.map serverOpts.commands, (command) ->
            opt = 
                op: 'exec'
                command: command
            

    cb = (err) -> console.log "Wow "+err
    _x (sshclient.session opts, cb), true, cb