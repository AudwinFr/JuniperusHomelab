# Juniperus Homelab

Multi-site infrastructure lab for learning virtualization, networking, automation, and systems administration. Named after the Latin term for my childhood street where I grew up and still live with my family today.

## What This Is

**Personal learning environment for enterprise technologies:**

    • High availability and redundancy patterns 
    • Network segmentation and security 
    • Container orchestration and virtualization 
    • Distributed systems and monitoring 
    • Infrastructure documentation 

## Infrastructure

### Network

**Primary Site: Juniperus**

    • Connectivety: 1Gbps/1Gbps fiber
    • Gateway: UniFi Dream Machine Pro 
    • Switching: USW-Pro-Max-16-POE, USW-8-Lite-POE, USW-Ultra, Flex Mini
    • Wireless: UniFi U7 Pro
    • Tarkin
    • Thrawn
    • Piett
    
**Remote Site: Lothal**

    • Connectivety: 100Mbps/100Mbps fiber
    • Gateway: UniFi Cloud Gateway Ultra 
    • Wireless: UniFi U6 Lite 
    • Ozzel
    
### VLAN Design

| VLAN | Purpose | Description |
|------|---------|-------------|
| Management | Infrastructure | Switches, APs |
| Infrastructure | Core Services | hypervisors, DNS, monitoring |
| Trusted | Primary Devices | Workstations, phones, tablets |
| IoT | Smart Home | Isolated IoT devices, TVs |
| Security | Cameras | Security systems |
| Tosche_Station | 3rdparty | Hosted services |
| Guest | Visitors | Internet-only access |

### Overview

![Homelab overview](https://github.com/AudwinFr/JuniperusHomelab/blob/main/docs/juniperushomelab.jpg?raw=true)

### Compute

**Primary Hypervisor: Tarkin**

    • Hardware: Supermicro 5018D-MTF 
    • CPU: Intel Xeon E3-1240v3 
    • RAM: 32GB ECC 
    • System storage: 240GB Intel SSD
    • Storage: 3x 2TB WD drives in ZFS RAIDZ1 
    • Platform: Proxmox VE 
    Running services:
    • Home Assistant VM (home automation) 
    • Docker VM (containers) 
    • Cloudflare LXC (Zero Trust access) 
    • Bookstack LXC (documentation) 
    • Immich LXC (photos) 
    • Audiobookshelf LXC (media) 
    • NAS Server LXC (file sharing) 
    • Pi-hole LXC (DNS filtering) 
    
**Remote Hypervisor: Ozzel**

    • Hardware: HP EliteDesk 705 G3 
    • CPU: AMD A10-9700E 
    • RAM: 16GB 
    • Storage: 480GB internal SSD 
    • Platform: Proxmox VE     
    Running services:
    • Home Assistant VM (site redundancy) 
    • Docker VM (distributed services) 

### Backup Infrastructure

**Backup Server: Thrawn**

    • Hardware: Custom 1U server
    • CPU: AMD A8-7200p
    • RAM: 8GB
    • Storage: 2TB
    • Platform: Proxmox Backup Server
    • Backup strategy: Automated ZFS snapshots + PBS incremental backups
      
**Management Server: Piett**

    • Hardware: Supermicro 1U
    • CPU: Intel Atom D510
    • RAM: 4GB
    • Platform: Proxmox Datacenter Manager
    • Centralized cluster management for Tarkin, Thrawn, and Ozzel.

**Secondary Backup**

    • Raspberry Pi 4 with OpenMediaVault

**Monitoring**

    • Prometheus on Raspberry Pi 3B+ 
    • Grafana dashboards 
    • Pi-hole DNS statistics 

### Smart Home

**Protocols**

    • Zigbee: SLZB-06 coordinator (PoE) 
    • Matter/Bluetooth: SLZB-06M bridge (PoE) 
    • Z-Wave: Rock Pi S with USB adapter and PoE hat 
    
**Platform**

    • Home Assistant dual-site deployment 
    • 50+ integrated devices 
    • Custom automations for temperature monitoring, equipment protection, presence detection 

### Security

**Zero Trust Implementation**

    • Cloudflare Zero Trust for desktop HA access 
    • mTLS authentication for mobile HA access 
    • VLAN isolation with zone-based firewall rules 
    • Pi-hole for DNS-level blocking 
    
**Access Control**

    • Self-hosted CA for internal services 
    • Cloudflare Access for authentication 
    • Service isolation via LXC containers 
    
**Development Hardware**

    • Orange Pi Zero3 for Docker experiments 
    • Multiple Raspberry Pi systems for distributed testing 

## Tech Stack

**Virtualization**

    • Proxmox VE 
    • LXC Containers 
    • Docker & Docker Compose 
    
**Networking**

    • UniFi Network Stack
    • VLANs with inter-vlan traffic blocked. Holes punched on a case by case need.
       
**Storage**

    • ZFS (RAIDZ1, snapshots, compression) 
    • Proxmox Backup Server 
    • OpenMediaVault 
    
**Scripting**

    • PowerShell (Windows automation) 
    • Bash (Linux management) 
    • Home Assistant YAML 
    
**Monitoring**

    • Prometheus 
    • Grafana 
    • Pi-hole 
    
**Security**

    • Cloudflare Zero Trust 
    • mTLS certificates 
    • Self-hosted CA 

## Learning Focus

Hands-on experience with:

    • Multi-site infrastructure design 
    • Network security and segmentation 
    • Linux/Windows systems administration 
    • Enterprise storage (ZFS) 
    • Automation scripting 
    • Infrastructure monitoring 
    • Technical documentation 
    
## Roadmap

**Next Up**

    • Ansible for configuration management 
    • Reverse-proxy
    • Python automation 
    • Kubernetes cluster 
    • Centralized logging 
    
**Future**

    • Disaster recovery testing 
    • Monitoring alerting 
    • GitOps workflows 
    • Network automation 

## Documentation

Infrastructure docs maintained in local Bookstack:

    • Network diagrams 
    • Service dependencies 
    • Runbooks 
    • Troubleshooting guides 
    • Configuration templates 
    
## Note

Personal learning environment. Security practices shown here are for educational purposes - evaluate against organizational policies before production use. In other words: don't do what I do just because you found it on the internet.
