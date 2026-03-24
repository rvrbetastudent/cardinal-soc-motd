# Colors - Using your Cardinal Red for the Accent
CA="\e[31m"  # Accent (Red)
CO="\e[32m"  # Ok (Green)
CW="\e[33m"  # Warning (Yellow)
CE="\e[31m"  # Error (Red)
CN="\e[0m"   # None (Reset)

# Max width used for components in the second column
# Since your bird is 65 chars wide, we set this to keep stats aligned
WIDTH=45

# The path to your Cardinal art
# Note: Ensure you renamed your file or change this path to match
BANNER_PATH="/home/reverb/Downloads/fancy-motd-main/banner.txt"

# Services to show (Validated for Rocky Linux 9.7)
declare -A services
services["sshd"]="SSH"
services["firewalld"]="Firewall"
services["NetworkManager"]="Network"
services["dbus"]="System Bus"
services["chronyd"]="Time Sync"

# Storage mount points to monitor
mounts=( "/" )
