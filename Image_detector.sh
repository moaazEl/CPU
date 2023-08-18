#!/bin/bash 

  

function check_image_software() { 

    echo "Searching for image software and viewers..." 

     

    # Common directories where image-related software may be installed 

    declare -a directories=("/usr/bin" "/usr/local/bin" "/bin" "/usr/sbin" "/usr/local/sbin" "/sbin") 

     

    for dir in "${directories[@]}"; do 

        echo "Checking $dir..." 

        for file in $(find "$dir" -maxdepth 1 -type f -executable); do 

            # Check if the file command output contains image-related keywords 

            file_output=$(file "$file") 

            if echo "$file_output" | grep -qiE "*image*|*photo*|*picture*|*viewer*|*display*"; then 

                echo "Found: $file" 

            fi 

        done 

    done 

} 

  

# Main 

echo "Image Software Detection Script" 

echo "===============================" 

  

check_image_software 

  

echo "Detection script execution completed." 

 
