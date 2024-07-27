#!/bin/bash

if [ "$UID" -ne 0 ]; then
    echo "Use sudo bro"
    exit 0
fi

work_dir=$( mktemp -d )
cd $work_dir
source_url=$(curl -s https://api.github.com/repos/meshya/4to6-tunnel/releases/latest \
                        | grep -oP '"tarball_url": "\K(.*)(?=")')
curl -L -o ./source.tar.gz "$source_url"
tar -xf ./source.tar.gz
rm source.tar.gz
mv * source
cd source/src

echo "Enter local server ipv6: [E0] "
read local_ip6

echo "Enter remote server ipv6: (another server) [E2] "
read remote_ip6

echo "Choose you virutal network ip4 and netmask"
echo "Suggested to use 192.168.1.1/24"
echo "for one server and 192.168.1.2/24"
echo "for another one,"
echo "Enter your choose for current "
echo "server : [E4] "
IFS='/' read local_ip4 local_ip4netmask 

conf="/etc/4to6tunnel/conf.sh"

install -Dm 755 ./conf.sh "$conf"
rm "$conf"

echo "#!/bin/bash" > "$conf"
echo "export IP4TO6TUNNEL_LOCAL=""\"$local_ip6\"" >> "$conf"
echo "export IP4TO6TUNNEL_REMOTE=""\"$remote_ip6\"" >> "$conf"
echo "export IP4TO6TUNNEL_IP4=""\"$local_ip4\"" >> "$conf"
echo "export IP4TO6TUNNEL_IP4NETMASK=""\"$local_ip4netmask\"" >> "$conf"

install -m 755 ./4to6tunnelstart /usr/bin/4to6tunnelstart
install -m 755 ./4to6tunnelstop /usr/bin/4to6tunnelstop
install -m 644 ./4to6tunnel.service /etc/systemd/system/4to6tunnel.service

systemctl daemon-reload
systemctl enable --now 4to6tunnel

echo "Configuring 4to6 tunnel done"
echo "In hope of one day which no need to any tunnel"
