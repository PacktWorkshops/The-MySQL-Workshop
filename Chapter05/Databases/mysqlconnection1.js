//This is the final incarnation of the mysqlconnection script
//it is now a module that can be reused.
//By setting this connection script up as a module, you only need to
//put the connection details in here and NOT in other scripts
//If the details change in the future, you only need to change them here, once, all other scripts
//using the module will still connect, so much easier for maintenance


//Include the sql2 module so we can connect to the database server
var mysql = require('mysql2');

//Create the connection
var mysqlconnection = mysql.createConnection({
host: "192.168.0.2",	
port: "3306",	//This will usually be 3306 but can be changed on the server or if the server is on the internet
user: "root",
password: ""
});


//Start the Connection Block
//Make the connection, include error checking
mysqlconnection.connect(function(err) {	

	//Test for an error and provide a suitable message and the code if one occurs
  if (err) throw "mysqlconnection.js problem connecting to MySQL, the ERROR CODE is :-" + err.code;			  

  //No error so report to the console that connection was successful
  //This can be omitted
  console.log("Connected to MySQL!"); 	
  
  
  //Close off the connection blocks bracketing
  });

//End the Connection Block

//This is the magic line, it allows the object mysqlconnection to be exported
//which means other scripts can .require(myqlconnection) and use the connection...so cool
module.exports = mysqlconnection;

//No requirement for a process.exit in this script