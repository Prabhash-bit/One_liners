#!/bin/bash 
echo 'Tools used=> Amass, subfinder, knockpy, httpx, dnsx, naabu'
echo 'install all above tools before exutions of script'
echo 'Enter domain name for Amass scan:'
read url1

# ask the user to input filenames
#read -p "Enter filenames for output(onefile_name): " $url1.txt
echo "Creating Folder for $url1"
mkdir $url1
echo "The file name is: $url1-amass.txt"


echo 'Scannig with <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<AMASS>>>>>>>>>>>>>>>>>>>>>>>>>>>'

amass enum  -passive -d $url1 -o $url1-amass.txt

mv $url1-amass.txt ./$url1
echo '<<<<<<<<<<<<<<<<scanning with amass ended>>>>>>>>>>>>>' | cat ./$url1/$url1-amass.txt


#echo '<<<<<<<<<<<<<<<<<<<<<<<Time for knockpy>>>>>>>>>>>>>>>>>>>>>>>>>>>'

#echo 'Enter domain name for knockpy:'
#read url2

#read -p "Enter file Name for output(onefile_name):" domainname

#echo "The file name is: $url2-knockpy.txt"
#echo 'Scanning with<<<<<< knockpy>>>>>>>> built with python3'
 
#knockpy $url2  > $url2-knockpy.txt  
#mv $url2-knockpy.txt ./$url1
#echo '<<<<<<<<<<<<<<<Scanning Ended with Knockpy>>>>>>>>>>>>>>>>>>>>>>>>>' | cat ./$url1/$url2-knockpy.txt

echo 'Scanning with<<<<<<<<<<<<<<<<< Subfinder>>>>>>>>>>>>>>>>>>>>>>>, Name of folder will be fromsubfinder.txt'
echo 'Enter Valid domain name for subfinder:'
read url3

echo "The file name is: $url3-subfinder.txt"
subfinder -d $url3 -o $url3-subfinder.txt

mv $url3-subfinder.txt ./$url1

echo 'Scanning with<<<<<<<<<<<<<<<<< ffuf>>>>>>>>>>>>>>>>>>>>>>>, Name of folder will be fromsubfinder.txt'
echo 'Enter Valid domain name for ffuf:'
read url4

echo "The file name is: $url3-ffuf.txt"

ffuf -u https://FUZZ.$url4 -w /home/kali/Training/wordlistforfuff.txt:FUZZ -o $url4-ffuf.txt
cat $url4-ffuf.txt |jq |grep "\"url" | tr "\"," " " | sed -e "s/url ://g" | tr -d "[:blank:]" |sed -e "s/https:\/\///g" | grep -v 'FUZZ' | sort -u > $url4-ffuf_filtered_urls.txt

mv $url4-ffuf_filtered_urls.txt ./$url1

echo '	\**********************************'
echo '	\*************************************'
echo '	\****************************************'
echo '	\********************************************'
echo '	\**************************************************'

echo 'Time to merge files you want' | ls ./$url1

echo '*********************Select from above lists*******************************'
cd $url1
# ask the user to input filenames
read -p "Enter filenames separated by a Space you want to merge: " -a multifiles

# use a for loop to iterate through the filenames
for filenames in "${multifiles[@]}"; do
  # do something with the filename
  echo "The file name is: $filenames"
done
echo "cat ${multifiles[*]} | sort -u > sorted_subdomains.txt"
cat ${multifiles[*]} | sort -u > sorted_subdomains.txt

#mv sorted_subdomains.txt ./$url1
echo 'Active Subdomains listed in (activesubdomains.txt)'
echo '----------------------------------------- - - -  - - -  - - --  - - - - - - -- - -  - - - - -'
httpx -list sorted_subdomains.txt > activesubdomains.txt 
#mv activesubdomains.txt ./$url1
echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4'
echo ''
echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Naabu scanning>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
naabu -l sorted_subdomains.txt -pe > naabu_final_result.txt

#mv naabu_final_result.txt ./$url1
echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Dnsx Scanning>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

dnsx -l sorted_subdomains.txt -a -resp -o domains_ip.txt
#mv domains_ip.txt ./$url1
echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<END>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
echo 'Get your results from files listed below---------->>>>>>>>>>>>' | ls
