\use world

db.dropCollection('worldcol')

db.createCollection('worldcol')

\sql INSERT INTO worldcol(doc) SELECT JSON_OBJECT('_id', city.id, 'name', city.name, 'district', city.district, 'population', city.population, 'is_capital', CAST(country.capital=city.id AS JSON), 'country', json_object('name', country.name, 'code', country.code, 'region', country.region, 'continent', country.continent, 'surface_area', country.surfacearea, 'independence_year', country.indepyear, 'population', country.population, 'GNP', country.gnp, 'local_name', country.localname, 'government_form', country.governmentform, 'head_of_state', country.headofstate, 'code2', country.code2), 'language', json_objectagg(countrylanguage.language, json_object('is_official', CAST(countrylanguage.isofficial='T' AS JSON), 'percentage', countrylanguage.percentage))) AS 'city_json' FROM city LEFT JOIN country ON city.CountryCode=country.Code LEFT JOIN countrylanguage ON city.CountryCode=countrylanguage.CountryCode GROUP BY city.id
