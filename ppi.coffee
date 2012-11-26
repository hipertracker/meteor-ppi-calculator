Devices = new Meteor.Collection("devices")

if Meteor.isClient

  Meteor.autosubscribe ->
    Meteor.subscribe 'devices', ->
      Session.set('devicesLoaded', true)

  Template.list.devices =  ->  Devices.find({}, sort: {ppi:-1, name:1})

  Template.list.devicesLoaded = -> Session.get('devicesLoaded')
  
  Template.calculator.width    = -> parseInt Session.get('width')
  Template.calculator.height   = -> parseInt Session.get('height')
  Template.calculator.diagonal = -> parseInt Session.get('diagonal')
  Template.calculator.ppi = -> 
    [w, h, d] = [Session.get('width'), Session.get('height'), Session.get('diagonal')]
    if w + h + d > 0
      Math.round Math.sqrt(w*w + h*h) / d, 2
    else
      0

  Template.calculator.events
    'change #width':    (event) -> Session.set 'width',    event.target.value
    'change #height':   (event) -> Session.set 'height',   event.target.value
    'change #diagonal': (event) -> Session.set 'diagonal', event.target.value

if Meteor.isServer
  Meteor.startup ->

    if Devices.find().count() is 0
      for device in initialDevices
        Devices.insert device

    Meteor.publish 'devices', -> Devices.find()
      