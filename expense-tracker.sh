#!/bin/bash

DATA_FILE="expenses.txt"

# Check if the data file exists; if not, create it
if [ ! -f "$DATA_FILE" ]; then
    touch "$DATA_FILE"
fi

# Function to display greetings with emoji
display_greeting() {
    hour=$(date +"%H")
    if [ "$hour" -ge 5 ] && [ "$hour" -lt 12 ]; then
        echo -e "☀️ Good Morning! Welcome to the Expense Tracker!"
    elif [ "$hour" -ge 12 ] && [ "$hour" -lt 18 ]; then
        echo -e "🌤️ Good Afternoon! Let's manage your expenses."
    else
        echo -e "🌙 Good Evening! Time to review your expenses."
    fi
}

# Function to validate a date input
validate_date() {
    if [[ $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] && date -d "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to validate a numeric amount
validate_amount() {
    if [[ $1 =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to add an expense
add_expense() {
    local date category amount description

    while true; do
        echo "Enter Date (YYYY-MM-DD):"
        read date
        if validate_date "$date"; then
            break
        else
            echo "❌ Invalid date format! Please enter in YYYY-MM-DD format."
        fi
    done

    echo "Enter Category (e.g., Food, Transport, Rent):"
    read category
    while [ -z "$category" ]; do
        echo "❌ Category cannot be empty. Please enter a valid category."
        read category
    done

    while true; do
        echo "Enter Amount (e.g., 100.50):"
        read amount
        if validate_amount "$amount"; then
            break
        else
            echo "❌ Invalid amount! Please enter a valid number (e.g., 100 or 100.50)."
        fi
    done

    echo "Enter Description:"
    read description

    # Save the record in the data file
    echo "$date,$category,$amount,$description" >> "$DATA_FILE"
    echo "✅ Expense added successfully!"
}

# Function to view expenses
view_expenses() {
    echo "View options:"
    echo "1. All Expenses"
    echo "2. Filter by Date"
    echo "3. Filter by Category"
    echo "4. Monthly Summary"
    read choice

    case $choice in
        1)
            echo "📋 All Expenses:"
            echo "Date, Category, Amount, Description"
            cat "$DATA_FILE"
            ;;
        2)
            while true; do
                echo "Enter Date (YYYY-MM-DD):"
                read filter_date
                if validate_date "$filter_date"; then
                    break
                else
                    echo "❌ Invalid date format! Please enter in YYYY-MM-DD format."
                fi
            done
            echo "📅 Expenses on $filter_date:"
            grep "^$filter_date" "$DATA_FILE" || echo "No records found."
            ;;
        3)
            echo "Enter Category:"
            read filter_category
            echo "📂 Expenses in $filter_category category:"
            grep ",$filter_category," "$DATA_FILE" || echo "No records found."
            ;;
        4)
            echo "📊 Monthly Summary:"
            awk -F, '{split($1, dateArr, "-"); month = dateArr[1] "-" dateArr[2]; total[month] += $3} END {for (m in total) print m, total[m]}' "$DATA_FILE"
            ;;
        *)
            echo "❌ Invalid choice!"
            ;;
    esac
}

# Function to delete an expense
delete_expense() {
    echo "Enter the line number of the expense to delete (use View option to find it):"
    read line_number
    if [[ $line_number =~ ^[0-9]+$ ]] && [ $line_number -le $(wc -l < "$DATA_FILE") ]; then
        sed -i "${line_number}d" "$DATA_FILE"
        echo "🗑️ Expense deleted successfully!"
    else
        echo "❌ Invalid line number!"
    fi
}

# Function to export expenses to CSV
export_csv() {
    cp "$DATA_FILE" expenses_export.csv
    echo "📂 Expenses exported to expenses_export.csv"
}

# Main menu
while true; do
    clear
    # Display greeting
    display_greeting

    # Display current date and time
    echo -e "\n📅 Today is: $(date '+%A, %d %B %Y')"
    echo -e "🕒 Current Time: $(date '+%H:%M:%S')\n"

    # Main menu
    echo "---- Personal Expense Tracker ----"
    echo "1️⃣  Add Expense"
    echo "2️⃣  View Expenses"
    echo "3️⃣  Delete Expense"
    echo "4️⃣  Export to CSV"
    echo "5️⃣  Exit"
    echo "----------------------------------"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) add_expense ;;
        2) view_expenses ;;
        3) delete_expense ;;
        4) export_csv ;;
        5) echo "👋 Goodbye! Have a great day!" ; exit ;;
        *) echo "❌ Invalid choice! Try again." ;;
    esac

    # Pause to allow the user to see results before returning to the menu
    echo -e "\nPress Enter to continue..."
    read
done

