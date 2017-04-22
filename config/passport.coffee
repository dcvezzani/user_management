# Importing Passport, strategies, and config
passport = require('passport')
User = require('../models/user')
config = require('config')
JwtStrategy = require('passport-jwt').Strategy
ExtractJwt = require('passport-jwt').ExtractJwt
LocalStrategy = require('passport-local')

localOptions = { usernameField: 'email' }

# Setting up local login strategy
localLogin = new LocalStrategy(localOptions, (email, password, done) ->
  User.findOne { email: email }, (err, user) ->
    if err
      return done(err)
    if !user
      return done(null, false, error: 'Your login details could not be verified. Please try again.')
    user.comparePassword password, (err, isMatch) ->
      if err
        return done(err)
      if !isMatch
        return done(null, false, error: 'Your login details could not be verified. Please try again.')
      done null, user
    return
  return
)

jwtOptions = 
  jwtFromRequest: ExtractJwt.fromAuthHeader()
  secretOrKey: config.get('secret')

# Setting up JWT login strategy
jwtLogin = new JwtStrategy(jwtOptions, (payload, done) ->
  User.findById payload._id, (err, user) ->
    if err
      return done(err, false)
    if user
      done null, user
    else
      done null, false
    return
  return
)

passport.use(jwtLogin);  
passport.use(localLogin);  
