
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appstate.dart';
import'../providers/widgets/bottom_navigation.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Transfer', 'Bills', 'Income'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        backgroundColor: Color(0xFF1E74FD),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          var transactions = appState.transactions;
          
          // Apply filter
          if (_selectedFilter != 'All') {
            transactions = transactions
               .where( (t) =>t.category == _selectedFilter)
                .toList();
          }

          return Column(
            children: [
              // Filter Tabs
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = _selectedFilter == filter;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF1E74FD) : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Transactions List
              Expanded(
                child: transactions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No transactions found',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return _buildTransactionItem(transaction);
                        },
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildTransactionItem(transaction) {
    IconData iconData;
    Color iconColor;
    
    switch (transaction.category) {
      case 'Transfer':
        iconData = Icons.send;
        iconColor = Colors.blue;
        break;
      case 'Bills':
        iconData = Icons.receipt_long;
        iconColor = Colors.orange;
        break;
      case 'Income':
        iconData = Icons.arrow_downward;
        iconColor = Colors.green;
        break;
      default:
        iconData = Icons.attach_money;
        iconColor = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
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
                SizedBox(height: 4),
                Text(
                  _formatDate(transaction.date),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    transaction.category,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.isDebit ? '-' : '+'}GH₵ ${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.isDebit ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                _formatTime(transaction.date),
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}