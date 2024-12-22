#!/bin/bash

CDate=`date +%d_%m_%Y_%M`
TOOL_NAME="SIMPLIFY NMAP FOR BEGGINER | EASY LEARNING"
AUTHOR_NAME="MAKBULKHAN PARMAR"

function nBanner () {
echo " __       ____    ______  ____    __  __      __  __           ______  ____    	"
echo "/\ \     /\  _`\ /\  _  \/\  _`\ /\ \/\ \    /\ \/\ \  /'\_/`\/\  _  \/\  _`\  	"
echo "\ \ \    \ \ \L\_\ \ \L\ \ \ \L\ \ \ `\\ \   \ \ `\\ \/\      \ \ \L\ \ \ \L\ \	"
echo " \ \ \  __\ \  _\L\ \  __ \ \ ,  /\ \ , ` \   \ \ , ` \ \ \__\ \ \  __ \ \ ,__/	"
echo "  \ \ \L\ \\ \ \L\ \ \ \/\ \ \ \\ \\ \ \`\ \   \ \ \`\ \ \ \_/\ \ \ \/\ \ \ \/ 	"
echo "   \ \____/ \ \____/\ \_\ \_\ \_\ \_\ \_\ \_\   \ \_\ \_\ \_\\ \_\ \_\ \_\ \_\ 	"
echo "    \/___/   \/___/  \/_/\/_/\/_/\/ /\/_/\/_/    \/_/\/_/\/_/ \/_/\/_/\/_/\/_/ 	"
echo "											"
}
display_banner() {
    clear
    echo "===================================================================="
    echo "SCRIPT:$TOOL_NAME      Version: 0.1"
    echo "HAPPY SCANNING!!! LEARNING WITH EASY SCANNING | AUTOMATED TOOL"	 	
    echo "BY:$AUTHOR_NAME"
    echo "        (\(\ "
    echo "       ( -.-)"
    echo "      o_('')('')"
    echo "==================================================================="
    echo "          Main Menu ---> Submenu"
    echo "          $1 ---> $2    		    "	
    echo "==================================================================="
}

result_banner() {
echo "---------------------------------------------------"
echo "		Find the Result of Execution		 "
echo "---------------------------------------------------"
}


# Function to install Nmap based on the distribution
install_nmap() {
    # Check internet connection
    ping -c 1 google.com &>/dev/null
    if [ $? -ne 0 ]; then
        echo "No internet connection. Please check your connection and try again."
        exit 1
    fi

    # Check if Nmap is installed
    if ! command -v nmap &>/dev/null; then
	clear
	echo "========================================================="
        echo "Nmap is not installed. Installing the latest version..."
	echo "========================================================="
        read -p "Press Enter to Continue"
        # OS-specific installation commands
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            case "$ID" in
                "ubuntu"|"debian")
                    # For Ubuntu/Debian-based systems
                    sudo apt update
                    sudo apt install -y nmap
                    ;;
                "centos"|"rhel"|"rocky"|"fedora")
                    # For CentOS/RHEL/Fedora/Rocky-based systems
                    sudo dnf install -y nmap
		    yum install nmap
                    ;;
                "fedora")
                    # Fedora systems (separate case for clarity)
                    sudo dnf install -y nmap
                    ;;
                "arch"|"manjaro")
                    # For Arch/Manjaro-based systems
                    sudo pacman -Syu --noconfirm nmap
                    ;;
                "feather")
                    # Feather Linux
                    echo "Feather Linux is not widely supported. Please install Nmap manually."
                    exit 1
                    ;;
                *)
                    echo "Unknown or unsupported Linux distribution: $ID"
                    exit 1
                    ;;
            esac

        else
            echo "Unable to determine the OS version. Please install Nmap manually."
            exit 1
        fi

        # Check if Nmap was installed successfully
        if command -v nmap &>/dev/null; then
	     clear
             echo "========================================================="
	     echo "Nmap has been successfully installed Enjoy...."
	     echo "========================================================="
             read -p "Enjoy the Scanning... Going for main Menu...."
	else
            echo "Failed to install Nmap. Please check your package manager settings."
            exit 1
        fi
    else
       	echo "Welcome to NMAP World!!!"
    	clear
	fi
}

# Check if the operating system is Linux
if [[ "$(uname)" != "Linux" ]]; then
    echo "This script is designed for Linux operating systems only."
    exit 1
fi

install_nmap || { echo "Installation failed, exiting."; exit 1; }


get_current_date() {
    echo "$(date +%F)"
}

in_progress (){
 # Print the message slowly (with delay)
    for ((i = 1; i <= 3; i++)); do
        sleep 1  # Delay for 1 second
        echo -n "."  # Print a dot without a newline
    done
    echo  # Newline after the dots

}




function folder () {



# Define base folder and date variables
base_folder="/root/NMAP_RESULT"  # Use an absolute path
cDate=$(date +%d_%m_%Y)

# Construct the target folder path
target_folder="$base_folder/$cDate"

# Ensure the base folder exists
if [ ! -d "$base_folder" ]; then
    mkdir -p "$base_folder"
    echo "Created base folder: $base_folder"
fi

# Check if the target folder already exists, if not create it
if [ ! -d "$target_folder" ]; then
    mkdir -p "$target_folder"
    echo "Created target folder: $target_folder"
else
    echo "Target folder already exists: $target_folder"
fi

# Now navigate to the target folder
if cd "$target_folder"; then
    echo "Successfully navigated to directory: $(pwd)"
else
    echo "Failed to navigate to directory: $target_folder"
    exit 1
fi

}


# Function to ask for and store the IP address
get_ip_address() {
    local ip_address

    # Check if an IP address is already stored
    if [ -f "ip_address.txt" ]; then
        # Read the stored IP address
        ip_address=$(cat ip_address.txt)
        echo "Current stored IP address: $ip_address"
    fi

    # Ask the user if they want to change the IP address
    read -p "Do you want to change the IP address? (y/n): " change_ip
    if [[ "$change_ip" =~ ^[Yy]$ ]]; then
        # If the user wants to change the IP, ask for a new IP address
        read -p "Enter the IP address for scanning: " ip_address
        # Save the new IP address to a file
        echo "$ip_address" > ip_address.txt
        cp ip_address.txt ip_address_date +%d%m%Y_%M%S.txt
        echo "IP address updated to $ip_address"
    else
        echo "Using the current IP address: $ip_address"
    fi

    echo "IP address for scanning: $ip_address"

} 

function ip_folder () {
	if folder; then
  	  get_ip_address
	else
	 echo "Not Found Folder and File"
	fi
}

ip_foldername_banner() {

               ip_folder
               result_banner
               ipname=$(cat ip_address.txt)
}

result_banner_enter () {
		result_banner
                echo -e "\e[31m$(cat "$filename")\e[0m"

}

trap 'echo -e "\nYou pressed Ctrl+C. Exiting..."; exit 0' SIGINT

##############################################INFORMATION SECTION
function discovery_info () {
echo "-------------------------------------------------------------------------------------------------------------------------"
echo ""

printf "%-50s\n" "About Discovery Option:-"
echo ""

printf "%-50s\n" "The default discovery options aren't useful when scanning secured systems and can hinder scaning progress."
printf "%-50s\n" "This is for only host discovery which allows you to perform more comprehensive discovery when looking for"
printf "%-50s\n" "available targets."
echo ""
echo "Choose below Submenu of Discovery Options"
# Print the separator line
echo "-------------------------------------------------------------------------------------------------------------------------"
}



ping_scan_info (){
echo "--------------------------------------------------------------"
echo "              Nmap Ping Scan Overview                        "
echo "--------------------------------------------------------------"
echo ""
echo "Usage: Performs a Ping Scan to determine if a host is up."
echo "Works by: Sending ICMP echo requests or similar probes to check"
echo "          if the target is reachable."
echo "Best for: Quickly determining which hosts in a network are online,"
echo "          without performing a full scan."
echo "Avoid if: You need detailed port or service information, as this"
echo "          option does not check open ports."
echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}

dont_ping_info () {
echo "--------------------------------------------------------------"
echo "              Nmap Don't Ping Scan Overview                   "
echo "--------------------------------------------------------------"
echo ""
echo "nmap -Pn <target>:"
echo "Usage: Skips host discovery and goes directly to port scanning."
echo "Works by assuming the host is alive, even if it doesn't respond to typical discovery probes."
echo "Best for: Hosts behind firewalls that block discovery probes, or when you're sure a host is alive and you want to speed up scanning."
echo "Avoid if: You want Nmap to verify if a target is alive first, or if you expect the host to block Nmap probes."
echo ""
echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
echo ""
}
aggresivescan_info (){

echo "--------------------------------------------------------------"
echo "              Nmap Aggressive Scan Overview                   "
echo "--------------------------------------------------------------"
echo "1. Service and Version Detection:"
echo "   Nmap identifies open ports on the target and attempts to"
echo "   detect the version of the services running on those ports."
echo "2. Operating System Fingerprinting:"
echo "   Nmap tries to determine the operating system by analyzing"
echo "   the target's responses to various probes."
echo "3. Script Execution:"
echo "   Nmap runs a set of default NSE scripts designed to discover"
echo "   vulnerabilities, gather information about the services,"
echo "   and perform other detailed checks."
echo "4. Traceroute:"
echo "   Nmap traces the path packets take to reach the target, helping"
echo "   you understand the network topology."
echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
} 

TCP_Syn_info () {

echo "--------------------------------------------------------------"
echo "                  Nmap TCP SYN Ping Overview                  "
echo "--------------------------------------------------------------"
echo ""
echo "Usage:"
echo "  nmap -PS <target>"
echo "  Sends TCP SYN packets to specified ports to determine if a host is up."
echo ""
echo "Work:"
echo "  - Sends TCP SYN packets to target hosts on default or specified ports."
echo "  - If the target responds with a SYN/ACK, it indicates the host is up."
echo "  - Can bypass firewalls that block ICMP ping."
echo "  - Does not perform full port scanning unless combined with other options."
echo ""
echo "When to Work:"
echo "  - Use when ICMP ping is blocked by firewalls."
echo "  - Ideal for environments where TCP port connectivity is a better indicator of active hosts."
echo "  - Combine with `--top-ports` or `-p` for specific port targeting."
echo ""
echo "Example:"
echo "  nmap -PS 192.168.1.1 -p 22,80,443"
echo "  This sends SYN packets to ports 22, 80, and 443 to check if the host is up."
echo ""
echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"

}

