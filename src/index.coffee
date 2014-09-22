
exports.main = ->
    test = require "./test"
    test.sayHello "Vivek"
    test.gauth "client_secret"
    test.connectSSH()
    console.log "done"
    
    