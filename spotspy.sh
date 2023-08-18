#!/bin/bash  

  

# List of information gathering tools by category  

  

network_scanners=("nmap" "masscan" "unicornscan" "netcat" "netdiscover" "fping" "xprobe2")  

  

sniffers_analyzers=("wireshark" "tcpdump" "ettercap" "ngrep" "driftnet" "chaosreader" "hexinject" "etherape")  

  

web_scanners=("nikto" "vega" "arachni" "burp" "grabber" "sublist3r" "amass")  

  

osint_tools=("censys" "foca" "skiptracer" "spaghetti" "tinfoleak" "zoomeye")  

  

wireless_tools=("wifiphisher" "bully" "bluelog" "bluetoothctl" "bluemaho")  

  

dns_tools=("dnsrecon" "dnswalk" "dnsmap" "bluto" "fierce2" "dnsenum")  

  

social_engineering=("socialfish" "reelphish" "evilginx2" "setoolkit" "gophish")  

  

vulnerability_scanners=("nikto" "openvas" "vulnwhisperer" "cve-search" "w3af" "skipfish")  

  

exploitation_frameworks=("metasploit" "beef" "routersploit" "empire" "crackmapexec" "veil" "msfvenom")  

  

traffic_analysis=("bro" "suricata" "moloch" "silk")  

  

miscellaneous=("wifite2" "hydra" "snmpenum" "smtp-user-enum" "webshag" "sslscan" "hostapd" "netstat" "ss" "ping" "iptraf" "bmon" "speedtest-cli" "john")  

  

   

  

# ... (previous categories and tools)  

  

   

  

# Additional categories and tools  

  

password_crackers=("hashcat" "ophcrack" "cewl" "johnny")  

  

forensics_tools=("autopsy" "sleuthkit" "volatility" "ddrescue" "photorec" "bulk_extractor")  

  

metadata_analyzers=("exiftool" "foremost" "binwalk" "steghide")  

  

voip_analysis=("voiphopper" "voipong" "sipcrack" "sipdump")  

  

database_audit=("sqlmap" "sqldict" "tnscmd10g" "hexorbase" "nosqlmap")  

  

iot_tools=("shodan" "iotop" "rfcat" "firmwalker" "zigdiggity")  

  

wireless_attacks=("mdk3" "airgeddon" "fluxion" "crackle" "ghost-phisher")  

  

social_media=("twint" "sherlock" "osintgram" "userrecon" "gitrob")  

  

   

  

  

  

   

  

# Even more categories and tools  

  

forensic_frameworks=("the_silver_searcher" "recoll" "rifiuti2")  

  

binary_analysis=("radare2" "gdb" "binaryninja" "ida")  

  

network_defense=("snort" "osquery" "bro" "suricata" "fail2ban" "wazuh")  

  

threat_intelligence=("maltego" "misp" "threatconnect" "threathunter-playbook")  

  

wireless_analysis=("kismet" "aircrack-ng" "wifi-honey" "horst")  

  

reverse_engineering=("ghidra" "angr" "binvis" "radare2")  

  

iot_security=("firmwalker" "mirai" "shikra" "iot-firmware-analysis")  

  

malware_analysis=("yara" "volatility" "cuckoo" "capa" "peepdf" "mcafee-epo")  

  

web_application_security=("burp" "zap" "sqlmap" "wpscan" "owasp-zap")  

  

threat_hunting=("bro" "elk" "yara" "sigma" "cuckoo")  

  

password_cracking=("hashcat" "john" "cewl" "hydra" "patator")  

  

# Function to search for tools 

search_tools() { 

    category_name="$1" 

    shift 

    tools=("$@") 

  

    echo "$category_name:" 

    for tool in "${tools[@]}"; do 

        if command -v "$tool" &>/dev/null; then 

            echo "  $tool is available" 

        fi 

    done 

    echo 

} 

  

# Search for tools in each category 

search_tools "Network Scanners" "${network_scanners[@]}" 

search_tools "Sniffers and Analyzers" "${sniffers_analyzers[@]}" 

search_tools "Web Scanners" "${web_scanners[@]}" 

search_tools "OSINT Tools" "${osint_tools[@]}" 

search_tools "Wireless Tools" "${wireless_tools[@]}" 

search_tools "DNS Tools" "${dns_tools[@]}" 

search_tools "Social Engineering" "${social_engineering[@]}" 

search_tools "Vulnerability Scanners" "${vulnerability_scanners[@]}" 

search_tools "Exploitation Frameworks" "${exploitation_frameworks[@]}" 

search_tools "Traffic Analysis" "${traffic_analysis[@]}" 

search_tools "Miscellaneous" "${miscellaneous[@]}" 

search_tools "Password Crackers" "${password_crackers[@]}" 

search_tools "Forensics Tools" "${forensics_tools[@]}" 

search_tools "Metadata Analyzers" "${metadata_analyzers[@]}" 

search_tools "VoIP Analysis" "${voip_analysis[@]}" 

search_tools "Database Audit" "${database_audit[@]}" 

search_tools "IoT Tools" "${iot_tools[@]}" 

search_tools "Wireless Attacks" "${wireless_attacks[@]}" 

search_tools "Social Media" "${social_media[@]}" 

search_tools "Forensic Frameworks" "${forensic_frameworks[@]}" 

search_tools "Binary Analysis" "${binary_analysis[@]}" 

search_tools "Network Defense" "${network_defense[@]}" 

search_tools "Threat Intelligence" "${threat_intelligence[@]}" 

search_tools "Wireless Analysis" "${wireless_analysis[@]}" 

search_tools "Reverse Engineering" "${reverse_engineering[@]}" 

search_tools "IoT Security" "${iot_security[@]}" 

search_tools "Malware Analysis" "${malware_analysis[@]}" 

search_tools "Web Application Security" "${web_application_security[@]}" 

search_tools "Threat Hunting" "${threat_hunting[@]}" 

search_tools "Password Cracking" "${password_cracking[@]}" 
