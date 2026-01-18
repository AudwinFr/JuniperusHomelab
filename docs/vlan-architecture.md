# VLAN Architecture

## Design Philosophy

Zone-based network segmentation following defense-in-depth principles. Default-deny firewall rules with explicit allow policies punched on a case-by-case basis.

## VLAN Configuration

| VLAN | Name | Subnet | Purpose | Description |
|------|---------|-------------|
| 1 | Management | 10.1.1.0/24 | Network infrastructure | Gateway, Switches, APs |
| 20 | Infrastructure | 192.168.20.0/24 | Core Services | hypervisors, DNS, monitoring |
| 30 | Trusted | 192.168.30.0/24 | Primary Devices | Workstations, phones, tablets |
| 40 | IoT | 192.168.40.0/24 | Smart Home | Isolated IoT devices, TVs |
| 50 | Security | 192.168.50.0/24 | Cameras | Security systems |
| 83 | Tosche_Station | 192.168.83.0/26 | 3rdparty hosted services | VMs and LXCs hosted for 3rdparty |
| 99 | Guest | 192.168.99.0/24 | Visitors | Internet-only access |

L3 routing not enabled on core switch. All vlan routing handled by UDM Pro.

## Firewall Rules Philosophy

### Default Policy
- All inter-VLAN traffic: **DENY**
- Explicit allow rules created based on service requirements

### Rule Examples

**Management VLAN → All VLANs**
- Full access for administrative purposes
- SSH, HTTPS, Proxmox web interface

**Infrastructure VLAN → IoT VLAN**
- Home Assistant needs to communicate with IoT devices
- MQTT, HTTP/HTTPS to specific devices

**Trusted VLAN → Infrastructure VLAN**
- Access to DNS (Pi-hole)
- Access to NAS file shares
- Access to documentation (Bookstack)

**Guest VLAN**
- Internet access only
- No access to any other VLANs
- DHCP provided by gateway

**IoT VLAN**
- No access to Trusted or any other vlan. Return traffic only with few exceptions.
- Can communicate with Infrastructure for Home Assistant integration

**Security VLAN**
- Fully isolated
- Only Infrastructure VLAN can access (for NVR/recording)
- No internet access
- Rule to allow NTP. Will be removed once I build RPi4 with GPShat as NTP server.

## WiFi SSID Mapping

| SSID | VLAN | Purpose |
|------|------|---------|
| Juniperus | Trusted | Main network for personal devices |
| Juniperus_IoT | IoT | Smart home devices |
| Juniperus_Guest | Guest | Visitor access |
| Juniperus_mgmt (hidden) | Management | Trusted laptop and phone only | 

## Multi-Site Considerations

### Juniperus (Primary Site)
- Full VLAN stack deployed
- All services running locally
- 1Gbps fiber connection

### Lothal (Remote Site)
- Simplified VLAN structure (Default, IoT and Infrastructure)
- Essential services only (HA, Docker)
- Site-to-site VPN for management (Unifi Mesh Site-Magic)
- 100Mbps fiber connection

### Tosche_Station (3rd Remote Site)
- Simpler VLAN structure (Default only, flat network)
- No services running
- Tunnel to vlan83 at Juniperus
- 1Gbps connection

## Security Considerations

1. **Network Segmentation**: Limits blast radius if one zone is compromised
2. **IoT Isolation**: Prevents potentially vulnerable devices from accessing sensitive data
3. **Guest Network**: Complete isolation from internal resources
4. **Management Access**: Restricted to dedicated VLAN with strong authentication
5. **DNS Filtering**: Pi-hole provides network-wide ad and malware blocking

## Future Improvements

- Layer 3 routing on Core switch
- Streamline network
- Add 1 more AP to main site
