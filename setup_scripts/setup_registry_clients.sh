REGISTRY=192.168.122.1:$1

sudo mkdir -p /etc/docker/certs.d/$REGISTRY
sudo cp registry_certs/domain.cert /etc/docker/certs.d/$REGISTRY/ca.crt

#Autorise docker à se connecter sans certificat valide
sudo echo "{ \"insecure-registries\" : [\"$REGISTRY\"]}"

#Restart docker
sudo service docker restart
