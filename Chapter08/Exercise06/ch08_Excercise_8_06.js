\use test
\sql DESCRIBE animals
db.animals.insert().values(1, 'Cheetah')
db.animals.insert().values(2, 'Leopard')
db.animals.select()
