var mysqlconnection = require("../mysqlconnection.js");

var sql = "CREATE TABLE `world_statistics`.`country` ( "
sql = sql + "`CountryID` int(11) NOT NULL AUTO_INCREMENT, "
sql = sql + "`Country Code` varchar(5) DEFAULT NULL, "
sql = sql + "`Country Name` varchar(50) DEFAULT NULL, "
sql = sql + "PRIMARY KEY (`CountryID`) "
sql = sql + ") ; "

  mysqlconnection.query(sql, function (err) {
  	    if (err) throw "Problem creating the table:- " + err.code;
  	        console.log("Table created");
            process.exit();
  });
