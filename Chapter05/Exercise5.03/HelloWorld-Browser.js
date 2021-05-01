//Output the message to the browser
//Include the http module to allow output to the browser
var http = require('http');

//Create a server to monitor the port for a request 
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
	
  var result = 4+4;
  //Output the text and the date serial in response to a request
  res.end(result.toString());

  //Close off the server bracketing and instruct server to list to port 82 for requests
  }).listen(82); 
  