#!/bin/sh

curl -fsSL https://tailscale.com/install.sh | sh

# make sure the installation is suceeded
if [ ! -f "/usr/bin/tailscale" ]; then
  echo "Tailscale doesn't seem to be installed properly. Existing..." >&2
  poweroff
  exit 1
fi

# https://tailscale.com/kb/1320/performance-best-practices?q=performance
printf '#!/bin/sh\n\nethtool -K %s rx-udp-gro-forwarding on rx-gro-list off \n' "$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")" | sudo tee /etc/networkd-dispatcher/routable.d/50-tailscale
sudo chmod 755 /etc/networkd-dispatcher/routable.d/50-tailscale
sudo /etc/networkd-dispatcher/routable.d/50-tailscale

# https://tailscale.com/kb/1103/exit-nodes?tab=linux
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

cat <<EOF
Please run the following example command over SSM sessions manager and approve it to join your tailnet
sudo tailscale up --advertise-tags=tag:TAG --ssh --advertise-exit-node
EOF
