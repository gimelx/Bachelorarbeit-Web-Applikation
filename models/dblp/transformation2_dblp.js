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


const transformation1_dblp = fs.readFileSync('./models/dblp/2-ETL-200127-With-Fact-Table-Creation-201103.sql').toString().split(";"); // macht ';' weg !!


    for(p in transformation1_dblp){
        
        //transformation1_dblp[p] = transformation1_dblp[p].toString().replace(/,/gm,"");
        
        transformation1_dblp[p].replace(/(\r\n|\n|\r)/gm," ");
        console.log('String: '+transformation1_dblp[p]+'  index: '+p);
        
        //transformation1_dblp[p] = transformation1_dblp[p].toString().replace(/.\n/gm,"");
        //console.log('=========================='+transformation1_dblp[p]+'-->index:'+p+  '\n');
        
        
        if(!transformation1_dblp[p] === transformation1_dblp[p].length){
            console.log('-------empty---------')
        }
    }

    //console.log(transformation1_dblp[133]+'-------------------------------Problemstelle')

let counter = 1;
  con.connect(async function(err) {
    if (err) throw err;
    for (i = 0; i < transformation1_dblp.length-1; i++) { //letzes array element ist leer --> wirft Fehler
        
        const query = await con.query(transformation1_dblp[i],  (err, result) => {
            if (err){
                console.log(err)
                return
            }else{
                console.log('Erfolgreiche Query: '+ counter+'index: '+i);
                counter++
            }
        });
    }
    con.end();
    
  });



  //Einzelfall Test

  /* con.connect(async function(err) {
    if (err) throw err;
    
        
        const query = await con.query(transformation1_dblp[8],(err, result) => {
            if (err){
                 console.log(err)
                 return
            }else{
                console.log('Erfolgreiche query: '+ counter);
                counter++
            }
        });
    
    con.end();
    
  }); */
  
   