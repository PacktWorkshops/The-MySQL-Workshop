

var mysqlconnection = require("./mysqlconnection.js");
		var sql = "CREATE TABLE `MOTdatabase`.`CustomerPurchases` ("
		sql = sql + "  `CPID` int(11) NOT NULL AUTO_INCREMENT, "
		sql = sql + "  `CustID` int(11) NOT NULL, "
		sql = sql + "  `SKU` varchar(20) NOT NULL, "
		sql = sql + "  `SaleDateTime` varchar(25) NOT NULL, "
		sql = sql + "  `Quantity` int(11) NOT NULL, "
		sql = sql + "  PRIMARY KEY (`CPID`)"
		sql = sql + ");"
		
		 mysqlconnection.query(sql, function (err) {
      		if (err) throw "Problem creating the Table:- " + err.code;	
      		console.log("Table created"); 	
			process.exit();
});
