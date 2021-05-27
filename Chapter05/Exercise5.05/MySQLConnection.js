//This is the final incarnation of the mysqlconnection script
//it is now a module that can be reused.
//By setting this connection script up as a module, you only need to
//put the connection details in here and NOT in other scripts
//If the details change in the future, you only need to change them here, once, all other scripts
//using the module will still connect, so much easier for maintenance


//Include the sql2 module so we can connect to the database server
var mysql = require('mysql');

//Create the connection
var mysqlconnection = mysql.createConnection({
host: "<Server IP Address>",	
port: "3306",	//This will usually be 3306 but can be changed on the server or if the server is on the internet
user: "<UserName>",
password: "<Password>"
});


//Start the Connection Block
//Make the connection, include error checking
mysqlconnection.connect(function(err) {	

  //Test for an error and provide a suitable message and the code if one occurs
  if (err){
    throw err;			  
  }else{
  //No error so report to the console that connection was successful
 //This can be omitted
    console.log("Connected to MySQL!"); 	
  }
process.exit();  
  
  //Close off the connection blocks bracketing
});

//End the Connection Block

