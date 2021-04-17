const rp = require('request-promise'), cheerio = require('cheerio'), XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest;
const fs = require('fs');
const request = require('request');

const fulltextdir = 'Fulltext';

// knwon countries are read from a file into an associative array where known countries are the key
var knownCountries = new Array();
var unknownCountries = new Array();
const knownCountriesFile = "data/dblp/countries.json";

// cookie management
//var FileCookieStore = require('tough-cookie-filestore');
//var j = request.jar(new FileCookieStore('cookies.json'));

exports.getAuthors = function (doi, id, uri, entry, callback) {

    // Returns an array of two objects for a URL 
    // First object: author with attributes name, institution, institution_department, institution_city, institution_country
    // Second object: keyword with an array of keywords of the paper
    //console.log("getSpringerAuthors, URL: " + url + " entry: " + JSON.stringify(entry));

    if (typeof uri === 'undefined') {
        console.log("Error: no URI defined for " + JSON.stringify(entry))
        callback(new Object(), entry);
        return;
    }

    var syncRequest = new XMLHttpRequest();
    syncRequest.open("GET", uri, false);
    statusOutput("Request: " + uri + " ********");
    syncRequest.send(null);

    // Follow redirects
    while (syncRequest.status === 301 || syncRequest.status === 302) {
        var redictUri = syncRequest.getResponseHeader("Location");
        if (!redictUri.startsWith("http")) {
            uri = uri.split("/")[0] + "//" + uri.split("/")[2] + redictUri;
        } else {
            uri = redictUri;
        }
        //console.log(uri);
        syncRequest = new XMLHttpRequest();
        syncRequest.open("GET", uri, false);
        statusOutput("Request: " + uri + " ********");
        syncRequest.send(null);
    }

    // Find out if this is link.springer.com, IEEE exmplore or ACM
    var html = syncRequest.responseText;

    if (syncRequest.status === 200) {

        if (/springer/i.test(uri)) {
            statusOutput("Request: " + uri + " received from Springer");
            getSpringerAuthors(html, doi, id, uri, entry, callback);
        } //else if (/ieee/i.test(uri)) {
            //statusOutput("Request: " + uri + " received from IEEE");
            //getIEEEAuthors(html, doi, id, uri, entry, callback);}
            else if (/acm/i.test(uri)) {
            statusOutput("Request: " + uri + " received from ACM");
            getACMAuthors(html, doi, id, uri, entry, callback);
        } else if (/emisa/i.test(uri)) {
            statusOutput("Request: " + uri + " received from EMISA");
            getEmisaAuthors(html, doi, id, uri, entry, callback);
        } else if (/igi/i.test(uri)) {
            statusOutput("Request: " + uri + " received from IGI");
            getIGIAuthors(html, doi, id, uri, entry, callback);
        } else if (/csimq/i.test(uri)) {
            statusOutput("Request: " + uri + " received from CSIMQ");
            getCsimqAuthors(html, doi, id, uri, entry, callback);
        } else if (/iospress/i.test(uri)) {
            statusOutput("Request: " + uri + " received from IOS");
            getScopusAuthors(html, doi, id, uri, entry, callback);
        }

    } else {
        console.log("Error: HTTP " + syncRequest.status + " DOI " + doi + " URI " + uri + " Entry: " + JSON.stringify(entry));
    }

}


