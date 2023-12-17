#!/bin/bash

# Function to generate a random character from a given set
function generate_random_char {
	local characters="$1"
	local length="${#characters}"
	local random_index=$((RANDOM % length))
	echo "${characters:$random_index:1}"
}

# Function to generate a random password
function generate_password {
	local length="$1"
	local password=""

	# Set of characters for password generation
	local lowercase="abcdefghijklmnopqrstuvwxyz"
	local uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local numbers="0123456789"
	local special_chars="."

	# Ensure length is at least 1
	if [ "$length" -lt 1 ]; then
		length=1
	fi

	# Generate password
	for ((i = 0; i < length; i++)); do
		char_set=""
		case $((RANDOM % 4)) in
		0) char_set="$lowercase" ;;
		1) char_set="$uppercase" ;;
		2) char_set="$numbers" ;;
		3) char_set="$special_chars" ;;
		esac

		password+=$(generate_random_char "$char_set")
	done

	echo "$password"
}

# Get password length from user
read -p "Enter a name for the password: " password_name
read -p "Enter the length of the password: " password_length

# Generate the password
generated_password=$(generate_password "$password_length")

password_file="/etc/passwords/$password_name.txt"

sudo mkdir -p "/etc/passwords"

# Save the password in a plain text file
echo "$generated_password" | sudo tee "$password_file" >/dev/null

echo "$generated_password" | xclip -selection clipboard
echo "Generated Password has been saved in the file: $password_file"

sudo chmod 600 "$password_file"
sudo chown root:root "$password_file"

echo "$generated_password" | xclip -selection clipboard
