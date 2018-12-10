#! /bin/bash





func(){
    url=${links[i]} 
    curl -s -o sum$i.txt $url 
    if [ $? -ne 0 ]
    then
        echo "$url FAILED"
        echo  "URLfailed" > backup$i.md5
    else
        md5sum sum$i.txt | cut -c -32 > sum$i.md5 
    
        if [ -e "backup$i.md5" ] 
        then 
            if [ $(cat sum$i.md5) != $(cat backup$i.md5) ] 
            then 
                echo "$url" 
                cat sum$i.md5 > backup$i.md5 
            fi 
        else 
            cat sum$i.md5 > backup$i.md5 
            echo "$url INIT" 
        fi 
        rm sum$i.txt 
        rm sum$i.md5 
    fi
}




IFS=$'\n' read -d '' -r -a links < list.txt
length=${#links[@]}

for(( i=0; i<$length; i++ )) 
 do 
    func "$i" &
 done
 wait