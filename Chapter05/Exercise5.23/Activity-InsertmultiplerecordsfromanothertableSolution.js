// Add the MySQL connection
var mysqlconnection = require("../mysqlconnection.js");

// Instruct server that all operations from this point are to use the world_statistics database
 mysqlconnection.query("USE world_statistics", function (err, result) {
  	//Deal with the error should one occur
    if (err) throw "Instructing database to use" + err. code;

  	console.log("Using World_Statistics");

	// Delete all records from the current country table
	 mysqlconnection.query("DELETE FROM country", function (err, result) {
	  	//Deal with the error should one occur
	    if (err) throw "Problem Deleting records from country table" + err. code;

	    console.log("Country table has been cleared of all records");

		// Restart AutoIncrement numbering from 1
		 mysqlconnection.query("ALTER TABLE country AUTO_INCREMENT = 1", function (err, result) {
		  	//Deal with the error should one occur
		    if (err) throw "Problem resetting the Auto Increment on the Country table" + err. code;

		    console.log("Auto Increment has been reset on the Country table");


			//Create the SQL to extract the data from the source table, temp
			var records = "SELECT `Country Code`, `Country Name`,`ContinentID` "
			records = records +"FROM world_statistics.temp "
			records = records +"ORDER BY `CountryID`";

			//Create the insert query but only with field names, no VALUES statement
			var sql = "INSERT INTO world_statistics.country (`Country Code`,`Country Name`,`ContinentID`)";

			//Combine the two SQL statements with a space between them
			sql = sql + " " + records; 

			console.log("The combined SQL statement is\n");
			console.log(sql + "\n");

			//Now we execute the SQL statement with error checking
			  mysqlconnection.query(sql, function (err, result) {
			  	//Deal with the error should one occur
			    if (err) throw "Problem inserting the data" + err. code;

			    //Otherwise, log the results to the console so user can see what happened and then exit 
			    console.log(result);													
			    console.log("Number of rows affected : " + result.affectedRows);		
			    console.log("New records ID : " + result.insertId);  					
			  	process.exit();
			});

		});
	});
});




