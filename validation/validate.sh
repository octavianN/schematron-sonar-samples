#!/bin/bash

SCHEMATRON_DIR=bin/xspec/src/schematron/iso-schematron/

echo "Downloading Saxon 9"
if [[ ! -e bin/saxon9.jar ]];
then
  curl -L -q http://central.maven.org/maven2/net/sf/saxon/Saxon-HE/9.9.1-2/Saxon-HE-9.9.1-2.jar > bin/saxon9.jar
fi

echo "Downloading the Oxygen framework"
if [[ ! -e bin/xspec ]];
then
  curl -q https://www.oxygenxml.com/maven/com/oxygenxml/frameworks/21.0.0.0/frameworks-21.0.0.0.zip > bin/frameworks.zip
  unzip -q bin/frameworks.zip -d bin/
fi

echo "Downloading the SVRL to SONAR conversion tool"
if [[ ! -e bin/svrl-to-sonar.jar ]];
then
  curl -qL https://github.com/octaviann/svrl-to-sonar/releases/download/0.2/svrl-to-sonar.jar > bin/svrl-to-sonar.jar
fi



rm -rf bin/tmp/
mkdir -p bin/tmp/
mkdir -p bin/out/

echo "Validating with schematron"

java -jar bin/saxon9.jar validation/paper.sch $SCHEMATRON_DIR/iso_dsdl_include.xsl > bin/tmp/paper-includes.sch
java -jar bin/saxon9.jar bin/tmp/paper-includes.sch $SCHEMATRON_DIR/iso_abstract_expand.xsl > bin/tmp/paper-expanded.sch
java -jar bin/saxon9.jar bin/tmp/paper-expanded.sch $SCHEMATRON_DIR/iso_svrl_for_xslt2.xsl > bin/tmp/paper-validate.xsl
java -jar bin/saxon9.jar paper.xml bin/tmp/paper-validate.xsl > bin/tmp/paper.svrl
java -jar bin/svrl-to-sonar.jar bin/tmp/paper.svrl > bin/tmp/sonar-schematron.json
echo "Generate HTML report"
java -jar bin/saxon9.jar bin/tmp/paper.svrl validation/svrl-to-html.xsl > bin/out/paperReport.html
