#!/bin/bash
#
#
echo 'H)    hh                   t)      F)ffffff ##              d)                 
H)    hh                 t)tTTT    F)                       d)                 
H)hhhhhh  o)OOO   s)SSSS   t)      F)fffff  i) n)NNNN   d)DDDD e)EEEEE  r)RRR  
H)    hh o)   OO s)SSSS    t)      F)       i) n)   NN d)   DD e)EEEE  r)   RR 
H)    hh o)   OO      s)   t)      F)       i) n)   NN d)   DD e)      r)      
H)    hh  o)OOO  s)SSSS    t)T     F)       i) n)   NN  d)DDDD  e)EEEE r)      
                                                                            '
echo "Virtual Host Finder by Prabhash"
echo '          \__/         # ##
         `(  `^=_ p _###_
          c   /  )  |   /
   _____- //^---~  _c  3
 /  ----^\ /^_\   / --,-
(   |  |  O_| \\_/  ,/
|   |  | / \|  `-- /
(((G   |-----|
      //-----\\
     //       \\
   /   |     |  ^|
   |   |     |   |
   |____|    |____|
  /______)   (_____\

'
   echo 'Enter (y(yes)/n(no)) to run this script'
read value

if [ $value == 'y' ] || [ $value == 'yes' ]
then
echo 'Enter Valid url:'
read url1

mkdir $url1
# ask the user to input filenames
read -p "Enter options listed above " -a options

# use a for loop to iterate through the filenames
#for filenames in "${options[@]}"; do
echo "ffuf -u https://$url1 -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -H "HOST:FUZZ.$url1" ${options[*]} -o $url1-hosts.txt"

mkdir $url1

echo "Your file is in the $url1 folder"

echo '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>>>>>>><<<<<<<<<<<<<<<<<<<^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
ffuf -u https://$url1 -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -H "HOST:FUZZ.$url1" ${options[*]} -o $url1-hosts.txt


#cat $url1-hosts.txt |jq |grep "\"url" | tr "\"," " " | sed -e "s/url ://g" | tr -d "[:blank:]" |sed -e "s/https:\/\///g" | grep -v 'FUZZ' | sort -u > $url1-vhosts.txt
cat $url1-hosts.txt | jq | grep "host" | grep -v "FUZZ" | grep -v "false" | grep -v "outputfile" | awk '{print $2}' | tr '"' " " | tr -d '[:blank:]' > $url1-vhosts.txt
rm $url1-hosts.txt
#mv $url1-hosts.txt ./$url1
mv $url1-vhosts.txt ./$url1
else
	echo 'Terminated'
fi
