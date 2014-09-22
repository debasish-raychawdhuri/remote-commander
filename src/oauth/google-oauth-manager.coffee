fs = require 'fs'
google = require "googleapis"
OAuth2 = google.auth.OAuth2

exports.oauth = (clientId, clientSecret, redirectUrl) ->
    scopes = [
        'https://www.googleapis.com/auth/googletalk'
    ]
    oauth2Client = new OAuth2 clientId, clientSecret, redirectUrl
    url = oauth2Client.generateAuthUrl
        access_type: 'offline'
        scope: scopes
        

exports.oauthFromConfig = (configName) ->
    configFile = configName + '.json'
    configNameString =  fs.readFileSync configFile, 
        encoding: 'UTF-8'
    configOps = JSON.parse configNameString
    opts = configOps.installed
    clientId = opts.client_id
    clientSecret = opts.client_secret
    redirecUris = opts.redirect_uris
    redirectUrl = redirecUris[0]
    exports.oauth clientId,clientSecret,redirectUrl