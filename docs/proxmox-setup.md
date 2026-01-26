# Proxmox Configuration

## PVE Setup

- 3-nodes (Tarkin, Ozzel, Thrawn)

- Proxmox Datacenter Manager in VM on Tarkin for centralized management. Will be moved to bare-metal in time.

## Storage Configuration

### ZFS Pool on Tarkin

- Pool: rpool

- Layout: RAIDZ1 (3x 2TB drives)

- Features: compression=lz4, snapshots enabled

- Usage: VM/LXC storage, important (to me) data

### Network Configuration

- vmbr0: Primary management bridge, VLAN-aware

- vmbr0.83: VLAN83 sub-interface with static IP for third-party hosting

- Guest isolation achieved through tagged VLANs on vmbr0

- Multiple VLANs for service segmentation

## Backup Strategy

- Proxmox Backup Server on Thrawn

- Weekly incremental backups

- Retain the last 3 backups

- ZFS snapshots before major changes
