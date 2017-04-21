express = require('express')
merge = require('merge')
logger = require('morgan')
bodyParser= require('body-parser')
app = express();
jwt = require('jsonwebtoken')
crypto = require('crypto')
mongoose = require('mongoose')
config = require('./config/main');


MongoClient = require('mongodb').MongoClient
db = ''
ObjectID = require('mongodb').ObjectID

USERS_COLLECTION = 'users'

app.set('view engine', 'pug')
app.set('views', './views')

app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())

# Setting up basic middleware for all Express requests
app.use(logger 'dev') # Log requests to API using morgan

# Enable CORS from client-side
app.use((req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header 'Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS'
  res.header "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization, Access-Control-Allow-Credentials"
  res.header "Access-Control-Allow-Credentials", "true"
  next()
)

# Database Connection
mongoose.connect(config.database);  

db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')
db.once 'open', ->
  console.log 'Database connection ready'

User = require('./models/user')

server = app.listen(config.port, ->
  port = server.address().port
  console.log 'App now running on port', port
  return
)

# Connect to the database before starting the application server.
# MongoClient.connect process.env.MONGODB_URI, (err, database) ->
#   if err
#     console.log err
#     process.exit 1
# 
#   # Save database object from the callback for reuse.
#   db = database
#   console.log 'Database connection ready'
# 
#   # Initialize the app.
# 
#   server = app.listen(config.port, ->
#     port = server.address().port
#     console.log 'App now running on port', port
#     return
#   )
#   return

# MongoClient.connect 'mongodb://localhost/user_management', (err, database) ->
#   if err
#     return console.log(err)
#   db = database
#   app.listen 3000, ->
#     console.log 'listening on 3000'
  

###  "/api/users"
#    GET: finds all users
#    POST: creates a new user
###

# Generic error handler used by all endpoints.

handleError = (res, reason, message, code) ->
  console.log 'ERROR: ' + reason
  res.status(code or 500).json 'error': message
  return

app.get '/api/users', (req, res) ->
  User.find (err, docs) ->
    if err
      handleError res, err.message, 'Failed to get users.'
    else
      res.status(200).json docs

app.post '/api/users', (req, res) ->
  user = req.body
  console.dir user
  User.insertOne user, (err, doc) ->
    if err
      handleError res, err.message, 'Failed to create new user.'
    else
      res.status(201).json(doc.ops[0]);

###  "/api/users/:id"
#    GET: find user by id
#    PUT: update user by id
#    DELETE: deletes user by id
###

app.get '/api/users/:id', (req, res) ->
  User.findOne { _id: new ObjectID(req.params.id) }, (err, doc) ->
    if err
      handleError res, err.message, 'Failed to fetch user details.'
    else
      res.status(200).json doc

app.put '/api/users/:id', (req, res) ->
  existingUser = null;
  user = req.body;
  delete user._id;

#   User.findOne { _id: new ObjectID(req.params.id) }, (err, doc) ->
#     if err
#       handleError res, err.message, 'Failed to update user.'
#     else
#       existingUser = doc
#       delete existingUser._id
#       user = merge(existingUser, user)

  User.updateOne { _id: new ObjectID(req.params.id) }, user, (err, results) ->
    if err
      handleError res, err.message, 'Failed to update user.'
    else
      res.status(200).json results

app.delete '/api/users/:id', (req, res) ->
  User.deleteOne { _id: new ObjectID(req.params.id) }, (err, result) ->
    if err
      handleError res, err.message, 'Failed to delete user.'
    else
      res.status(200).json req.params

