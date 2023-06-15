#!/bin/bash
echo 'P)ppppp                                        F)ffffff ##              d)                 
P)    pp                                       F)                       d)                 
P)ppppp  a)AAAA   r)RRR  a)AAAA   m)MM MMM     F)fffff  i) n)NNNN   d)DDDD e)EEEEE  r)RRR  
P)        a)AAA  r)   RR  a)AAA  m)  MM  MM    F)       i) n)   NN d)   DD e)EEEE  r)   RR 
P)       a)   A  r)      a)   A  m)  MM  MM    F)       i) n)   NN d)   DD e)      r)      
P)        a)AAAA r)       a)AAAA m)      MM    F)       i) n)   NN  d)DDDD  e)EEEE r)      
                                                                                           '
echo 'Param finder'

wordlist_path = $1
echo 'Enter Valid url:'
read url1
mkdir $url1
read -p "Enter if you want to filter :" -a options1

ffuf -w  $1 -u https://$url1?FUZZ=value ${options1[*]} -o $url1-param.txt

mv $url1-param.txt ./$url1
