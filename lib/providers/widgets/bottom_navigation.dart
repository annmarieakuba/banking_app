
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        //to highlight the active button.
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,//to show all buttons at once
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF1E74FD),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        onTap: (index) {
          switch (index) {
            case 0://f the user isn’t already on the Home screen , it takes them to the dashboard screen.
              if (currentIndex != 0) {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
              break;
            case 1://If not already on the Transfer screen, it takes them to the transfer screen .
              if (currentIndex != 1) {
                Navigator.pushReplacementNamed(context, '/transfer');
              }
              break;
            case 2:
              //It shows a popup (showModalBottomSheet) with a rounded top edge
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildQuickActionButton(
                            context,
                            'Transfer',
                            Icons.send,
                            () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/transfer');
                            },
                          ),
                          _buildQuickActionButton(
                            context,
                            'Pay Bills',
                            Icons.receipt_long,
                            () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/bills');
                            },
                          ),
                          _buildQuickActionButton(
                            context,
                            'Accounts',
                            Icons.account_balance_wallet,
                            () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/accounts');
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
              break;
              //If not already on the Accounts screen, it takes the user to accounts.
            case 3:
              if (currentIndex != 3) {
                Navigator.pushReplacementNamed(context, '/accounts');
              }
              break;
              //If not already on the History screen, it takes the user to transactions
            case 4:
              if (currentIndex != 4) {
                Navigator.pushReplacementNamed(context, '/transactions');
              }
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_outlined),
            activeIcon: Icon(Icons.send),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF1E74FD),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'History',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    //makes the button tappable
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF1E74FD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: Color(0xFF1E74FD),
              size: 28,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}