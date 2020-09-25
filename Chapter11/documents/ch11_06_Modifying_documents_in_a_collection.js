\use test

db.dropCollection('todo')
db.createCollection('todo')
db.todo.add({
  "_id": 1,
  "text": "file taxes",
  "duedate": new Date("2020-04-01").toJSON(),
  "done": false
})

db.todo.add({
  "_id": 2,
  "text": "do the dishes",
  "duedate": new Date("2020-04-11").toJSON(),
  "done": false
})

session.startTransaction()
db.todo.modify('_id = 2').set('text', mysqlx.expr('upper(text)'))
session.rollback()

db.todo.find()
db.todo.modify('_id = 1').set('done', true)
db.todo.find()
