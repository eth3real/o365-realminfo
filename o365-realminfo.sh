#!/bin/sh
usage="Usage: $0 <domain>"
if [ $# -ne 1 ]; then echo "$usage" && exit; fi

domain="$1"
user=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 9)

response=$(curl -s "https://login.microsoftonline.com/getuserrealm.srf?login=$user@$domain&xml=1")

echo "$response" | xmllint --format - | grep --color=always -P "^|(?<=<NameSpaceType>).+?(?=</NameSpaceType>)|(?<=<AuthURL>).+?(?=</AuthURL>)|(?<=<STSAuthURL>).+?(?=</STSAuthURL>)|(?<=<MEXURL>).+?(?=</MEXURL>)"
