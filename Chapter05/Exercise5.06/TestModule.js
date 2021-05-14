var mysqlconnection = require("./mysqlconnection.js");

mysqlconnection.query("SELECT Count(*) AS CountryCount FROM	backuppractice.country;", function (err, SQLresult) {

if (err) throw "Problem counting Countries:- " + err.code;
console.log("Country count :- " + SQLresult[0].CountryCount);
process.exit();
});