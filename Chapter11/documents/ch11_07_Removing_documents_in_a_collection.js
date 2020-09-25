\use test

db.todo.find()
db.todo.remove('done = true')
db.todo.find()
