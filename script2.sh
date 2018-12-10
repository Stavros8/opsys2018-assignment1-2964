#! /bin/bash


tar xf file.tar.gz
mkdir clone
find .  -iname '*.txt'  -exec echo "|- {}" \;
IFS=$'\n' read -d '' -r -a lines < file1.txt
length=${#lines[@]}
for (( i=0; i<$length; i++))
do
    url=${lines[i]}
    if [[ $url == https* ]]  
    then 
        repository="$url"

        localFolder="/Users/Stavros/Desktop/clone"

        git clone "$repository" "$localFolder"
    fi

done


