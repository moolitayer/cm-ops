# cm-ops alerts

## What

This document explains how to setup and view alerts in ManageIQ for the cm-ops flow.
A diagram is available in https://drive.google.com/a/redhat.com/file/d/0B6b5rGdg1hPBWTJWb3NFU3FRWmc/view?usp=sharing

## Prerequisites
- CFME 5.8 and up
- OCP 3.5.1 and up

## Setup

sudo dnf install redhat-rpm-config
sudo dnf install ansible pycryptopp
Fetch manageiq-ansible-modules:
```
# replace with package when available
git clone https://github.com/dkorn/manageiq-ansible-module.git ${PREFIX}/manageiq-ansible-module
pip install --user -r manageiq-ansible-module/requirements.txt
```

view help for modules:
```
ansible-doc -M ${PREFIX}/manageiq-ansible-module/library/ manageiq_alert.py #help
```

Add a container provider and a DWH providers:
```
ansible-playbook ./ansible/add_providers.yml -M ${PREFIX}/manageiq-ansible-module/library/ # debug with -vvv
OR user ruby script
```

Add an datawarehouse alert
```
# This isn't working yet and should be done manualy
ansible-playbook ./ansible/add-alert.yml -M ${PREFIX}/manageiq-ansible-module/library/
```

Add some settings to manageIQ & restart it
```
cat config/settings.local.yml
#:product:
#  :datawarehouse_manager: true
:prototype:
  :monitoring: true
:log:
  :level_datawarehouse: debug
:workers:
  :worker_base:
    :event_catcher:
      :event_catcher_hawkular_datawarehouse:
        :poll: 10.seconds
        :alertable_tenants: ['_system','_ops']
# restart servuce
systemctl restart evmserverd
```

## Setup hawkular to send out alerts
```
cd hawkular
01-push-trigger.sh
02-list-triggers.sh
...
```