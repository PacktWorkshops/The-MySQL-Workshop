\use test

db.createCollection('airports')

db.airports.add(
  {"iata_code": "ATL", "location": "Atlanta, Georgia",
  "country": "United States", "passengers": 54388000},
  {"iata_code": "LAX", "location": "Los Angeles, California", 
  "country": "United States", "passengers": 43049000},
  {"iata_code": "DBX", "location": "Garhoud, Dubai",
  "country": "United Arab Emirates", "passengers": 41278000},
  {"iata_code": "PEK", "location": "Chaoyang-Shunyi, Beijing", 
  "country": "China", "passengers": 49242000},
  {"iata_code": "HND", "location": "Ōta, Tokyo",
  "country": "Japan", "passengers": 41435000}
)

db.airports.find()

db.airports.find().sort('passengers DESC')

