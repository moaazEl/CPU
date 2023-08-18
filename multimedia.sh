#!/bin/bash 

  

choose_category() { 

    PS3="Choose a category (enter the number): " 

    options=("Image" "Audio" "Video" "Document" "Archive" "Executable" "Code" "Database" "Font" "Presentation" "Spreadsheet" "System" "Text" "Web" "Other") 

    select category in "${options[@]}"; do 

        case "$category" in 

            "Image") 

                SELECTED_CATEGORY="image" 

                EXTENSIONS=("jpg" "jpeg" "png" "gif" "bmp" "tiff" "webp" "svg" "heic" "ico" "jfif" "psd" "ai" "eps" "raw" "xcf" "pdf" "djvu" "pict" "cr2" "nef" "orf") 

                break 

                ;; 

            "Audio") 

                SELECTED_CATEGORY="audio" 

                EXTENSIONS=("mp3" "wav" "ogg" "flac" "aac" "wma" "m4a" "opus" "mid" "amr" "aiff" "au" "raw" "mka" "caf" "ac3" "m4b") 

                break 

                ;; 

            "Video") 

                SELECTED_CATEGORY="video" 

                EXTENSIONS=("mp4" "avi" "mkv" "mov" "wmv" "flv" "webm" "m4v" "3gp" "mpeg" "mpg" "vob" "divx" "ogv" "rm" "rmvb" "asf" "m2v" "mts" "m2ts" "swf" "f4v" "mxf" "webm" "ogv" "avi" "mts") 

                break 

                ;; 

            "Document") 

                SELECTED_CATEGORY="document" 

                EXTENSIONS=("pdf" "doc" "docx" "ppt" "pptx" "xls" "xlsx" "odt" "odp" "ods" "txt" "rtf" "csv" "md" "odg" "odf" "wpd") 

                break 

                ;; 

            "Archive") 

                SELECTED_CATEGORY="archive" 

                EXTENSIONS=("zip" "tar" "gz" "bz2" "xz" "rar" "7z" "tgz" "tbz2" "txz") 

                break 

                ;; 

            "Executable") 

                SELECTED_CATEGORY="executable" 

                EXTENSIONS=("exe" "sh" "bat" "com" "jar" "run" "app") 

                break 

                ;; 

            "Code") 

                SELECTED_CATEGORY="code" 

                EXTENSIONS=("c" "cpp" "h" "hpp" "java" "py" "js" "html" "css" "php" "xml" "json" "rb" "pl" "swift" "go" "lua" "vb" "ts") 

                break 

                ;; 

            "Database") 

                SELECTED_CATEGORY="database" 

                EXTENSIONS=("sql" "db" "sqlite" "mdb" "accdb" "dbf") 

                break 

                ;; 

            "Font") 

                SELECTED_CATEGORY="font" 

                EXTENSIONS=("ttf" "otf" "woff" "woff2" "eot") 

                break 

                ;; 

            "Presentation") 

                SELECTED_CATEGORY="presentation" 

                EXTENSIONS=("ppt" "pptx" "key" "odp") 

                break 

                ;; 

            "Spreadsheet") 

                SELECTED_CATEGORY="spreadsheet" 

                EXTENSIONS=("xls" "xlsx" "ods" "csv") 

                break 

                ;; 

            "System") 

                SELECTED_CATEGORY="system" 

                EXTENSIONS=("dll" "so" "sys" "bin" "inf" "cfg") 

                break 

                ;; 

            "Text") 

                SELECTED_CATEGORY="text" 

                EXTENSIONS=("txt" "log" "md" "rtf") 

                break 

                ;; 

            "Web") 

                SELECTED_CATEGORY="web" 

                EXTENSIONS=("html" "css" "js" "php" "xml" "json" "asp" "jsp") 

                break 

                ;; 

            "Other") 

                SELECTED_CATEGORY="other" 

                EXTENSIONS=("bak" "tmp" "dat" "out" "temp" "lock") 

                break 

                ;; 

            *) 

                echo "Invalid option, please choose a valid category." 

                ;; 

        esac 

    done 

} 

   

  

confirm() {  

  

    while true; do  

  

        read -p "$1 (yes/no): " choice  

  

        case "$choice" in  

  

            [Yy][Ee][Ss]|[Yy])  

  

                return 0  

  

                ;;  

  

            [Nn][Oo]|[Nn])  

  

                return 1  

  

                ;;  

  

            *)  

  

                echo "Please enter 'yes' or 'no'"  

  

                ;;  

  

        esac  

  

    done  

  

}  

  

   

  

# Main script  

  

for user_home in /home/*; do  

  

    username=$(basename "$user_home")  

  

   

  

    # Exclude user 'ubuntu' from processing  

  

    if [[ "$username" == "ubuntu" ]]; then  

  

        continue  

  

    fi  

  

   

  

    echo "Scanning files for user: $username"  

  

   

  

    choose_category  

  

   

  

    # Array to store found files  

  

    found_files=()  

  

   

  

    IFS=$'\n'  # Set IFS to newline to handle file paths with spaces  

  

    for ext in "${EXTENSIONS[@]}"; do  

  

        # Search for both regular and hidden files  

  

        files=($(find "$user_home" -type f \( -iname "*.$ext" -o -iname ".*.$ext" \)))  

  

        if [[ ${#files[@]} -gt 0 ]]; then  

  

            found_files+=("${files[@]}")  

  

        fi  

  

        echo "Found ${#files[@]} files with extension .$ext"  

  

    done  

  

    IFS=" "  # Reset IFS to default  

  

   

  

    echo "Number of found files: ${#found_files[@]}"  

  

   

  

    if [[ ${#found_files[@]} -gt 0 ]]; then  

  

        echo "Files found:"  

  

        printf '%s\n' "${found_files[@]}"  

  

   

  

        for file in "${found_files[@]}"; do  

  

            confirm "Do you want to delete the file: $file"  

  

            response=$?  

  

            if [[ $response -eq 0 ]]; then  

  

                rm -f "$file"  

  

                echo "File $file deleted."  

  

            else  

  

                echo "File $file not deleted."  

  

            fi  

  

        done  

  

    else  

  

        echo "No files were found."  

  

    fi  

  

   

  

    echo "-------------------------------------------"  

  

done  