UDP_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap UDP Scan Overview	                   "
echo "--------------------------------------------------------------"

echo "The command nmap -PU is used for performing a Ping Scan with a UDP port check, specifically using a UDP ping to discover live hosts on a network. Let’s break it down:"
echo ""
echo "Usage:"
echo "The command nmap -PU would typically be used in scenarios where you want to scan a network to see which hosts are active by sending UDP packets (as opposed to traditional ICMP pings). This can be useful for network discovery in environments where ICMP (ping) might be blocked, but UDP traffic is allowed."
echo ""
echo "Work:"
echo "-P: This option specifies the type of probe to use. The -PU flag tells Nmap to use UDP for pinging hosts to check their availability."
echo "The -P flag is followed by the specific type of probe you want to use, and in this case, U stands for UDP."
echo "When you run nmap -PU followed by a target IP or subnet, it sends UDP packets to the target and listens for responses. Hosts that respond with a valid response packet indicate that they are live."
echo ""
echo "When to Work:"
echo "You would use nmap -PU in the following scenarios:"
echo "1. When you want to check the availability of hosts over UDP. Unlike the standard ICMP (ping), which might be blocked by firewalls, UDP packets can sometimes bypass restrictions."
echo "2. When ICMP is blocked on the network and you need an alternative method to discover hosts that are up."
echo "3. For more stealthy scans where a normal ICMP ping might give away the presence of a scan."
echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"

}

SCNTP_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap SCTOP Scan Overview                     "
echo "--------------------------------------------------------------"

echo "-PY: This option sends an SCTP INIT chunk to the target to check whether the host is up."
echo "SCTP (Stream Control Transmission Protocol) is a transport-layer protocol like TCP and UDP."
echo "When the target responds with an SCTP INIT-ACK packet, it confirms that the host is alive."
echo "If there's no response, Nmap marks the host as down or filtered."
echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"

}


ICMPEcho_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap ICMPECHO Scan Overview                     "
echo "--------------------------------------------------------------"

echo "Work: The -PE option in Nmap sends ICMP Echo Requests (ping packets) to the target to check if the host is up."
echo "Explain: This method works by sending an ICMP Echo Request and waiting for an ICMP Echo Reply from the target, a standard ping technique."
echo "Function: It is used for host discovery, allowing Nmap to identify active systems on a network before performing further scans."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"

}



ICMPTime_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap ICMPECHO Scan Overview                     "
echo "--------------------------------------------------------------"
echo "Work: The -PP option in Nmap uses ICMP Timestamp Requests to check whether the host is online."
echo "Explain: This method sends ICMP Timestamp Request packets, which ask the target to reply with its system time. A response indicates the host is up."
echo "Function: It is useful for host discovery on networks where standard ICMP Echo Requests (-PE) might be blocked by firewalls or security configurations."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}

IPProtocol_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap IP Protocol Scan Overview              "
echo "--------------------------------------------------------------"

echo "Work: The -PO option in Nmap performs an IP protocol scan to determine active hosts by sending packets for various IP protocols."
echo "Explain: This method tests different IP protocols (e.g., ICMP, IGMP, or TCP) to see which are supported and elicit responses, indicating that the host is up."
echo "Function: It is effective for discovering hosts on networks where traditional port-based scans or ICMP requests might be blocked or filtered."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}


ARPScan_info () {
echo "--------------------------------------------------------------"
echo "                   Nmap ARP Scan Overview                     "
echo "--------------------------------------------------------------"

echo "Work: The -PR option in Nmap uses ARP requests to discover live hosts on a local Ethernet network."
echo "Explain: ARP scans send a request to resolve the MAC address of hosts in the network, and responses confirm the presence of live systems."
echo "Function: This method is highly reliable and fast for host discovery on local networks, as ARP packets bypass IP filtering and firewalls."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}


Traceroute_info () {
echo "--------------------------------------------------------------"
echo "                 Nmap Traceroute Scan Overview                "
echo "--------------------------------------------------------------"

echo "Work: The --traceroute option in Nmap maps the network path (hops) from the scanning machine to the target."
echo "Explain: This option determines the intermediate devices (routers) between the source and the target by sending packets with incrementally increasing TTL values."
echo "Function: It is used for network analysis and troubleshooting, allowing visibility into the routing path and identifying possible bottlenecks or filtering devices."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}


ReverseDNS_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap Reverse DNS Scan Overview              "
echo "--------------------------------------------------------------"

echo "Work: The --R option in Nmap performs a reverse DNS lookup on the target host to find its domain name."
echo "Explain: This method sends a reverse DNS query for the IP address, /n attempting to map it back to a hostname using available DNS records."
echo "Function: It is useful for gathering additional information about a target," 
echo "helping to identify the host by its domain name rather than just an IP address."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}

NoDNS_info () {
echo "--------------------------------------------------------------"
echo "                 Nmap No DNS Resolution Scan Overview         "
echo "--------------------------------------------------------------"

echo "Work: The -n option in Nmap disables DNS resolution during the scan."
echo "Explain: This option prevents Nmap from performing reverse DNS lookups on IP addresses, speeding up the scan by not resolving hostnames."
echo "Function: It is useful when scanning large networks where DNS resolution might slow down the process or when you don't need the domain names."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}

SystemDNS_info () {
echo "--------------------------------------------------------------"
echo "               Nmap System DNS Usage Overview                 "
echo "--------------------------------------------------------------"

echo "Work: The --system-dns option in Nmap forces the use of the system's default DNS resolver for hostname resolution."
echo "Explain: Instead of using Nmap's built-in DNS resolver, this option directs Nmap to rely on the operating system's DNS configuration for resolving hostnames."
echo "Function: It is helpful when you want Nmap to align with custom or localized DNS settings configured on the system."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}

DNSServers_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap DNS Servers Scan Overview                "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --dns-servers option specifies custom DNS servers for hostname resolution."
    printf "%-10s   %s\n" " " "Instead of using the system's default DNS, Nmap queries the specified servers."

    printf "%-10s : %s\n" "Explain" "This option is useful when the default DNS server is unreliable or untrusted."
    printf "%-10s   %s\n" " " "It helps ensure accurate hostname resolution during scans."

    printf "%-10s : %s\n" "Function" "Useful for scanning across networks where specific DNS servers are required."
    printf "%-10s   %s\n" " " "It allows the use of trusted DNS servers to avoid potential DNS poisoning."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --dns-servers <dns1,dns2,...> <target>"
    echo "Example      : nmap --dns-servers 8.8.8.8,8.8.4.4 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}


ListScan_info () {
echo "--------------------------------------------------------------"
echo "                  Nmap List Scan Overview                     "
echo "--------------------------------------------------------------"

echo "Work: The -sL option in Nmap performs a list scan, displaying the targets without actually scanning them."
echo "Explain: This option resolves hostnames for the specified targets (if DNS resolution is enabled) and lists the results without sending any packets to the hosts."
echo "Function: It is useful for verifying the list of targets to be scanned or for gathering information about target domains without performing a full scan."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}
Advancescan_info () {
echo "---------------------------------------------------------------------------------------------------------"
echo " Nmap will perform a basic TCP scan on each target system. In some sitations it may be necessary to
       perfor more complex TCP(or even UDP) scans in an attempt to find uncommon services or to evade a firewall."
echo "---------------------------------------------------------------------------------------------------------"


}
# Function for Submenu 2.1
submenu_1_1() {
    while true; do
        display_banner "Submenu 1.1"
        echo "1. Option 1"
        echo "2. Option 2"
        echo "3. Back to Submenu 1"
        echo "4. Exit"
        echo "----------------------------------"
        read -p "Enter your choice: " choice

        case $choice in
            1) echo "You chose Submenu 1.1 - Option 1"; discovery_info read -p "Press Enter to continue..." ;;
            2) echo "You chose Submenu 1.1 - Option 2"; read -p "Press Enter to continue..." ;;
            3) return ;;
            4) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}

