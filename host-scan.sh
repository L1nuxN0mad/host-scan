#!/bin/bash

print_info() {
    echo -e "\e[1;32m[+] $1\e[0m"
}

print_info "Starting the Tor service... "
sudo service tor start
echo ""


read -p "Enter a new domain or IP to scan:  " domain


name_base_dir="$domain"

ip_regex='^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'


if [[ ! "$domain" =~ $ip_regex ]] && [[ "$domain" == *"."* ]]; then
    name_base_dir="${domain%.*}"
fi

print_info "'$name_base_dir' will be used as the name for the results folder.  "
echo ""


results_dir="SCAN-DATA/$name_base_dir"
mkdir -p "$results_dir"

print_info "The results will be saved in the folder: '$results_dir' "
echo ""


host_output_file="$results_dir/host.txt"
print_info "Running 'host' for $domain... "
host "$domain" > "$host_output_file"
echo "Result of 'host' saved in: $host_output_file "
echo ""

whois_output_file="$results_dir/whois.txt"
print_info "Running 'whois' to obtain registration information... "
whois "$domain" > "$whois_output_file"
echo "Result of 'host' saved in: $host_output_file "
echo ""

print_info "Process completed. Check the '$results_dir' folder for results. "
