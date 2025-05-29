# 📝 To-Do List App

A feature-rich **Flutter** application to manage daily tasks efficiently with categories, priorities, deadlines, and smart organization.

---

## 🚀 Features

- **Add / Remove / Complete Tasks**
- **Categorize** tasks (Work, Personal, Shopping)
- **Due Dates** with overdue highlighting
- **Priority Levels** (High, Medium, Low)
- **Search** functionality to quickly find tasks
- **Statistics** (Total, Completed, Pending, High-priority)
- **Empty State Guidance** for new users
- **Swipe to Delete** with confirmation dialogs

---

## 📲 How to Use

### ➕ Add Task
- Tap the **“+”** button.
- Fill in **Title**, **Category**, **Priority**, and optional **Due Date**.
- Tap **“ADD”** to save.

### ✔️ Mark as Completed
- Tap the **checkbox** next to a task.

### ❌ Delete a Task
- **Swipe left** on a task to reveal **Delete**.
- Confirm deletion via dialog.

### 🔍 Search Tasks
- Tap the **search icon** in the top bar.
- Type a query to filter tasks live.

### 📑 Task Info
- Each task shows:
   - **Category**
   - **Due Date**
   - **Priority bar**
   - **Red alert** for overdue items

---

## 🧠 Tech Stack

- **Flutter** (latest stable version)
- **Dart**
- **SharedPreferences** for local storage

---

## 📦 Installation

1. Clone this repo:
   ```bash
   git clone https://github.com/SmitaPatel19/Todo_App_Reto_India
   ```

2. Navigate to project folder:
   ```bash
   cd enhanced-todo-list
   ```

3. Install packages:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
lib/
├── models/
│   └── todo_item.dart                # Task model 
├── screens/
│   └── todo_screen.dart              # Main screen showing the task list
├── utils/
│   ├── constants.dart                # App-wide constants
│   └── functions.dart                # Helper functions
├── widgets/
│   ├── dialog_add_task.dart          # Modal dialog for adding new tasks
│   ├── empety_state_text.dart        # UI for empty state instructions
│   ├── task_item.dart                # Widget for displaying individual tasks
│   └── task_statistic_card.dart     # Widget to show task statistics
└── main.dart                         # App entry point

---

## 🤝 Contributing  

Got an idea? Found a bug? Feel free to **contribute**! Fork this repo, make your changes, and submit a pull request. Contributions are always welcome. 🙌  

---

## 🎉 Acknowledgements  

A huge shoutout to the **Flutter** team for making such awesome tools! 🚀  

If you like this project, don’t forget to **⭐ Star** the repo! 😊  

---
