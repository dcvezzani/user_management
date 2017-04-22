AuthenticationController = require('./controllers/authentication')
UsersController = require('./controllers/users')

express = require('express')
passportService = require('./config/passport')
passport = require('passport')

# Constants for role types
REQUIRE_ADMIN = 'Admin'
REQUIRE_OWNER = 'Owner'
REQUIRE_CLIENT = 'Client'
REQUIRE_MEMBER = 'Member'

# Middleware to require login/auth
requireAuth = passport.authenticate('jwt', session: false)
requireLogin = passport.authenticate('local', session: false)
requireAdmin = AuthenticationController.roleAuthorization(REQUIRE_ADMIN)

module.exports = (app) ->

  # Initializing route groups
  apiRoutes = express.Router()
  authRoutes = express.Router()


  #=========================
  # Auth Routes
  #=========================

  # Set auth routes as subgroup/middleware to apiRoutes
  apiRoutes.use '/auth', authRoutes

  # Registration route
  authRoutes.post '/register', AuthenticationController.register

  # Login route
  authRoutes.post '/login', requireLogin, AuthenticationController.login
  
  # Set url for API group routes

  # Protect dashboard route with JWT
  apiRoutes.all '/users*', requireAuth


  #=========================
  # User Routes
  #=========================

  apiRoutes.post '/users*', requireAdmin
  apiRoutes.put '/users*', requireAdmin
  apiRoutes.delete '/users*', requireAdmin

  ###  "/api/users"
  #    GET: finds all users
  #    POST: creates a new user
  ###

  apiRoutes.get '/users', UsersController.list
  apiRoutes.post '/users', UsersController.create

  ###  "/api/users/:id"
  #    GET: find user by id
  #    PUT: update user by id
  #    DELETE: deletes user by id
  ###

  apiRoutes.get '/users/:id', UsersController.show
  apiRoutes.put '/users/:id', UsersController.update
  apiRoutes.delete '/users/:id', UsersController.destroy
    
  app.use '/api', apiRoutes
  return

