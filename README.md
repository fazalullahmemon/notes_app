# Flutter Notes App with Firebase Authentication

This is a simple Notes app built using Flutter, Firebase Authentication, Firebase Firestore and Bloc State management. The app allows users to sign in via Google and Apple, create, edit, and delete notes, with data persistence using Firebase. The app also handles user authentication state and offers a responsive design for both Android and iOS.

## Features

- **User Authentication**: Users can sign in using **Google** or **Apple** authentication.
- **Notes Management**: Users can create, edit, delete, and view notes.
- **Data Persistence**: All notes are stored in **Firebase Firestore**, ensuring that the data is synced across devices.
- **Logout Functionality**: The app includes a **logout** feature, with a confirmation dialog to ensure that the user intends to log out.
- **Responsive Design**: The app works seamlessly on both **Android** and **iOS** devices.
- **Internet Connectivity Check**: The app checks if the user has internet connectivity and displays appropriate messages.

## Technologies Used

- **Flutter**: Framework for building natively compiled applications for mobile from a single codebase.
- **Firebase Authentication**: Authentication service for enabling Google and Apple sign-ins.
- **Firebase Firestore**: A NoSQL cloud database to store and retrieve user notes.
- **Connectivity Plus**: To monitor the internet connection and show appropriate alerts.
- **Bloc**: For state management.
  
## Setup and Installation
- **Flutter Version Used**: 3.22.3

### Follow the steps below to run App:

- git clone https://github.com/fazalullahmemon/notes_app.git
- cd notes_app
- flutter run
