//Verified
//Here we are going to add a table to the new database
//Again...and this will be in all subsequent scripts, include the mysqlconnection module
//Oh the joy of not rewriting all that connection stuff
var mysqlconnection = require("../mysqlconnection.js");

//Issue a server command to create the table. The command also defines the fields and their data type
//The ID field is also designated as the prinary key, it is an integer and will auto increment its value
//as each recor is inserted into the table
var sql = "CREATE TABLE `world_statistics`.`continents` ( \
  `ContinentID` int(11) NOT NULL AUTO_INCREMENT, \
  `Continent` varchar(13) DEFAULT NULL, \
  PRIMARY KEY (`ContinentID`)\
);"


//Execute the SQL, in clude error checking
mysqlconnection.query(sql, function (err) {

  //Handle any errors
  if (err) throw "Problem creating the table:- " + err.code;

  //Otherwise tell user that the table was created
  console.log("Table created");

//And leave
process.exit();

//Close off the block bracketing            
});
