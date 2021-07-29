var mysqlconnection = require("MySQLConnection.js");
var sql = "CREATE TABLE world_statistics.Region1(CountryID INT, `Country Code` VARCHAR(45));";

mysqlconnection.query(sql, function (err, result) {

    if (err) throw "Problem creatings the data" + err. code;

    console.log(result);
    console.log("Number of rows affected : " + result.affectedRows)
    console.log("New records ID : " + result.insertId);  

});

var records = "SELECT `ContinentID`, `Country Code` FROM world_statistics.countries WHERE `CountryID` < 10 ORDER BY `CountryID`";
var sql = "INSERT INTO world_statistics.country (`CountryID`,`Country Code`)";
sql = sql + " " + records;
mysqlconnection.query(sql, function (err, result) {
	if (err) throw "Problem inserting the data" + err.code;
    console.log(result);
    console.log("Number of rows affected : " + result.affectedRows);
    console.log("New records ID : " + result.insertId);  
    process.exit();
});
