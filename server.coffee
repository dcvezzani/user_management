express = require('express')
merge = require('merge')
bodyParser= require('body-parser')
config = require('config')
app = express();
jwt = require('jsonwebtoken')
crypto = require('crypto')
mongoose = require('mongoose')

if config.util.getEnv('NODE_ENV') != 'test'
  # setup the logger
  logger = require('./logging').logger
  require('./logging').setupLogger(app)

MongoClient = require('mongodb').MongoClient
db = ''

USERS_COLLECTION = 'users'

app.set('view engine', 'pug')
app.set('views', './views')

app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())

# Enable CORS from client-side
app.use((req, res, next) ->
  res.header "Access-Control-Allow-Origin", "*"
  res.header 'Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS'
  res.header "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization, Access-Control-Allow-Credentials"
  res.header "Access-Control-Allow-Credentials", "true"
  next()
)

# Database Connection
mongoose.connect(config.get 'database')
db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')
db.once 'open', ->
  console.log 'Database connection ready'

# User model
User = require('./models/user')

# Start server
server = app.listen config.get('port'), ->
  port = server.address().port
  console.log 'App now running on port', port
  return

router = require('./router')
router(app);

# for testing
module.exports = app
