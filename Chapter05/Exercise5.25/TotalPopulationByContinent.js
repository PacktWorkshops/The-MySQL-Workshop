//This script will extract some data, format it and put it to the browser when we get a request

//Include modules for http and mysqlconnection
var http = require('http');
var mysqlconnection = require("./mysqlconnection.js");
var numeral = require('numeral');

//We want to use the world_statistics database
mysqlconnection.query("USE world_statistics");

//Prepare variables
    var FilterYear = "";   //Our filter for year
    var string = "";       //To build our output into
    var banner = "";       //Page banner
    var headings = "";     //Column headings
    var temp = "";         //for building output banner
    var sql = "";          //For the SQL statement
    var tablestyle = "";   //styling for the table


//Build the SQL statement to extract the data
var sql = "SELECT "
sql = sql + "  continents.Continent AS Continent_Region, "
sql = sql + "  Sum(countrypopulation.StatisticValue) AS `Total_Population`, "
sql = sql + "  countrypopulation.Year, "
sql = sql + "  Count(country.CountryID) AS `Total_Countries` "
sql = sql + "FROM "
sql = sql + "  continents "
sql = sql + "  INNER JOIN country ON country.ContinentID = continents.ContinentID "
sql = sql + "  INNER JOIN countrypopulation ON countrypopulation.`Country Code` = country.`Country Code` "
sql = sql + "WHERE "
sql = sql + "  countrypopulation.Year = ? " // ? so we can change the year easily
sql = sql + "GROUP BY "
sql = sql + "  continents.Continent, "
sql = sql + "  countrypopulation.Year "
sql = sql + "ORDER BY "
sql = sql + "  `Total_Population` DESC ";

//Create the server to listen for requests
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});

//Prepare the variable values
FilterYear = 2011; 
banner = "Continent Population " + FilterYear;
headings = "<th>Continent_Region</th><th>Total Population</th><th>Total Countries</th>";

  //When a request is received, run the SQL with the filters
  //Check for errors, values returned go into the object named result
  mysqlconnection.query(sql, FilterYear, function (err, result) {
    if (err) throw err;

//Now we have to prepare the data, make it look good for output
//To line everything up we are going to put it into a table
//It will all come together in the end

//NEW COMMAND: for each record in result, put the record in the object named Statistics
		result.forEach(function(Statistics){

      //Now the fun begins, format the output to make it look cool
      //We are going to build up the variable named string with each record
      //wrap each record in Table Row tags and each data point in table cell tags
      //wrap each data point in html code to format its size and color

      string = string + "<tr>" //Start table row

        //add the Continent
  			string = string + "<th><font size='3' color='blue'>" + Statistics.Continent_Region + "</font></th>"
        
        //add the Population Total
  	  	string = string + "<th><font size='3' color='black'>" + numeral(Statistics.Total_Population).format('0.00a') + "</font></th>" 

        //add the Total_Countries
  			string = string + "<th><font size='3' color='green'>" + Statistics.Total_Countries + "</font></th>"

      string = string + "</tr>" //End table row

      //From here, it will loop around to the next record until there are no more records
      //Building a new row on each loop
		});

    tablestyle = "<style>table, th, td {border: 1px solid black;}</style>"

    //Now we build the banner and headings into the variable temp 
    temp = "<font size='5' color='red'>" + banner + " </font></br>"
    temp = temp + "<table style='width:30%'>"
    temp = temp + "<tr>" + headings + "</tr>"
    
    //now we join them together
		string = tablestyle + temp  + string + "</table>";

    //And sent the lot back in response to the request
		res.end(string);

    //Bracketing for the SQL statement
	});

//Bracketing for the create server, tell it to listen on port 82
}).listen(82); 

//Now we wait, when a response is received, the code will run, extract the data, build the output and send it
