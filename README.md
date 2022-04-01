# multipass-vpnkit

Inject vpnkit network interface in Canonical Multipass.run

## Problem

Canonical Multipass.run https://multipass.run/ is great for spawning Ubuntu VM quickly. Unfortunately on MacOS Multipass VMs can't access resources located behind a VPN.
This "hack" makes Multipass (hyperkit) play nice with corporate VPNs by using VPNKit https://github.com/moby/vpnkit.

## How it works

The idea is to substitute the `hyperkit` binary by a shell script that injects a secondary network interfaces connected to vpnkit `-s 2:1,virtio-vpnkit,path=/var/run/vpnkit.socket`.
Credit for this technique goes to https://github.com/AlmirKadric-Published/docker-tuntap-osx.

## Dependencies

You need to install **Docker For Mac** https://www.docker.com/docker-mac or manually install **VPNKit** binary in `/usr/local/bin/vpnkit`.

## Installation

```bash
Usage:
  make <target> <variables>

Example:
  make vpnkit

Targets:
  hack     Install hack
  vpnkit   Configure vpnkit
```

### Configure VPNKit

Install `io.pixelfactory.vpnkit.plist`.

```bash
$ make vpnkit
make[1]: Entering directory '/Users/amine/Dev/multipass-vpnkit/vpnkit'
/Library/LaunchDaemons/io.pixelfactory.vpnkit.plist: service already loaded
make[1]: Leaving directory '/Users/amine/Dev/multipass-vpnkit/vpnkit'
```

### Install hack

Move original **hyperkit** binary to `/Library/Application\ Support/com.canonical.multipass/bin/hyperkit.original` and replace it with `hyperkit.sh`.

```bash
$ make hack
```

### Usage

You can use Multipass as usual. The script `hyperkit.sh` will "inject" the network interface `virtio-vpnkit,path=/var/run/vpnkit.socket`.

```bash
# Start your VM with injected network configured
$ multipass launch --name ubuntu --cloud-init - <<EOF
runcmd:
  - dhclient enp0s2f1
EOF

# Check ip
$ multipass exec ubuntu -- ifconfig enp0s2f1
enp0s2f1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.66.5  netmask 255.255.255.0  broadcast 192.168.66.255
        inet6 fe80::50:ff:fe00:3  prefixlen 64  scopeid 0x20<link>
        ether 02:50:00:00:00:03  txqueuelen 1000  (Ethernet)
        RX packets 5  bytes 832 (832.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 23  bytes 3614 (3.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```

You can know access your private resources (behind corporate VPN) from your VM.

### Uninstall

```bash
sudo -i
cd /Library/Application\ Support/com.canonical.multipass/bin/
mv hyperkit.original hyperkit
```

