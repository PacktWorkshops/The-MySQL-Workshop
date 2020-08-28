#!/usr/bin/python3
# Expects datbase with two tables created from animals.sql
import mysql.connector
import mysqlx

def sql_example():
    con = mysql.connector.connect(
      host='localhost',
      user='msandbox',
      password='msandbox',
      database='test',
    )   
    c = con.cursor()
    c.execute("SELECT name FROM animals")
    output = "Animals in the animals table\n"
    for row in c:
        output += "SQL Animal: {0}\n".format(row[0])
    c.close()
    con.close()
    return output

def nosql_example():
    session = mysqlx.get_session(
      host='localhost',
      user='msandbox',
      password='msandbox',
    )   
    schema = session.get_schema('test')
    animals = schema.get_collection('animals_collection')
    output = "Animals in the animals collection\n"
    for doc in animals.find().fields('name').execute().fetch_all():
        output += "NoSQL Animal: {0}\n".format(doc['name'])
    session.close()
    return output

def test_sql_example():
    assert sql_example() == """Animals in the animals table
SQL Animal: dog
SQL Animal: Camel
SQL Animal: None
"""

def test_nosql_example():
    assert nosql_example() == """Animals in the animals collection
NoSQL Animal: monkey
NoSQL Animal: zebra
NoSQL Animal: lion
"""

if __name__ == "__main__":
    print(sql_example())
    print(nosql_example())
    print(test_sql_example())
    print(test_nosql_example())
