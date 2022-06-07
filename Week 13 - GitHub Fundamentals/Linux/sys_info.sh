#~/bin/bash

output_folder=~/Research
output=~/$output_folder/sys_info.txt

echo "System Audit Script" >> $output
echo "Running on " >> $output
date >> $output

echo "Machine Type Info: " >> $output
echo $MACHTYPE >>$output

echo "Uname info is:" >> $output
uname >> $output


echo "IP Address" >> $output
hostname -I | awk '{print $1}' >> $output

echo "Host" >> $output
hostname >> $output

echo "DNS info" >> $output
dig -v >> $output

echo "all save in outout"

# create output folder if it doesn't exist

if [ ! -d $output_folder ]
then
mkdir $output_folder
else
echo "folder exist"
fi


sys_info.txt=$output

if [ -f sys_info.txt ]
then
rm sys_info.txt
fi

