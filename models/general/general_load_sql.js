//https://www.sitepoint.com/using-node-mysql-javascript-client/ -->helping website

var fs = require('fs');

var mysql = require('mysql');
//const create = require('../models/general_create_tables.sql')

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "general-scraping",
  port: "3306"
});



  const creat_table_general_input = fs.readFileSync('./data/general/input_create_table_general.txt').toString();

  // cleaning 
  var sqlstring = creat_table_general_input.toString().replace('"create-general":','');
  var cleaing = sqlstring.replace("{",'');
  cleaing = sqlstring.replace("}",'');
  var temp = cleaing.replace("{",'');
  var temp2 = temp.replace(/.r.n.t/gm,' ')
  var temp3 = temp2.replace(/.r.n/gm,' ')
  var lastcleaning = temp3.replace(/"/gm,'');

  //debug
  console.log("this is going into query():  "+lastcleaning);

  con.connect(async function(err) {
    if (err) throw err;       
        const query = await con.query(lastcleaning,  (err, result) => {
            if (err){
                console.log(err)
                return
            }else{
                console.log('Erfolgreiche Query!');                
            }
        });    
  con.end();
  });


