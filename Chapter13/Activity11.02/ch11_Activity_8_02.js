\use test

db.createCollection('printers')
db.printers.add(
  {_id: 1, name: 'HP LaserJet 1012', location: 'Building 1, First floor'},
  {_id: 2, name: 'Epson WorkForce WF-2835DWF', location: 'Building 1, Second floor'},
  {_id: 3, name: 'Canon Maxify MB2750 printer', location: 'Building 1, Third floor'}
)

db.printers.add({
  _id: 4,
  name: ' Brother DCP-J774DW',
  location: 'Building 1, Fourth floor'
})

db.printers.modify('name not like "%LaserJet%"').
patch({warranty_until: 2023})

db.printers.modify('name like "%LaserJet%"').
patch({warranty_until: 2021})

db.printers.find().fields('name','warranty_until')

db.printers.modify('name = "Epson WorkForce WF-2835DWF"').
set('location', 'Building 2, First floor')

db.printers.remove('name = "Canon Maxify MB2750 printer"')

db.printers.find()
