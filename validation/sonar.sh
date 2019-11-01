echo "Downloading sonar"

if [[ ! -e bin/sonar ]];
then
  curl -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip > bin/sonar.zip
  unzip -q bin/sonar.zip -d bin/
  mv bin/sonar-scanner* bin/sonar
fi

echo "Running validation"
bash resources/validation/validate.sh

echo "Running sonar"
bin/sonar/bin/sonar-scanner \
    -Dproject.settings=resources/validation/sonar.properties
   
