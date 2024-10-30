# Study Tracker App

## Overview
The **Study Tracker App** is a Flutter-based mobile application designed to help users manage their study activities effectively. It utilizes **SQLite** for local data storage, ensuring data persistence and easy access to study-related information. The app features dynamic route management, modular screens, and custom input widgets.

<p align="center">
  <img src="https://github.com/user-attachments/assets/875a9c8d-b990-4292-a2b6-c81159439efd" width="200"/>
  <img src="https://github.com/user-attachments/assets/75cbbd6c-9105-4caa-bcc5-80642eae4770" width="200"/>
  <img src="https://github.com/user-attachments/assets/3fa38fed-6c24-4544-a27d-f2f999dec43f" width="200"/>
</p>

## Features
Add, edit, and track study activities efficiently.
Store and retrieve study data locally on the device.
Includes reusable components like ```CustomDatePickerFormField``` and ```CustomTextFormField```.
Uses ```RouteGenerator``` for smooth navigation.
Displays a fallback message for undefined routes.

## What I Used / Learned
* Flutter with SQLite: Implemented SQLite for effective local storage management.
* Custom Widgets: Designed form fields for consistent user input.
* Dynamic Route Management: Used ```RouteGenerator``` for navigating between screens.
* Error Handling: Implemented fallback routes for better user experience.

## Challenges and issue

### SQLite Data Management:
* Problem: Proper schema design and query management were critical for maintaining data consistency.
* Solution: Implemented CRUD operations following best practices and optimized queries for performance.


### Route Argument Type Safety:
* Problem: Handling arguments in navigation can lead to runtime issues.
* Solution: Used argument validation to prevent navigation errors.

### State Management:
* Problem: Managing form state across multiple screens can be tricky.
* Solution: State management with ```Provider``` or ```Bloc``` is recommended for future updates.


## Bugs need to be fixed
* To see update need to restart the app.
* After CRUD operation close buttion pressing necessary. Otherwise it may crash.
* Setting the time.

## Future Plans
* Push Notifications: Notify users about study reminders and deadlines.
* Analytics Dashboard: Provide insights on study progress and performance.

## How to Install and Run Locally
### Prerequisites
* Java 17: Ensure it is installed. Download from [Oracle Archive](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html).
* Flutter SDK: [Get Flutter](https://docs.flutter.dev/get-started/install/windows).

### Steps
#### Clone the repository:
```
https://github.com/smnasimahmed/assignment_list.git
```

#### Install dependencies:
```
flutter pub get
```

#### Ensure Java 17 is the active version:
```
java -version
```
##### If necessary, set Java 17 manually:

* Linux/Mac:
```
export JAVA_HOME=/path-to-java-17
```
* Windows: Update the JAVA_HOME environment variable.
#### Run the app:
```
flutter run
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