# Function for Submenu 1
Discovery_Option() {
    while true; do
        display_banner "Discovery Options"
        discovery_info
        echo "1. Aggresive_Scan"
	echo "2. Dont_Ping_Scan"
	echo "3. Ping_Scan"
	echo "4. TCP_Syn_Scan"
	echo "5. UDPScan"
	echo "6. SCTPScan"
	echo "7. ICMPechoping"
	echo "8. ICMPtimestamp"
	echo "9. IPProtocol"
	echo "10. ARPPingScan"
	echo "11. Traceroute"
	#echo "12. ForceRev.Dns.Resolv."
	echo "12. Disable.Reve.Dns.Resolu."
	echo "13. Alt.DNSlookup"
	echo "14. DNSScan"
	echo "15. ListScan"
	echo "16. Return to Main Menu"
        echo "17. Exit"
        echo "----------------------------------"
        read -p "Enter your choice: " choice

        case $choice in
            1) echo "Welcome to Aggresive Scan"; 
	       display_banner "Discovery Options" "Aggressive Scan"
	       aggresivescan_info
	       display_banner "Discovery Options" "Aggressive Scan"	
	       ip_foldername_banner
	       filename=Aggresive_Scan_`date +%d_%m_%Y_%M%S`.log
	       echo "nmap -A $ipname is Executed"
	       echo "file Name is:" $(pwd)"/$filename"
	       nmap -A $ipname >> $filename		       	
	       result_banner_enter 
               read -p "Press Enter to continue..." ;;
            2) echo "Welcome to Don't Ping Scan";
               display_banner "Discovery Options" "Dont'Ping Scan"
               dont_ping_info
	       display_banner "Discovery Options" "Dont'Ping Scan"	
               ip_foldername_banner
	       filename=dont_ping_scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -Pn $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -Pn $ipname >> $filename
               result_banner_enter
	       read -p "Press Enter to continue..." ;;
 
	    3) echo "Welcome to  Ping Scan";
               display_banner "Discovery Options" "Ping Scan"
               ping_scan_info
               display_banner "Discovery Options" "Ping Scan"
	       ip_foldername_banner
	       filename=ping_scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sP $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sP $ipname >> $filename
               result_banner_enter
		read -p "Press Enter to continue..." ;;
	    4) echo "Welcome to  TCP Syn  Scan";
               display_banner "Discovery Options" "TCP Syn"
               TCP_Syn_info
               display_banner "Discovery Options" "TCP Syn"
	       ip_foldername_banner
	       filename=TCP_Syn_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PS $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PS $ipname >> $filename
               result_banner_enter
	       read -p "Press Enter to continue..." ;;

	     5) echo "Welcome to  UDP  Scan";
               display_banner "Discovery Options" "UDP Syn"
               UDP_info
               display_banner "Discovery Options" "UDP Syn"
	       ip_foldername_banner
	       filename=UDP_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PU $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PU $ipname >> $filename
	       result_banner_enter	      
	       read -p "Press Enter to continue..." ;;	
            
	     6) echo "Welcome to  SCTP INIT  Scan";
               display_banner "Discovery Options" "SCTP INIT"
               SCTP_info
               display_banner "Discovery Options" "SCTP INIT"
               ip_foldername_banner
               filename=SCTP_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PY $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PY $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


	       7) echo "Welcome to  ICMPEcho  Scan";
               display_banner "Discovery Options" "ICMPEcho"
               ICMPEcho_info
               display_banner "Discovery Options" "ICMPEcho"
               ip_foldername_banner
               filename=ICMPEcho_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PU $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PU $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;
         

	       8) echo "Welcome to  ICMP Time Stamping  Scan";
               display_banner "Discovery Options" "ICMP Time Stamping"
               ICMPTime_info
               display_banner "Discovery Options" "ICMP Time Stamping"
               ip_foldername_banner
               filename=ICMPTime_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PP $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PP $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

	      9) echo "Welcome to  IPProtocol  Scan";
               display_banner "Discovery Options" "IPProtocol"
               IPProtocol_info
               display_banner "Discovery Options" "IPProtocol"
               ip_foldername_banner
               filename=IPProtocol_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PO $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PO $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;
	
	      10) echo "Welcome to  ARP  Scan";
               display_banner "Discovery Options" "ARPScan"
               ARPScan_info
               display_banner "Discovery Options" "ARPScan"
               ip_foldername_banner
               filename=ARPScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -PR $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -PR $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

	       11) echo "Welcome to  Traceroute  Scan";
               display_banner "Discovery Options" "Traceroute"
               Traceroute_info
               display_banner "Discovery Options" "Traceroute"
               ip_foldername_banner
               filename=Traceroute_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --traceroute $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --traceroute $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


              # 12) echo "Welcome to  Reverse DNS Scan";
              # display_banner "Discovery Options" "Reverse DNS"
              # ReverseDNS_info
              # display_banner "Discovery Options" "Reverse DNS"
              # ip_foldername_banner
              # filename=ReverseDNS_Scan_`date +%d_%m_%Y_%M%S`.log
              # echo "nmap --R $ipname is Executed"
              # echo "file Name is:" $(pwd)"/$filename"
              # nmap --R $ipname >> $filename
              # result_banner_enter
              # read -p "Press Enter to continue..." ;;


               12) echo "Welcome to  No DNS  Scan";
               display_banner "Discovery Options" "NoDNS"
               NoDNS_info
               display_banner "Discovery Options" "No DNS"
               ip_foldername_banner
               filename=NoDNS_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -n $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -n $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               13) echo "Welcome to  System DNS  Scan";
               display_banner "Discovery Options" "System DNS"
               SystemDNS_info
               display_banner "Discovery Options" "System DNS"
               ip_foldername_banner
               filename=SystemDNS_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --system-dns $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --system-dns $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



	       14) echo "Welcome to  DNSServers  Scan";
               display_banner "Discovery Options" "DNSServers Syn"
               DNSServers_info
               display_banner "Discovery Options" "DNSServers Syn"
               ip_foldername_banner
               filename=DNSServer_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --dns-servers $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --dns-servers $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               15) echo "Welcome to ListScan";
               display_banner "Discovery Options" "ListScan"
               ListScan_info
               display_banner "Discovery Options" "ListScan"
               ip_foldername_banner
               filename=ListScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sL $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sL $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


	
	    16) return ;;
            17) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}


StealthScan_info () {
echo "--------------------------------------------------------------"
echo "                 Nmap TCP SYN Scan Overview                   "
echo "--------------------------------------------------------------"

echo "Work: The -sS option in Nmap performs a TCP SYN scan, often called a stealth scan, as it doesn't complete the full TCP handshake."
echo "Explain: This scan sends a SYN packet to the target port and waits for a response (SYN-ACK for open, RST for closed)."
echo "It doesn't establish a connection, making it less detectable."
echo "Function: It is the most popular and efficient scan type,"
echo "used for quickly identifying open ports while minimizing detection by firewalls and intrusion detection systems."

echo "--------------------------------------------------------------"
read -p "Enter For Scanning Now.... "
clear
echo "--------------------------------------------------------------"
}


TCPConnectScan_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap TCP Connect Scan Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sT option in Nmap performs a TCP Connect scan, which establishes a full TCP handshake"
    printf "%-10s   %s\n" " " "with the target to identify open or closed ports."
    
    printf "%-10s : %s\n" "Explain" "This scan sends a SYN packet to the target, waits for a SYN-ACK response, and completes"
    printf "%-10s   %s\n" " " "the connection by sending an ACK. For closed ports, it receives an RST packet."

    printf "%-10s : %s\n" "Function" "Used when SYN scans (-sS) are unavailable, such as when running without root privileges."
    printf "%-10s   %s\n" " " "However, it is more detectable by firewalls and intrusion detection systems."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
UDPScan_info () {
    echo "--------------------------------------------------------------"
    echo "                    Nmap UDP Scan Overview                    "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sU option in Nmap performs a UDP scan to detect open UDP ports on the target system."
    printf "%-10s   %s\n" " " "It sends UDP packets to target ports and interprets responses to determine the port's state."

    printf "%-10s : %s\n" "Explain" "If no response is received, the port is considered open|filtered. If an ICMP port unreachable"
    printf "%-10s   %s\n" " " "(type 3, code 3) message is received, the port is closed. Some UDP services may respond with data."

    printf "%-10s : %s\n" "Function" "Used to identify services running on UDP, such as DNS, SNMP, or DHCP, making it essential for"
    printf "%-10s   %s\n" " " "comprehensive network assessments, though slower than TCP scans due to UDP's stateless nature."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
NullScan_info () {
    echo "--------------------------------------------------------------"
    echo "                     Nmap Null Scan Overview                  "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sN option in Nmap performs a Null scan, sending packets with no TCP flags set to"
    printf "%-10s   %s\n" " " "determine the state of the target ports."

    printf "%-10s : %s\n" "Explain" "If the port is closed, the target responds with an RST packet. Open or filtered ports"
    printf "%-10s   %s\n" " " "do not respond, making it challenging for intrusion detection systems to detect."

    printf "%-10s : %s\n" "Function" "Primarily used to bypass some firewalls or packet filters and to check for responses"
    printf "%-10s   %s\n" " " "on non-standard configurations. Not reliable on Windows systems, as they don't follow the RFC."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
FINScan_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap FIN Scan Overview                     "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sF option performs a FIN scan, sending FIN packets to the target."
    printf "%-10s   %s\n" " " "FIN scans are used to identify open/closed ports on a host."

    printf "%-10s : %s\n" "Explain" "An open port ignores FIN packets, while a closed port responds with an RST."
    printf "%-10s   %s\n" " " "This scan is stealthy, as it doesn't initiate a full TCP handshake."

    printf "%-10s : %s\n" "Function" "Useful for evading firewalls or IDS systems that detect SYN scans."
    printf "%-10s   %s\n" " " "It provides a stealthy way to probe port statuses without being easily detected."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -sF <target>"
    echo "Example      : nmap -sF 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

XmasScan_info () {
    echo "--------------------------------------------------------------"
    echo "                    Nmap Xmas Scan Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sX option in Nmap performs an Xmas scan by sending TCP packets with the FIN, PSH, and URG flags set."
    printf "%-10s   %s\n" " " "The name 'Xmas' refers to the 'lights' (flags) being set, which makes the packet unusual and easily recognizable."

    printf "%-10s : %s\n" "Explain" "If the port is closed, the target responds with an RST packet. Open or filtered ports typically do not respond."
    printf "%-10s   %s\n" " " "The Xmas scan is designed to evade firewalls and intrusion detection systems by using uncommon flag combinations."

    printf "%-10s : %s\n" "Function" "Primarily used for bypassing firewalls and packet filters that may not properly handle or inspect packets with unusual flag combinations."
    printf "%-10s   %s\n" " " "However, it is not reliable on all systems, especially Windows, which responds with RST packets for any unusual scans."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
AckScan_info () {
    echo "--------------------------------------------------------------"
    echo "                    Nmap ACK Scan Overview                    "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sA option in Nmap performs an ACK scan, sending TCP ACK packets to the target ports."
    printf "%-10s   %s\n" " " "The primary goal is to map out firewall rules and determine if ports are filtered or unfiltered."

    printf "%-10s : %s\n" "Explain" "If the port is filtered, the target will not respond. If it is unfiltered, it will respond with an RST packet."
    printf "%-10s   %s\n" " " "This scan doesn't help in identifying open ports directly but is used to assess firewall and filtering behaviors."

    printf "%-10s : %s\n" "Function" "Commonly used to map out firewall rules and to determine if ports are being filtered by firewalls or packet filters."
    printf "%-10s   %s\n" " " "It is useful for analyzing how a target network handles ACK packets and helps in mapping firewall configurations."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}



IPProtocolScan_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap IP Protocol Scan Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sO option in Nmap performs an IP protocol scan to identify which IP protocols (such as ICMP, TCP, UDP) are supported."
    printf "%-10s   %s\n" " " "It sends packets with different protocol numbers to the target to check for responses."

    printf "%-10s : %s\n" "Explain" "The scan tests for protocols beyond TCP and UDP, including protocols like ICMP, IGMP, and others. If a protocol is supported, the target responds accordingly."
    printf "%-10s   %s\n" " " "If there’s no response, the protocol is considered unsupported or filtered."

    printf "%-10s : %s\n" "Function" "Useful for mapping out the protocols available on a system, especially for detecting non-TCP/UDP services or unusual protocols."
    printf "%-10s   %s\n" " " "This scan type helps identify hidden services or devices using unusual IP protocols, which could be critical for network reconnaissance."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
SendEthScan_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Send Ethernet Scan Overview            "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --send-eth option in Nmap forces Nmap to use raw Ethernet frames for scanning instead of IP packets."
    printf "%-10s   %s\n" " " "This option is useful for bypassing certain network restrictions or filters that block IP traffic."

    printf "%-10s : %s\n" "Explain" "When this option is enabled, Nmap sends packets directly to the Ethernet layer, bypassing the IP layer. This is especially useful when scanning networks with complex routing."
    printf "%-10s   %s\n" " " "The option helps in scenarios where IP-level scanning is restricted or filtered, allowing for lower-level probing."

    printf "%-10s : %s\n" "Function" "Used when the target is on a local network and direct access to raw Ethernet frames is necessary. It is useful for network penetration tests and scanning local network devices."
    printf "%-10s   %s\n" " " "Note that raw Ethernet frames can only be sent on local networks or within the same broadcast domain and may require administrative privileges."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
SendIPScan_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Send IP Scan Overview                  "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --send-ip option in Nmap allows you to send raw IP packets instead of the usual Nmap packets at the transport layer."
    printf "%-10s   %s\n" " " "This can be useful for bypassing some network filters that block non-IP traffic or to test network devices at the IP layer."

    printf "%-10s : %s\n" "Explain" "When using --send-ip, Nmap sends packets with IP headers directly to the target, bypassing higher layers like TCP or UDP."
    printf "%-10s   %s\n" " " "This option is generally used for advanced users who need to test or explore network devices and protocols at a low level."

    printf "%-10s : %s\n" "Function" "This scan is beneficial for network penetration tests, especially when trying to analyze or bypass IP filtering systems."
    printf "%-10s   %s\n" " " "It may be helpful when you want to manipulate raw IP packets, such as when trying to evade detection systems or test how the target handles IP-layer traffic."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}


#SUBMENU 2
Advance_Scan() {
    while true; do
        display_banner "Advance Scanning"
        Advancescan_info

        echo "1. TCP_SYN_Scan"
        echo "2. TCPCONNECT"
        echo "3. UDPScan"
        echo "4. TCPNull"
        echo "5. TCPFinscan"
        echo "6. XmasScan"
        echo "7. TCPACKscan"
        echo "8. IPProtocolScan_info"
        echo "9. SendRawEthPacket"
        echo "10. SendIPPackets"
        echo "11. Return to Main Menu"
        echo "12. Exit"
        echo "----------------------------------"
        read -p "Enter your choice: " choice

        case $choice in

               1) echo "Welcome To Advance Scanning";
               display_banner "Advance Scanning" "TCP_SYN_Scan"
               StealthScan_info
               display_banner "Advance Scanning" "TCP_SYN_Scan"
               ip_foldername_banner
               filename=TCP_SYN_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sS $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sS $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

               2) echo "Welcome To TCPCONNCET";
               display_banner "Advance Scanning" "TCPCONNECT "
               TCPConnectScan_info
               display_banner "Advance Scanning" "TCPCONNECT"
               ip_foldername_banner
               filename=TCPCONNECT_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sT $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sT $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

               3) echo "Welcome To UDPScan";
               display_banner "Advance Scanning" "UDPScan"
               UDPScan_info
               display_banner "Advance Scanning" "UDPScan"
               ip_foldername_banner
               filename=UDPScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sU $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sU $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               4) echo "Welcome To TCPNull";
               display_banner "Advance Scanning" "TCPNull"
               NullScan_info
               display_banner "Advance Scanning" "TCPNull"
               ip_foldername_banner
               filename=TCPNull_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sN $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sN $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               5) echo "Welcome To TCPFinscan Scanning";
               display_banner "Advance Scanning" "TCPFinscan"
               FINScan_info
               display_banner "Advance Scanning" "TCPFinscan"
               ip_foldername_banner
               filename=TCPFinscan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sF $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sF $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               6) echo "Welcome To XmasScan";
               display_banner "Advance Scanning" "XmasScan_Scan"
               XmasScan_info
               display_banner "Advance Scanning" "XmasScan_Scan"
               ip_foldername_banner
               filename=XmasScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sX $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sX $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               7) echo "Welcome To TCPACKscan";
               display_banner "Advance Scanning" "TCPACKscan_Scan"
               AckScan_info 
               display_banner "Advance Scanning" "TCPACKscan_Scan"
               ip_foldername_banner
               filename=TCPACKscan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sA $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sA $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               8) echo "Welcome To IPProtocolScan";
               display_banner "Advance Scanning" "IPProtocolScan_Scan"
               IPProtocolScan_info
	       display_banner "Advance Scanning" "IPProtocolScan_Scan"
               ip_foldername_banner
               filename=IPProtocolScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sO $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sO $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               9) echo "Welcome To SendRawEthPacket";
               display_banner "Advance Scanning" "SendRawEthPacket_Scan"
               SendEthScan_info 
               display_banner "Advance Scanning" "SendRawEthPacket_Scan"
               ip_foldername_banner
               filename=SendRawEthPacket_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -send-eth $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -send-eth $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               10) echo "Welcome To SendIPPackets";
               display_banner "Advance Scanning" "SendIPPackets_Scan"
               SendIPScan_info
               display_banner "Advance Scanning" "SendIPPackets_Scan"
               ip_foldername_banner
               filename=SendIPPackets_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -send-ip $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -send-ip $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


 		11) return ;;
                12) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}


