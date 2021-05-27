//Verified 
//Outputs data to a disk file

//Include the File System module to work with disk files
var fs = require('fs');

//Creates the file into object stream and names the file
var stream = fs.createWriteStream("Log.txt");

//Output data to the file.
stream.write("Application Started Successfully!\n");	// the \n forces a new line

//Ends the stream and closes the file
stream.end(); 
