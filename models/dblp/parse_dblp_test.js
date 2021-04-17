
console.log('parser skript');
let startbool = true;


while(startbool == true){
  'use strict';
  var fs = require('fs');
  var sax = require("sax"),
  strict = true, // set to false for html-mode
  parser = sax.parser(strict);
  var scrape = require('./scrape');
  
  var saxStream = require("sax").createStream()
  
  // file stream to store fulltext URLs
  var fstreamURL = fs.createWriteStream("data/dblp/fulltext-links.txt", {flags:'w'});
  fstreamURL.close();
  fstreamURL = fs.createWriteStream("data/dblp/fulltext-links.txt", {flags:'a'});
  
  // --- SETUP ------------------------------------------

  //read data input
/*   var inputMetaTag = '';
  var inputAttr1= '';
  var inputAttr2= '';
  var inputAttr3= '';
  function readinginput(){
    fs.readFile('data/dblp/input_dblp.txt', (err, data) => {
      if (err) throw err;
      let inputP2 = JSON.parse(data);

      var hasMetaTag = false;
      var has1Attr= false;
      var has2Attr= false;
      var has3Attr= false;
      
      if(inputP2.metatag !== ''){
        hasMetaTag = true;
      }
      if(inputP2.attr1 !== ''){
        has1Attr = true;
      }
      if(inputP2.attr2 !== ''){
        has2Attr = true;
      }
      if(inputP2.attr3 !== ''){
        has3Attr = true;
      }

      if(hasMetaTag && has1Attr){
        inputMetaTag = inputP2.metatag;
        inputAttr1 = inputP2.attr1;
      }else if(hasMetaTag && has2Attr){
        inputMetaTag = inputP2.metatag;
        inputAttr1 = inputP2.attr1;
        inputAttr2 = inputP2.attr2;
      }else if(hasMetaTag && has2Attr){
        inputMetaTag = inputP2.metatag;
        inputAttr1 = inputP2.attr1;
        inputAttr2 = inputP2.attr2;
        inputAttr3 = inputP2.attr3;
      }else{
        console.log('something went wrong with the input reading!')
      }
      console.log(inputMetaTag+''+inputAttr1+''+inputAttr2+''+inputAttr3);
    });
  }
  readinginput(); */

  
  // select the tags and entries to parse (note: the tag must occur once and only once, e.g. the "author" tag cannot be used here)
  const selectorArticle = { tag: "JOURNAL", entries: ["IJISMD"] };
  const selectorConfere = { tag: "BOOKTITLE", entries: [] };
  
  // tag names
  const urlTag = "EE";
  const titleTag = "TITLE";
  const yearTag = "YEAR";
  const authorTag = "AUTHOR";
  const doiTag = "DOI";
  const idTag = "ID";
  
  // define types of entries with their tags
  const typeArticle = { entryTag: "ARTICLE", selector: selectorArticle, tags: ["JOURNAL", "VOLUME", "NUMBER", titleTag, yearTag, authorTag, urlTag] };
  
  const typeInproceedings = { entryTag: "INPROCEEDINGS", selector: selectorConfere, tags: ["BOOKTITLE", titleTag, yearTag, authorTag, urlTag] };//this could be you!
  const typeIncollection = { entryTag: "INCOLLECTION", selector: {}, tags: [titleTag, yearTag, authorTag, urlTag] };
  
  // parse these types of entries
  const enabledTypes = [typeArticle, typeInproceedings];
  
  // --- SCRIPT ------------------------------------------
  
  // store the tags currently parsed
  var parsingActiveType = false;
  var parsingActiveTag = false;
  var parsingActiveData = false;
  
  // count entries
  var cntEntriesSelected = 0;
  var cntEntriesRetrieved = 0;
  var cntEntriesSelectedNoUrl = 0;
  var cntEntriesAll = 0;
  
  // resulting collection
  var collection = [];
  
  //fs.createReadStream("dblp-testdata-models.xml").pipe(saxStream)
  fs.createReadStream("data/dblp/dblp-all.xml").pipe(saxStream)
  
  
  // --- SAX Event Handling --------------------------------
  
  saxStream.on("error", function (e) {
    // unhandled errors will throw, since this is a proper node
    // event emitter.
    console.error("error!", e)
    // clear the error
    this._parser.error = null
    this._parser.resume()
  })
  
  saxStream.on("opentag", function (node) {
    var nodeName = node.name.toUpperCase();
  
    if (parsingActiveType) {
      parsingActiveType.tags.forEach(tag => {
        if (nodeName === tag) {
          parsingActiveTag = nodeName;
        }
      });
    }
  
    enabledTypes.forEach(entryType => {
      if (nodeName === entryType.entryTag) {
        parsingActiveType = entryType;
        parsingActiveData = {};
      }
    });
  
  });
  saxStream.on("closetag", function (node) {
    var nodeName = node.toUpperCase();
  
    // active tag closed
    if (parsingActiveTag && parsingActiveTag === nodeName) {
      parsingActiveTag = false;
    }
  
    // active tag of an entry type closed
    if (parsingActiveType && parsingActiveType.entryTag === nodeName) {
  
      cntEntriesAll++;
      parsingActiveData[idTag] = cntEntriesAll;
  
      if (cntEntriesAll%1000 == 0) {
        process.stdout.write(cntEntriesAll + " ".repeat(115) + "\r");
      }
      
      // get the selector tag and check if it exists
      var selectorTag = parsingActiveType.selector.tag;
      if (typeof parsingActiveData[selectorTag] != 'undefined') {
  
        // check entries of the selector
        parsingActiveType.selector.entries.forEach(selectorEntry => {
  
          // if the selected entry is found and a DOI is known, start scraping
          if (selectorEntry.toUpperCase() === parsingActiveData[selectorTag].toUpperCase()) {
  
            cntEntriesSelected++;
  
            var id = parsingActiveData[idTag];
            var doi = parsingActiveData[doiTag];
            var url = parsingActiveData[urlTag];
            if (typeof doi === 'undefined') {
              doi = "";
            } else {
              url = "https://doi.org/" + doi;
            }
  
            if (typeof url === 'undefined') {
              cntEntriesSelectedNoUrl++;
            }
  
            process.stdout.write(doi + " " + url + "\n");
            process.stdout.write("\r" + " ".repeat(115) + "#" + id + "\r");
  
            scrape.getAuthors(doi, id, url, parsingActiveData, function (result, parsingActiveDataEntry) {
              if (typeof result.authors != 'undefined') {
                // replace authors
                parsingActiveDataEntry[authorTag] = result.authors;
                // store fulltext URL
                fstreamURL.write("ID " + id + "\n");
                fstreamURL.write("DOI " + doi + "\n");
                fstreamURL.write(result.url1 + "\n");
                fstreamURL.write(result.url2 + "\n");
                // count
                cntEntriesRetrieved++;
              }
              collection.push(parsingActiveDataEntry);
            });
          }
        });
      }
      parsingActiveType = false;
    }
  
  });
  
  saxStream.on("text", function (data) {
  
    // continue only when parsing an active tag
    if (!parsingActiveTag) {
      return;
    }
  
    if (parsingActiveTag === authorTag) {
  
      // insert authors into array
      var author = new Object();
      author.name = data;
      if (typeof parsingActiveData[parsingActiveTag] != 'undefined') {
        parsingActiveData[parsingActiveTag].push(author);
      } else {
        parsingActiveData[parsingActiveTag] = [];
        parsingActiveData[parsingActiveTag].push(author);
      }
  
    } else if (parsingActiveTag === urlTag) {
  
      parsingActiveData[parsingActiveTag] = data;
  
      // parse DOI and store separately
      var dois = data.match(/(10\.....+)/g);
      if (dois != null && dois.length > 0) {
        parsingActiveData[doiTag] = dois[0];
      }
  
    } else {
  
      parsingActiveData[parsingActiveTag] = data;
  
    }
  
  });
  
  saxStream.on("end", function () {
  
    fstreamURL.end();
  
    console.log(" ".repeat(120));
    console.log();
    console.log('Done');
    console.log();
  
    fs.writeFile('data/dblp/collection_modeling.json', JSON.stringify(collection, null, 2), function (error, file) {
      if (error) throw error;
      console.log('Saved');
    });
  
    console.log("Entries found:       " + cntEntriesAll);
    console.log("Entries selected:    " + cntEntriesSelected);
    console.log("Entries retrieved:   " + cntEntriesRetrieved);
    console.log("Entries without URL: " + cntEntriesSelectedNoUrl);
    
    console.log();
    console.log("Ignored country entries extracted from the affiliation not matching the known country list:");
  
    Object.keys(scrape.getCountryList()).forEach(element => {
      console.log(element);
    });
  
    console.log();
    console.log();
  });
  


  startbool = false;
}
