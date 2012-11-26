Devices = new Meteor.Collection("devices")

if Meteor.isClient
  Meteor.autosubscribe ->
    Meteor.subscribe 'devices', ->
      Session.set('devicesLoaded', true)

  Template.list.devicesLoaded = -> Session.get('devicesLoaded')
  
  Template.calculator.width = -> parseInt Session.get('width')
  Template.calculator.height = -> parseInt Session.get('height')
  Template.calculator.diagonal = -> parseInt Session.get('diagonal')
  Template.calculator.ppi = -> 
    w = Session.get('width') 
    h = Session.get('height')
    d = Session.get('diagonal') 
    if w > 0 && h > 0 && d > 0
      Math.round(Math.sqrt(w*w + h*h) / d, 2)
    else
      0

  Template.calculator.events
    'change #width': -> Session.set 'width', $('#width').val()
    'change #height': -> Session.set 'height', $('#height').val()
    'change #diagonal': -> Session.set 'diagonal', $('#diagonal').val()

  Template.list.devices =  -> 
    Devices.find({}, sort: {ppi:-1, name:1})

if Meteor.isServer

  Meteor.startup ->
    Devices.remove({})
    if Devices.find().count() is 0
      for device in initialDevices
        Devices.insert device

    Meteor.publish 'devices', -> Devices.find()
    