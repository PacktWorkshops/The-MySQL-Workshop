//Verified
var mysqlconnection = require("./mysqlconnection.js");

mysqlconnection.query("CREATE DATABASE `MOTdatabase`", 
  function (err) {
    if (err) throw "Problem creating the database:- " + 
      err.code;
    console.log("Database created");
    process.exit();
});
