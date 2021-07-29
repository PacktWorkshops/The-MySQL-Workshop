// :) Just do it
var mysqlconnection = require("MySQLConnection.js");

//Instruct server to use world_statistics
mysqlconnection.query("USE world_statistics", function (err) {
    if (err) throw err;

    console.log("Using world_statistics database");

    //Resize the field so we can fit the new name in
    var ChangeCol = "ALTER TABLE `continents` "
    ChangeCol = ChangeCol + "CHANGE COLUMN `Continent` `Continent` VARCHAR(20) NULL DEFAULT NULL;"
    mysqlconnection.query(ChangeCol, function (err) {
        if (err) throw err;

          console.log("Column Continent has been resized");

          //Set a variable for the new value and the ContinentID we are changing
          var updateValues = ["Australia/Oceana",5];	

          //Create the SQL
          var sql = "UPDATE continents SET Continent = ? WHERE ContinentID = ? ";

          //Execute it...don't forget errors
          mysqlconnection.query(sql, updateValues, function (err, result) {
            if (err) throw err;

            //Tell user we are finished  
            console.log("Record has been updated");

            //And leave
            process.exit();      

            //Close brackets for update 
          });
    });
  });          
