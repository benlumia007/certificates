#! /bin/sh
echo
read -p "Enter Organization Name (Company): " name
read -p "Enter Email Address: " email
read -p "Enter Country Name (2 Letter Code): " country
read -p "Enter State or Province Name (Full Name): " state
read -p "Enter Locality Name (City): " city
read -p "Enter Common Name (FQDN or Your Name): " fqdn
read -p "Enter Root Certificate Name: " root

if [ ! -d $root ];
then
  sleep 1
  echo
  echo "Initialize Folder at $root"
  sleep 1
  mkdir $root
  sleep 1
  echo "Folder has been created"
  echo
fi

if [ -d $root ];
then
  sleep 1
  echo "Creating a" $root.conf "file"
  sleep 1
  cd $HOME/certificates/$root
  touch $root.conf
  echo "[req]" >> $root.conf
  echo "default_bits = 4096" >> $root.conf
  echo "default_md = sha256" >> $root.conf
  echo "distinguished_name" = subject >> $root.conf
  echo "prompt = no" >> $root.conf
  echo "string_mask = utf8only" >> $root.conf
  echo >> $root.conf
  echo "[subject]" >> $root.conf
  echo "C" = $country >> $root.conf
  echo "ST" = $state >> $root.conf
  echo "L" = $city >> $root.conf
  echo "O" = $name >> $root.conf
  echo "CN" = $fqdn >> $root.conf
  echo "emailAddress" = $email >> $root.conf
  sleep 1
  echo $root.conf "has been created"
  echo
  sleep 1
  openssl genrsa -des3 -out $root.key 4096
  echo
  sleep 1
  echo "Generating a" $root.pem
  sleep 1
  openssl req -config $root.conf -x509 -new -nodes -key $root.key -sha256 -days 3650 -out $root.pem
  sleep 1
  echo
  sleep 1
  echo $root.pem "has been created"
fi
