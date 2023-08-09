import subprocess

def get_system_users():
    try:
        result = subprocess.run(['cut', '-d', ':', '-f', '1', '/etc/passwd'], capture_output=True, text=True, check=True)
        return result.stdout.strip().split('\n')
    except subprocess.CalledProcessError:
        print("Error getting system users.")
        return []

def add_user(username):
    try:
        subprocess.run(['sudo', 'useradd', '-m', username], check=True)
        print(f"User '{username}' added successfully.")
    except subprocess.CalledProcessError:
        print(f"Error adding user '{username}'.")

def delete_user(username):
    try:
        subprocess.run(['sudo', 'userdel', '-r', username], check=True)
        print(f"User '{username}' deleted successfully.")
    except subprocess.CalledProcessError:
        print(f"Error deleting user '{username}'.")

def main():
    with open('users.txt', 'r') as file:
        desired_users = set(file.read().splitlines())

    system_users = get_system_users()

    users_to_add = desired_users - set(system_users)
    users_to_delete = set(system_users) - desired_users

    for user in users_to_add:
        confirmation = input(f"Add user '{user}'? (yes/no): ")
        if confirmation.lower() == 'yes':
            add_user(user)

    for user in users_to_delete:
        confirmation = input(f"Delete user '{user}'? (yes/no): ")
        if confirmation.lower() == 'yes':
            delete_user(user)

if __name__ == "__main__":
    main()
