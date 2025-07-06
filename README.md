# Stanbic Banking App

A modern **Mobile Banking App** built with **Flutter** that simulates key banking functionalities including signing up, logging in, viewing balances, transferring funds, paying bills, and checking transaction history.

The app uses the `Provider` package for efficient state management, keeping user data and transactions synchronized across all screens.

---

## 📱 Features

### 1. Welcome Screen (`welcome.dart`)
- Displays the Stanbic Bank logo and motto: _"It paves the way"_
- Includes **"LOGIN"** and **"CREATE ACCOUNT"** buttons
- Blue background and circular logo matching Stanbic branding

### 2. Sign Up Screen (`signup.dart`)
- Users create accounts with first name, last name, email, password
- Validates input (e.g., email format, password length, matching passwords)
- Navigates to dashboard on success

### 3. Login Screen (`login.dart`)
- Existing users log in with email and password
- Validates credentials and redirects to dashboard

### 4. Dashboard (`dashboard.dart`)
- Displays user's full name, balance (in GH₵), and recent transactions
- Quick action buttons: **Transfer**, **Pay Bills**, **View Accounts**, **Transaction History**
- Includes logout via notification icon

### 5. Bill Payment (`billspayment.dart`)
- Pay for services like electricity, water, internet, mobile, cable TV, and insurance
- Users select bill type, input account/meter/phone number, and enter amount
- Confirmation and transaction record upon success

### 6. Transfer Funds (`transferfunds.dart`)
- Send money via:
  - Bank Transfer
  - PayShap
  - Mobile Money
  - International Wire
- Supports optional transfer descriptions and fixed fee display (GH₵ 2.50)
- Simulates successful completion with a confirmation

### 7. Transaction History (`transactionhistory.dart`)
- Displays all user transactions with filters:
  - **All**, **Transfer**, **Bills**, **Income**
- Each item shows date, time, amount, category, and description

### 8. Data Models
- **User Model (`user.dart`)**: ID, name, email, phone, computed display name
- **Account Model (`account.dart`)**: ID, account number, masked number, type, balance
- **Transaction Model (`transaction.dart`)**: ID, type (credit/debit), category, description, amount, recipient, and timestamp

### 9. Bottom Navigation (`bottom-navigation.dart`)
- Navigation bar with icons: **Home**, **Transfer**, **+**, **Accounts**, **History**
- Central “+” button opens quick action popup

### 10. Main App Entry (`main.dart`)
- Initializes app with routing and Provider-based state management

### 11. App State Management (`appstate.dart`)
- Central `AppState` class maintains:
  - Current user
  - Accounts
  - Transaction list

---

## 🔄 App Flow

1. **Welcome Screen** → Choose Login or Sign Up  
2. **Sign Up** → Enter details, validate, redirect to Dashboard  
3. **Login** → Validate credentials and redirect to Dashboard  
4. **Dashboard** → View balance and quick actions  
5. **Bill Payment** → Select type, input details, confirm  
6. **Transfer Funds** → Enter recipient, add description, confirm  
7. **Transaction History** → Filter and view past transactions  
8. **Navigation Bar** → Move between screens  
9. **Logout** → Clears session and returns to Welcome screen

---

## 🚀 How to Run

### ✅ Prerequisites
- Flutter SDK (v3.x or later)
- Visual Studio Code or Android Studio
- A connected Android emulator or physical device

### 🧰 Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/annmarieakuba/banking_app.git
   cd banking_app
