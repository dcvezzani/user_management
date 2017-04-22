#During the test the env variable is set to test
process.env.NODE_ENV = 'test'
mongoose = require('mongoose')
User = require('../models/user')
ObjectID = require('mongodb').ObjectID
merge = require('merge')

#Require the dev-dependencies
chai = require('chai')
chaiHttp = require('chai-http')
server = require('../server')
should = chai.should()
chai.use chaiHttp

admin = null
token = null
admin_attrs = {email: "me@gmail.com", password: 'pass'}

emptyUsersCollection = () ->
  promise = new Promise (resolve, reject) ->
    User.remove {}, (err) ->
      if err
        console.log 'Unable to empty test database ' + err
    resolve({database: 'cleaned up'});        
  return promise

loginAdmin = (data) ->
  promise = new Promise (resolve, reject) ->
    admin = User.create {"email":admin_attrs.email,"password":admin_attrs.password,"firstname":"John","lastname":"Doe","role":"Admin"}
    chai.request(server).post('/api/auth/login')
    .send({ email: admin_attrs.email, password: admin_attrs.password })
    .set('Content-Type', 'application/json').end (err, res) ->
      if err
        console.log 'Unable to login ' + admin_attrs.email + '; ' + err
      else
        resolve(merge data, {token: res.body.token})
  return promise

findUserByEmail = (data, email) ->
  promise = new Promise (resolve, reject) ->
    User.findOne { "email":email }, (err, doc) ->
      if err
        handleError res, err.message, 'Failed to fetch user details.'
      else
        resolve(merge data, {"found-user": doc._doc})
  return promise

createUser = () ->
  promise = new Promise (resolve, reject) ->
    User.create {"email":"joe@gmail.com","password":"pass","firstname":"Joe","lastname":"Shmoe","role":"Member"}, (err, doc) ->
      if err
        handleError res, err.message, 'Failed to create new user.'
      else
        resolve({"created-user": doc})
  return promise

filterOutAttrs = (records, email, names) ->
  i = 0
  target_record = null
  while i < records.length
    target_record = records[i]
    if target_record.email == email
      break
    i++  

  i = 0
  while i < names.length
    delete target_record[names[i]]
    i++  
  return target_record

