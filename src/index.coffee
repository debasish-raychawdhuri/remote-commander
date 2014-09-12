exports.main = ->
    test = require "./test"
    test.sayHello "Vivek"
    test.connectSSH()
    console.log "done"