
# 💰 Personal Expense Tracker (Shell Script)

A terminal-based **Personal Expense Tracker** written in **Bash**. This lightweight and interactive tool helps you keep track of your daily expenses right from the command line.

## ✨ Features

- 📅 Add expense entries with date, category, amount, and description
- 📋 View all expenses or filter by date/category
- 📊 Monthly summary of expenses
- 🗑️ Delete specific entries by line number
- 📂 Export all data to a CSV file (`expenses_export.csv`)
- 🕒 Smart greeting and real-time date/time display

## 📁 File Structure

- `expense-tracker.sh` – Main shell script
- `expenses.txt` – Auto-generated file to store expense records
- `expenses_export.csv` – Exported CSV file (optional)

## 🚀 How to Run

### 🖥️ Linux/macOS

```bash
chmod +x expense-tracker.sh
./expense-tracker.sh
```

### 🪟 Windows (using Git Bash or WSL)

Ensure you have a Bash shell available (Git Bash or WSL), then run:

```bash
bash expense-tracker.sh
```

## 🧠 Usage Overview

### ➕ Add Expense

- Prompts for:
  - Date (format: `YYYY-MM-DD`)
  - Category (e.g., Food, Transport)
  - Amount (e.g., 150.00)
  - Description

### 🔍 View Expenses

- View all
- Filter by:
  - Date
  - Category
  - Monthly Summary

### ❌ Delete Expense

- View line number using the View option first
- Delete by providing the line number

### 📤 Export

- Generates a `expenses_export.csv` copy of all records

## 📝 Data Format

Each record is stored in `expenses.txt` as:

```
YYYY-MM-DD,Category,Amount,Description
```

## 🛠️ Requirements

- Bash 4+
- Unix-based system or Git Bash/WSL on Windows

## 🙌 Author

Created by **Eiamin Hassan** to demonstrate shell scripting, file handling, and terminal UI interaction.

---

Start tracking your expenses the terminal way! 🚀
