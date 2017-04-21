console.log('May Node be with you')

const express = require('express');
const bodyParser= require('body-parser')
const app = express();


const MongoClient = require('mongodb').MongoClient

app.use(bodyParser.urlencoded({extended: true}))

var db

MongoClient.connect('link-to-mongodb', function(err, database) {
  if (err) return console.log(err)
  app.listen(3000, function() {
    console.log('listening on 3000')
  })
})

app.get('/', function(req, res) {
  res.sendFile(__dirname + '/index.html')
})

app.post('/quotes', function(req, res) {
  console.log(req.body)
})
