//Include modules
var fs = require('fs');     //File System
var http = require('http'); //http 

//Create a file and assign it to stream
var stream = fs.createWriteStream("Quarter 3 Sales Report.txt");

//Write data to the file
  stream.write("The Web server is monitoring port 82\n");
  stream.write(Date.now() + "\n\n");
  stream.write("Quarter 3 Sales Report  \n");
  stream.write("----------------------  \n");
  stream.write("Month     - Units Sold  \n");
  stream.write("----------------------  \n");
  stream.write("July      - 1000 \n");
  stream.write("August    - 2000\n");
  stream.write("September - 3000 \n");

  //Close the file
  stream.end();

//Write a message to the console
console.log("Web server is monitoring port 82");


//Create the server to monitor port 82
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});

  //Send the response when a request is received
  res.end('Quarter 3 Sales Report file has been generated - ' + Date.now());

  //Closes off the bracketing for the server, instruct to listen on port 82
}).listen(82);
