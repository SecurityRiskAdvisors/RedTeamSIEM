#!/bin/bash

#arg check
if [ "$#" -ne 2 ]; then
   printf "Usage: ./csbeat.sh <es_host> <cs_path>\n- es_host should be in the <ip> format\n- cs_path should be in the /path/to/cobaltstrike format\n\n"
   exit 1
fi

echo "[+] Installing filebeat\n"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update && sudo apt-get install filebeat metricbeat
sudo update-rc.d filebeat defaults 95 10
sudo update-rc.d metricbeat defaults 95 10

eshost=$1
cspath=$2
echo "[+] Retrieving Certs"
sudo mkdir /etc/beat
sudo curl -s http://$eshost:8080/beat-forwarder.crt -o /etc/beat/beat-forwarder.crt
sudo curl -s http://$eshost:8080/beat-forwarder.key -o /etc/beat/beat-forwarder.key

echo "[+] Writing beat configs"
sudo cat > /etc/filebeat.yml << EOF
filebeat.prospectors:
- type: log
  enabled: true
  paths:
    - $cspath/weblog.log
    - $cspath/events.log
    - $cspath/logs/**/*.log
output.logstash:
  hosts: ["$eshost:5044"]
  ssl:
    certificate_authorities: [/etc/beat/beat-forwarder.crt]
    certificate: "/etc/beat/beat-forwarder.crt"
    key: "/etc/beat/beat-forwarder.key"
EOF
sudo cat > /etc/metricbeat.yml << EOF
mbconfig="metricbeat.modules:
- module: system
  period: 10s
  metricsets:
    - cpu
    - load
  cpu.metrics: [percentages]
output.logstash:
  hosts: ["$eshost:5044"]
  ssl:
    certificate_authorities: [/etc/beat/beat-forwarder.crt]
    certificate: "/etc/beat/beat-forwarder.crt"
    key: "/etc/beat/beat-forwarder.key"
EOF

echo "[+] Applying beat configs"
sudo service filebeat restart
sudo service metricbeat restart

echo "[+] Done!"

