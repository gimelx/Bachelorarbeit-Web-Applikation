var fs = require('fs');

var mysql = require('mysql');


var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "dblp",
  port: "3306",
  multipleStatements: true
});


const transformation1_dblp = fs.readFileSync('./data/dblp/input_query.txt').toString();

// cleaning 
var sqlstring = transformation1_dblp.toString().replace('"inputquery":','');
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


