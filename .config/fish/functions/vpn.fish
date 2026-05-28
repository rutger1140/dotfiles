function vpn -d "Toggle Proton VPN servers"
    set -l active (sudo wg show interfaces 2>/dev/null)

    switch "$argv[1]"
        case "" off down
            if test -n "$active"
                sudo wg-quick down $active
                echo "🔓 VPN disconnected"
            else
                echo "VPN was not active"
            end
        case status
            if test -n "$active"
                echo "🔒 Active: $active"
                echo "IP: "(curl -4 -s --max-time 3 ifconfig.me)
            else
                echo "🔓 VPN off"
                echo "IP: "(curl -4 -s --max-time 3 ifconfig.me)
            end
        case list ls
            echo "Available configs:"
            sudo ls /etc/wireguard/ | grep '^proton.*\.conf$' | sed 's|proton\(.*\)\.conf|  \1|'
        case '*'
            if not sudo test -f /etc/wireguard/proton$argv[1].conf
                echo "❌ Config /etc/wireguard/proton$argv[1].conf does not exist"
                echo "Available:"
                sudo ls /etc/wireguard/ | grep '^proton.*\.conf$' | sed 's|proton\(.*\)\.conf|  \1|'
                return 1
            end
            if test -n "$active"
                sudo wg-quick down $active
                or echo "⚠️  Down failed for $active"
            end
            if sudo wg-quick up proton$argv[1]
                echo "🔒 VPN connected: $argv[1]"
            else
                echo "❌ VPN connect failed for $argv[1]"
                return 1
            end
    end
end
