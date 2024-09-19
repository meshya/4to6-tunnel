- [4to6 Tunnel](#4to6-tunnel)
  - [Technical Overview](#technical-overview)
  - [How to Use](#how-to-use)
      - [Server A](#server-a)
      - [Server B](#server-b)
  - [Testing](#testing)
      - [On Server A](#on-server-a)
      - [On Server B](#on-server-b)
  - [Warning](#warning)
  - [Options for making a proxy](#options-for-making-a-proxy)
    - [IP/Port Forwarding](#ipport-forwarding)
      - [Step 1: Server A](#step-1-server-a)
      - [Step 2](#step-2)
    - [Use Xray on Both Servers](#use-xray-on-both-servers)
    - [Use Custom Tunneling Methods](#use-custom-tunneling-methods)
  - [Tip](#tip)
  - [Change settings](#change-settings)
  - [Delete 4to6tunnel](#delete-4to6tunnel)
  - [References](#references)

# 4to6 Tunnel

The 4to6 tunnel is similar to the 6to4 tunnel with the following advantages:

1. Your effective IP address between two servers will be IPv6.
2. IPv6 is inexpensive and can be changed easily if blocked.
3. Your IPv4 addresses on both sides will be protected from blocking.

## Technical Overview

The setup involves two nodes, A and B:

```
Tehran ------------------GFW----------------- Tokyo 
   A <---------------------------------------> B
```

A tunnel is created between these two nodes:

```
Tehran ------------------------------------------GFW----------------------------------------- Tokyo 
   A                                                                                          B
| virtual IPv4 <---- 4to6 ----> real IPv6 | <------IPv6-----> | real IPv6 <---- 4to6 ----> virtual IPv4 |
```

IPv4 packets are encapsulated within IPv6 packets and transmitted over an IPv6 network. If an IP is blocked, it will be an IPv6 address and can be easily replaced, as IPv6 addresses are generally more cost-effective than IPv4 addresses.

## How to Use

You will need two servers with IPv6 support.

#### Server A

```bash
curl -o 6to4install.sh https://raw.githubusercontent.com/meshya/4to6-tunnel/main/scripts/install.sh; sudo bash 6to4install.sh; rm 6to4install.sh
```

| Field | Value |
|-------|-------|
| E0    | Server A IPv6 |
| E2    | Server B IPv6 |
| E4    | 192.168.1.1/24 |

#### Server B

```bash
curl -o 6to4install.sh https://raw.githubusercontent.com/meshya/4to6-tunnel/main/scripts/install.sh; sudo bash 6to4install.sh; rm 6to4install.sh
```

| Field | Value |
|-------|-------|
| E0    | Server B IPv6 |
| E2    | Server A IPv6 |
| E4    | 192.168.1.2/24 |

## Testing

#### On Server A

```bash
ping 192.168.1.2
```

#### On Server B

```bash
ping 192.168.1.1
```

## Warning

If one of your servers is already using a 192.168.x.x network, you may need to use 172.16.x.x/12 (e.g., 172.16.0.1/12 and 172.16.0.2/12) instead. If you are unsure, open an issue and include the output of `ip addr`.

## Options for making a proxy

There are three methods to make a proxy on this tunnel:

1. IP/Port Forwarding
2. Use Xray on Both Servers
3. Use Custom Tunneling Methods

### IP/Port Forwarding

For those unfamiliar with IP/Port forwarding, it is recommended to read more about it and perform the configuration manually. 

[This article](https://tecadmin.net/setting-up-a-port-forwarding-using-iptables-in-linux/) provides guidance on setting up port forwarding.

Here is a quick setup guide:

To forward a single port (e.g., port 80), use the following settings (assuming virtual IPs of 192.168.1.1 for Server A and 192.168.1.2 for Server B).

#### Step 1: Server A

```bash
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.2:80 
iptables -t nat -A POSTROUTING -j MASQUERADE 
```

#### Step 2

If the setup works, add the commands to `local.rc`.

### Use Xray on Both Servers

Install the Xray service on both servers and configure Server A to route data through a proxy on Server B. This configuration can be simplified using 3x-ui. For assistance, contact me (I am available as meshya everywhere and meshyah on Telegram).

Note: Use 192.168.1.2 instead of the real IP of Server B when configuring Xray on Server A.

### Use Custom Tunneling Methods

While not recommended, you can use custom tunneling methods such as [Reverse TLS](https://github.com/radkesvat/ReverseTlsTunnel) or [Fake TLS](https://github.com/radkesvat/FakeTlsTunnel) on top of the 4to6 tunnel if you are familiar with these techniques.

Note: Use virtual IPs (192.168.x.x) instead of real IPs.

## Tip

When using [Method 2](#use-xray-on-both-servers), consider adjusting routing rules and utilizing the [Iran Hosted Domain Project](https://github.com/bootmortis/iran-hosted-domains) to direct traffic for Iran-hosted websites and services, especially Shaparak and payment services, from an Iranian IP. This setup will prevent users from needing to toggle their proxies.

## Change settings

You may need to change settings of tunnel for example in the case, one of your IP's changes

For this reason edit `/etc/4to6tunnel/conf.sh`

## Delete 4to6tunnel

You may use this script

```bash
curl https://raw.githubusercontent.com/meshya/4to6-tunnel/main/scripts/uninstall.sh -o /tmp/uninstall4to6.sh && sudo bash /tmp/uninstall4to6.sh && rm /tmp/uninstall4to6.sh
```


## References

1. [Linux document project - ip4 in ip6 tunneling](https://tldp.org/HOWTO/Linux+IPv6-HOWTO/ch10.html
)

2. [RFC2437](http://www.faqs.org/rfcs/rfc2473.html)


<br>
<br>
<br>

```
Edited by chatgpt
```
