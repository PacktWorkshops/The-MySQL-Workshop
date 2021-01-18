var mysqlconnection = require("./mysqlconnection.js");

var sql = "INSERT INTO motdatabase.customerpurchases (`CustID`,`SKU`,`SaleDateTime`,`Quantity`) VALUES ?";

var record = [ 
				[1,'SKU001','01-JAN-2020 09:10am',3],
				[1,'SKU002','01-JAN-2020 09:12am',2], 
				[2,'SKU001','01-JAN-2020 09:10am',3],
				[3,'SKU002','02-JAN-2020 10:12am',2], 
				[3,'SKU004','02-FEB-2020 11:10am',3],
				[4,'SKU003','02-FEB-2020 09:32am',2], 
				[4,'SKU004','05-FEB-2020 08:00am',3],
				[4,'SKU003','10-MAR-2020 12:12am',2], 
				[1,'SKU001','11-MAR-2020 14:41am',3],
				[1,'SKU001','12-MAR-2020 16:12am',2] 
			];

  	mysqlconnection.query(sql, [record], function (err, result) {
    if (err) throw "Problem inserting the data" + err.code;
    console.log(result);
    console.log("Number of rows affected : " + result.affectedRows);
    console.log("New records ID : " + result.insertId);  
	process.exit();
});
