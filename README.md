# easylearningnmap
easy learning nmap based shell script
# Simplify Nmap for Beginners

Welcome to **Simplify Nmap for Beginners**, a shell script designed to make network scanning and information gathering easier and more accessible for students, learners, and professionals. This tool provides a user-friendly, menu-driven interface for utilizing Nmap's powerful features.

---

## Features

- **Beginner-Friendly:** No prior knowledge of Nmap is required. Easy-to-use interface for exploring scanning options.
- **Comprehensive Menu:** Includes options for:
  1. Discovery Scans
  2. Advanced Scans
  3. Port Scanning
  4. OS Detection
  5. Timing-Based Scans
  6. Firewall Evasion
- **Automated Output:** Scan results are saved in organized log files for easy access.
- **Educational:** Each menu option comes with detailed explanations to help you understand its purpose and function.

---

## Installation

1. Clone the repository:
   ```bash
   git clone (https://github.com/opensourcemak/easylearningnmap.git)
   ```
2. Navigate to the directory:
   ```bash
   cd easylearningnmap
   ```
3. Make the script executable:
   ```bash
   chmod +x easylearningnmap.sh
   ```
4. Run the script:
   ```bash
   ./easylearningnmap.sh
   ```

---

## Requirements

- Linux operating system.
- Nmap installed on your system.
  - If Nmap is not installed, the script will attempt to install it for you.
- Root privileges for certain advanced scans.

---

## Menu Options

### 1. Discovery Options
   - Discover active hosts in a network.
   - Includes ping scans, ARP scans, traceroute, and more.

### 2. Advanced Scans
   - Perform deeper scans, including SYN scans, UDP scans, and more.

### 3. Port Scanning
   - Focus on scanning specific ports or ranges.
   - Includes fast scanning, sequential scanning, and detailed analysis.

### 4. OS Detection
   - Detect the operating system and version of target hosts.

### 5. Timing-Based Scanning
   - Customize scan speed using Nmap's timing templates.

### 6. Firewall Evasion
   - Techniques to bypass firewalls and gather network data.

### 7. Exit
   - Quit the script.

---

## Example Usage

1. **Select a Discovery Scan:**
   ```
   Choose Option 1: Discovery Scans
   ```
   Follow the prompts to perform a ping scan or traceroute.

2. **Perform an Advanced Scan:**
   ```
   Choose Option 2: Advanced Scans
   ```
   Select SYN scan, UDP scan, or other advanced techniques.

3. **Save Results Automatically:**
   The script saves all scan results in organized log files within `/root/NMAP_RESULT/YYYY_MM_DD`.

---

## License

This project is licensed under the MIT License. 

---

## Contributions

Contributions, issues, and feature requests are welcome from anyone, anywhere in the world. Feel free to fork this repository and submit a pull request. Let's make this project better together!

---

## Author

- **Name:** Makbulkhan Parmar
- **Contact:** [opensourcemak@gmail.com]

---

Start learning and exploring the power of Nmap with ease. Happy scanning!
