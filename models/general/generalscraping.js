const fs = require('fs');
const util = require('util');
const request = require('request-promise');
const cheerio = require('cheerio');
const axios = require("axios").default;
const read = util.promisify(fs.readFile);


var inputurl = '';
var inputMetaTag = '';
var inputAttr1='';
var inputAttr2= '';
var inputAttr3= '';

async function inputReader (){
    const data = await read('data/general/input_general.txt')
      let inputP2 = JSON.parse(data);    
      console.log(inputP2);  
          inputurl = inputP2.url;
          inputMetaTag = inputP2.metatag;
          inputAttr1 = inputP2.attr1;
          inputAttr2 = inputP2.attr2;
          inputAttr3 = inputP2.attr3; 

          console.log(inputurl+"\n"
          +inputAttr1);
      //console.log(inputAttr1+"----------inputreader-----Attribute 1");    
    return {
      inputurl,
      inputMetaTag,
      inputAttr1,
      inputAttr2,
      inputAttr3
  }
}
   
//Code Teile von: Leonardo Dias https://dev.to/diass_le/tutorial-web-scraping-with-nodejs-and-cheerio-2jbh

const fethHtml = async url => {
  try {
    const { data } = await axios.get(url);
    return data;
  } catch {
    console.error(`ERROR: An error occurred while trying to fetch the URL: ${url}`);
  }
};

//Userinput in find() einsetzen 
const extractDeal = selector => {
  const Attribut_1 = selector
    .find(inputAttr1)
    .text()
    .trim();

    const Attribut_2 = selector
    .find(inputAttr2)
    .text()
    .trim();

    const Attribut_3 = selector
    .find(inputAttr3)
    .text()
    .trim();
    
  return {  Attribut_1, Attribut_2, Attribut_3 };
}


const generalScrape = async () => {
  const input = await inputReader();
  // Url von User einsetzen
  const url = inputurl;

  //const input = await inputReader();
  const html = await fethHtml(url);
  
  const selector = cheerio.load(html);   

  const searchResults = selector("body")
  .find(inputMetaTag);
  
  //Items in map einlesen
  const items = searchResults
  .map((idx, el) => {
    const elementSelector = selector(el);
    return extractDeal(elementSelector);
  })
  .get();

    //Speichern des Resultates map-->JSON file
    let data = JSON.stringify(items);
    fs.writeFileSync('data/general/generalscraper.json', data+"\n");
  return items;
  
};

module.exports = generalScrape();


//debug
console.log('GENERAL FINISH');
