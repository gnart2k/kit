function show_menu() {
	echo "1. View Schedule"
	echo "2. Create Schedule"
	echo "3. Update Schedule"
	echo "4. Exit"
}

function view_schedule() {

	current_day=$(date +%w)             # Get the current day of the week (1-7, where Monday is 1 and Sunday is 7)
	remaining_days=$((8 - current_day)) # Calculate remaining days until Sunday

	echo "Your Schedule for the remaining days:"

	for ((day = 0; day < remaining_days; day++)); do
		target_day=$((current_day + day))
		day_file="day${target_day}_schedule.txt"

		if [ -f "$day_file" ]; then
			case $target_day in
			1) display_day="Monday" ;;
			2) display_day="Tuesday" ;;
			3) display_day="Wednesday" ;;
			4) display_day="Thursday" ;;
			5) display_day="Friday" ;;
			6) display_day="Saturday" ;;
			7) display_day="Sunday" ;;
			*)
				echo "Invalid day"
				return
				;;
			esac

			echo "$display_day"
			cat "$day_file" || echo "No tasks scheduled."
			echo
		fi
	done
}

function create_schedule() {
	echo "Enter the day number (1-7) for the task:"
	read day_number

	if ((day_number < 1 || day_number > 7)); then
		echo "Invalid day number. Please enter a number between 1 and 7."
		return
	fi

	day_file="day${day_number}_schedule.txt"

	echo "Enter the task description:"
	read task_description

	echo "- $task_description" >>"$day_file"
	echo "Task added successfully to Day $day_number!"
}

function update_schedule() {
	echo "Enter the day number (1-7) for the task:"
	read day_number

	if ((day_number < 1 || day_number > 7)); then
		echo "Invalid day number. Please enter a number between 1 and 7."
		return
	fi

	day_file="day${day_number}_schedule.txt"

	echo "Enter the task description:"
	read task_description

	echo "- $task_description" >"$day_file"
	echo "Task updated successfully to Day $day_number!"
}

while true; do
	show_menu

	read -p "Enter your choice: " choice

	case $choice in
	1) view_schedule ;;
	2) create_schedule ;;
	3) update_schedule ;;
	4)
		echo "Exiting. Have a great day!"
		break
		;;
	*) echo "Invalid choice. Please enter a valid option." ;;
	esac
	echo
done
