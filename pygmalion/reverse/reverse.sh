#!/bin/sh
date=`date +%Y%m%d-%H%M`
database=$1
pg_dump -COs -E UTF-8 ${database} > ${database}-${date}.sql
awk -f sql2xml.awk ${database}-${date}.sql > ${database}-${date}.xml
xsltproc --timing -o ${database}-${date}.opa xml2opa.xsl ${database}-${date}.xml
xsltproc --timing -o ${database}-${date}.html opa2html.xsl ${database}-${date}.opa
rm -f ${database}-${date}.sql ${database}-${date}.xml