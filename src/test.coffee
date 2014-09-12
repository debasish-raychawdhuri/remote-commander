sm = require('./ssh/session-manager')

exports.sayHello = (name) -> console.log "Welcome " + name 
exports.connectSSH = ->
    sm.runCommandInServer 'ubuntu32',
        [
            'ls -l'
            'echo hello'
            'echo hello >> myfile.txt'
            'cat myfile.txt'
        ], (out, err) ->
            console.log out if out?
            console.error err if err?
        
        