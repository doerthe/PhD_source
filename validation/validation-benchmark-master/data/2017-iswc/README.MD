# Data for ISWC2017 Benchmark

## Dataset Sizes

* `dataset_sizes_lodstats.csv`: size of the datasets as indexed by [LODStats](http://lodstats.aksw.org/)
  * data retrieved 15/05/2017, using following SPARQL query [direct link](http://stats.lod2.eu/sparql?default-graph-uri=&query=select+distinct+%3Fx+%3Fo+where+%7B%3Fx+%3Chttp%3A%2F%2Flodstats.aksw.org%2Fontology%2Fldso.owl%23currentStats%3E+%3Fs.+%3Fs+%3Chttp%3A%2F%2Frdfs.org%2Fns%2Fvoid%23triples%3E+%3Fo%7D&format=text%2Fhtml&timeout=0&debug=on)
```
SELECT DISTINCT  ?x ?o
WHERE
  { ?x  <http://lodstats.aksw.org/ontology/ldso.owl#currentStats>  ?s .
    ?s  <http://rdfs.org/ns/void#triples>  ?o
  }
```
* `dataset_sizes_lodlaundromat.csv`: size of the datasets as indexed by [LODLaundromat](http://lodlaundromat.org/)
  * data retrieved 13/04/2017, using following SPARQL query [direct link](http://lodlaundromat.org/sparql/?query=PREFIX%20llo%3A%20%3Chttp%3A%2F%2Flodlaundromat.org%2Fontology%2F%3E%0APREFIX%20ll%3A%20%3Chttp%3A%2F%2Flodlaundromat.org%2Fresource%2F%3E%0ASELECT%20%3Fmd5%20%3Fdoc%20%3Ftriples%20%3Fduplicates%20%7B%0A%20%20%5B%5D%20llo%3Atriples%20%3Ftriples%3B%0A%20%20%20%20llo%3Aduplicates%20%3Fduplicates%20%3B%0A%20%20%20%20llo%3Aurl%20%3Fdoc%20%3B%0A%20%20%20%20llo%3Amd5%20%3Fmd5%20.%0A%20%20FILTER(%3Ftriples%20%3E%200)%0A%7D%20ORDER%20BY%20DESC(%3Ftriples%20%2B%20%3Fduplicates))
```
PREFIX llo: <http://lodlaundromat.org/ontology/>
PREFIX ll: <http://lodlaundromat.org/resource/>
SELECT ?md5 ?doc ?triples ?duplicates {
  [] llo:triples ?triples;
    llo:duplicates ?duplicates ;
    llo:url ?doc ;
    llo:md5 ?md5 .
  FILTER(?triples > 0)
} ORDER BY DESC(?triples + ?duplicates)
```

## Datasets

Downloaded from [LODLaundromat](http://lodlaundromat.org/).
Based on `LODLaundromat_ID`, you can download the datasets from `http://download.lodlaundromat.org/[LODLaundromat_ID]`.

## Inferencing

* `measures_inferencing.csv`: for each dataset, infer using the RDFS-rules as defined on [http://eulersharp.sourceforge.net/](http://eulersharp.sourceforge.net/).

## Measures

Comparing N3/EYE with RDFUnit