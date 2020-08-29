\use test
\sql DESCRIBE animals
db.animals.insert().values(4, 'Cheetah')
db.animals.insert().values(5, 'Leopard')
db.animals.select()