FastScan_info () {
    echo "--------------------------------------------------------------"
    echo "                    Nmap Fast Scan Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -F option in Nmap performs a Fast Scan, which only scans the top 100 most common ports."
    printf "%-10s   %s\n" " " "This is quicker than a full port scan and is ideal when time is a constraint."

    printf "%-10s : %s\n" "Explain" "Instead of scanning all 65,535 TCP/UDP ports, this scan focuses on the most frequently used ports."
    printf "%-10s   %s\n" " " "The list of these ports is based on Nmap’s default 'nmap-services' database."

    printf "%-10s : %s\n" "Function" "Used for quick assessments of the target’s services, making it suitable for preliminary reconnaissance."
    printf "%-10s   %s\n" " " "It is a trade-off between scan speed and thoroughness, providing fast results with reduced detail."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

PortScan_info () {
    echo "--------------------------------------------------------------"
    echo "                    Nmap Port Scan Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -p option in Nmap allows you to specify specific ports or a range of ports to scan on the target system."
    printf "%-10s   %s\n" " " "This gives you control over which ports are scanned, saving time compared to scanning all 65,535 ports."

    printf "%-10s : %s\n" "Explain" "You can specify single ports (e.g., -p 80), multiple ports separated by commas (e.g., -p 22,80,443),"
    printf "%-10s   %s\n" " " "or ranges (e.g., -p 1-1000). This flexibility allows focused scans based on the services of interest."

    printf "%-10s : %s\n" "Function" "Useful for targeting specific services or reducing the scan duration by limiting the scope to relevant ports."
    printf "%-10s   %s\n" " " "This option is commonly used during reconnaissance to narrow the focus to important or suspected open ports."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
TCPUDPScan_info () {
    echo "--------------------------------------------------------------"
    echo "                Nmap TCP and UDP Port Scan Overview            "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sT option performs a TCP Connect scan, establishing a full TCP handshake with specified ports."
    printf "%-10s   %s\n" " " "The -sU option performs a UDP scan on the same specified ports using the -p flag."
    printf "%-10s   %s\n" " " "Together, they scan both TCP and UDP ports simultaneously for specified targets."

    printf "%-10s : %s\n" "Explain" "This command scans the ports specified by the -p option for services running on both TCP and UDP."
    printf "%-10s   %s\n" " " "For TCP ports, a full handshake is used to determine if the port is open. For UDP, empty or protocol-specific packets"
    printf "%-10s   %s\n" " " "are sent, and responses or lack of them determine the status of the port (open, closed, or filtered)."

    printf "%-10s : %s\n" "Function" "This combined scan is useful for comprehensive analysis, as it checks for services on both TCP and UDP protocols."
    printf "%-10s   %s\n" " " "It is especially effective for discovering both application-layer services and non-standard communication protocols."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
AllPortsScan_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap All Ports Scan Overview                 "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -p * option in Nmap instructs it to scan all 65,535 TCP and/or UDP ports on the target."
    printf "%-10s   %s\n" " " "This ensures a thorough scan by including every possible port to check for open services."

    printf "%-10s : %s\n" "Explain" "By default, Nmap scans only the top 1,000 most common ports. Using -p *, it scans every port number,"
    printf "%-10s   %s\n" " " "ranging from 1 to 65,535, for both TCP and UDP protocols. This method is exhaustive but time-consuming."

    printf "%-10s : %s\n" "Function" "This scan is useful for discovering services running on non-standard ports or for thorough network reconnaissance."
    printf "%-10s   %s\n" " " "It provides a complete picture of all accessible ports but should be used with caution due to the increased time and network load."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

ScanSequential_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap Sequential Scan Overview                "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -r option in Nmap performs a scan where ports are scanned sequentially instead of randomly."
    printf "%-10s   %s\n" " " "This provides an ordered scan of ports from lowest to highest."

    printf "%-10s : %s\n" "Explain" "By default, Nmap scans ports in a randomized order to reduce the likelihood of detection by intrusion detection systems (IDS)."
    printf "%-10s   %s\n" " " "Using -r disables this randomness, ensuring ports are scanned in numerical order, which may help when analyzing specific port behavior."

    printf "%-10s : %s\n" "Function" "Useful for situations where a predictable and systematic scanning approach is needed. This is particularly helpful for"
    printf "%-10s   %s\n" " " "troubleshooting or when working with services that might behave differently under randomized scans."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}


#SUBMENU 3
Port_Scan() {
    while true; do
        display_banner "Port Scanning"
        PortScanning_info

        echo "1. FastScan"
        echo "2. ScanSpecificPort"
        echo "3. PortsbyProtocol"
        echo "4. TopPorts"
        echo "5. SequntialScan"
        echo "6. Return to Main Menu"
        echo "7. Exit"

        echo "----------------------------------"
        read -p "Enter your choice: " choice

        case $choice in


               1) echo "Welcome To FastScan";
               display_banner "Port_Scan" "FastScan"
               FastScan_info
               display_banner "Port_Scan" "FastScan"
               ip_foldername_banner
               filename=FastScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -F $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -F $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

               2) echo "Welcome To ScanSpecificPort";
               display_banner "Port_Scan" "ScanSpecificPort"
               PortScan_info
               display_banner "Port_Scan" "ScanSpecificPort"
               ip_foldername_banner
               filename=FastScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "Enter Port No. OR Port Name:-"
	       read prtname
	       echo "nmap -p $prtname $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -p $prtname $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               3) echo "Welcome To PortsbyProtocol";
               display_banner "Port_Scan" "PortsbyProtocol"
               TCPUDPScan_info
               display_banner "Port_Scan" "PortsbyProtocol"
               ip_foldername_banner
               filename=PortsbyProtocol_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "Enter Port No. OR Port Name:-"
               read prtname
               echo "nmap -p $ipname $prtname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sU -sT -p $prtname $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;; 
               


               4) echo "Welcome To PortsbyProtocol";
               display_banner "Port_Scan" "PortsbyProtocol"
               TCPUDPScan_info
               display_banner "Port_Scan" "PortsbyProtocol"
               ip_foldername_banner
               filename=PortsbyProtocol_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "Enter Port No. OR Port Name:-"
               read prtname
               echo "nmap -p $ipname $prtname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sU -sT -p $prtname $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;
               

               5) echo "Welcome To Scan Sequential";
               display_banner "Port_Scan" "Sequential Scan"
               ScanSequential_info
               display_banner "Port_Scan" "Sequential Scan"
               ip_foldername_banner
               filename=Sequential_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -r $ipname $prtname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -r $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               
	      6) return ;;
              7) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}