function getEmisaAuthors(html, doi, id, uri, entry, callback) {
    /*
        <meta name="citation_author" content="Kurt Sandkuhl"/>
        <meta name="citation_author_institution" content="University of Rostock, Albert-Einstein-Str. 22, 18059 Rostock"/>
        <meta name="citation_author" content="Jelena Zdravkovic"/>
        <meta name="citation_author_institution" content="Stockholm University, Box 7003, Kista, 16407"/>
    */
    
    var authors = new Array();
    var keywords = new Array();
    var returnSet = new Object();

    $ = cheerio.load(html);
    var authortags = $('meta[name="citation_author"]'); 

    $(authortags).each(function (i) {
        var author = new Object();

        author.name = $(this).attr('content');
        author.institution = $(this).next('meta[name="citation_author_institution"]').attr('content');
        if (typeof author.institution != 'undefined') {
            author.institution_country = getCountryFromAffiliation(author.institution);
        }
        checkCountryExists(doi, uri, author);
        authors.push(author);
    });

    if (!doi) {
        var doiTags = $('meta[name="citation_doi"]'); 
        $(doiTags).each(function (i) {
            entry['DOI'] = $(this).attr('content');
        });
    }

    // <a class="obj_galley_link pdf" href="https://emisa-journal.org/emisa/article/view/154/112">
    var fulltextTags = $('a.pdf'); 
    $(fulltextTags).each(function (i) {
        //returnSet.url1 = uri;
        returnSet.url1 = fulltextTags.attr('href');
    });

    checkAuthorsExist(doi, uri, authors);
    returnSet.authors = authors;

    callback(returnSet, entry);
}



function getCsimqAuthors(html, doi, id, uri, entry, callback) {
    /*
        <meta name="citation_author" content="Kurt Sandkuhl"/>
        <meta name="citation_author_institution" content="University of Rostock, Albert-Einstein-Str. 22, 18059 Rostock"/>
        <meta name="citation_author" content="Jelena Zdravkovic"/>
        <meta name="citation_author_institution" content="Stockholm University, Box 7003, Kista, 16407"/>
    */
    
    var authors = new Array();
    var keywords = new Array();
    var returnSet = new Object();

    $ = cheerio.load(html);
    var authortags = $('meta[name="citation_author"]'); 

    $(authortags).each(function (i) {
        var author = new Object();

        author.name = $(this).attr('content');
        author.institution = $(this).next('meta[name="citation_author_institution"]').attr('content');
        if (typeof author.institution != 'undefined') {
            author.institution_country = getCountryFromAffiliation(author.institution);
        }
        checkCountryExists(doi, uri, author);
        authors.push(author);
    });

    if (!doi) {
        var doiTags = $('meta[name="citation_doi"]'); 
        $(doiTags).each(function (i) {
            entry['DOI'] = $(this).attr('content');
        });
    }

    var fulltextTags = $('a.file'); 
    $(fulltextTags).each(function (i) {
        //returnSet.url1 = uri;
        returnSet.url1 = fulltextTags.attr('href');
        returnSet.url1 = returnSet.url1.replace('/view/', '/download/');
    });
    // <a href="https://csimq-journals.rtu.lv/article/view/csimq.2016-6.05/818" class="file" style="border:0px;font-size:1em;" target="_parent">PDF</a>
    
    checkAuthorsExist(doi, uri, authors);
    returnSet.authors = authors;

    callback(returnSet, entry);
}

