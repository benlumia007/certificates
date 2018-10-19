#! /bin/sh
echo
echo  "Please note that you should have already generated a root certificate using root.sh before you proceed below."
echo
read -p "Enter Root Certificate Name: " root
read -p "Enter Domain Name: " domain
echo

if [ ! -d $HOME/certificates/$domain ];
then
  sleep 1
  echo
  echo Initialize Folder at $HOME/certificates/$domain
  sleep 1
  mkdir -p $HOME/certificates/$domain
  sleep 1
  echo Folder has been created
  echo
fi

if [ -f $HOME/certificates/$root/$root.conf ]; then
    cp /$HOME/certificates/$root/$root.conf /$HOME/certificates/$domain/$domain.conf
    exit 0
else
    sleep 2
    echo  $root.conf has not been generated. Please use root.sh to generate a root certificate before proceeding to generate a domain name certificate.
    exit 0
fi
