#!/bin/bash

 touch "existingusers.txt"
sudo chmod 777 "existingusers.txt"
touch "sortedexisting.txt"
sudo chmod 777 sortedexisting.txt
touch "sortedusers.txt"
sudo chmod 777 sortedusers.txt
touch "differences.txt"
sudo chmod 777 differences.txt
touch "removethese.txt"
sudo chmod 777 removethese.txt
touch "addthese.txt"
sudo chmod 777 addthese.txt

cut -d ':' -f 1 /etc/passwd > existingusers.txt
sort existingusers.txt > sortedexisting.txt
sort users.txt > sortedusers.txt

diff "sortedusers.txt" "sortedexisting.txt" > "differences.txt"

awk '/^< / {print $2}' differences.txt > removethese.txt
awk '/^> / {print $2}' differences.txt > addthese.txt


# Path to the text file containing usernames
input_file="addthese.txt"

# Check if the user list file exists
if [ ! -f "$input_file" ]; then
    echo "User list file $input_file not found."
    exit 1
fi

# Read usernames from the input file and add users
while IFS= read -r username; do
    # Create the user with the given username
    useradd -m "$username"
  
    if [ $? -eq 0 ]; then
        echo "User $username added successfully."
    else
        echo "Failed to add user $username."
    fi
done < "$input_file"

echo "User addition process completed."



# Path to the text file containing usernames
input_file2="deletethese.txt"

# Check if the user list file exists
if [ ! -f "$input_file" ]; then
    echo "User list file $input_file not found."
    exit 1
fi

# Read usernames from the input file and add users
while IFS= read -r username; do
    # delete the user with the given username
    userdell -m "$username"
  
    if [ $? -eq 0 ]; then
        echo "User $username added successfully."
    else
        echo "Failed to add user $username."
    fi
done < "$input_file"

echo "User addition process completed."
