\use sakila
db.createCollection('payroll')
db.payroll.add(
    {_id: 1, name: "Mike Hillyer", salary: 50000},
    {_id: 2, name: "Jon Stephens", salary: 51000}
)
db.payroll.modify('1').
set('old_salary', mysqlx.expr('salary')).
set('salary', mysqlx.expr('salary*1.03'))
db.payroll.find()