function getIGIAuthors(html, doi, id, uri, entry, callback) {

    // meta name="citation_authors" content="Babkin, Eduard; Malyzhenkov, Pavel; Ivanova, Marina; Ponomarev, Nikita" 
    /*
        <div class="bottom-space-10 font-14 affiliate-font"><span
        id="ctl00_ctl00_cphMain_cphSection_lblAffiliates" class="notranslate">Eduard Babkin
        (National Research University “Higher School of Economics,” Nizhni Novgorod, Russia), Pavel
        Malyzhenkov (National Research University “Higher School of Economics,” Nizhni Novgorod,
        Russia), Marina Ivanova (National Research University “Higher School of Economics,” Nizhni
        Novgorod, Russia) and Nikita Ponomarev (National Research University “Higher School of
        Economics,” Nizhni Novgorod, Russia)</span></div>
    */

   var authors = new Array();
   var keywords = new Array();
   var returnSet = new Object();

   $ = cheerio.load(html);

   var authortags = $('meta[name="citation_authors"]'); 

   $(authortags).each(function (i) {
       
        var authorText = $(this).attr('content');
        var authorEntries = authorText.split(";");

        authorEntries.forEach( element => {
            var author = new Object();
            var authorEntry = element.split(",");
            
            var name = "";
            for (var j = authorEntry.length - 1; j >= 0; j--) {
                if (authorEntry[j].slice(0, 1) === ' ') {
                    name += authorEntry[j].substr(1) + " ";
                } else {
                    name += authorEntry[j] + " ";
                }
            }
            author.name = name.trim();

            var affiliatesTag = $('span[id="ctl00_ctl00_cphMain_cphSection_lblAffiliates"]'); 

            $(affiliatesTag).each(function (i) {
        
                var affText = $(this).text();
                var nOpenBrances = 1;
                var insitution = "";

                // e.g.: author name (inst, dept (dept short form), country), author name 2 (inst 2, ..., country 2), ...
                while (nOpenBrances > 0) {
                    var authorInstRegex = new RegExp(author.name + "\\s?(\\\(" + ".*?\\\)".repeat(nOpenBrances) + ")");
                    var authorInst = authorInstRegex.exec(affText);
                    if (typeof authorInst !== 'undefined') {
                        if ( (authorInst || []).length > 1) {
                            // store entry without braces
                            insitution = authorInst[1].substr(1, authorInst[1].length-2);
                            author.institution = insitution;
                        }
                    }
                    var nOpenBrancesFound = (insitution.match(/\(/g) || []).length + 1;
                    if ( nOpenBrancesFound > nOpenBrances) {
                        nOpenBrances = nOpenBrancesFound;
                    } else {
                        nOpenBrances = 0;
                    }
                } 

                if (insitution) {
                    author.institution_country = getCountryFromAffiliation(author.institution);
                }
            });
            checkCountryExists(doi, uri, author);
            authors.push(author);
        });
    });

   checkAuthorsExist(doi, uri, authors);
   returnSet.authors = authors;

   callback(returnSet, entry);
}


function getScopusAuthors(html, doi, id, uri, entry, callback) {

   var returnSet = new Object();
   var authors = entry["AUTHOR"];

   /* 
    * The scopus api does not allow for
    * - dependable results for identifiers other than DOI or Scopus ID,
    * - retrieval of multiple authors (often times, authors are missing),
    * - retrieval of the relation author-association (only affiliations alone),
    * - e.g. https://api.elsevier.com/content/search/scopus?query=DOI(10.3233%2F978-1-61499-472-5-1)&apiKey=9ca20b03f9a6c27a3e53519ca5efa94c .
    * Therefore, cancel if there is no DOI of if there is more than one author.
    * Testcase: https://doi.org/10.3233/978-1-61499-834-1-263
    */

   // TODO also use in case of >= 1 by assigning the authors to the retrieved affiliations separately
   if (typeof authors !== 'undefined' && doi && authors.length == 1) {

        var scopusUrl = 'https://api.elsevier.com/content/abstract/doi/' + doi  + '?fields=affiliations&apiKey=9ca20b03f9a6c27a3e53519ca5efa94c'

        // TODO: use content api: var scopusUrl = 'https://api.elsevier.com/content/search/scopus?query=DOI(' + doi + ')&apiKey=9ca20b03f9a6c27a3e53519ca5efa94c&field=affiliation' + '?field=affiliation'
        //https://api.elsevier.com/content/search/scopus?start=0&count=25&query=DOI(10.3233%2F978-1-61499-933-1-61)&apiKey=9ca20b03f9a6c27a3e53519ca5efa94c&field=affiliation

        authors.forEach( author => {
            // make scopus abstract api query
            var syncRequest = new XMLHttpRequest();
            syncRequest.open("GET", scopusUrl, false);
            statusOutput("Request: " + scopusUrl + " ********");
            syncRequest.send(null);
            var resp = syncRequest.responseText;
            
            $ = cheerio.load(resp);
            var afftags = $('affiliation'); 

            $(afftags).each(function (i) {
                authors[0].institution = $(this).find('affilname').text();
                authors[0].institution_city = $(this).find('affiliation-city').text();
                authors[0].institution_country = $(this).find('affiliation-country').text();
            });

            // TODO: get author from scopus preview
            // var scopusURL2 = 'https://www.scopus.com/record/display.uri?eid=2-s2.0-85059548587&origin=inward&txGid=507c5bee2f3d77ac1358ba663993ad4e&apiKey=9ca20b03f9a6c27a3e53519ca5efa94c';


        });
    }

   checkAuthorsExist(doi, uri, authors);
   returnSet.authors = authors;

   callback(returnSet, entry);
}


function getSpringerAuthors(html, doi, id, uri, entry, callback) {

    //function getSpringerAuthors (doi, entry, callback) {

    // Returns an array of two objects for a DOI finally pointing to link.springer.com (2019-11-11):
    // First object: author with attributes name, institution, institution_department, institution_city, institution_country
    // Second object: keyword with an array of keywords of the paper

    var authors = new Array();
    var keywords = new Array();
    var returnSet = new Object();

    $ = cheerio.load(html);
    var authortags = $('meta[name="citation_author"]'); //use your CSS selector here
    $(authortags).each(function (i) {
        var author = new Object();
        author.name = $(this).attr('content');
        author.institution = $(this).next('meta[name="citation_author_institution"]').attr('content');
        var affiliationIndex = "";
        //console.log(authorname + " from: " + author_institution);
        $('.authors-affiliations__name').each(function (i) {
            var itemName = $(this).text().toString().replace(/\s/g, ":");
            var authName = author.name.toString().replace(/\s/g, ":");
            //console.log(itemName + " " + authName);
            if (itemName == authName) {
                affiliationIndex = $(this).next().children().first().attr('data-affiliation');
                //console.log(author.name + " " + affiliationIndex);
            }
        });
        if (affiliationIndex) {
            var selector = '.affiliation[data-test="' + affiliationIndex + '"]';
            $(selector).each(function (i) {
                var department = $(this).find('.affiliation__department').text();
                var city = $(this).find('.affiliation__city').text();
                var country = $(this).find('.affiliation__country').text();
                if (department)
                    author.institution_department = department;
                if (city)
                    author.institution_city = city;
                if (country)
                    author.institution_country = country;
                checkCountryExists(doi, uri, author);
            });
        }
        authors.push(author);
    });
    var keywordtags = $('.Keyword');
    $(keywordtags).each(function (i) {
        keywords.push($(this).text());
    });

    checkAuthorsExist(doi, uri, authors);
    returnSet.authors = authors;
    returnSet.keyword = keywords;
    //returnSet.url1 = uri;
    returnSet.url1 = 'https://link.springer.com/content/pdf/' + doi + '.pdf';

    callback(returnSet, entry);
}

// deprecated
async function downloadFile(url, id) {
    
    // NOTE: 
    // using request with promises to downlaod files causes errors due to tcp connections resets:
    // Error: read ECONNRESET
    //at TLSWrap.onStreamRead (internal/stream_base_commons.js:201:27) {
    //    errno: 'ECONNRESET',
    //    code: 'ECONNRESET',
    //    syscall: 'read'
    //  }


    //console.log(url);
    if (url.length < 1) {
        console.log("PDF-URL missing for " + id);
        return;
    }

    let fulltextfile = fulltextdir + "//" + id + ".pdf";
    try {
        var stats = fs.statSync(fulltextfile);
        if (stats["size"] > 0) {
            return;
        }
    } catch(exception) {
        // file does not exist
    }


    /* Create an empty file where we can save data */
    let file = fs.createWriteStream(fulltextfile);
    /* Using Promises so that we can use the ASYNC AWAIT syntax */        
    await new Promise((resolve, reject) => {
        let stream = request({
            /* Here you should specify the exact link to the file you are trying to download */
            uri: url,
            headers: {
                'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
                'Accept-Encoding': 'gzip, deflate, br',
                'Accept-Language': 'en-US,en;q=0.9,fr;q=0.8,ro;q=0.7,ru;q=0.6,la;q=0.5,pt;q=0.4,de;q=0.3',
                'Cache-Control': 'max-age=0',
                'Connection': 'keep-alive',
                'Upgrade-Insecure-Requests': '1',
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36'
            },
            gzip: true
            // , jar: j
        })
        .pipe(file)
        .on('finish', () => {
            console.log(`Download ${id} finished`);
            resolve();
        })
        .on('error', (error) => {
            console.log(`Download ${id} ${error}`);
            reject(error);
        })
    })
    .catch(error => {
        console.log(`Download ${id} ${error}`);
    });
}

function getACMAuthors(html, doi, id, uri, entry, callback) {

    var authors = new Array();
    var keywords = new Array();
    var returnSet = new Object();

    $ = cheerio.load(html);

    // <a id="arnd_15192902744496282_Ctrl" class="author-name" title="Lorena Arcega">    <span class="loa__author-info">   
    //   <div class="author-data">    <span class="loa__author-name">     <span><img.../>Lorena Arcega</span></span></div>
    //   <span class="loa_author_inst">  <p data-pill-inst="arnd_15192902744496282" data-doi="10.1145/contrib-99658740145">SVIT Research Group, Universidad San Jorge, Zaragoza, Spain, Department of Informatics, University of Oslo, Oslo, Norway </p>

    // <a name="FullTextPDF" title="FullText PDF" href="ft_gateway.cfm?id=3109734&amp;ftid=1902619&amp;dwn=1&amp;CFID=178795549&amp;CFTOKEN=90909afbfc5d4a64-FE850254-AF36-23E0-F00612B30A3E2022" target="_blank"><img src="imagetypes/pdf_logo.gif" alt="PDF" class="fulltext_lnk" border="0">PDF</a>

    var authortags = $('a[title="Author Profile Page"]'); 

    $(authortags).each(function (i) {
        var author = new Object();

        author.name = $(this).text();
        author.institution = $(this).parent().next().find('small').text();
        author.institution_country = getCountryFromAffiliation(author.institution);
        checkCountryExists(doi, uri, author);
        authors.push(author);
    });

    var fulltextlink = 'https://dl.acm.org/doi/pdf/' + doi + '?download=true';
    // https://dl.acm.org/doi/pdf/10.1145/3239372.3239392?download=true

    checkAuthorsExist(doi, uri, authors);
    returnSet.authors = authors;
    returnSet.url1 = uri;
    returnSet.url1 = fulltextlink;

    callback(returnSet, entry);
}


function getIEEEAuthors(html, doi, id, uri, entry, callback) {

    var authors = new Array();
    var keywords = new Array();
    var pdfUrl = '';
    var returnSet = new Object();

    $ = cheerio.load(html);

    var scripttags = $('script');

    // TODO: request authors using API
    // http://ieeexploreapi.ieee.org/api/v1/search/articles?apikey=8mpfe9ruajjtkndj72zuqusz&format=xml&max_records=25&start_record=1&sort_order=asc&sort_field=article_number&doi=10.1109%2FMODELS.2017.34

    $(scripttags).each(function (i) {

        var script = $(this).html();

        // extract the java script code containing JSON data of authors
        var authorScript = script.match(/\"authors\":.+?\]/g);
        
        var pdfScript = script.match(/\"pdfUrl\":\".+?\"/g);
        if (pdfUrl.length < 1 && pdfScript != null && pdfScript.length > 0) {
            // remove: "pdfUrl":"..." and leave ...
            pdfUrl = pdfScript[0].substr(10, pdfScript[0].length - 11);
            pdfUrl = 'https://ieeexplore.ieee.org' + pdfUrl + '&tag=1';
        }
        // ...,"pdfUrl":"/stamp/stamp.jsp?tp=&arnumber=8101247","

        if (authorScript != null && authorScript.length > 0) {

            // remove "authors":[...] and leave [...]
            var authorsJson = authorScript[0].substr(10);

            var authorEntries = JSON.parse(authorsJson);

            authorEntries.forEach(element => {

                var author = new Object();
                author.name = element.name;
                author.institution = element.affiliation;
                author.institution_country = getCountryFromAffiliation(author.institution);
                checkCountryExists(doi, uri, author);
                authors.push(author);
            });
        }
    });
    checkAuthorsExist(doi, uri, authors);
    returnSet.authors = authors;
    returnSet.url1 = uri;
    returnSet.url2 = pdfUrl;

    callback(returnSet, entry);
}

// returns true if the authors array contains entries; if not, false is returned and a warnig is printed
function checkAuthorsExist(doi, uri, authorsArray) {
    if (typeof authorsArray == 'undefined' || authorsArray.length == 0) {
        var id = (!doi) ? uri : doi;
        warningOutput("Warning: author missing for " + id);
        return false;
    } else {
        return true;
    }
}

// returns true if the country in an author object exists; if not, false is returned and a warning is printed
function checkCountryExists(doi, uri, authorObject) {
    if (typeof authorObject == 'undefined' || 
        typeof authorObject.institution_country == 'undefined' || 
        authorObject.institution_country.length == 0) {    
        var id = (!doi) ? uri : doi;
        warningOutput("Warning: country missing for " +  id + ", " + authorObject.name);
        return false;
    } else {
        return true;
    }
}

// returns the last value from a comma-separated affiliation, usually the country)
// if no comma is found, an empty string is returned
function getCountryFromAffiliation(affiliation) {

    // read the list of known countries if it is not present
    if (Object.keys(knownCountries).length < 1) {
        var data = fs.readFileSync(knownCountriesFile,'utf8');
        var countriesJson = JSON.parse(data);
        countriesJson.forEach( element => {
            var country = element.toUpperCase();
            knownCountries[country] = 1;
        });
    }

    // parse the last entry and check if it is a known country
    var institutionEntries = affiliation.split(",");
    if (institutionEntries != null && institutionEntries.length > 1) {
        var country = institutionEntries[institutionEntries.length - 1].trim();
        if (knownCountries[country.toUpperCase()] === undefined) {
            unknownCountries[country] = 1;
        } else {
            return country;
        }
    }
    return "";
}

// performs a sync. request, resolves redirects and returns the response text
function requestRedirSync(uri, id) {
    console.log(uri);
    if (uri.length < 1) {
        console.log("URL missing for " + id);
        return;
    }

    var statusCode = -1;
    var responseText = '';
    var syncRequest = request.defaults({ jar : j });
    statusOutput("Request: " + uri + " ********");
    syncRequest(uri, function (error, response, body) {
        console.error('error:', error); 
        if (response) {
            statusCode = response.statusCode;
            responseText = body;
        }
    });

    // Follow redirects
    while (statusCode === 301 || statusCode === 302) {
        var redictUri = syncRequest.headers['Location'];
        if (!redictUri.startsWith("http")) {
            uri = uri.split("/")[0] + "//" + uri.split("/")[2] + redictUri;
        } else {
            uri = redictUri;
        }
        
        var syncRequest = request.defaults({ jar : j });
        statusOutput("Request: " + uri + " ********");
        syncRequest(uri, function (error, response, body) {
            console.error('error:', error); 
            if (response) {
                statusCode = response.statusCode;
                responseText = body;
            }
        });
    }

    return responseText;
}

// outputs status text
function statusOutput(message) {
    var nBlanks = 115 - message.length;
    if (nBlanks < 1) {
        nBlanks = 1;
    }
    process.stdout.write("\r" + message + " ".repeat(nBlanks) + "\r");
}

// outputs status text
function warningOutput(message) {
    var nBlanks = 115 - message.length;
    if (nBlanks < 1) {
        nBlanks = 1;
    }
    console.log(message + " ".repeat(nBlanks));
}

// returns all entries assumed to be countries as keys of an associative array
exports.getCountryList = function () {
    return unknownCountries;
}


function wait(ms) {
    var start = new Date().getTime();
    var end = start;
    while (end < start + ms) {
        end = new Date().getTime();
    }
}
