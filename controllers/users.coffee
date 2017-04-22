User = require('../models/user')
ObjectID = require('mongodb').ObjectID

#========================================
# List
#========================================

exports.list = (req, res, next) ->
  User.find (err, docs) ->
    if err
      handleError res, err.message, 'Failed to get users.'
    else
      res.status(200).json docs

#========================================
# Create
#========================================

exports.create = (req, res, next) ->
  user = req.body
  User.create user, (err, doc) ->
    if err
      handleError res, err.message, 'Failed to create new user.'
    else
      res.status(201).json(doc);

#========================================
# Update
#========================================

exports.update = (req, res, next) ->
  existingUser = null;
  user = req.body;
  delete user._id;

  User.updateOne { _id: new ObjectID(req.params.id) }, user, (err, results) ->
    if err
      handleError res, err.message, 'Failed to update user.'
    else
      res.status(200).json results

#========================================
# Show
#========================================

exports.show = (req, res, next) ->
  User.findOne { _id: new ObjectID(req.params.id) }, (err, doc) ->
    if err
      handleError res, err.message, 'Failed to fetch user details.'
    else
      res.status(200).json doc

#========================================
# Destroy
#========================================

exports.destroy = (req, res, next) ->
  User.deleteOne { _id: new ObjectID(req.params.id) }, (err, result) ->
    if err
      handleError res, err.message, 'Failed to delete user.'
    else
      res.status(200).json req.params

