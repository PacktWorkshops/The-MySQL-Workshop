//2.	Include the mysqlconnection module and instruct the database to use the world_statistics database
var mysqlconnection = require("./mysqlconnection.js");
mysqlconnection.query("USE motdatabase");


//4.	Build the SQL to extract the data we want and put it in a variable named sql:
var sql = ""
	sql = sql + "SELECT "
	sql = sql + "  customers.CustomerName, "
	sql = sql + "  customerpurchases.SaleDateTime, "
	sql = sql + "  customerpurchases.SKU, "
	sql = sql + "  customerpurchases.Quantity "
	sql = sql + "FROM "
	sql = sql + "  customers "
	sql = sql + "  INNER JOIN customerpurchases ON customerpurchases.CustID = customers.CustID "
	sql = sql + "ORDER BY "
	sql = sql + "  customers.CustomerName, "
	sql = sql + "  customerpurchases.SaleDateTime, "
	sql = sql + "  customerpurchases.SKU, "
	sql = sql + "  customerpurchases.Quantity"


//5.	Execute the SQL and put the records into the customers object. Add error handling:
    mysqlconnection.query(sql, function (err, countries) {
    if (err) throw err;


//6.	Prepare a variable to put our output into and initialize it. Also, build a proper date format for the report:    
      var lineout=""
      var d = new Date();	//Assign Date() to variable d
      var day = d.getDate();	//Using d, get the day part of todays date
      var month = d.getMonth()+1;   //Get the month part, Note: Month is 0 to 11? We need to add one to it 
      var year = d.getFullYear();	//Get the 4 digit year


//7.	Put all the date parts together into a properDate format:
      var properDate = day + "/" + month + "/" + year;


//8.	Start building the output line. Start by adding the date, the report title, and a separator line:
      //lineout = lineout + properDate + "\n\n";
      lineout = lineout + "Customer Purchases" + " " + properDate + "\n";
      lineout = lineout + "--------------------------------------------------------------------------------------------------\n";


//9.	Add the column headings and another separator line:
      lineout = lineout + "Customer,Date_Time,SKU, Quantity\n";
      lineout = lineout + "--------------------------------------------------------------------------------------------------\n";


//10.	To add the Excel formula, keep track of the lines. The first record will land in row seven in Excel. We know this by how many rows we have used in the headers, so we start our counters from seven. Put an "x" in lastcustomer for our initial test for a customer change in records:

var customerstartrow = 5; //Where the first customer record lands
var linecount = 5;
var lastcustomer = "x"; //So we can keep track of the customer changes


//11.	Loop through each of the records returned from the SQL. Each record will go into an object named PurRecord:
      countries.forEach(function(PurRecord,index){

//12.	Now, we'll add a test on each record to see if the customer has changed. The first time it does this, it will be true because we have an "x" as the last customer. We are also logging the values as we go through so that we can track them visually:
          if (lastcustomer != PurRecord.CustomerName) {
            console.log (lastcustomer,customerstartrow,linecount);

//13.	If the customer has changed, then this code will run. Check if the last customer is "x". If it is, then we are on our first record. So, log this and immediately set the last customer to the customer in the current record. The code will then leave this test block and move on:
          if (lastcustomer == "x")  {
                  //First time through so just assign the customer
                  console.log ("customer changed First time through");
                  lastcustomer = PurRecord.CustomerName;

              }

//14.	We are still in the customer test. The execution will drop in here from the second record onward if the customers are not equal. Log the change in customer:
    else if (lastcustomer != PurRecord.CustomerName) {
                  //Not first time through
                  //customer has changed, do a totals line for the customer in Excel
                  console.log ("customer changed add total line");

//15.	Add a comma to position the message in the second column, which includes the total population message, comma, and the Excel formula to calculate the total for the customer. Use the values in the variable values from our line tracking to build the formula statement. Excel considers anything starting with an equals sign to be a formula:
        lineout = lineout + ",Total Purchases for " + lastcustomer + ",,=sum(D" + customerstartrow + ":D" + (linecount) + ")\n\n\n";                     

//16.	Increment the counters. Add three linefeeds in the formula statement so that we can increment the line counter by four, which is where the next customer data will start. Update customerstartrow and assign the new customer to the lastcustomer variable. Also, close off the brackets for the test:
                  linecount=linecount + 4;
                  customerstartrow = linecount;
                  lastcustomer = PurRecord.CustomerName;
              };

//17.	This is the final part of the test. In step 12, if the customer of the current record is equal to the value in lastcustomer, then this will execute. Increment linecount and close off the test block:
              } else {
            //Increment line counter each time through
            linecount = linecount + 1

          };

//18.	Add the records' data points to lineout. 
          lineout = lineout + PurRecord.CustomerName;
          lineout = lineout + ",";
          lineout = lineout + PurRecord.SaleDateTime;
          lineout = lineout + ",";
          lineout = lineout + PurRecord.SKU;
          lineout = lineout + ",";
          lineout = lineout + PurRecord.Quantity;
          lineout = lineout + "\n";
      });

//19.	We are now out of the loop and have read through all the records, so log that we are out. The last record's customer will not be tested from the previous loop, so we need to add the Excel formula for it. This is identical to what we did in step 15.
      console.log ("Finished looping through records");
      console.log ("Add total line for last customer");
      lineout = lineout + ",Total Purchases for " + lastcustomer + ",,=sum(D" + customerstartrow + ":D" + (linecount-1) + ")\n\n\n";                     

//20.	We have finished building the output line. Now, prepare the file for output. First, include the file system module, create the file, and open it for the output:
var fs = require('fs');
var stream = fs.createWriteStream("Report_CustomerPurchases.csv");
         stream.once('open', function(fd) {

//21.	Finally, write the lineout variable to the file, close the file, exit the script, and close off the bracketing:
        stream.write(lineout);        //Write the linout variable to the file
        stream.end();                 //and close it, we are done
        process.exit();               //Exit the script
                   });  
});
