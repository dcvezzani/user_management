console.log('May Node be with you')

express = require('express');
bodyParser= require('body-parser')
app = express();

MongoClient = require('mongodb').MongoClient

app.set('view engine', 'pug')
app.set('views', './views')

app.use(bodyParser.urlencoded({extended: true}))

db = ''

MongoClient.connect 'mongodb://localhost/user_management', (err, database) ->
  if err
    return console.log(err)
  db = database
  app.listen 3000, ->
    console.log 'listening on 3000'

app.get '/', (req, res) ->
  cursor = db.collection('quotes').find().toArray (err, results) ->
    console.log(results)
    res.render('index', quotes: results)
    

app.post '/quotes', (req, res) ->
  db.collection('quotes').save req.body, (err, result) ->
    if err
      return console.log(err)
    console.log 'saved to database'
    res.redirect '/'

