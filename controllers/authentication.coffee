jwt = require('jsonwebtoken')
crypto = require('crypto')
User = require('../models/user')
config = require('../config/main')

# Generate token

generateToken = (user) ->
  jwt.sign user, config.secret, expiresIn: 10080

# Set user info from request

setUserInfo = (request) ->
  {
    _id: request._id
    firstname: request.firstname
    lastname: request.lastname
    email: request.email
    role: request.role
  }

#========================================
# Login Route
#========================================

exports.login = (req, res, next) ->
  userInfo = setUserInfo(req.user)
  res.status(200).json
    token: 'JWT ' + generateToken(userInfo)
    user: userInfo
  return

#========================================
# Registration Route
#========================================

exports.register = (req, res, next) ->

  # Check for registration errors
  email = req.body.email
  firstname = req.body.firstname
  lastname = req.body.lastname
  password = req.body.password

  # Return error if no email provided
  if !email
    return res.status(422).send(error: 'You must enter an email address.')

  # Return error if full name not provided
  if !firstname or !lastname
    return res.status(422).send(error: 'You must enter your full name.')

  # Return error if no password provided
  if !password
    return res.status(422).send(error: 'You must enter a password.')

  User.findOne { email: email }, (err, user) ->
    if err
      return next(err)

    # If user is not unique, return error
    if user
      return res.status(422).send(error: 'That email address is already in use.')

    # If email is unique and password was provided, create account
    user = new User(
      email: email
      password: password
      firstname: firstname
      lastname: lastname)

    user.save (err, user) ->
      if err
        return next(err)

      # Subscribe member to Mailchimp list
      # mailchimp.subscribeToNewsletter(user.email);

      # Respond with JWT if user was created
      userInfo = setUserInfo(user)
      res.status(201).json
        token: 'JWT ' + generateToken(userInfo)
        user: userInfo
      return
    return
  return

#========================================
# Authorization Middleware
#========================================
# Role authorization check

exports.roleAuthorization = (role) ->
  (req, res, next) ->
    user = req.user
    User.findById user._id, (err, foundUser) ->
      if err
        res.status(422).json error: 'No user was found.'
        return next(err)

      # If user is found, check role.
      if foundUser.role == role
        return next()

      res.status(401).json error: 'You are not authorized to view this content.'
      next 'Unauthorized'
    return  