OSDetection_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap OS Detection Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -O option in Nmap enables operating system detection by analyzing the target's network responses."
    printf "%-10s   %s\n" " " "It attempts to identify the target's OS and kernel version with high accuracy."

    printf "%-10s : %s\n" "Explain" "Nmap sends a series of TCP/IP packets to the target and examines the responses for unique characteristics."
    printf "%-10s   %s\n" " " "The results are matched against Nmap's database of OS fingerprints to identify the operating system."

    printf "%-10s : %s\n" "Function" "OS detection is useful for gathering detailed information about a target during reconnaissance."
    printf "%-10s   %s\n" " " "It aids in vulnerability assessments by identifying OS-specific attack vectors. Note that OS detection requires administrative privileges."

    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}


OSDetectionGuess_info () {
    echo "--------------------------------------------------------------"
    echo "           Nmap OS Detection with Guessing Overview           "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -O option enables operating system detection, and --osscan-guess allows Nmap to guess the OS when exact matches are unavailable."
    printf "%-10s   %s\n" " " "It provides an approximate result if the target's OS doesn't fully match any known fingerprints."

    printf "%-10s : %s\n" "Explain" "When the --osscan-guess flag is used, Nmap relaxes its matching criteria for OS detection."
    printf "%-10s   %s\n" " " "This increases the likelihood of identifying an OS, even when the fingerprints are incomplete or ambiguous."

    printf "%-10s : %s\n" "Function" "This option is useful for reconnaissance in scenarios where precise OS identification is challenging."
    printf "%-10s   %s\n" " " "It helps estimate the target OS to aid further testing or exploitation, especially when facing custom or uncommon setups."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -O --osscan-guess <target>"
    echo "Example      : nmap -O --osscan-guess 127.0.0.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

ServiceVersionScan_info () {
    echo "--------------------------------------------------------------"
    echo "               Nmap Service Version Detection Overview        "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sV option in Nmap performs service version detection by probing open ports."
    printf "%-10s   %s\n" " " "It determines the application name, version, and sometimes additional details about the service."

    printf "%-10s : %s\n" "Explain" "Nmap sends specific probes to open ports and analyzes the responses to identify services running on them."
    printf "%-10s   %s\n" " " "The results are matched against a database of known service signatures to provide detailed information."

    printf "%-10s : %s\n" "Function" "Useful for identifying the exact software version running on open ports, aiding in vulnerability assessments."
    printf "%-10s   %s\n" " " "This option helps locate outdated or vulnerable software versions during penetration testing or system audits."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -sV <target>"
    echo "Example      : nmap -sV 127.0.0.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

VersionTrace_info () {
    echo "--------------------------------------------------------------"
    echo "       Nmap Service Version Detection with Trace Overview     "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sV option enables service version detection, while --version-trace provides detailed debugging output."
    printf "%-10s   %s\n" " " "It shows how Nmap probes services and interprets responses to identify versions."

    printf "%-10s : %s\n" "Explain" "When --version-trace is used, Nmap outputs every step of the version detection process."
    printf "%-10s   %s\n" " " "This includes detailed information about the probes sent, responses received, and matching attempts."

    printf "%-10s : %s\n" "Function" "Useful for troubleshooting service version detection issues, fine-tuning probes, or studying how Nmap works."
    printf "%-10s   %s\n" " " "Provides in-depth insights for advanced users performing detailed analysis or debugging."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -sV --version-trace <target>"
    echo "Example      : nmap -sV --version-trace 127.0.0.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

#SUBMENU 4
OS_Scan() {
    while true; do
        display_banner "OS Scanning"
        OSScanning_info

        echo "1. OSDetection"
        echo "2. GuessunknownOS"
        echo "3. ServiceVersionDetection"
        echo "4. VersionScan"
        echo "5. Return to Main Menu"
        echo "6. Exit"

        echo "----------------------------------"
        read -p "Enter your choice: " choice

        case $choice in


               1) echo "Welcome To OSDetection";
               display_banner "OS_Scan" "OSDetection"
               OSDetection_info
               display_banner "OS_Scan" "OSDetection"
               ip_foldername_banner
               filename=OSDetection_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -O $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -O $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

               2) echo "Welcome To OSDetectionGuess";
               display_banner "OS_Scan" "OSDetectionGuess"
               OSDetectionGuess_info
               display_banner "OS_Scan" "OSDetectionGuess"
               ip_foldername_banner
               filename=OSDetectionGuess_Scan_`date +%d_%m_%Y_%M%S`.log
#               echo "Enter Port No. OR Port Name:-"
#               read prtname
               echo "nmap -O --osscan-guess $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -O --osscan-guess $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               3) echo "Welcome To Service Version Detection";
               display_banner "OS_Scan" "ServiceVerDetection"
               ServiceVersionScan_info
               display_banner "OS_Scan" "ServiceVerDetection"
               ip_foldername_banner
               filename=ServiceVersionScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sV $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sV $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               4) echo "Welcome To VersionTrace Scanning";
               display_banner "OS_Scan" "VersionTrace"
               VersionTrace_info
               display_banner "OS_Scan" "VersionTrace"
               ip_foldername_banner
               filename=VersionTrace_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sV --version-trace $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sV --version-trace $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

              5) return ;;
              6) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}


TimingBasedScan_info () {
    echo "--------------------------------------------------------------"
    echo "                    Nmap Timing-Based Scanning                "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "Timing-based scanning in Nmap allows you to control the speed and stealth of scans using -T[0-5]."
    printf "%-10s   %s\n" " " "This helps adapt scans for various network conditions and levels of detection risk."

    printf "%-10s : %s\n" "Explain" "Nmap provides six timing templates ranging from -T0 (Paranoid) to -T5 (Insane)."
    printf "%-10s   %s\n" " " "Each template adjusts parameters like probe parallelism, delay times, and timeouts:"
    echo ""
#    printf "  %-15s : %s\n" "-T0 (Paranoid)" "Used for highly stealthy scans; sends probes very slowly, one at a time."
#    printf "  %-15s : %s\n" "-T1 (Sneaky)" "Similar to -T0 but slightly faster; avoids detection by IDS."
#    printf "  %-15s : %s\n" "-T2 (Polite)" "Moderate speed; reduces network load to avoid disruptions."
#    printf "  %-15s : %s\n" "-T3 (Normal)" "Default timing; balances speed and reliability."
#    printf "  %-15s : %s\n" "-T4 (Aggressive)" "Fast scanning for responsive networks but increases detection risk."
#    printf "  %-15s : %s\n" "-T5 (Insane)" "Max speed; used for fast networks with minimal concern for stealth."

    printf "%-10s : %s\n" "Function" "Timing templates let you customize scans based on environment. Stealthy modes (-T0/-T1) are ideal"
    printf "%-10s   %s\n" " " "for evading IDS, while faster modes (-T4/-T5) are better for quick results in responsive networks."

    echo ""
 #   printf "%-10s : %s\n" "Usage Syntax" "nmap -T<value> <target>"
 #   echo "Example      : nmap -T4 192.168.1.1"
    echo ""
#    echo "--------------------------------------------------------------"
#    read -p "Enter For Scanning Now.... "
#    clear
    echo "--------------------------------------------------------------"
}

timetable()
{

echo ""

echo ""
echo "-----You are in Timing Templets Mode --------- "
echo "-------------------------------------------------------------------------------------------------------------------------"
echo "|  Template        |  Name                |    Notes                                                                    |"
echo "|                  |                      |                                                                             |"
echo "|-----------------------------------------------------------------------------------------------------------------------|"
echo "|  -T0             |  Paranoid            |    Extremly Slow                                                            |"
echo "|------------------|----------------------|-----------------------------------------------------------------------------|"
echo "|  -T1             |  Sneaky              |    Useful for avoiding intrusion detection systems                          |"
echo "|------------------|----------------------|-----------------------------------------------------------------------------|"
echo "|  -T2             |  Polite              |    Unlikely to interfere with the target system                             |"
echo "|------------------|----------------------|-----------------------------------------------------------------------------|"
echo "|  -T3             |  Normal              |    This is the default timing template                                      |"
echo "|------------------|----------------------|-----------------------------------------------------------------------------|"
echo "|  -T4             |  Aggressive          |    Produces faster results on local networks                                |"
echo "|------------------|----------------------|-----------------------------------------------------------------------------|"
echo "|  -T5             |  Insane              |    Very Fast and Agressive Scan                                             |"
echo "|------------------|----------------------|-----------------------------------------------------------------------------|"

}

TimingTemplate_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Timing Template Overview              "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -T4 option in Nmap sets the timing template to 'Aggressive', optimizing the scan for speed."
    printf "%-10s   %s\n" " " "This makes Nmap perform scans faster by reducing wait times and using more parallelism."

    printf "%-10s : %s\n" "Explain" "Nmap offers timing templates ranging from -T0 (slowest, stealthy) to -T5 (fastest, noisy)."
    printf "%-10s   %s\n" " " "The -T4 template balances speed and reliability, making it suitable for most networks while minimizing missed results."

    printf "%-10s : %s\n" "Function" "Useful for scanning large networks or when quick results are needed. However, it increases the chance"
    printf "%-10s   %s\n" " " "of detection by intrusion detection systems (IDS) or firewalls compared to slower templates."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -T4 <target>"
    echo "Example      : nmap -T4 127.0.0.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}


