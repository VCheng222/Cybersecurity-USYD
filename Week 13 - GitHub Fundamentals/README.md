# Project-1
 ## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Diagrams/Network-Topology.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.

  [Ansible Config](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/ansible.cfg)
  
  [Ansible Hosts](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/hosts)
  
  [Filebeat Config](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/filebeat-config.yml)
  
  [Filebeat playbook](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/filebeat-playbook.yml)
  
  [Install Elk](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/install-elk.yml)
  
  [Metricbeat Config](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/metricbeat-config.yml)
  
  [Metricbeat playbook](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/metricbeat-playbook.yml)
  
  [Pentest playbook](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Ansible/pentest.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly effective, in addition to restricting traffic to the network.

    - Load balancing can prevent unwanted traffic and defends attacks such as DDoS attacks by shifting traffic. It distrubutes traffic evenly across networks to prevent failure caused by overloading.

    - Jump box is a system on a network that us used to access and manage devices in a seperate security zone, therefore it adds an extra layer of security protection.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the configuration files and system files.
- Filebeat enables users to monitor logs files or log events.
- Metricbeat collects metric data from severs and services.

The configuration details of each machine may be found below.

| Name     | Function  | IP Address | Operating System |
|----------|-----------|------------|------------------|
| Jump Box | Gateway   | 10.0.0.7   | Linux            |
| Web-1    | Webserver | 10.0.0.12  | Linux            |
| Web-2    | Webserver | 10.0.0.13  | Linux            |
| Web-3    | Webserver | 10.0.0.14  | Linux            |
| ElkStack | Webserver | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 220.224.131.10

Machines within the network can only be accessed by Jumpbox. In order to access the ELK Server it must be from the IP address 220.224.131.10 via port 5601.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 220.224.141.10       |
| Web-1    | No                  | 10.0.0.7             |
| Web-2    | No                  | 10.0.0.7             |
| Web-3    | No                  | 10.0.0.7             |
| ElkStack | No                  | 10.0.0.7             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Ansible is very simple to set up and use and comes with many advantages in configuring machines. By using ansible it can remove the possiblity of human error when new machines are setup this will ensure that system across platforms are properly setup with the same configurations.

The playbook implements the following tasks:
- Installation of docker.io
```#Install docker with apt
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present
 ```
- Increase virtual memory
```#Use command module
    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144
```
- Download and launch a docker elk container
```#Use docker_containter module
    - name: download and launch a docker elk container
      docker_container:
         name: elk
         image: sebp/elk:761
         state: started
         restart_policy: always
```
- Enable docker server on boot
```#Use systemd module
    - name: Enable service docker on boot
      systemd:
          name: docker
          enabled: yes
```

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2013%20-%20GitHub%20Fundamentals/Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.0.0.12
- Web-2: 10.0.0.13
- Web-3: 10.0.0.14

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is a lightweight shipper for forwarding and centralizing log data. Installed as an agent on your servers, Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- Metricbeat consists of modules and metricsets. A Metricbeat module defines the basic logic for collecting data from a specific service, such as Redis, MySQL, and so on. The module specifies details about the service, including how to connect, how often to collect metrics, and which metrics to collect.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml and metricbeat-config.yml file to /etc/ansible/files.
- Update the ansible hosts file to include webservers and elk server
    - **NOTE:** webserver is where beats are installed, elk server is where beats are analysed
- Run the playbooks using the following commands:
    - ansible-playbook filebeat-playbook.yml
    - ansible-playbook metricbeat-playbook.yml
- Navigate to http://(Elk-VM publicIP:5601/app/kibana) to check that the installation worked as expected.

Specific commands the user will need to run to download the playbook, update the files (Commands needed to setup up a new VM)

| Command                                       | Function                                          |
|-----------------------------------------------|---------------------------------------------------|
| curl -L -O [file url]                         | Downloading file from http/https services         |
| nano /etc/ansible/hosts                       | Edit hosts file to include webserver and elk VM   |
| nano /etc/ansible/ansible.cfg                 | Configurate ansible file                          |
| nano /etc/ansible/filebeat-config.yml         | Indicate which VM Filebeat will be installed on   |
| nano /etc/ansible/metricbeat-config.yml       | Indicate which VM Metricbeat will be installed on |
| ansible-playbook /path-to-ansible/ [file.yml] | Run YAML file                                     |

