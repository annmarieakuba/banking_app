
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appstate.dart';
import '../providers/widgets/bottom_navigation.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts & Balances'),
        backgroundColor: Color(0xFF1E74FD),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          final accounts = appState.accounts;
          final totalBalance = appState.totalBalance;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E74FD), Color(0xFF4A90E2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'GH₵ ${totalBalance.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: Colors.white70, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '+2.5% from last month',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Accounts List
                Text(
                  'Your Accounts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ...accounts.map((account) => _buildAccountCard(account)),

                SizedBox(height: 24),

                // Link Account Button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF1E74FD),
                        size: 48,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Link New Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E74FD),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Connect your other bank accounts',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildAccountCard(account) {
    Color balanceColor = account.balance >= 0 ? Colors.green : Colors.red;
    IconData accountIcon;
    
    switch (account.type) {
      case 'Checking':
        accountIcon = Icons.account_balance_wallet;
        break;
      case 'Savings':
        accountIcon = Icons.savings;
        break;
      case 'Credit':
        accountIcon = Icons.credit_card;
        break;
      default:
        accountIcon = Icons.account_balance;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF1E74FD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              accountIcon,
              color: Color(0xFF1E74FD),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  account.maskedAccountNumber,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  account.type,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'GH₵ ${account.balance.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  color: balanceColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (account.balance < 0)
                Text(
                  'Outstanding',
                  style: TextStyle(
                    color: Colors.red.shade300,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}