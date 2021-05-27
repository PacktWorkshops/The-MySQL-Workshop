//Verified
//This script uses the mysqlconnection as a module so does not require the connection details 
//for the database, these are included when the module is required

//Bring in the mysqlconnection module, sure save time...
//and if the server or user account changes later, no need to worry about it here
//as long asthey are updated in the mysqlconnection.js module
var mysqlconnection = require("../mysqlconnection.js");

//You can issue commands to the server via an SQL statement
//Here we are issuing a server command to create a new database
//We are including error checking
mysqlconnection.query("CREATE DATABASE `world_statistics`", 
  function (err) {

    //If there was and error, tell the user, along with the error code
    if (err) throw "Problem creating the database:- " + 
      err.code;

    //No error, tell user the database was created		
    console.log("Database created"); 

    //And leave the script
    process.exit();										  	

//Closing off the bracketing
});	           
