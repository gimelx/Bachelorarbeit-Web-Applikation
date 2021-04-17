
const fs = require('fs');
const path = require('path');

exports.getp1 = (req, res, next) => {
  res.render('p1', {
  pageTitle: 'page1',
  path: '/',
    
  });
};

// p2 adding dummy input
exports.postAddTags = (req, res, next) => {
  /* const name = req.body.name;
  const id = req.body.id;
  const isXML = req.body.isXML;
  
  const input = new DataInput(name, id, isXML);
  input.save(); */
  res.redirect('/');
};

exports.postp1_data = (req, res, next) => {
  res.redirect('/p2_add_tags');

};
exports.postp1_todblp = (req, res, next) => {
  res.redirect('/p2_dataselection_dblp');

};



exports.getp2 = (req, res, next) => {
  res.render('p2_add_tags', {
    pageTitle: 'page2',
    path: '/p2_add_tags',
  });
};

exports.post_generalTags = (req,res,next) => {
  var testinput = req.body
  console.log(testinput);
  var jsonresult = JSON.stringify(req.body); // fügt \ ein
  console.log(jsonresult);


  fs.writeFile('data/general/input_general.txt', jsonresult, function (err) {
    if (err) return console.log(err);
    console.log('file saved');
  });  
  res.redirect('/p2_add_tags');
}

exports.p2_start_general = (req, res, next) => {
  const general = require('../models/general/generalscraping');
  res.redirect('/p3_general_result');
     
};

exports.p2PostTags = (req, res, next) => {
  var testinput = req.body
  console.log(testinput);
  var jsonresult = JSON.stringify(req.body);
  console.log(jsonresult);


  fs.writeFile('data/input_dblp.txt', jsonresult, function (err) {
    if (err) return console.log(err);
    console.log('file saved');
  });
  res.redirect('/p2_dataselection_dblp');
};

exports.p2_start_dblp = (req, res, next) => {
  const dblpScraper = require('../models/dblp/parse_dblp_test');  
  res.redirect('/p3_result_dblp');
};
  

exports.getp2dblp = (req, res, next) => {  
  res.render('p2_dataselection_dblp', {
    pageTitle: 'page2_dblp',
    path: '/p2_dataselection_dblp',
  });

};

exports.getp3dblp = (req, res, next) => { 
  res.render('p3_result_dblp', {
    pageTitle: 'p3_dblp',
    path: '/p3_result_dblp',
  });
};
exports.getp3general = (req, res, next) => {
    res.render('p3_general_result', {
    pageTitle: 'p3_general_result',
    path: '/p3_general_result',
  });
};

exports.p3_downloadJsonFile =  (req, res, next) => {
  
  const filepath = path.join('data/dblp','collection_modeling.json');
  var file = fs.readFile(filepath,(err, data)=>{
    if(err){
      console.log(err);
    }
    res.send(data);
  });
  /* res.download(file); */
  };
  exports.p3_downloadJsonFile_general =  (req, res, next) => {
  
    const filepath = path.join('data/general','generalscraper.json');
    var file = fs.readFile(filepath,(err, data)=>{
      if(err){
        console.log(err);
      }
      res.send(data);
    });
  };


exports.postp2top3_dblp = (req, res, next) => {
  res.redirect('/p3_result_dblp')
};

exports.getp4_load_dblp = (req, res, next) => {
  res.render('p4_load_dblp', {
    pageTitle: 'p4_load',
    path: '/p4_load_dblp',
  });
};

exports.p4_general_load = (req, res, next) => {
  res.render('p4_general_load', {
    pageTitle: 'p4_general_load',
    path: '/p4_general_load',
  });
};

exports.p4_post_general_load =(req, res, next) => {
  const loader = require('../models/general/general_load_sql')
};

exports.p4_post_dblp_load =(req, res, next) => {
  const dblplaod = require('../models/dblp/dblp_load_mysql.js')
};

exports.postp3_p4_dblp = (req, res, next) => {
  res.redirect('/p4_load_dblp')
};

exports.postp3_general_result = (req, res, next) => {
  res.redirect('/p4_load_dblp')
};

exports.p4_load_general_table = (req, res, next) => { 
  const loader_general = require("../models/general/general_load_sql.js");
  res.redirect('/p4_general_load');
  };

exports.p4_create_general_input = (req, res, next) => { 
  var result = JSON.stringify(req.body);
  fs.writeFile('data/general/input_create_table_general.txt', result, function (err) {
    if (err) return console.log(err);
    console.log('file saved');
  });

  res.redirect('/p4_general_load');
};


exports.getp5_transformation_dblp = (req, res, next) => {
  res.render('transformations_dblp', {
    pageTitle: 'transformations_dblp',
    path: '/transformations_dblp',
  });
};

exports.p5_post_trans1 =(req, res, next) => {
  const dblplaod = require('../models/dblp/transformation1_dblp.js')
};

exports.p5_post_trans2 =(req, res, next) => {
  const dblplaod2 = require('../models/dblp/transformation2_dblp.js')
};

exports.p5_post_query =(req, res, next) => {
  const dblpquery = require('../models/dblp/queries.js')
};

exports.p5_personal_Query = (req, res, next) => { 
  var result = JSON.stringify(req.body);
  fs.writeFile('data/dblp/input_query.txt', result, function (err) {
    if (err) return console.log(err);
    console.log('file saved');
  });
  res.redirect('/transformations_dblp');
};

exports.p5_exe_personal_query = (req, res, next) => { 
const loader_query = require("../models/dblp/personal_query_dblp");
res.redirect('/transformations_dblp');
};
