//Outputs data to a disk file

//Include the File System module to work with disk files
var fs = require('fs');

//Creates the file into object stream and names the file
var stream = fs.createWriteStream("HelloWorld.txt");

//Output data to the file.
stream.write("Hello World\n");	// the \n forces a new line
stream.write("Disk File\n");

//Ends the stream and closes the file
  stream.end();
  