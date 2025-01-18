# Task Manager App

## Overview
The **Task Manager App** is a Flutter application designed to test fetching and working on APIs of tasks efficiently for the users to manage their tasks. With a clean and intuitive user interface, robust state management, seamless performance, and persistent data storage, the app ensures a smooth and reliable experience.

## Key Features

### 1. User Authentication
- **Authentication**: Users can securely log in using their username and password.
- **API**: Authentication is implemented using the [DummyJSON API](https://dummyjson.com/docs/auth).

### 2. Task Management
- Users can:
  - View tasks.
  - Add new tasks.
  - Edit existing tasks.
  - Delete tasks.
- **API**: Task management utilizes the [DummyJSON Todos API](https://dummyjson.com/docs/todos).

### 3. Pagination
- **Feature**: Efficiently fetch large numbers of tasks using pagination.
- **Implementation**: 
  - API endpoint: `https://dummyjson.com/todos?limit=10&skip=10`.
  - This allows smooth scrolling and optimized data retrieval.

### 4. State Management
- **Option Used**: Provider
- **Goal**: Ensure efficient state updates across the app and maintain consistency.

### 5. Local Storage
- **Persistence**: Tasks are stored locally using:
  - Flutter's shared preferences.
  - SQLite database.
- **Benefit**: Tasks remain accessible even when the app is closed and reopened.

### 6. Unit Tests (Planned)
- **Coverage**:
  - Task CRUD operations.
  - Input validation.
  - State management.
  - Network requests.
- **Testing Tools**: Mock responses using [reqres.in](https://reqres.in) endpoints.

## UI Enhancements
- **Design Packages**:
  - **Awesome Snackbar**: Enhanced user feedback and notifications.
- **Customizations**:
  - Changed the font family for a modern and clean look.
  - Added a splash screen for a professional app launch experience.

## Demo
[Check out the video demo of the app here](https://drive.google.com/drive/folders/1a0aK2KD7wbJM4COC_-DNBrZt6R_MMwmp?usp=sharing)...


