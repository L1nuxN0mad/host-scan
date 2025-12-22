#! bin/bash

read -p "Ingress a new domain to scan: " domain

host "$domain" > index.html

for dom in $(cat index.html); do host $dom; done

