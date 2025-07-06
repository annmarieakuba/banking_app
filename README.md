Stanbic Banking App
This is a Mobile Banking App built using Flutter, a framework for creating mobile applications. This app allows users to sign up, log in, view their account balance, transfer funds, pay bills, and check their transaction history.
The app utilizes the Provider package for state management to manage and update user data and transactions efficiently. 
A .Features of the Application 
The app includes the following features:
1.	Welcome Screen (welcome.dart):
o	This is the first screen users see when  the app is opened ,  which displays dthe Stanbic Bank logo and motto ("It paves the way").
o	Has  two buttons: "LOGIN" to sign in and "CREATE ACCOUNT" to sign up.
o	Has the blue background and circular logo representing the bank’s color  

2 .Sign Up Screen (signup.dart):
o	 Users can create a new account by entering their first name, last name, email, password, and agreeing to terms and conditions.
o	The form checks for valid inputs (ie;, email must have an "@" symbol, password must be at least 6 characters, and passwords must match).
o	After signing up, users are t then taken to the dashboard.

3.Login Screen (login.dart):
o	 Already existing users can log in using their email and password.
o	The form ensures the email is valid and the password is at least 6 characters long.
o	Upon successful login, users go to the dashboard.
4.Dashboard Screen (dashboard.dart):
o	The main screen shows the user’s name, total balance (in Ghanaian Cedis, GH₵), and their last three transactions.
o	It includes quick action buttons  which is used for transferring funds, paying bills, viewing accounts, and checking transaction history.
o	A logout option is available (a notification icon).
5.Bill Payment Screen (billspayment.dart):
o	Users can pay bills like electricity, water, internet, mobile, cable TV, or insurance.
o	They select a bill type from a grid, enter an account/meter/phone number, and specify the amount.
o	After payment, a  success message appears, and the transaction is saved.


6.Transfer Funds Screen (transferfunds.dart):
o	Users can send money through Bank Transfer, PayShap, Mobile Money, or International Wire.
o	They enter the recipient’s details, amount (up to GH₵ 10,000), and an optional description of why they may be sending the money.
o	A summary shows the transfer type, a fixed fee (GH₵ 2.50), and total amount. A success message appears after completion.
7.Transaction History Screen (transactionhistory.dart):
o	Displays all transactions with filters for All, Transfer, Bills, or Income.
o	Each transaction shows the description, date (formatted as “Today,” “Yesterday,” or a specific date), time, amount, and category.
8. Data Models (user.dart, account.dart, transaction.dart):
User Model: Stores user details like ID, first name, last name, email, and phone number. It provides a full name and a lowercase display name.

Account Model: Represents a bank account with an ID, name, account number, balance, and type (e.g., savings). It includes a masked account number for security (showing only the last four digits).

Transaction Model: Represents a transaction (e.g., payment or transfer) with details like ID, description, amount, date, type (debit or credit), category, and optional recipient account.
9. Bottom Navigation (bottom-navigation.dart):
•	A navigation bar at the bottom of the screen with five icons: Home, Transfer, a plus button (for quick actions), Accounts, and History.
•	The plus button opens a popup with options to transfer funds, pay bills, or view accounts.
•	Tapping an icon takes users to the corresponding screen (e.g., Home goes to the dashboard).
10.main app(main.dart)
The main.dart file serves as the entry point for the Banking App, initializing the application with Flutter and setting up the necessary state management and navigation structure

11.Appstate (appstate.dart)
The app uses a central “brain” (AppState class, not shown here) to store user data, accounts, and transactions, ensuring everything stays in sync across screens.




B.  How the App Works
The flow is at follows :
1.	The Welcome Screen: When you open the app, you see the Stanbic Bank logo and two buttons: "LOGIN" or "CREATE ACCOUNT." This is like the bank’s front door.

2.	Creating an Account: On the signup screen, you fill out a form with your details, agree to terms, and tap “Create Account.” The app checks if everything is correct before saving your info.

3.	Logging In: On the login screen, you enter your email and password. If correct, you’re taken to the dashboard.

