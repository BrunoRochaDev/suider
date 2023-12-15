#!/bin/bash
#Based on the works of : etc5had0w
#Original: https://github.com/etc5had0w/suider
echo "==================================="
echo " SUIDER - SUID Exploit Finder Tool "
echo "==================================="

echo "[+] Looking for standard exploitable SUID binaries...."

suid_binaries=$(find / -perm -u=s -type f 2>/dev/null | rev | cut -d'/' -f 1 | rev)

suid=(
    aa-exec ab agetty alpine ar arj arp as ascii-xfr ash aspell atobm awk base32 base64 basenc basez bash bc bridge busybox bzip2 cabal capsh cat chmod choom chown chroot clamscan cmp column comm cp cpio cpulimit csh csplit csvtool cupsfilter curl cut dash date dd debugfs dialog diff dig distcc dmsetup docker dosbox ed efax elvish emacs env eqn espeak expand expect file find fish flock fmt fold gawk gcore gdb genie genisoimage gimp grep gtester gzip hd head hexdump highlight hping3 iconv install ionice ip ispell jjs join jq jrunscript julia ksh ksshell kubectl ld.so less logsave look lua make mawk minicom more mosquitto msgattrib msgcat msgconv msgfilter msgmerge msguniq multitime mv nasm nawk ncftp nft nice nl nm nmap node nohup od openssl openvpn pandoc paste perf perl pexec pg php pidstat pr ptx python rc readelf restic rev rlwrap rsync rtorrent run-parts rview rvim sash scanmem sed setarch setfacl setlock shuf soelim softlimit sort sqlite3 ss ssh-agent ssh-keygen ssh-keyscan sshpass start-stop-daemon stdbuf strace strings sysctl systemctl tac tail taskset tbl tclsh tee terraform tftp tic time timeout troff ul unexpand uniq unshare unsquashfs unzip update-alternatives uudecode uuencode vagrant view vigr vim vimdiff vipw w3m watch wc wget whiptail xargs xdotool xmodmap xmore xxd xz yash zsh zsoelim
)

limited_suid=(
    aria2c awk batcat byebug composer dc dvips ed gawk ginsh git iftop joe latex ldconfig lftp lua lualatex luatex mawk mysql nano nawk nc nmap octave pdflatex pdftex pic pico posh pry psftp rake rpm rpmdb rpmquery rpmverify runscript rview rvim scp scrot slsh socat sqlite3 tar tasksh tdbtool telnet tex tmate view vim vimdiff watch xelatex xetex zip
)

exploitable_results=()
for binary in $suid_binaries; do
    if [[ " ${suid[@]} " =~ " $binary " ]]; then
        exploitable_results+=( "$binary:SUID" )
    elif [[ " ${limited_suid[@]} " =~ " $binary " ]]; then
        exploitable_results+=( "$binary:Limited SUID" )
    fi
done

if [[ ${#exploitable_results[@]} -eq 0 ]]; then 
    echo "[-] Nothing Found!"
else
    echo '------------------------------'
    echo " LIST OF EXPLOITABLE BINARIES"
    echo '------------------------------'
    
    for result in "${exploitable_results[@]}"; do
        IFS=":" read -r binary type <<< "$result"
        printf '[+] %s : https://gtfobins.github.io/gtfobins/%s [%s]\n' "$binary" "$binary" "$type"
    done
fi
