
var sqlite3 = require('sqlite3');
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

const transformation1_dblp = fs.readFileSync('./models/dblp/1-Transformations-200117.sql').toString().split(";"); // trennt Array bei ; 

for(p in transformation1_dblp){       
    transformation1_dblp[p] = transformation1_dblp[p].toString().replace(/,/gm,"");
    console.log('=========================='+transformation1_dblp[p]+'================'+'\n')
        if(!transformation1_dblp[p] || 0 === transformation1_dblp[p].length){
        console.log('-------empty---------')
        }
}


let counter = 1;
  con.connect(async function(err) {
    if (err) throw err;
    for (i = 0; i < transformation1_dblp.length; i++) {
        
        const query = await con.query(transformation1_dblp[i],  (err, result) => {
            if (err){
                 console.log(err)
                 return
            }else{
                console.log('Erfolgreiche query: '+ counter);
                counter++
            }
        });
    }
    con.end();
    
  });
  
   