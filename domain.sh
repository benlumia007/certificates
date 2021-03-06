#! /bin/sh
echo
echo  "Please note that you should have already generated a root certificate using root.sh before you proceed below."
echo
sleep 1
read -p "Enter Root Certificate Name: " root
sleep 1
read -p "Enter Domain Name (Do Not Include TLD): " domain
echo
sleep 1

if [ ! -d $HOME/certificates/$domain ];
then
    mkdir -p $HOME/certificates/$domain
    echo
    if [ -f $HOME/certificates/$root/$root.conf ]; then
        cp $HOME/certificates/$root/$root.conf $HOME/certificates/$domain/$domain.conf
        echo "The configuration file for $domain has been created"
        sleep 1
    else
        echo "The configuration file for $domain has not been generated. Please use root.sh to generate a root certificate before proceeding to generate a configuration file."
        exit 0
    fi
    echo
    cd $HOME/certificates/$domain
    echo "Generating a" $domain.key
    echo
    openssl genrsa -out $domain.key 4096
    echo
    echo "Generating a" $domain.csr
    openssl req -config $domain.conf -new -key $domain.key -out $domain.csr
    echo
    touch $domain.ext
    echo "authorityKeyIdentifier=keyid,issuer" >> $domain.ext
    echo "basicConstraints=CA:FALSE" >> $domain.ext
    echo "keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment" >> $domain.ext
    echo "subjectAltName = @alt_names" >> $domain.ext
    echo >> $domain.ext
    echo "[alt_names]" >> $domain.ext
    echo DNS.1 = $domain.test >> $domain.ext
    echo DNS.2 = *.$domain.test >> $domain.ext
    echo
    echo "Generating a" $domain.crt
    echo 
    openssl x509 -req -in $domain.csr -CA $HOME/certificates/$root/$root.pem -CAkey $HOME/certificates/$root/$root.key -CAcreateserial -out $domain.crt -days 3650 -sha256 -extfile $domain.ext
else
    echo "It has already been generated.";
fi
