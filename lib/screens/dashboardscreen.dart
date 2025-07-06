
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appstate.dart';
import '../providers/widgets/bottom_navigation.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final user = appState.currentUser;
        final totalBalance = appState.totalBalance;
        final recentTransactions = appState.transactions.take(3).toList();

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header with user info
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E74FD),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 24,
                                  child: Icon(
                                    Icons.person,
                                    color: Color(0xFF1E74FD),
                                    size: 28,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back,',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      user?.firstName ?? 'User',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _showLogoutDialog(context, appState);
                              },
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'GH₵ ${totalBalance.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick Actions
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildQuickAction(
                              context,
                              'Transfer',
                              Icons.send,
                              () => Navigator.pushNamed(context, '/transfer'),
                            ),
                            _buildQuickAction(
                              context,
                              'Pay Bills',
                              Icons.receipt_long,
                              () => Navigator.pushNamed(context, '/bills'),
                            ),
                            _buildQuickAction(
                              context,
                              'Accounts',
                              Icons.account_balance_wallet,
                              () => Navigator.pushNamed(context, '/accounts'),
                            ),
                            _buildQuickAction(
                              context,
                              'History',
                              Icons.history,
                              () => Navigator.pushNamed(context, '/transactions'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Recent Transactions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Transactions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/transactions');
                              },
                              child: Text('View All'),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        ...recentTransactions.map((transaction) =>
                          _buildTransactionItem(transaction)),
                        if (recentTransactions.isEmpty)
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                'No recent transactions',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(currentIndex: 0),
        );
      },
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
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

  Widget _buildTransactionItem(transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: transaction.isDebit ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction.isDebit ? Icons.arrow_upward : Icons.arrow_downward,
              color: transaction.isDebit ? Colors.red : Colors.green,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.isDebit ? '-' : '+'}GH₵ ${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: transaction.isDebit ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                appState.logout();
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}