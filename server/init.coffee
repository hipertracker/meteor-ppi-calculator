initialDevices = [
  # smartphones
  {name:'iPad2',         width:1024, height:768,  diagonal:9.7},
  {name:'iPad 3/4',      width:2048, height:1536, diagonal:9.7},
  {name:'iPad Mini',     width:1024, height:768,  diagonal:7.9},
  {name:'iPhone 4/4s',   width:960,  height:640,  diagonal:3.5},
  {name:'iPhone 5',      width:1136, height:640,  diagonal:4},
  {name: 'Nexus 4',      width:1280, height:768, diagonal: 4.7},
  # tablets
  {name:'MacBook Air 11"',            width:1366, height:768,  diagonal:11.6},  
  {name:'MacBook Air 13.3"',          width:1440, height:900,  diagonal:13.3},  
  {name:'MacBook Pro 15.4"',          width:1440, height:900,  diagonal:15.4},  
  {name:'MacBook Pro 15.4" hires',    width:1680, height:1050, diagonal:15.4},  
  {name:'MacBook Pro & 13" retina',   width:2560, height:1600, diagonal:13.3},  
  {name:'MacBook Pro & 15.4" retina', width:2880, height:1800, diagonal:15.4},  
  # desktops
  {name:'iMac 27"', width:2560, height:1440, diagonal:27},    
  {name:'iMac 27"', width:1920, height:1080, diagonal:21.5},    
]

ppi = (w,h,d) -> Math.round (Math.sqrt(w*w + h*h) / d)

initialDevices = ((d.ppi = ppi(d.width,d.height,d.diagonal); d) for d in initialDevices)
