#generate x509 RSA keys

mkdir registry_certs
openssl req -newkey rsa:4096 -nodes -sha256 \
                -keyout registry_certs/domain.key -x509 -days 356 \
                -out registry_certs/domain.cert

#need human interaction here

#create the docker registry instance
#TODO set the good port number
docker run -d -p 6666:5000 \
 -v $(pwd)/registry_certs:/certs \
 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.cert \
 -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
 --restart=always --name registry-lab7 registry:2

echo "Registry created"
echo "Now you can run setup_registry_clients.sh 6666 on each client who will use the registry"
