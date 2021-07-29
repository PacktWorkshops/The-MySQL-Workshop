var mysqlconnection = require("./mysqlconnection.js");


mysqlconnection.query("USE CustomerDatabase", function (err, result) {
    if (err) throw err.code;
    console.log(result); 
});
var record = [['Big Company'],['Little Company'],['Old Company'],['New Company']];

var sql = "INSERT INTO customers(CustomerName) VALUES ?;"

mysqlconnection.query(sql, [record], function (err, result) {
    if (err) throw "Problem creating database" + err.code;
    console.log(result);
});

record = [ 
				[1,'SKU001','01-JAN-2020 09:10am',3],
				[2,'SKU001','01-JAN-2020 09:10am',2],
				[3,'SKU002','02-FEB-2020 09:15am',5], 
				[4,'SKU003','05-MAY-2020 12:21pm',10], 
			];
var sql = "INSERT INTO CustomerPurchases(CustID,SKU,SalesDateTime,Quantity) VALUES ?;"

mysqlconnection.query(sql, [record], function (err, result) {
    if (err) throw "Problem creating database" + err.code;
    console.log(result);
	process.exit();
});
