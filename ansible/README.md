# Ansible playbooks for configuring Elastic

The original version of this can be found here: https://github.com/sadsfae/ansible-elk. This version is mostly a mirror of the original with some minor configuration variations. Additionally, it includes several new roles. The elastalert role will install and start Elastalert on an ELK host. This role is bundled in the **elk.yml** playbook as well as in a standlone **alert.yml** playbook. The elk-deb-client role will install Filebeat and Metricbeat on a Debian-based host and modify their configurations. The elk-cs-client role is the same as the elk-deb-client with a modified path (defined by the cs_path, which needs to be specified by extra-vars).

*Note:* While this repo contains configs for services like Fluentd, the majority of SRA's testing was done using Elasticsearch/Logstash/Kibana/-Beats

## Example Usage

Edit the **hosts** file with the appropriate hosts. Edit the **install/group_vars/all.yml** file to match your desired configuration.

To configure the ELK instance, run:

```
ansible-playbook -i hosts install/elk.yml
```

To configure the client instance, run (replacing 10.0.0.1 with the IP of the ELK instance):

```
ansible-playbook -i hosts install/elk-client.yml --extra-vars 'elk_server=10.0.0.1'
```

To configure log forwarding for a Cobalt Strike running on Ubuntu, run:

```
ansible-playbook -i hosts install/cs.yml --extra-vars 'elk_server=10.0.0.1 cs_path=/opt/cobaltstrike'
```

*note: Make sure to set the appropriate user name for SSH connections. The default is 'ec2-user'. You can override this when installing playbooks by specifying the 'ansible_system_user=username' in the --extra-vars option
