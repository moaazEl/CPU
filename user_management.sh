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

  

# Ask the user to choose a category 

choose_category 

  

# Get the list of system users 

users=$(sudo getent passwd | awk -F: '$3 >= 1000{print $1}') 

  

# Specify the directory to search for files in each user'shome directory 

directory="/home" 

  

file_list=() 

  

# Iterate over each user and search for files in their home directory 

for user in $users; do 

  user_directory="$directory/$user" 

  

  if [[ -d "$user_directory" ]]; then 

    while IFS= read -r -d '' file; do 

      file_list+=("$user: $file") 

    done < <(sudo find "$user_directory" -type f -print0) 

  fi 

done 

  

# Display the detected files 

if [[ ${#file_list[@]} -eq 0 ]]; then 

  echo "No files found." 

else 

  for file in "${file_list[@]}"; do 

    echo "$file" 

  done 

fi 

  

# Ask if the user wants to delete files 

read -p "Do you want to delete any files? (yes/no): " choice 

  

if [[ $choice == "yes" ]]; then 

  read -p "Enter the numbers of the files you want to delete (comma-separated): " delete_files 

  IFS=',' read -ra files_to_delete <<<"$delete_files" 

  

  for file_index in "${files_to_delete[@]}"; do 

    index=$((file_index - 1)) 

    file="${file_list[$index]}" 

    user="${file%%:*}" 

    file_path="${file#*: }" 

  

    full_path="/home/$user/$file_path" 

  

    if [[ -f "$full_path" ]]; then 

      sudo rm "$full_path" 

      echo "File deleted: $full_path" 

    else 

      echo "File not found: $full_path" 

    fi 

  done 

fi 
