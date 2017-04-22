User = require('../models/user')
ObjectID = require('mongodb').ObjectID

# Generic error handler used by all endpoints.

handleError = (res, err, message, code) ->
  console.log 'ERROR: ' + err.message
  res.status(code or 500).json {'error': message, details: err}
  return

# TODO: something is still wrong with this common method to load user when appropriate
# will use for show, delete, and edit
load_user = (req, res) ->
  users = User.find(_id: ObjectID(req.params.id)).toArray()
  console.log users.length
  if users.length() < 1
    handleError res, {}, "User id doesn't exist.", 404
    return null
  else
    user = users[0]
    console.dir user
    return user

#========================================
# List
#========================================

exports.list = (req, res, next) ->
  User.find (err, docs) ->
    if err
      handleError res, err, 'Failed to get users.'
    else
      res.status(200).json docs

#========================================
# Create
#========================================

exports.create = (req, res, next) ->
  user = req.body
  User.create user, (err, doc) ->
    if err
      handleError res, err, 'Failed to create new user.'
    else
      res.status(201).json(doc);

#========================================
# Update
#========================================

exports.update = (req, res, next) ->
  user = req.body;
  delete user._id;

  User.updateOne { _id: new ObjectID(req.params.id) }, user, (err, results) ->
    if err
      handleError res, err, 'Failed to update user.'
    else
      res.status(200).json results

#========================================
# Show
#========================================

exports.show = (req, res, next) ->
  User.findOne { _id: new ObjectID(req.params.id) }, (err, doc) ->
    if err
      handleError res, err, 'Failed to fetch user details.'
    else
      res.status(200).json doc

#========================================
# Destroy
#========================================

exports.destroy = (req, res, next) ->
  User.deleteOne { _id: new ObjectID(req.params.id) }, (err, result) ->
    if err
      handleError res, err, 'Failed to delete user.'
    else
      res.status(200).json req.params

