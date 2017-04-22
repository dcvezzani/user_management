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

# User model
User = require('./models/user')

# Start server
server = app.listen(config.port, ->
  port = server.address().port
  console.log 'App now running on port', port
  return
)

# Generic error handler used by all endpoints.

handleError = (res, reason, message, code) ->
  console.log 'ERROR: ' + reason
  res.status(code or 500).json 'error': message
  return

router = require('./router')
router(app);
