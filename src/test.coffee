sm = require('./ssh/session-manager')

exports.sayHello = (name) -> console.log "Welcome " + name 
exports.connectSSH = ->
    sm.connectSSH 'ubuntu32',
        [
            'ls -l'
            'echo hello'
        ]
        
        