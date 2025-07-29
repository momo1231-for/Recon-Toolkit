### **Description**:

**FTP-Web-Recon script** is a comprehensive reconnaissance tool designed to gather essential information about a target domain or IP. It performs a series of automated checks, including:

* **WHOIS Lookup**: Retrieves domain registration information, including name servers and domain status.
* **DNS Lookup**: Resolves the domain to associated IP addresses.
* **Nmap Scan**: Detects open ports and checks for potential vulnerabilities.
* **HTTP(S) Response**: Verifies HTTP/S status codes and redirects.
* **TLS/SSL Testing**: Scans for SSL/TLS configurations and cipher support.
* **Web Fingerprinting**: Identifies the web technologies used by the target.
* **FTP Anonymous Login Check**: Tests for anonymous FTP login availability.

This script is ideal for anyone performing basic domain and network reconnaissance or gathering information for penetration testing. It combines various tools and commands into a simple, automated process for ease of use.

----
### Example Usage:

* **Run the script**:
  `./Recon.bash`

* **Log Output**:
  Results are saved to a timestamped log file for future reference.

----

### Key Features:

* Multi-step reconnaissance in a single command.
* Fast and easy to use.
* Saves detailed results in a structured log file.
* Supports HTTP, HTTPS, DNS, and FTP checks.
