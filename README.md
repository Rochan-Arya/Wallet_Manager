# Wallet Manager App

Wallet Manager is a Flutter + Firebase based digital wallet management application built with separate User and Admin panels. The application allows users to send credit/debit requests while administrators can manage requests, monitor transactions, and control wallet balances in real time.

This project was developed as a full-stack mobile application using Firebase Authentication, Cloud Firestore, Provider State Management, and modern Flutter UI design principles.

---

# Project Overview

The application simulates a wallet management system where:

- Users can create accounts and log in securely
- Users can request wallet credits or debits
- Admins can approve or reject requests
- Wallet balances automatically update in real time
- Both users and admins have dedicated dashboards
- Firebase Firestore acts as the real-time cloud database

The project also includes dark/light theme support and responsive UI components.

---

# Features

## User Features

- Secure Login & Signup
- Wallet Dashboard
- View Current Wallet Balance
- Send Credit Requests
- Send Debit Requests
- Transaction History
- Real-time Wallet Updates
- Profile Management
- Dark / Light Theme Toggle

---

## Admin Features

- Separate Admin Panel
- View All Registered Users
- Search & Filter Users
- View Pending Requests
- Approve / Reject Transactions
- Edit User Wallet Balance
- View Transaction History
- Dashboard Analytics
- Real-time Firebase Updates

---

# Tech Stack

## Frontend
- Flutter
- Dart

## Backend / Database
- Firebase Authentication
- Cloud Firestore

## State Management
- Provider

---

# Database Collections

## users Collection

Stores all registered users and admin information.

Fields:
- uid
- name
- email
- mobile
- upiId
- walletBalance
- role

---

## transactions Collection

Stores all transaction requests.

Fields:
- userId
- userName
- type
- amount
- description
- status
- createdAt

---

# Application Flow

## User Flow

1. User signs up or logs in
2. User dashboard displays wallet balance
3. User sends credit/debit request
4. Request is stored in Firestore
5. Admin reviews request
6. Wallet balance updates automatically after approval

---

## Admin Flow

1. Admin logs into admin panel
2. Admin views all users and requests
3. Admin approves or rejects requests
4. User wallet balance updates in Firestore
5. Changes reflect instantly across the app

---

# UI Features

- Modern Card-Based UI
- Custom Bottom Navigation
- Dark & Light Theme Support
- Rounded Input Fields
- Responsive Layout Design
- Real-time Data Rendering

---

# Run Project

```bash
flutter pub get
flutter run
```

---

# Admin Access

To make a user an admin:

1. Open Firebase Firestore
2. Go to the `users` collection
3. Change:

```json
"role": "admin"
```

The app automatically redirects admins to the Admin Panel after login.

---

# Future Improvements

- Push Notifications
- Expense Analytics Charts
- Monthly Reports
- QR Based Payments
- Export Transaction Reports
- Better Security Rules
- Profile Image Upload
- Transaction Categories

---

# Author

Arya

Built as a learning and interview demonstration project using Flutter and Firebase 🚀
