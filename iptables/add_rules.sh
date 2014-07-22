#!/bin/bash

read -p "Do you need Samba ports expose (yes/no, default: no)? " ANSWER
if [[ $ANSWER == 'yes' || $ANSWER == 'y' ]]; then
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/iptables/iptables_samba.sh | /bin/bash
else
    curl -s https://raw.githubusercontent.com/titovanton/bicycle-docker/master/iptables/iptables.sh | /bin/bash
fi
echo '#!/sbin/iptables-restore' > /etc/network/if-up.d/iptables-rules
iptables-save >> /etc/network/if-up.d/iptables-rules
chmod +x /etc/network/if-up.d/iptables-rules
