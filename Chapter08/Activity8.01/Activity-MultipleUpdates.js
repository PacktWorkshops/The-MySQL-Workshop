var mysqlconnection = require("./mysqlconnection.js")
mysqlconnection.query("USE world_statistics", function (err, result) {
	if (err) throw "Instructing database to use" + err.code;
	//Tell user on console
	console.log("Using World_Statistics");
	var newfield = "CREATE TABLE countryalldetails(CountryID INT(11), ContinentID INT(11), `Country Code` VARCHAR(5), `Country Name` VARCHAR(50))”;
	
	mysqlconnection.query(newfield, function (err, result) {
	//Deal with the error should one occur
		if (err) throw "Problem creating column Capital" + err.code;
		//Tell user that the capital column has been created
		console.log("Column Capital created");	
	});
	
	var newfield = "ALTER TABLE countryalldetails ADD COLUMN Is_Independent VARCHAR(25);"

	mysqlconnection.query(newfield, function (err, result) {
		//Deal with the error should one occur
		if (err) throw "Problem creating column Is_Independent" + err.code;
		//Tell user that the Is_Independent column has been created
		console.log("Column Is_Independent created");
	});
	
	var newfield = "ALTER TABLE countryalldetails ADD COLUMN Currency VARCHAR(5);"
	mysqlconnection.query(newfield, function (err, result) {
		//Deal with the error should one occur
		if (err) throw "Problem creating column Currency" + err.code;
		//Tell user that the currency column has been created
		console.log("Column Currency created");
	});
	
	var updateOne="UPDATE countryalldetails SET Capital = " 
	updateOne = updateOne + "(SELECT `Capital` FROM world_statistics.temp WHERE `Country Code`= `country`.`Country Code` LIMIT 1);"

	mysqlconnection.query(updateOne, function (err, result) {
		if (err) throw "Problem updating Capital" + err.code;
		//Tell user that the capital is updated, and show affectedRows
		console.log("Capital is updated");
		console.log("Number of rows affected : " + result.affectedRows);
	});
	
	var updateTwo="UPDATE countryalldetails SET Is_Independent = "
	updateTwo = updateTwo + "(SELECT `Is_Independent` FROM world_statistics.temp WHERE `Country Code`= `country`.`Country Code` LIMIT 1);"
	
	mysqlconnection.query(updateTwo, function (err, result) {
		if (err) throw "Problem updating Is_Independent" + err.code;
		//Tell user that the Is_Independent column has been updated
		console.log("Is_Independent is updated");
		console.log("Number of rows affected : " + result.affectedRows);
	});
	
	var updateThree="UPDATE country SET Currency = "
	updateThree = updateThree + "(SELECT `Currency` FROM world_statistics.temp WHERE `Country Code`= `country`.`Country Code` LIMIT 1);"
	mysqlconnection.query(updateThree, function (err, result) {
		if (err) throw "Problem updating Currency" + err.code;
		//Tell user that the currency column has been updated
		console.log("Currency is updated");
		console.log("Number of rows affected : " + result.affectedRows);
		process.exit();
	});
	
});//USE world_statistics
