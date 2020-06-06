// Add the MySQL connection
var mysqlconnection = require("./mysqlconnection.js");

// Instruct server that all operations from this point are to use the world_statistics database
 mysqlconnection.query("USE world_statistics", function (err, result) {
  	//Deal with the error should one occur
    if (err) throw "Instructing database to use" + err. code;
    	//Tell user on console
  	console.log("Using World_Statistics");
			//Create the new columns
			var newfield = "ALTER TABLE country ADD COLUMN Capital VARCHAR(50);"
			  mysqlconnection.query(newfield, function (err, result) {
			  	//Deal with the error should one occur
			    if (err) throw "Problem creating column Capital" + err. code;
			    	//Tell user on console
				console.log("Column Capital created");			    	
				
				var newfield = "ALTER TABLE country ADD COLUMN Is_Independent VARCHAR(25);"
				mysqlconnection.query(newfield, function (err, result) {
				//Deal with the error should one occur
				    if (err) throw "Problem creating column Is_Independent" + err. code;
				    	//Tell user on console
					console.log("Column Is_Independent created");			    	

					var newfield = "ALTER TABLE country ADD COLUMN Currency VARCHAR(5);"
					mysqlconnection.query(newfield, function (err, result) {
					//Deal with the error should one occur
					    if (err) throw "Problem creating column Currency" + err. code;
					    	//Tell user on console
						console.log("Column Currency created");			    	

			//All columns have been created so can now insert data

						var updateOne="UPDATE Country SET Capital = " 
						updateOne = updateOne + "(SELECT `Capital` FROM world_statistics.temp WHERE `Country Code`= `country`.`Country Code` LIMIT 1);"
						mysqlconnection.query(updateOne, function (err, result) {
						    if (err) throw "Problem updating Capital" + err. code;
						    	//Tell user on console
							console.log("Capital is updated");			    	
						    console.log("Number of rows affected : " + result.affectedRows);		

							var updateTwo="UPDATE Country SET Is_Independent = "
							updateTwo = updateTwo + "(SELECT `Is_Independent` FROM world_statistics.temp WHERE `Country Code`= `country`.`Country Code` LIMIT 1);"
							mysqlconnection.query(updateTwo, function (err, result) {
							    if (err) throw "Problem updating Is_Independent" + err. code;
							    	//Tell user on console
								console.log("Is_Independent is updated");			    	
							    console.log("Number of rows affected : " + result.affectedRows);		

								var updateThree="UPDATE Country SET Currency = "
								updateThree = updateThree + "(SELECT `Currency` FROM world_statistics.temp WHERE `Country Code`= `country`.`Country Code` LIMIT 1);"
								mysqlconnection.query(updateThree, function (err, result) {
								    if (err) throw "Problem updating Currency" + err. code;
								    	//Tell user on console
									console.log("Currency is updated");			    	
								    console.log("Number of rows affected : " + result.affectedRows);		
								  	process.exit();
	//Close of the brackets								  	
								});	//updateThree
							});	//updateTwo
						});	//updateOne
					});	//Column Currency
				});	//Column Is_Independent
			});	//Column Capital
	});	//USE world_statistics


