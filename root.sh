#! /bin/sh
echo
read -p "Enter Organization Name (Company): " name
read -p "Enter Email Address: " email
read -p "Enter Country Name (2 Letter Code): " country
read -p "Enter State or Province Name (Full Name): " state
read -p "Enter Locality Name (City): " city
read -p "Enter Root Certificate Name: " root

if [ ! -d $HOME/certificates/$root ];
then
  sleep 1
  echo
  echo "Initialize Folder at" $HOME/certificates/$root
  sleep 1
  mkdir -p $HOME/certificates/$root;
  sleep 1
  echo "Folder has been created"
  echo
fi

if [ -d $HOME/certificates/$root ];
then
  sleep 1
  echo "Creating a" $root.conf "file"
  sleep 1
  cd $HOME/certificates/$root
  touch $root.conf
  echo [req] >> $HOME/certificates/$root/$root.conf
  echo default_bits = 4096 >> $HOME/certificates/$root/$root.conf
  echo default_md = sha256 >> $HOME/certificates/$root/$root.conf
  echo distinguished_name = subject >> $HOME/certificates/$root/$root.conf
  echo prompt = no >> $HOME/certificates/$root/$root.conf
  echo string_mask = utf8only >> $HOME/certificates/$root/$root.conf
  echo >> $HOME/certificates/$root/$root.conf
  echo [subject] >> $HOME/certificates/$root/$root.conf
  echo C = $country >> $HOME/certificates/$root/$root.conf
  echo ST = $state >> $HOME/certificates/$root/$root.conf
  echo L = $city >> $HOME/certificates/$root/$root.conf
  echo O = $name >> $HOME/certificates/$root/$root.conf
  echo CN = $root.test >> $HOME/certificates/$root/$root.conf
  echo emailAddress = $email >> $HOME/certificates/$root/$root.conf
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
