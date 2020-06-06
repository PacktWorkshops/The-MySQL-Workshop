//This script inserts a single record into the new database table
//You guessed it, include the connection module
var mysqlconnection = require("./mysqlconnection.js");

//Create a query to insert the data
//Notice we need to include the database name with the table,  world_statistics.continents
//This is because we did not specify a database in the connection, we"ll get to this soon enough
//
//Also notice the question mark, also important
var sql = "INSERT INTO world_statistics.country (`Country Code`,`Country Name`) VALUES ?";

//Create a record object, this is an array of data to insert into the table.
var record = [['ABW','Aruba'],['AFG','Afghanistan'],['AGO','Angola']];



//Now we execute the SQL statement
//The second parameter is the record object, it is in square brackets to indicate it is an array, albeit one dimension only
//When the sql is executed, record will replace the question mark, Node.js knows to do this
//Of course, error checking is included, as always
  mysqlconnection.query(sql, [record], function (err, result) {

  	//Deal with the error should one occur
    if (err) throw "Problem inserting the data" + err. code;

    //Otherwise, log the results to the console so user can see what happened
    console.log(result);													//This will report ALL result details
    console.log("Number of rows affected : " + result.affectedRows);		//This will report only how many rows, should be 1 in this example
    console.log("New records ID : " + result.insertId);  					//Reports the ID of the new record...you can extract specific details

    //Exit script
  	process.exit();

 	//Bracketing
});
