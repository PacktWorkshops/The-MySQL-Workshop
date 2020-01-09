#!/usr/bin/python3
# Expects datbase with two tables created from animals.sql
import mysql.connector
import mysqlx

def sql_example() -> None:
    con = mysql.connector.connect(
      unix_socket='/tmp/mysql_sandbox8018.sock',
      user='msandbox',
      password='msandbox',
      database='test',
    )   
    c = con.cursor()
    c.execute("SELECT name FROM animals_table")
    output = "Animals in the animals table\n"
    for row in c:
        output += f"SQL Animal: {row[0]}\n"
    c.close()
    con.close()
    return output

def nosql_example() -> None:
    session = mysqlx.get_session(
      socket='/tmp/mysqlx-18018.sock',
      user='msandbox',
      password='msandbox',
    )   
    schema = session.get_schema('test')
    animals = schema.get_collection('animals_collection')
    output = "Animals in the animals collection\n"
    for doc in animals.find().fields('name').execute().fetch_all():
        output += f"NoSQL Animal: {doc['name']}\n"
    session.close()
    return output

def test_sql_example():
    assert sql_example() == """Animals in the animals table
SQL Animal: monkey
SQL Animal: zebra
SQL Animal: lion
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
