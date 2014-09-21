sm = require('./ssh/session-manager')
cm = require('./command/command-manager')
oauth = require('./oauth/google-oauth-manager')

exports.sayHello = (name) -> console.log "Welcome " + name 
exports.connectSSH = ->
    cm.runCommandSet 'echo' , (out,err) ->
        console.log out if out?
        console.error err if err?
            
            
exports.gauth = (configName) ->
    console.log oauth.oauthFromConfig configName
            
    
                
                

        
        