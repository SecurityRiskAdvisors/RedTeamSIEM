# Elastic for Red Teaming

## Overview

Repository of resources for configuring a Red Team SIEM using Elastic

## Directory structure

```
.
├── ansible
│     └── Ansible playbooks for deploying an Elastic instance and configuring clients to forward the relevant logs 
├── elastalert
│     └── Elastalert example rules and configuration files
├── elastic
│     └── Example static configuration files
└── resources
      └── Resources for related services/technology such as Cobalt Strike
```

## Roadmap

- Update ELK services to latest version
- Refine playbooks added to reference repo
- Evaluate alternatives (e.g. Fluentd vs Logstash, Grafana vs Kibana, Rsyslog vs Beats)

