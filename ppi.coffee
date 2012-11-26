Devices = new Meteor.Collection("devices")

if Meteor.isClient
  validator = (value) ->
    if !value? 
      ''
    else if value > 0 
      'success' 
    else 
      'error'

  Meteor.autosubscribe ->  
    Meteor.subscribe 'devices', -> Session.set('devicesLoaded', true)

  Template.list.devicesLoaded = -> Session.get('devicesLoaded')
  Template.list.devices = -> Devices.find {}, sort: {ppi:-1, name:1}
  
  Template.calculator.width          = -> Session.get('width')
  Template.calculator.statusWidth    = -> validator Session.get('width')
  Template.calculator.height         = -> Session.get('height')
  Template.calculator.statusHeight   = -> validator Session.get('height')
  Template.calculator.diagonal       = -> Session.get('diagonal')
  Template.calculator.statusDiagonal = -> validator Session.get('diagonal')
  Template.calculator.ppi = -> 
    [w, h, d] = [Session.get('width'), Session.get('height'), Session.get('diagonal')]
    if w + h + d > 0
      Math.round Math.sqrt(w*w + h*h) / d, 2
    else
      0
  Template.calculator.events
    'change #width input':    (event) -> Session.set 'width',    parseInt(event.target.value)
    'change #height input':   (event) -> Session.set 'height',   parseInt(event.target.value)
    'change #diagonal input': (event) -> Session.set 'diagonal', parseInt(event.target.value)

if Meteor.isServer
  Meteor.startup ->

    if Devices.find().count() is 0
      for device in initialDevices
        Devices.insert device

    Meteor.publish 'devices', -> Devices.find()
      