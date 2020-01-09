// WorldPopulationByCountry.js

var mysqlconnection = require("./../mysqlconnection.js");
mysqlconnection.query("USE world_statistics");


var filteryear = "2018";

var sql = ""
    sql = sql + "SELECT "
    sql = sql + "continents.Continent AS Continent_Region, "
    sql = sql + "country.`Country Name` AS Country_Name, "
    sql = sql + "countrypopulation.StatisticValue AS Country_Population, "
    sql = sql + "countrypopulation.Year "
    sql = sql + "FROM "
    sql = sql + "continents "
    sql = sql + "INNER JOIN country ON country.ContinentID = continents.ContinentID "
    sql = sql + "INNER JOIN countrypopulation ON countrypopulation.`Country Code` = country.`Country Code` "
    sql = sql + "WHERE "
    sql = sql + "countrypopulation.Year = ? "
    sql = sql + "GROUP BY "
    sql = sql + "continents.Continent, "
    sql = sql + "country.`Country Name`, "
    sql = sql + "countrypopulation.StatisticValue, "
    sql = sql + "countrypopulation.Year "
    sql = sql + "ORDER BY "
    sql = sql + "Continent_Region, "
    sql = sql + "`Country_Population` DESC ";

    mysqlconnection.query(sql,filteryear, function (err, countries) {
    if (err) throw err;

      var lineout="";
      var d = new Date();	//Assign Date() to variable d
      var day = d.getDate();	//Using d, get the day part of todays date
      var month = d.getMonth()+1;   //Get the month part, Note: Month is 0 to 11? We need to add one to it 
      var year = d.getFullYear();	//Get the 4 digit year

      var properDate = day + "/" + month + "/" + year;

      lineout = lineout + properDate + "\n\n";
      lineout = lineout + "World Population - Continent Alphabetical, Country by Population Descending\n";
      lineout = lineout + "--------------------------------------------------------------------------------------------------\n";

      lineout = lineout + "Continent Region,Country,Population\n";
      lineout = lineout + "--------------------------------------------------------------------------------------------------\n";

var continentstartrow = 7; //Where the first continent record lands on
var linecount = 7;
var lastcontinent = "x"; //So we can keep track of the continent changes

      countries.forEach(function(PopRecord,index){

      		                if (lastcontinent != PopRecord.Continent_Region) {
            console.log (lastcontinent,continentstartrow,linecount);

          if (lastcontinent == "x")  {
                  //First time through so just assign the continent
                  console.log ("Continent changed First time through");
                  lastcontinent = PopRecord.Continent_Region;

              }

    else if (lastcontinent != PopRecord.Continent_Region) {
                  //Not first time through
                  //Continent has changed, do a totals line for the continent in Excel
                  console.log ("Continent changed add total line");


        lineout = lineout + ",Total Population for " + lastcontinent + ",=sum(C" + continentstartrow + ":C" + (linecount) + ")\n\n\n";                     

                          linecount=linecount + 4;
                  continentstartrow = linecount;
                  lastcontinent = PopRecord.Continent_Region;
              };


              } else {
            //Increment line counter each time through
            linecount = linecount + 1

          };

          lineout = lineout + PopRecord.Continent_Region;
          lineout = lineout + ",";
          lineout = lineout +  '"' + PopRecord.Country_Name + '"';
          lineout = lineout + ",";
          lineout = lineout + PopRecord.Country_Population;
          lineout = lineout + "\n";
      });

      console.log ("Finished looping through records");
      console.log ("Add total line for last continent");
      lineout = lineout + ",Total Population for " + lastcontinent + ",=sum(C" + continentstartrow + ":C" + (linecount-1) + ")\n\n\n";                     

var fs = require('fs');

var stream = fs.createWriteStream("WorldPopulationByCountry.csv");

         stream.once('open', function(fd) {

        stream.write(lineout);        //Write the linout variable to the file
        stream.end();                 //and close it, we are done
        process.exit();               //Exit the script

    });  

});