4.	Using the Dashboard: The dashboard is your home page, showing your balance and recent transactions. You can tap buttons to pay bills, transfer money, or view all transactions.

5.	Paying Bills: Pick a bill type, enter your account number and amount, and confirm. The app saves the payment and shows a confirmation.

6.	Transferring Money: Choose a transfer type, enter the recipient and amount, and confirm. The app adds a small fee and saves the transaction.

7.	Viewing Transactions: See all your transactions(history), filter them by type, and check details like date and amount.

8.	Navigation: The bottom navigation bar lets you switch between screens easily. The plus button shows quick options for common tasks.


9.	Logging Out: From the dashboard, you can log out and return to the welcome screen.

To run the app:
•	Flutter SDK: Install Flutter (version 3.x or later) on your computer.
•	IDE: Use Visual Studio Code or Android Studio.
•	Dependencies: Ensure the pubspec.yaml file includes flutter, provider, and any other dependencies (not shown here but assumed to be set up).
•	Assets: Place a logo.png file in the assets folder for the signup and login screens.
Steps:
1.	Clone the project to your computer.
2.	Open the project in your IDE.
3.	Run flutter pub get to install dependencies.
4.	Connect a phone or emulator and run flutter run.






C. Challenges Faced During Development
1.	Form Validation:
o	Challenge: Ensuring users enter valid data (e.g., a real email or matching passwords) was tricky. Incorrect inputs could crash the app or confuse users.
o	Solution: Added validation rules to check for empty fields, valid email formats, password length, and matching passwords. Error messages guide users to fix mistakes.
2.	State Management:
o	Challenge: Keeping track of user data (like name, balance, and transactions) across different screens was complex. Without proper management, data could get lost or show incorrectly.
o	Solution: Used the Provider package to create a central AppState class that holds all data and updates screens automatically when data changes.
3.	Responsive Design:
o	Challenge: Making the app look good and work well on different phone sizes was hard. Long forms could get cut off or look crowded.
o	Solution: Used SingleChildScrollView to allow scrolling and SafeArea to avoid phone notches. Adjusted padding and layouts to fit various screens.
4.	Simulating Backend:
o	Challenge: The app simulates API calls with a 2-second delay (e.g., for signup, login, or payments), but connecting to a real server wasn’t implemented, which could cause issues in a real app.
o	Solution: Used Future.delayed to mimic server delays, but in a real app, you’d need to connect to a backend service like Firebase or a custom server.
5.	Error Handling:
o	Challenge: If something went wrong (e.g., a failed signup or transfer), users needed clear feedback instead of the app crashing.
o	Solution: Added try-catch blocks to catch errors and show user-friendly messages via ScaffoldMessenger(pop-up notifications).
6.	Navigation:
o	Challenge: Moving between screens (e.g., from login to dashboard or dashboard to bills) and ensuring users don’t get stuck was tricky.
o	Solution: Used Navigator with named routes (e.g., /dashboard, /bills) to manage screen transitions smoothly. The logout function clears the navigation stack to start fresh.
  7.Build Errors:
•	Challenge:
•	Launching lib/main.dart on sdk gphone64 arm64 in debug mode...
•	Error detected in pubspec.yaml:
•	No file or variants found for asset: assets/logo.png.
•	Target debug_android_application failed: Exception: Failed to bundle asset files.
•	FAILURE: Build failed with an exception.

•	Solution: To resolve this issue, ensure that the logo.png file exists in the assets directory and that the path is correctly defined in the pubspec.yaml file. Verify the file location and update the assets section accordingly if needed.


Key Lessons Learned 
•  Learned how to use  the Provider package to share user data, accounts, and transactions across screens, ensuring the app stays in sync, like a bank’s central record book that all tellers can access.
•  Implemented form validation to check for valid emails, passwords, and other inputs, preventing errors with clear messages, like a bank teller ensuring forms are filled out correctly before processing.

Future Improvements
•	Backend Integration: Connect to a real server (e.g., Firebase) for user authentication and data storage.
•	Forgot Password: Implement the “Forgot Password” feature on the login screen.
•	More Features: Add account management, support for multiple currencies, or push notifications for transactions.