MinParallelism_info () {
    echo "--------------------------------------------------------------"
    echo "              Nmap Minimum Parallelism Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --min-parallelism option in Nmap sets the minimum number of parallel probes."
    printf "%-10s   %s\n" " " "It ensures a specific level of parallelism regardless of Nmap's dynamic adjustments."

    printf "%-10s : %s\n" "Explain" "Nmap dynamically adjusts parallelism during scans based on network conditions."
    printf "%-10s   %s\n" " " "Using --min-parallelism overrides this behavior to maintain at least the specified number of concurrent probes."

    printf "%-10s : %s\n" "Function" "This option is useful for speeding up scans in networks where higher parallelism is feasible."
    printf "%-10s   %s\n" " " "However, setting a value too high may lead to dropped packets or unreliable results on slower networks."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --min-parallelism <value> <target>"
    echo "Example      : nmap --min-parallelism 10 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

MaxParallelism_info () {
    echo "--------------------------------------------------------------"
    echo "              Nmap Maximum Parallelism Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --max-parallelism option in Nmap sets the maximum number of parallel probes."
    printf "%-10s   %s\n" " " "It limits the number of probes running concurrently, regardless of Nmap's dynamic adjustments."

    printf "%-10s : %s\n" "Explain" "Nmap dynamically adjusts parallelism to optimize performance and reliability."
    printf "%-10s   %s\n" " " "The --max-parallelism option enforces an upper limit, helping prevent network overload or packet drops."

    printf "%-10s : %s\n" "Function" "This option is useful for controlling scan intensity in fragile or bandwidth-limited networks."
    printf "%-10s   %s\n" " " "A low value ensures network stability, while a higher value speeds up scanning but risks reliability."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --max-parallelism <value> <target>"
    echo "Example      : nmap --max-parallelism 10 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

MinHostGroup_info () {
    echo "--------------------------------------------------------------"
    echo "               Nmap Minimum Host Group Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --min-hostgroup option in Nmap specifies the minimum number of hosts scanned in a group."
    printf "%-10s   %s\n" " " "It sets a lower limit on how Nmap divides the target hosts into groups for scanning."

    printf "%-10s : %s\n" "Explain" "Nmap groups hosts to optimize parallel scanning. The --min-hostgroup option ensures that at least"
    printf "%-10s   %s\n" " " "the specified number of hosts are grouped, even if network conditions allow smaller groups."

    printf "%-10s : %s\n" "Function" "Useful in larger networks where scanning more hosts at once can save time. However,"
    printf "%-10s   %s\n" " " "it should be used carefully in networks with limited resources to avoid overload."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --min-hostgroup <value> <target>"
    echo "Example      : nmap --min-hostgroup 10 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
InitialRTTTimeout_info () {
    echo "--------------------------------------------------------------"
    echo "             Nmap Initial RTT Timeout Overview                "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --initial-rtt-timeout option in Nmap sets the initial timeout for Round Trip Time (RTT) probes."
    printf "%-10s   %s\n" " " "This value determines how long Nmap waits for a response before retrying or considering a host unreachable."

    printf "%-10s : %s\n" "Explain" "RTT is the time taken for a probe to reach the target and for a response to return. The --initial-rtt-timeout"
    printf "%-10s   %s\n" " " "overrides Nmap's default adaptive behavior by setting a specific starting timeout for RTT measurement."

    printf "%-10s : %s\n" "Function" "Useful in environments with high latency or unreliable networks. A higher value avoids premature timeouts,"
    printf "%-10s   %s\n" " " "while a lower value can speed up scans in fast networks but risks missed responses."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --initial-rtt-timeout <time> <target>"
    echo "Example      : nmap --initial-rtt-timeout 500ms 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

MaxHostGroup_info () {
    echo "--------------------------------------------------------------"
    echo "                Nmap Maximum Host Group Overview              "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --max-hostgroup option in Nmap sets the maximum number of hosts scanned in a group."
    printf "%-10s   %s\n" " " "It limits how many hosts are grouped together for parallel scanning."

    printf "%-10s : %s\n" "Explain" "Nmap groups target hosts for efficient parallel scanning. By default, the size of host groups"
    printf "%-10s   %s\n" " " "is dynamically adjusted. The --max-hostgroup option sets an upper limit to prevent large group sizes."

    printf "%-10s : %s\n" "Function" "This option is useful for controlling scan intensity in networks. A lower value ensures"
    printf "%-10s   %s\n" " " "less resource usage, while a higher value increases scanning speed but risks overloading networks."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --max-hostgroup <value> <target>"
    echo "Example      : nmap --max-hostgroup 20 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
MaxRTTTimeout_info () {
    echo "--------------------------------------------------------------"
    echo "             Nmap Maximum RTT Timeout Overview                "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --max-rtt-timeout option in Nmap sets the maximum Round Trip Time (RTT) timeout for probes."
    printf "%-10s   %s\n" " " "It specifies the longest time Nmap will wait for a response before considering a host unreachable."

    printf "%-10s : %s\n" "Explain" "RTT is the time it takes for a probe to reach the target and receive a response. By default,"
    printf "%-10s   %s\n" " " "Nmap dynamically adjusts RTT timeouts. The --max-rtt-timeout option defines an upper limit for these adjustments."

    printf "%-10s : %s\n" "Function" "This option is useful in high-latency networks where responses may take longer. A higher value"
    printf "%-10s   %s\n" " " "prevents false negatives, but it can slow scans. In contrast, a lower value can speed up scans but risks missing slow hosts."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --max-rtt-timeout <time> <target>"
    echo "Example      : nmap --max-rtt-timeout 2s 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
MaxRetries_info () {
    echo "--------------------------------------------------------------"
    echo "                Nmap Maximum Retries Overview                 "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --max-retries option in Nmap sets the maximum number of retransmissions for a probe."
    printf "%-10s   %s\n" " " "It limits how many times Nmap will retry sending probes if no response is received."

    printf "%-10s : %s\n" "Explain" "Nmap normally retries probes a few times to account for packet loss or temporary network issues."
    printf "%-10s   %s\n" " " "The --max-retries option allows you to control this behavior, reducing retries to speed up scans or increasing them for reliability."

    printf "%-10s : %s\n" "Function" "This option is useful in unreliable networks where more retries ensure accurate results,"
    printf "%-10s   %s\n" " " "or in fast, stable networks where fewer retries can make scans quicker."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --max-retries <value> <target>"
    echo "Example      : nmap --max-retries 3 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
HostTimeout_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap Host Timeout Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --host-timeout option in Nmap sets a time limit for scanning a single host."
    printf "%-10s   %s\n" " " "If the scan takes longer than the specified timeout, Nmap stops scanning that host."

    printf "%-10s : %s\n" "Explain" "This option is helpful for ensuring scans complete within a predictable timeframe."
    printf "%-10s   %s\n" " " "Nmap abandons slow or unresponsive hosts after the timeout is reached, freeing resources for other scans."

    printf "%-10s : %s\n" "Function" "Useful in large networks to prevent lengthy delays caused by a single unresponsive host."
    printf "%-10s   %s\n" " " "A high timeout ensures thorough scans, while a low timeout prioritizes speed over completeness."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --host-timeout <time> <target>"
    echo "Example      : nmap --host-timeout 1m 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
ScanDelay_info () {
    echo "--------------------------------------------------------------"
    echo "                  Nmap Scan Delay Overview                    "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --scan-delay option in Nmap sets a fixed delay between sending packets to a target."
    printf "%-10s   %s\n" " " "This ensures that probes are sent at a consistent interval, avoiding overwhelming the target."

    printf "%-10s : %s\n" "Explain" "By default, Nmap adjusts the delay dynamically based on network conditions. The --scan-delay"
    printf "%-10s   %s\n" " " "option overrides this behavior, forcing Nmap to use a user-specified delay between probes."

    printf "%-10s : %s\n" "Function" "This is useful for evading Intrusion Detection Systems (IDS) or firewalls that may detect and"
    printf "%-10s   %s\n" " " "block scans based on rapid packet sequences. It is also helpful for scanning slow networks."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --scan-delay <time> <target>"
    echo "Example      : nmap --scan-delay 500ms 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
MaxScanDelay_info () {
    echo "--------------------------------------------------------------"
    echo "                Nmap Maximum Scan Delay Overview              "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --max-scan-delay option in Nmap sets the upper limit for adaptive delays between probes."
    printf "%-10s   %s\n" " " "This ensures that delays do not exceed the specified maximum value during the scan."

    printf "%-10s : %s\n" "Explain" "By default, Nmap dynamically adjusts delays based on network conditions. The --max-scan-delay"
    printf "%-10s   %s\n" " " "option restricts this adjustment to a defined maximum value, preventing excessive delays."

    printf "%-10s : %s\n" "Function" "This is useful in networks where high delays could make scans inefficient or in controlled"
    printf "%-10s   %s\n" " " "environments where strict timing constraints are required for testing or analysis."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --max-scan-delay <time> <target>"
    echo "Example      : nmap --max-scan-delay 1s 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
 MinRate_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Minimum Rate Overview                 "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --min-rate option in Nmap sets a minimum number of packets per second for scanning."
    printf "%-10s   %s\n" " " "This ensures that Nmap sends probes at least at the specified rate, improving scan speed."

    printf "%-10s : %s\n" "Explain" "By default, Nmap adjusts the sending rate based on network conditions. The --min-rate option"
    printf "%-10s   %s\n" " " "overrides this behavior, enforcing a constant minimum rate, which is useful for time-sensitive tasks."

    printf "%-10s : %s\n" "Function" "This is particularly useful for fast networks where adaptive throttling may reduce speed."
    printf "%-10s   %s\n" " " "However, setting a very high rate might overwhelm slower networks or trigger rate-limiting mechanisms."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --min-rate <rate> <target>"
    echo "Example      : nmap --min-rate 1000 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
   echo "--------------------------------------------------------------"
}
MaxRate_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Maximum Rate Overview                 "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --max-rate option in Nmap sets an upper limit on the number of packets sent per second."
    printf "%-10s   %s\n" " " "This restricts the scanning speed to prevent overwhelming the network or target system."

    printf "%-10s : %s\n" "Explain" "By default, Nmap adjusts its sending rate based on network conditions. The --max-rate"
    printf "%-10s   %s\n" " " "option overrides this by enforcing a fixed maximum rate, useful for maintaining network stability."

    printf "%-10s : %s\n" "Function" "This is particularly useful for avoiding detection or rate-limiting by firewalls."
    printf "%-10s   %s\n" " " "It also helps prevent network congestion during large-scale scans."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --max-rate <rate> <target>"
    echo "Example      : nmap --max-rate 500 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
DefeatRSTRateLimit_info () {
    echo "--------------------------------------------------------------"
    echo "             Nmap Defeat RST Rate-Limit Overview              "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --defeat-rst-ratelimit option in Nmap helps to handle targets that impose"
    printf "%-10s   %s\n" " " "rate limits on TCP RST (Reset) packets during port scanning."

    printf "%-10s : %s\n" "Explain" "Some systems limit the number of RST packets sent to avoid abuse, slowing down"
    printf "%-10s   %s\n" " " "scans. This option uses retries and other techniques to bypass such rate limits."

    printf "%-10s : %s\n" "Function" "This option ensures comprehensive scans by compensating for RST rate limits,"
    printf "%-10s   %s\n" " " "allowing accurate identification of open and closed ports even under restricted conditions."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --defeat-rst-ratelimit <target>"
    echo "Example      : nmap --defeat-rst-ratelimit 192.168.1.1"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}

#SUBMENU 5
Timebase_Scan() {
    while true; do
        display_banner "Time Scanning"
        TimingBasedScan_info

        echo "1. TimingTemplets"
        echo "2. MinParllscan"
        echo "3. MaxParallel"
        echo "4. Minhostgroup"
        echo "5. Maxhostgroup"
        echo "6. MinRTTtimeout"
        echo "7. MaxRTTtimeout"
        echo "8. MaxRetry"
        echo "9. Hosttimeout"
        echo "10. Min.ScanDelay"
        echo "11. Max.ScanDelay"
        echo "12. Min.PacketRate"
        echo "13. Max.PacketRate"
        echo "14. DefeatResetRate"
        echo "15. Return to Main Menu"
        echo "16. Exit"

        echo "----------------------------------"
        read -p "Enter your choice: " choice

        case $choice in


               1) echo "Welcome To Time Base Scanning";
               display_banner "TimeBase" "TimeTemplate"
               TimingTemplate_info
               display_banner "TimeBase" "TimeTemplate"
	       timetable	       	
               ip_foldername_banner
               filename=TimeBase_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -T4 $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
	       echo "Enter Time:-"
	       read Time
               nmap -T"$Time" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               2) echo "Welcome To MinParallelism";
               display_banner "TimeBase" "MinParallelism"
               MinParallelism_info
               display_banner "TimeBase" "MinParallelism"
               timetable
               ip_foldername_banner
               filename=MinParallelism_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --min-parallelism $par $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Minimum Parallel Operation(Bydefaul it's 100):- "
               read par
	       nmap --min-parallelism $par $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               3) echo "Welcome MaxParallelism Scanning ";
               display_banner "TimeBase" "MaxParallelism"
               MaxParallelism_info
               display_banner "TimeBase" "MaxParallelism"
               timetable
               ip_foldername_banner
               filename=MaxParallelism_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap  --max-parallelism $mpar $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Maximum Parallel Operation(Bydefaul it's 1):- "
               read mpar
               nmap --max-parallelism $mpar $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               4) echo "Welcome To MinHostGroup Scanning";
               display_banner "TimeBase" "MinHostGroup"
               MinHostGroup_info
               display_banner "TimeBase" "MinHostGroup"
               timetable
               ip_foldername_banner
               filename=MinHostGroup_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --min-hostgroup $hmin $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Minimum Hostgroup Operation:- "
               read hmin
               nmap  --min-hostgroup $hmin $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               5) echo "Welcome To Maxhostgroup";
               display_banner "TimeBase" "Maxhostgroup"
               MaxHostGroup_info
               display_banner "TimeBase" "Maxhostgroup"
               timetable
               ip_foldername_banner
               echo "Enter Max. HostGroup Operation:-"
               read hmax
               filename=Maxhostgroup_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --max-hostgroup $hmax $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --max-hostgroup "$hmax" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

             
	       6) echo "Welcome To MinRTTtimeout";
               display_banner "TimeBase" "MinRTTtimeout"
               InitialRTTTimeout_info
               display_banner "TimeBase" "MinRTTtimeout"
               timetable
               ip_foldername_banner
               echo "Enter Min. RTT TimeOut:-"
               read minrtt
               filename=MinRTTtimeout_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --initial-rtt-timeout $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --initial-rtt-timeout "$minrtt" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;




               7) echo "Welcome To MaxRTTtimeout";
               display_banner "TimeBase" "MaxRTTtimeout"
               MaxRTTTimeout_info 
               display_banner "TimeBase" "MaxRTTtimeout"
               timetable
               ip_foldername_banner
               filename=MaxRTTtimeout_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --max-rtt-timeout $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Time:-"
               read Time
               nmap --max-rtt-timeout "$Time" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;




               8) echo "Welcome To MaxRetry";
               display_banner "TimeBase" "MaxRetry"
               MaxRetries_info
               display_banner "TimeBase" "MaxRetry"
               timetable
               ip_foldername_banner
               filename=MaxRetry_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --max-retries $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Time:-"
               read Time
               nmap --max-retries "$Time" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;




               9) echo "Welcome To Hosttimeout";
               display_banner "TimeBase" "Hosttimeout"
               HostTimeout_info 
               display_banner "TimeBase" "Hosttimeout"
               timetable
               ip_foldername_banner
               filename=Hosttimeout_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --host-timeout $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Time:-"
               read Time
               nmap --host-timeout "$Time" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               10) echo "Welcome To Min.ScanDelay";
               display_banner "TimeBase" "Min.ScanDelay"
               ScanDelay_info
               display_banner "TimeBase" "Min.ScanDelay"
               timetable
               ip_foldername_banner
               filename=Min.ScanDelay_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --scan-delay $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Time:-"
               read Time
               nmap --scan-delay "$Time"ms $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;




               11) echo "Welcome To Max.ScanDelay";
               display_banner "TimeBase" "Max.ScanDelay"
               MaxScanDelay_info
               display_banner "TimeBase" "Max.ScanDelay"
               timetable
               ip_foldername_banner
               filename=Max.ScanDelay_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --max-scan-delay $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Time:-"
               read Time
               nmap --max-scan-delay "$Time" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;




               12) echo "Welcome To Min.PacketRate";
               display_banner "TimeBase" "Min.PacketRate"
               MinRate_info
               display_banner "TimeBase" "Min.PacketRate"
               timetable
               ip_foldername_banner
               filename=Min.PacketRate_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --min-rate $Rate $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Rate:-"
               read Rate
               nmap --min-rate "$Rate" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               13) echo "Welcome To Max.PacketRate";
               display_banner "TimeBase" "Max.PacketRate"
               MaxRate_info
               display_banner "TimeBase" "Max.PacketRate"
               timetable
               ip_foldername_banner
               filename=Max.PacketRate_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --max-rate $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               echo "Enter Time:-"
               read Time
               nmap --max-rate "$Time" $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               14) echo "Welcome To DefeatResetRate";
               display_banner "TimeBase" "DefeatResetRate"
               DefeatRSTRateLimit_info
               display_banner "TimeBase" "DefeatResetRate"
               timetable
               ip_foldername_banner
               filename=DefeatResetRate_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --defeat-rst-ratelimit $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --defeat-rst-ratelimit  $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



              15) return ;;
              16) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}
