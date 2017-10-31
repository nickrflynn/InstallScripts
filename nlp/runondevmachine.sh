
#
# This script is meant for quick & easy install via:
#   curl -sSL https://healthcatalyst.github.io/InstallScripts/nlp/runondevmachine.sh | sh


docker stack rm fabricnlp

sleep 10s;

docker secret rm MySQLPassword || echo ""
echo 'yourpassword' | docker secret create MySQLPassword -

docker secret rm MySQLRootPassword || echo ""
echo "new-password" |  docker secret create MySQLRootPassword -

export SHARED_DRIVE=c:/tmp
export SHARED_DRIVE_SOLR=c:/tmp/solr
mkdir -p c:/tmp/solr
export SHARED_DRIVE_MYSQL=c:/tmp/mysql_nlp
mkdir c:/tmp/mysql_nlp
export nlpwebserverexternal="localhost"
export smtpserver="localhost"
export jobserverexternal="localhost"

# use docker stack deploy to start up all the services
stackfilename="nlp-stack.yml"

echo "running stack: $stackfilename"

echo "https://healthcatalyst.github.io/InstallScripts/nlp/${stackfilename}"

curl -sSL "https://healthcatalyst.github.io/InstallScripts/nlp/${stackfilename}" | docker stack deploy --compose-file - fabricnlp
