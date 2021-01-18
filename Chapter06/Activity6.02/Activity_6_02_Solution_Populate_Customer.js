
var mysqlconnection = require("./mysqlconnection.js");

var sql = "INSERT INTO motdatabase.customers (`CustomerName`) VALUES ?";

var record = [['Big Company'],['Little Company'],['Old Company'],['New Company']];

  	mysqlconnection.query(sql, [record], function (err, result) {
    if (err) throw "Problem inserting the data" + err.code;
    console.log(result);
    console.log("Number of rows affected : " + result.affectedRows);
    console.log("New records ID : " + result.insertId);  
process.exit();
});
