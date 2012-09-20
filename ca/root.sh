# Create the self-signed root CA and root's certificate: root.pem cacert.pem

echo "* Create the self-signed root CA and root's certificate: root.pem cacert.pem"
echo "* Distribute the cacert.pem to clients to authenticate your server"
echo "* Enter a (new) secret pass phrase when requested"
echo "* Enter it again when prompted"
echo "* You need the pass phrase later to sign the client and server key files"
echo "* Enter your company name as the Common Name (e.g. genivia.com) when requested"
echo "* The root CA will expire after three years (1095 days)"

# crée une paire clé privée(rootkey) /clé publique (rootreq)
openssl req -newkey rsa:1024 -sha1 -keyout rootkey.pem -out rootreq.pem
# crée un certificat et le signe avec la clé privée
openssl x509 -req -in rootreq.pem -sha1 -extfile openssl.cnf -extensions v3_ca -signkey rootkey.pem -out cacert.pem -days 1095
# joint le certificat et la clé privée
cat cacert.pem rootkey.pem > root.pem
# affiche des détails du certificat 
openssl x509 -subject -issuer -dates -noout -in root.pem
