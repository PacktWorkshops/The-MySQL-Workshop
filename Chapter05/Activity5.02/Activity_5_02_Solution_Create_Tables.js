

var mysqlconnection = require("./mysqlconnection.js");
		var sql = "CREATE TABLE `MOTdatabase`.`Customers` (\
		`CustID` int(11) NOT NULL AUTO_INCREMENT, \
		`CustomerName` varchar(50) NOT NULL, \
		PRIMARY KEY (`CustID`)\
		);"
		
		 mysqlconnection.query(sql, function (err) {
      		if (err) throw "Problem creating the Table:- " + err.code;	
      		console.log("Table created"); 	
});

		var sql = "CREATE TABLE `MOTdatabase`.`CustomerPurchases` (\
		`CPID` int(11) NOT NULL AUTO_INCREMENT, \
		`CustID` int(11) NOT NULL, \
		`SKU` varchar(20) NOT NULL, \
		`SaleDateTime` varchar(25) NOT NULL, \
		`Quantity` int(11) NOT NULL, \
		PRIMARY KEY (`CPID`)\
		);"
		
		 mysqlconnection.query(sql, function (err) {
      		if (err) throw "Problem creating the Table:- " + err.code;	
      		console.log("Table created"); 	
			process.exit();
});
