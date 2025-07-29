#!/bin/bash
echo "=== Target Recon Script ==="
# Prompt user for input
read -p "Enter target IP or domain: " target
# Basic input validation
if [[ -z "$target" ]]; then
    echo "[!] No target provided. Exiting."
    exit 1
fi

# Optional: Check if the target resolves
if ping -c 1 -W 1 "$target" &>/dev/null; then
    echo "[+] Target resolved successfully."
else
    echo "[!] Target does not appear to resolve. Please check the input."
    exit 1
fi

# Log file setup
timestamp=$(date +"%Y%m%d_%H%M%S")
log_file="recon_${target}_${timestamp}.log"

# Print the absolute path of the log file
echo "[*] Log file will be saved at: $(pwd)/$log_file"


echo "[*] Logging to: ~/Documents/$log_file"
echo "[*] Starting reconnaissance on $target at $(date)" | tee -a "$log_file"

# Run recon steps with timeout
echo "[+] Running WHOIS..." | tee -a "$log_file"
echo "[+] Running WHOIS..."
whois "$target" 2>&1 | tee -a "$log_file" | grep -E 'Domain|Name Server|OrgName|NetRange'

echo "[+] Running DNS Lookup..." | tee -a "$log_file"
timeout 10s nslookup "$target" | tee -a "$log_file"

echo "[+] Scanning Open Ports with Nmap..." | tee -a "$log_file"
timeout 10s nmap -sV -T4 "$target" | tee -a "$log_file"

echo "[+] Checking for FTP Anonymous Login..." | tee -a "$log_file"
timeout 20s nmap -p 21 --script ftp-anon "$target" | tee -a "$log_file"

echo "[+] Checking HTTP(S) Response..." | tee -a "$log_file"
timeout 10s curl -I "http://$target" | tee -a "$log_file"
timeout 10s curl -I "https://$target" | tee -a "$log_file"

echo "[+] Testing TLS/SSL Support..." | tee -a "$log_file"
timeout 30s nmap --script ssl-enum-ciphers -p 443 "$target" | tee -a "$log_file"

echo "[+] Checking if DVWA is Installed..." | tee -a "$log_file"
timeout 10s curl -s "http://$target/DVWA" | grep -i 'DVWA' | tee -a "$log_file"

echo "[+] Basic Web Fingerprinting..." | tee -a "$log_file"
timeout 20s whatweb "http://$target" | tee -a "$log_file"

echo "[*] Done. Output saved to: $log_file" | tee -a "$log_file"

# End script with success
exit 0

