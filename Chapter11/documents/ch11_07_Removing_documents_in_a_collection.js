\use test

db.todo.find()
db.todo.modify('_id = 2').patch({"done": false})
db.todo.find()
db.todo.remove('done = true')
db.todo.find()
db.todo.add(
    {_id: 10, done: true, text: "Buy milk", duedate: new Date("2020-01-01")},
    {_id: 11, done: true, text: "Shop for a new watch", duedate: new Date("2020-01-02")},
    {_id: 12, done: true, text: "Pay electricity bill", duedate: new Date("2020-01-03")}
)
db.todo.find()
db.todo.remove('1').sort('duedate asc').limit(1)
db.todo.find()