describe 'Users', ->
  beforeEach (done) ->

    outcomeLoginAdmin = emptyUsersCollection().then (data) ->
      return loginAdmin(data)

    outcomeLoginAdmin.then (data) ->
      token = data.token
      done()

    return
      
  # Test the /GET route

  describe 'GET /users', ->
    it 'it should GET all the users (== 1)', (done) ->
      chai.request(server).get('/api/users')
      .set('Authorization', token).end (err, res) ->

        res.should.have.status 200
        res.body.should.be.a 'array'
        res.body.length.should.be.eql 1

        done()
        return
      return

    it 'it should GET all the users (> 1)', (done) ->
      User.create {"email":"joe@gmail.com","password":"pass","firstname":"Joe","lastname":"Shmoe","role":"Member"}
      User.create {"email":"jim@gmail.com","password":"pass","firstname":"Jim","lastname":"Shmoe","role":"Member"}
      User.create {"email":"jorge@gmail.com","password":"pass","firstname":"Jorge","lastname":"Shmoe","role":"Member"}

      chai.request(server).get('/api/users')
      .set('Authorization', token).end (err, res) ->

        res.should.have.status 200
        res.body.should.be.a 'array'
        res.body.length.should.be.eql 4

        attrs = filterOutAttrs res.body, 'joe@gmail.com', ['_id', '__v', 'createdAt', 'updatedAt', 'password']
        attrs.should.be.eql { "email": "joe@gmail.com", "firstname": "Joe", "lastname": "Shmoe", "role": "Member" }

        done()
        return
      return

  # Test the /POST route (create)

  describe 'POST /users', ->
    user_attrs = {"email":"joe@gmail.com","password":"pass","firstname":"Joe","lastname":"Shmoe","role":"Member"}
    user_attrs_minus_email = {"password":"pass","firstname":"Joe","lastname":"Shmoe","role":"Member"}

    it 'it should create a new user', (done) ->
      chai.request(server).post('/api/users')
      .send(user_attrs)
      .set('Authorization', token).end (err, res) ->

        res.should.have.status 201
        attrs = filterOutAttrs [res.body], 'joe@gmail.com', ['_id', '__v', 'createdAt', 'updatedAt', 'password']
        attrs.should.be.eql { "email": "joe@gmail.com", "firstname": "Joe", "lastname": "Shmoe", "role": "Member" }

        done()
        return
      return

    # TODO: validation reporting needs some tweaking
    xit 'it should prevent duplicate emails', (done) ->
      User.create user_attrs, (err, doc) ->
        chai.request(server).post('/api/users')
        .send(user_attrs)
        .set('Authorization', token).end (err, res) ->

          res.should.have.status 201
          attrs = filterOutAttrs [res.body], 'joe@gmail.com', ['_id', '__v', 'createdAt', 'updatedAt', 'password']
          attrs.should.be.eql { "email": "joe@gmail.com", "firstname": "Joe", "lastname": "Shmoe", "role": "Member" }

          done()
          return
        return
      return

    # TODO: validation reporting needs some tweaking
    xit 'it should require email', (done) ->
      chai.request(server).post('/api/users')
      .send(user_attrs_minus_email)
      .set('Authorization', token).end (err, res) ->

        console.log res.body
        res.should.have.status 201
        attrs = filterOutAttrs [res.body], 'joe@gmail.com', ['_id', '__v', 'createdAt', 'updatedAt', 'password']
        attrs.should.be.eql { "email": "joe@gmail.com", "firstname": "Joe", "lastname": "Shmoe", "role": "Member" }

        done()
        return
      return

  # Test the /PUT/:id route

  describe 'PUT /users/:id', ->
    user = null
    joe_email = "joe@gmail.com"

    beforeEach (done) ->
      outcomeFindUserByEmail = createUser().then (data) ->
        return findUserByEmail(data, joe_email)

      outcomeFindUserByEmail.then (data) ->
        user = data['found-user']

        done()
        return
      return
  
    it 'it should update an existing user', (done) ->
      user.role.should.be.eql 'Member'
    
      chai.request(server).put('/api/users/' + user._id)
      .send({"email":joe_email,"password":"pass","firstname":"Joe","lastname":"Shmoe","role":"Admin"})
      .set('Authorization', token).end (err, res) ->
        User.findOne { "email":joe_email }, (err, doc) ->

            res.should.have.status 200
            attrs = filterOutAttrs [doc._doc], joe_email, ['_id', '__v', 'createdAt', 'updatedAt', 'password']
            attrs.should.be.eql { "email": joe_email, "firstname": "Joe", "lastname": "Shmoe", "role": "Admin" }

            done()
            return
          return
        return
      return

    # TODO: needs better reporting; should be reporting 404, not 500
    xit 'it should handle non-existing user ids', (done) ->
      chai.request(server).put('/api/users/999')
      .send({"email":joe_email,"password":"pass","firstname":"Joe","lastname":"Shmoe","role":"Admin"})
      .set('Authorization', token).end (err, res) ->

            res.should.have.status 404

            done()
            return
          return
        return
      return

  # Test the /GET/:id route
  #
  describe 'GET /users/:id', ->
    user = null
    joe_email = "joe@gmail.com"

    beforeEach (done) ->
      outcomeFindUserByEmail = createUser().then (data) ->
        return findUserByEmail(data, joe_email)

      outcomeFindUserByEmail.then (data) ->
        user = data['found-user']
        done()
        return
      return
  
    it 'it should display/show an existing user', (done) ->
      chai.request(server).get('/api/users/' + user._id)
      .set('Authorization', token).end (err, res) ->

        res.should.have.status 200
        attrs = filterOutAttrs [user], joe_email, ['_id', '__v', 'createdAt', 'updatedAt', 'password']
        attrs.should.be.eql { "email": joe_email, "firstname": "Joe", "lastname": "Shmoe", "role": "Member" }

        done()
        return
      return

  # Test the /GET/:id route
  #
  describe 'GET /users/:id', ->
    user = null
    joe_email = "joe@gmail.com"

    beforeEach (done) ->
      outcomeFindUserByEmail = createUser().then (data) ->
        return findUserByEmail(data, joe_email)

      outcomeFindUserByEmail.then (data) ->
        user = data['found-user']
        done()

      return
  
    it 'it should display/show an existing user', (done) ->
      chai.request(server).get('/api/users/' + user._id)
      .set('Authorization', token).end (err, res) ->
        res.should.have.status 200

        attrs = filterOutAttrs [user], joe_email, ['_id', '__v', 'createdAt', 'updatedAt', 'password']
        attrs.should.be.eql { "email": joe_email, "firstname": "Joe", "lastname": "Shmoe", "role": "Member" }
        done()
        return
      return
      
  # Test the /DELETE/:id route
  #
  describe 'DELETE /users/:id', ->
    user = null
    count = -1
    joe_email = "joe@gmail.com"

    beforeEach (done) ->
      outcomeFindUserByEmail = createUser().then (data) ->
        return findUserByEmail(data, joe_email)

      outcomeFindUserByEmail.then (data) ->
        user = data['found-user']
        done()

      return
  
    it 'it should display/show an existing user', (done) ->
      user.email.should.be.eql joe_email

      chai.request(server).delete('/api/users/' + user._id)
      .set('Authorization', token).end (err, res) ->
        res.should.have.status 200
        res.body.should.be.eql { "id": user._id.toString() }

        User.count (err, c) ->
          count = c
          console.log "Count is " + count
          count.should.be.eql 1
          done()
          return
        return
      return

