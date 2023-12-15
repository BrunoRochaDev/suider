# SUIDer

This repository is a modified version of [etc5had0w's SUID binary exploitation tool](https://github.com/etc5had0w/suider).

The adjustments include an updated list of vulnerable binaries sourced from [GTFOBins](https://gtfobins.github.io/), as well as the distinction between "SUID" and "Limited SUID".

Notably, the tool no longer conducts a search for SUID binaries on the local machine; instead, it requires a text file containing the output of a search conducted on the target machine.

## How To Use :

* Copy paste this code to clone this script into your system by : 
`git clone https://github.com/BrunoRochaDev/suider.git`

* Set permission to make it executable by :
`chmod +x suider.sh`

* On the target machine, search for SUID binaries and save the output to a file :
`find / -perm -u=s -type f 2>/dev/null > suid.txt`

* Back on your system, run the script with the output file as a parameter.
`./suider.sh ./suid.txt`