FFlag_info () {
    echo "--------------------------------------------------------------"
    echo "                     Nmap --fragmentation Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -f option in Nmap forces packet fragmentation during scanning."
    printf "%-10s   %s\n" " " "It breaks TCP packets into smaller fragments to evade network-based filters or firewalls."

    printf "%-10s : %s\n" "Explain" "Some networks, especially those with firewalls, block packets that exceed a certain size."
    printf "%-10s   %s\n" " " "Fragmenting packets helps bypass these restrictions and completes scans effectively."

    printf "%-10s : %s\n" "Function" "This is useful for networks with strict packet size filters that may drop or block large packets."
    printf "%-10s   %s\n" " " "It helps in avoiding firewalls or intrusion detection systems that scan for fragmented packets."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -f <target>"
    echo "Example      : nmap -f 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
MTU_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap MTU Size Overview                    "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --mtu option in Nmap sets the Maximum Transmission Unit (MTU) size for packets."
    printf "%-10s   %s\n" " " "MTU defines the maximum size of data packets that can be sent over the network."

    printf "%-10s : %s\n" "Explain" "Some networks may drop or fragment packets that exceed certain MTU sizes."
    printf "%-10s   %s\n" " " "Setting the MTU ensures that Nmap’s packets conform to the MTU limits of the target network."

    printf "%-10s : %s\n" "Function" "Useful for networks with specific MTU size limitations, helping prevent packet loss or fragmentation."
    printf "%-10s   %s\n" " " "Ensures smooth packet delivery and accurate scans in constrained networks."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --mtu <size> <target>"
    echo "Example      : nmap --mtu 1500 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
DFlag_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap Decoy Scan Overview                      "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -D option in Nmap performs a decoy scan using multiple IP addresses as decoys."
    printf "%-10s   %s\n" " " "This makes it harder for the target to determine the true origin of the scan."

    printf "%-10s : %s\n" "Explain" "By sending packets from multiple decoy IP addresses, Nmap disguises the true source."
    printf "%-10s   %s\n" " " "The target receives multiple packets from various IPs, obscuring the origin of the scan."

    printf "%-10s : %s\n" "Function" "Useful for evading IDS (Intrusion Detection Systems) and reducing the likelihood of detection."
    printf "%-10s   %s\n" " " "It helps obscure the real IP address of the scanning host, making analysis harder."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -D <decoy-ips> <target>"
    echo "Example      : nmap -D 192.168.1.1,192.168.1.2,192.168.1.3 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
SIScan_info () {
    echo "--------------------------------------------------------------"
    echo "                 Nmap Intermediary Scan Overview                "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The -sI option in Nmap uses an intermediate proxy to forward packets."
    printf "%-10s   %s\n" " " "This hides the actual source IP address from the target."

    printf "%-10s : %s\n" "Explain" "An intermediary or bounce host relays packets from Nmap to the target."
    printf "%-10s   %s\n" " " "The target sees packets from the intermediary instead of the scanning machine."

    printf "%-10s : %s\n" "Function" "Useful for evading restrictions or firewalls that block traffic from specific sources."
    printf "%-10s   %s\n" " " "It helps obfuscate the real IP address of the scanning machine from the target."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -sI <intermediate-host> <target>"
    echo "Example      : nmap -sI proxy.example.com 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
SourcePort_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Source Port Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --source-port option allows you to specify a custom source port for the scan."
    printf "%-10s   %s\n" " " "By default, Nmap uses a randomly chosen source port for TCP scans."

    printf "%-10s : %s\n" "Explain" "Some firewalls and intrusion detection systems (IDS) may block scans originating from common ports."
    printf "%-10s   %s\n" " " "This option helps bypass such blocks by using a non-standard source port."

    printf "%-10s : %s\n" "Function" "Useful for evading network filters or IDS systems that detect common source ports."
    printf "%-10s   %s\n" " " "It allows more flexibility in evading firewalls and IDS/IPS systems."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --source-port <port> <target>"
    echo "Example      : nmap --source-port 12345 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
DataLength_info () {
    echo "--------------------------------------------------------------"
    echo "                   Nmap Data Length Overview                   "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --data-length option specifies the size of the data payload sent in packets."
    printf "%-10s   %s\n" " " "By default, Nmap uses standard payload sizes, but this option allows customization."

    printf "%-10s : %s\n" "Explain" "Some firewalls and IDS/IPS systems may block packets based on their data payload size."
    printf "%-10s   %s\n" " " "This option helps avoid such restrictions by sending packets with a specific data length."

    printf "%-10s : %s\n" "Function" "Useful for bypassing filters that block packets based on payload size."
    printf "%-10s   %s\n" " " "It allows greater flexibility when dealing with networks with restrictive packet filters."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --data-length <length> <target>"
    echo "Example      : nmap --data-length 1000 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
RandomizeHosts_info () {
    echo "--------------------------------------------------------------"
    echo "               Nmap Randomize Hosts Overview                  "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --randomize-hosts option shuffles the order of IP addresses in the target list."
    printf "%-10s   %s\n" " " "This helps avoid detection by IDS/IPS systems that track sequential scans."

    printf "%-10s : %s\n" "Explain" "Many network defenses monitor scans based on the order of IP addresses."
    printf "%-10s   %s\n" " " "Shuffling the order makes it harder to detect scanning patterns."

    printf "%-10s : %s\n" "Function" "Useful for evading intrusion detection systems (IDS) that track scan patterns."
    printf "%-10s   %s\n" " " "It improves scanning stealth and reduces the chances of being flagged by IDS."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --randomize-hosts <target>"
    echo "Example      : nmap --randomize-hosts 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
SpoofMAC_info () {
    echo "--------------------------------------------------------------"
    echo "              Nmap Spoof MAC Address Scan Overview               "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --spoof-mac option alters the source MAC address in the Ethernet frames sent by Nmap."
    printf "%-10s   %s\n" " " "This helps conceal the actual MAC address of the scanning machine."

    printf "%-10s : %s\n" "Explain" "Some networks, especially with MAC filtering, may block traffic from certain MAC addresses."
    printf "%-10s   %s\n" " " "Spoofing the MAC address helps bypass such restrictions, appearing as a different device."

    printf "%-10s : %s\n" "Function" "Useful in networks with MAC address-based access control or filtering."
    printf "%-10s   %s\n" " " "It ensures the scanner remains undetected by hiding its true MAC address."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap -sT -Pn --spoof-mac <mac-address> <target>"
    echo "Example      : nmap -sT -Pn --spoof-mac 00:11:22:33:44:55 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}
BadSum_info () {
    echo "--------------------------------------------------------------"
    echo "                  Nmap Bad Checksum Scan Overview              "
    echo "--------------------------------------------------------------"

    printf "%-10s : %s\n" "Work" "The --badsum option sends packets with intentionally incorrect checksums."
    printf "%-10s   %s\n" " " "This tests whether the target system processes or discards these malformed packets."

    printf "%-10s : %s\n" "Explain" "Network devices, firewalls, and intrusion detection systems should ignore bad packets."
    printf "%-10s   %s\n" " " "A system that responds to these packets may have unexpected vulnerabilities."

    printf "%-10s : %s\n" "Function" "Useful for identifying misconfigured systems or devices that improperly process invalid packets."
    printf "%-10s   %s\n" " " "It can help uncover network weaknesses or anomalies."

    echo ""
    printf "%-10s : %s\n" "Usage Syntax" "nmap --badsum <target>"
    echo "Example      : nmap --badsum 192.168.1.0/24"
    echo ""
    echo "--------------------------------------------------------------"
    read -p "Enter For Scanning Now.... "
    clear
    echo "--------------------------------------------------------------"
}







#SUBMENU 6
Firewall_Scan() {
    while true; do
        display_banner "Firewall Scanning"

        echo "1. FragmentPackets"
        echo "2. SpecificMT"
        echo "3. Decoy"
        echo "4. ZombieScan"
        echo "5. ManuallySpecifyPort"
        echo "6. AppendRandomData"
        echo "7. RandomizeTarget"
        echo "8. SpoofMac"
        echo "9. Badchecksum"
        echo "10. Return to Main Menu"
        echo "11. Exit"
        echo "----------------------------------"
        read -p "Enter your choice: " choice
        case $choice in


               1) echo "Welcome To FragmentPackets";
               display_banner "Firewall Scanning" "FragmentPackets"
               FFlag_info
               display_banner "Firewall Scanning" "FragmentPackets"
               ip_foldername_banner
               filename=FragmentPackets_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -f $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -f $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

               2) echo "Welcome To SpecificMT";
               display_banner "Firewall Scannning" "SpecficMT"
               MTU_info
               display_banner "Firewall Scanning" "SpecficMT"
               ip_foldername_banner
               filename=SpecficMT_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "Enter MTU  Number:-"
               read prtname
               echo "nmap --mtu $prtname $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --mtu $prtname $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;


               3) echo "Welcome To Decoy";
               display_banner "Firewall Scanning " "Decoy"
               DFlag_info
               display_banner "Firewall Scanning"  "Decoy"
               ip_foldername_banner
               filename=Decoy_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "Enter DECOY IP's :- "
                read rnd
               echo "nmap -D $rnd $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -D $rnd $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;



               4) echo "Welcome To ZombieScan";
               display_banner "Firewall Scanning" "ZombieScan"
               SIScan_info
               display_banner "Firewall Scanning " "ZombieScan"
               ip_foldername_banner
               echo "Enter Zombie Host IP :- "
               read zo
               filename=ZombieScan_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sI $zo $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sI $zo $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

               5) echo "Welcome To ManuallySpecifyPort";
               display_banner "Firewall Scanning" "ManuallySpecifyPort"
               SourcePort_info
               display_banner "Firewall Scanning " "ManuallySpecifyPort"
               ip_foldername_banner
               echo "Enter PortNumber :- "
               read sport
               filename=ManuallySpecifyPort_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sI $sport $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --source-port $sport  $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;
             
               6) echo "Welcome To AppendRandomData";
               display_banner "Firewall Scanning" "AppendRandomData"
               DataLength_info
               display_banner "Firewall Scanning " "AppendRandomData"
               ip_foldername_banner
               echo "Enter Length :- "
               read lngth
               filename=AppendRandomData_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --data-length $lngth $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --data-length $lngth  $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;
               

               7) echo "Welcome To RandomizeTarget";
               display_banner "Firewall Scanning" "RandomizeTarget"
               RandomizeHosts_info
               display_banner "Firewall Scanning" "RandomizeTarget"
               ip_foldername_banner
               filename=RandomizeTarget_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --randomize-hosts $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --randomize-hosts $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;
               
               8) echo "Welcome To SpoofMac";
               display_banner "Firewall Scanning" "SpoofMac"
               SpoofMAC_info
               display_banner "Firewall Scanning" "SpoofMac"
               ip_foldername_banner
               echo "-----Spoof Mac Table --------- "
