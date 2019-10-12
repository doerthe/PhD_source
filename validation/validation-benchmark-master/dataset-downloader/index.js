/**
 * Created by pheyvaer on 13.04.17.
 */

let SparqlClient = require('sparql-client');
let Q = require('q');
let requestify = require('requestify');
let fs = require("fs-extra");
let http = require('http');
let config = require('./config.json');
const gzip = require("zlib");

let endpoint = 'http://lodlaundromat.org/sparql';

const wiggleRoom = 0.1;

function getDatasetsWithTripleSize(tripleSize) {
  let deferred = Q.defer();
  let query = `
  PREFIX llo: <http://lodlaundromat.org/ontology/>
  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  SELECT ?s WHERE {
    ?s llo:triples ?x.
    FILTER (?x < "${tripleSize * (1 + wiggleRoom)}"^^xsd:integer).
    FILTER (?x > "${tripleSize * (1 - wiggleRoom)}"^^xsd:integer)
  } ORDER BY DESC(?x) LIMIT 10000
  `;
  let client = new SparqlClient(endpoint);
  //console.log("Query to " + endpoint);
  //console.log("Query: " + query);
  client.query(query)
    .execute(function (error, results) {
      //console.log(results.results.bindings);
      let ids = [];

      results.results.bindings.forEach(function (r) {
        ids.push(r.s.value.replace('http://lodlaundromat.org/resource/', ''));
      });

      deferred.resolve(ids);
    });

  return deferred.promise;
}

function filterDatasetsWithSchema(ids, schemas) {
  let deferred = Q.defer();

  //console.log('http://index.lodlaundromat.org/ns2d/' + schema + '?limit=0');
  requestify.get('http://index.lodlaundromat.org/ns2d/', {
    params: {
      uri: schemas[0],
      limit: 0
    }
  })
    .then(function (response) {
      let results = response.getBody();
      let downloadIDs = [];

      ids.forEach(function (id) {
        if (results.indexOf(id) !== -1) {
          downloadIDs.push(id);
        }
      });

      schemas.shift();

      if (schemas.length > 0) {
        filterDatasetsWithSchema(downloadIDs, schemas).then(function(ids){
          deferred.resolve(ids);
        });
      } else {
        deferred.resolve(downloadIDs);
      }
    })
    .fail(function (response) {
      console.log(response.getCode()); // Some error code such as, for example, 404
      console.log('FATAL ERROR');
      process.exit(1);
    });

  return deferred.promise;
}

function getDatasetIDs(tripleSize, schemas) {
  return getDatasetsWithTripleSize(tripleSize)
    .then(function (ids) {
      return filterDatasetsWithSchema(ids, schemas)
    });
}

function downloadDatasets(ids, outputFolder){
  ids.forEach(function(id){
    http.get('http://download.lodlaundromat.org/' + id, function(response) {
      let file = fs.createWriteStream(outputFolder + '/' + id + '.nt');
      const gunzip = gzip.createGunzip();
      response.pipe(gunzip).pipe(file);
    });
  });
}

/**
 * 2: number of triples in the dataset
 * 3: schemas to be used in the dataset
 * 4: output folder
 * 5: number of dataset wanted
 */

let schemas = [];
process.argv[3].split(',').forEach(function(s){
  schemas.push(config.prefixes[s]);
});

getDatasetIDs(process.argv[2], schemas)
  .then(function(ids){
    ids = ids.slice(0, process.argv[5]);
    console.log(ids);
    let path = process.argv[4] + '/' + process.argv[2] + '/' + process.argv[3].replace(',', '-');
    fs.ensureDirSync(path);

    downloadDatasets(ids, path);
  });