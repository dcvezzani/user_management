fs = require('fs')
logger = require('morgan')
winston = require('winston')

# create a write stream (in append mode)
accessLogStream = fs.createWriteStream(__dirname + '/access.log',{flags: 'a'})

# setup default logger (no category)
winston.loggers.add 'default',
  console:
    colorize: 'true'
    handleExceptions: true
    json: true
    level: 'debug'
    label: 'default'
  file:
    filename: __dirname + '/access.log'
    level: 'debug'
    json: true
    handleExceptions: true

setupLogger = (app) ->
  app.use(logger('combined', {stream: accessLogStream}))

  # Setting up basic middleware for all Express requests
  app.use(logger 'dev') # Log requests to API using morgan
  
module.exports = { winston, logger, accessLogStream, setupLogger }
