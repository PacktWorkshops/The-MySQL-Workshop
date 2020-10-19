\js
\use world
\source worldcol.js
db.worldcol.find('district="Punjab" and country.name="India"').

fields('name','population')

db.worldcol.find('district="Punjab" and country.name="India"').
fields('name','population').
sort('population desc')
