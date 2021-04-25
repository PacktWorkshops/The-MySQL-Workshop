var mysqlconnection = require("./mysqlconnection.js");

mysqlconnection.query("CREATE DATABASE CustomerDatabase", function (err, result) {
    if (err) throw err.code;
    console.log(result);
});

mysqlconnection.query("USE CustomerDatabase", function (err, result) {
    if (err) throw err.code;
    console.log(result); 
});  
		
var sql = "CREATE TABLE Customers(CustomerID INT AUTO_INCREMENT, CustomerName VARCHAR(50), PRIMARY KEY (CustomerID));"

mysqlconnection.query(sql, function (err, result) {
    if (err) throw "Problem creating database" + err.code;
    console.log(result);
});

var sql = "CREATE TABLE CustomerPurchases(CPID INT AUTO_INCREMENT, CustID INT, SKU VARCHAR(10), SalesDateTime DATETIME, Quantity INT, PRIMARY KEY(CPID));"

mysqlconnection.query(sql, function (err, result) {
    if (err) throw "Problem creating database" + err.code;
    console.log(result);
	process.exit();
});
