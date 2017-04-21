console.log('May Node be with you')

express = require('express');
bodyParser= require('body-parser')
app = express();

MongoClient = require('mongodb').MongoClient

app.set('view engine', 'pug')
app.set('views', './views')

app.use(bodyParser.urlencoded({extended: true}))

db = ''
ObjectId = require('mongodb').ObjectID;

MongoClient.connect 'mongodb://localhost/user_management', (err, database) ->
  if err
    return console.log(err)
  db = database
  app.listen 3000, ->
    console.log 'listening on 3000'

app.get '/', (req, res) ->
  res.redirect '/users'

app.get '/users/new', (req, res) ->
  #user = {username: 'aaa-username', firstname: 'aaa-firstname', lastname: 'aaa-lastname'}
  user = {}
  res.render('user_form', user: user, form_method: 'post', title: 'Create new user')
    
app.get '/users/edit/:id', (req, res) ->
  console.log "Parameters: "
  console.dir req.params
  cursor = db.collection('users').findOne {_id: ObjectId(req.params.id)}, (err, user) ->
    res.render('user_form', user: user, form_method: 'put', title: 'Edit user')
    
app.get '/users', (req, res) ->
  cursor = db.collection('users').find().toArray (err, results) ->
    if err
      return console.log(err)
    res.render('user_list', users: results, title: 'List users')
    
app.post '/users', (req, res) ->
  console.log 'creating new user'
  db.collection('users').save req.body, (err, result) ->
    if err
      return console.log(err)
    console.log 'saved to database'
    res.redirect '/users'

app.post '/users/:id', (req, res) ->
  db.collection('users').deleteOne {_id: ObjectId(req.params.id)}, (err, result) ->
    if err
      return console.log(err)
    console.log 'removed from database'
    res.redirect '/users'

router = require('./router')

#require('express-debug')(app, {})

router(app);  
