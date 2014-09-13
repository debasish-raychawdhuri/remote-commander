#Handles abstraction of commands

#A remote commander front end must use this method 
# to execute a named commandSet

fs = require 'fs'
sm = require '../ssh/session-manager'

exports.runCommandSet = (commandSet, callback) ->
    commandConfigFile = 'commands.json'
    commandSetsString =  fs.readFileSync commandConfigFile, 
        encoding: 'UTF-8'
    commandSets = JSON.parse commandSetsString    
    commandSetArray = commandSets[commandSet]
    
    commandSetArray.map (commandSet)->
        server = commandSet.server
        commands = commandSet.commands
        sm.runCommandInServer server, commands, callback
        