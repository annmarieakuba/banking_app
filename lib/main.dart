//import necessary packages 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/appstate.dart';
import '../screens/welcomescreen.dart';
import '../screens/loginscreen.dart';
import '../screens/signupscreen.dart';
import '../screens/dashboardscreen.dart';
import '../screens/transferfundsscreen.dart';
import '../screens/billspaymentscreen.dart';
import '../screens/accountbalancescreen.dart';
import '../screens/transactionhistory_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: BankingApp(),
    ),
  );
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stanbic Bank ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF1E74FD),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1E74FD),
          foregroundColor: Colors.white,
          elevation: 0,//removes the shadow under the appBar 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1E74FD),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/transfer': (context) => TransferScreen(),
        '/bills': (context) => BillsScreen(),
        '/accounts': (context) => AccountsScreen(),
        '/transactions': (context) => TransactionsScreen(),
      },
    );
  }
}
