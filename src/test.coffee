sm = require('./ssh/session-manager')
cm = require('./command/command-manager')

exports.sayHello = (name) -> console.log "Welcome " + name 
exports.connectSSH = ->
    cm.runCommandSet 'echo' , (out,err) ->
        console.log out if out?
        console.error err if err?
                
                

        
        