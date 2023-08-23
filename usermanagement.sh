#!/bin/bash 


sort unsorted.txt > authorisedusers.txt

 
# Function to add users from authorizedusers.txt 

add_users() { 

    echo "Adding Users:" 

    while IFS= read -r user; do 

        sudo useradd "$user" 

        echo "  $user" 

    done < authorizedusers.txt 

    echo 

} 

  

# Function to export current system users to systemusers.txt 

export_system_users() { 

    sudo awk -F':' '{print $1}' /etc/passwd > systemusers.txt 

} 

  

# Function to sort users in systemusers.txt and save to systemusers2.txt 

sort_system_users() { 

    sort systemusers.txt > systemusers2.txt 

} 

  

# Function to compare authorized users and system users 

compare_users() { 

    sudo diff authorizedusers.txt systemusers2.txt | grep '^<' | sed 's/^< //' 

} 

  

# Function to add missing users from authorized users 

add_missing_users() { 

    echo "Users to Add:" 

    while IFS= read -r user; do 

        sudo useradd "$user" 

        echo "  $user" 

    done < <(compare_users) 

    echo 

} 

  

# Function to remove excess users from systemusers2.txt 

remove_excess_users() { 

    echo "Users to Delete:" 

    while IFS= read -r user; do 

        sudo userdel "$user" --remove 

        echo "  $user" 

    done < <(sudo diff systemusers2.txt authorizedusers.txt | grep '^>' | sed 's/^> //') 

    echo 

} 

  

# Function to perform cleanup 

cleanup() { 

    sudo rm -f systemusers.txt systemusers2.txt 

    echo "Cleanup completed." 

} 

  

# Confirmation prompt function 

confirm() { 

    read -p "Do you want to proceed? (yes/no): " choice 

    case "$choice" in 

        [Yy][Ee][Ss]|[Yy]) 

            return 0 

            ;; 

        [Nn][Oo]|[Nn]) 

            return 1 

            ;; 

        *) 

            echo "Invalid choice. Please enter 'yes' or 'no'." 

            confirm 

            ;; 

    esac 

} 

  

# Check if authorizedusers.txt exists 

if [ ! -f "authorizedusers.txt" ]; then 

    echo "Create a sorted authorizedusers.txt file in order to execute the script." 

    exit 1 

fi 

  

# Main script execution 

add_users 

export_system_users 

sort_system_users 

add_missing_users 

remove_excess_users 

  

# Display confirmation prompt 

confirm && cleanup 

  

echo "User management completed." 