echo "-------------------------------------------------------------------------------------------------------------------------"
echo "|  Argument        |  Argument                                                                                          |"
echo "|                  |                                                                                                    |"
echo "|------------------|----------------------------------------------------------------------------------------------------|"
echo "| 0 (Zero)         |  Generates a random MAC Address                                                                    |"
echo "|------------------|----------------------------------------------------------------------------------------------------|"
echo "| Specific MAC Addr|  Uses the Specified MAC Address                                                                    |"
echo "|------------------|----------------------------------------------------------------------------------------------------|"
echo "| Vendor Name      |  Generates a MAC address from the specified vendor (Such as Apple, Dell, 3Com, etc.)               |"
echo "|------------------|----------------------------------------------------------------------------------------------------|"
               filename=SpoofMac_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap -sT -Pn --spoof-mac $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap -sT -Pn --spoof-mac $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;     
             
               9) echo "Welcome To Badchecksum";
               display_banner "Firewall Scanning" "Badchecksum"
               BadSum_info
               display_banner "Firewall Scanning" "Badchecksum"
               ip_foldername_banner
               filename=Badchecksum_Scan_`date +%d_%m_%Y_%M%S`.log
               echo "nmap --badsum $ipname is Executed"
               echo "file Name is:" $(pwd)"/$filename"
               nmap --badsum $ipname >> $filename
               result_banner_enter
               read -p "Press Enter to continue..." ;;

              
              11) return ;;
              12) clear; exit ;;
            *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
        esac
    done
}


# Main Menu
while true; do
    display_banner "Main Menu"
    echo "1. Discovery Option"
    echo "2. Advance Scan"
    echo "3. PortScanning" 
    echo "4. OSScanning"
    echo "5. TimeBase Scanning"
    echo "6. Firewall Evading"
    echo "7. Exit"
    echo "----------------------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1) echo "Discovery Options";  
	   
	   discovery_info 
	   Discovery_Option
	   read -p "Press Enter to continue..." ;;
        2) echo "Advance Scan"
	    Advancescan_info
	    Advance_Scan

	    read -p "Press Enter to continue..." ;;
   
        3) echo "Port Scanning"
            Portscan_info
            Port_Scan

            read -p "Press Enter to continue..." ;;


        4) echo "OS Scanning"
            OSscan_info
            OS_Scan

            read -p "Press Enter to continue..." ;;


        5) echo "Time Based Scanning"
            Timebase_Scan
	    TimingBasedScan_info
            read -p "Press Enter to continue..." ;;


        6) echo "Evading Firewall Scanning"
            Firewall_Scan
            FirewallScan_info
            read -p "Press Enter to continue..." ;;




        7) clear; exit ;;
        *) echo "Invalid option! Try again."; read -p "Press Enter to continue..." ;;
    esac
done

