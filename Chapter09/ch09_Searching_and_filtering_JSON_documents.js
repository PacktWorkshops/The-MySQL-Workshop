\source worldcol.js

db.worldcol.find().limit(1)

db.worldcol.find('name="Paris"')

db.worldcol.find('is_capital=true').
fields('name').
limit(5)

db.worldcol.count()

db.worldcol.find('is_capital=true').
fields('name', 'country.name').
limit(5)

db.worldcol.find('language.Kazakh').
fields('country.name').
groupBy('country.name')

db.worldcol.find('country.name="Russian Federation"').
fields('name', 'population').
sort('population desc').
limit(5)

db.worldcol.find('country.name="Romania"').
fields(
  'name',
  'population', 
  'country.population',
  '100*population/country.population as pct_of_country'
)
.sort('population desc')
.limit(5)
