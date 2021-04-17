var fs = require('fs');

var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "dblp",
  port: "3306"
});

var sql_create_tables = fs.readFileSync("./util/create_tables.sql", "utf-8");


con.connect(function (err) { if (err) throw err; });

con.query(sql_create_tables, function (err, result) {
  if (err) throw err;
  console.log("Tables created");
});

var sql_insert = fs.readFileSync("./util/insert.sql", "utf-8");



var content;

content = JSON.parse(fs.readFileSync("./data/collection_modeling.json", 'utf-8'));
var i = 0;
for (p of content) {
  if (!Array.isArray(p.AUTHOR)) {

    storeValues(p, p.AUTHOR);

  } 
  else {
    for (a of p.AUTHOR) {

      storeValues(p, a);

    }
    /** console.log(p.TITLE);
    console.log(p.YEAR);
    console.log(p.VOLUME);
    console.log(p.JOURNAL);  
    console.log(p.BOOKTITLE);      
    console.log(p.NUMBER);
    console.log(p.EE);
    console.log(p.DOI);
    **/
  }
}

con.end();


function storeValues(entry, author) {

  var values = new Array();
  values.push(entry.DOI);
  values.push(entry.EE);
  values.push(entry.TITLE);

  if (typeof entry.YEAR !== "undefined") {
    values.push(Number(entry.YEAR));
  }
  else {
    values.push(entry.YEAR);
  }

  if (typeof entry.JOURNAL !== "undefined") {
    values.push(entry.JOURNAL);
  }
  else if (typeof entry.BOOKTITLE !== "undefined") {
    values.push(entry.BOOKTITLE);
  }
  else {
    values.push(null);
  }
  if (typeof entry.VOLUME !== "undefined") {
    values.push(Number(entry.VOLUME));
  }
  else {
    values.push(entry.VOLUME);
  }
  if (typeof entry.NUMBER !== "undefined" && !isNaN(entry.NUMBER)) {
    values.push(Number(entry.NUMBER));
  }
  else {
    values.push(null);
  }

  if (typeof author == 'undefined') {
    values.push(null);
    values.push(null);
    values.push(null);
    values.push(null);
    values.push(null);
  }
  else {
    values.push(author.name);
    values.push(author.institution);
    values.push(author.institution_department);
    values.push(author.institution_city);
    values.push(author.institution_country);
  }
  // console.log([values]);

  con.query(sql_insert, [values], function (err, result) {
    if (err) {
      console.log(err);
      //console.log([values]);
      process.exit(1);
    };
    console.log("Inserted rows: " + i++);
  });

}
