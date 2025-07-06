
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E74FD),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,//takes the full width of the screen
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // logo section
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,//makes the side look regular 
                        boxShadow: [
                          BoxShadow(                           //adds a shadow which gives a 3D effect for it 
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                          // if the image cannot be found this code will make it use an icon rather 
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.account_balance,
                              size: 50,
                              color: Color(0xFF1E74FD),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),//create a box with the height of 20 
                    Text(
                      'Stanbic Bank',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'It paves the way',//displays the bank's motto 
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');//when pressed moves to the login screen 
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF1E74FD),
                        ),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {//moves to the sign up page 
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'CREATE ACCOUNT',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}