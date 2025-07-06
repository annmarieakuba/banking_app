
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appstate.dart';
import 'models/transaction.dart';

class BillsScreen extends StatefulWidget {
  @override
  _BillsScreenState createState() => _BillsScreenState();
}

//Sets up a form tag, text boxes for accountnumber and amount, a default bill type 
class _BillsScreenState extends State<BillsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedBillType = 'Electricity';
  bool _isLoading = false;

//form tag which contains  list of bill types (cable, water,) with icons and providers.
  final List<Map<String, dynamic>> _billTypes = [
    {'name': 'Electricity', 'icon': Icons.electrical_services, 'provider': 'ECG'},
    {'name': 'Water', 'icon': Icons.water_drop, 'provider': 'Ghana Water'},
    {'name': 'Internet', 'icon': Icons.wifi, 'provider': 'Surfline'},
    {'name': 'Mobile', 'icon': Icons.phone_android, 'provider': 'MTN'},
    {'name': 'Cable TV', 'icon': Icons.tv, 'provider': 'DStv'},
    {'name': 'Insurance', 'icon': Icons.security, 'provider': 'SIC Insurance'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Bills'),
        backgroundColor: Color(0xFF1E74FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill Categories
            Text(
              'Select Bill Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _billTypes.length,
              itemBuilder: (context, index) {
                final billType = _billTypes[index];
                final isSelected = _selectedBillType == billType['name'];
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBillType = billType['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF1E74FD) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Color(0xFF1E74FD) : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          billType['icon'],
                          color: isSelected ? Colors.white : Color(0xFF1E74FD),
                          size: 28,
                        ),
                        SizedBox(height: 8),
                        Text(
                          billType['name'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32),

            // Bill Payment Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Service Provider Info
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _billTypes.firstWhere((bill) => bill['name'] == _selectedBillType)['icon'],
                          color: Color(0xFF1E74FD),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedBillType,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _billTypes.firstWhere((bill) => bill['name'] == _selectedBillType)['provider'],
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Account/Meter Number
                  TextFormField(
                    controller: _accountNumberController,
                    decoration: InputDecoration(
                      labelText: _selectedBillType == 'Electricity' || _selectedBillType == 'Water'
                          ? 'Meter Number'
                          : _selectedBillType == 'Mobile'
                              ? 'Phone Number'
                              : 'Account Number',
                      prefixIcon: Icon(Icons.confirmation_number_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your account/meter number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Amount
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Amount (GH₵)',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),

                  // Payment Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handlePayment,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('PAY BILL'),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Recent Bills
            Text(
              'Recent Bill Payments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Consumer<AppState>(
              builder: (context, appState, child) {
                final billTransactions = appState.transactions
                    .where((t) => t.category == 'Bills')
                    .take(3)
                    .toList();

                if (billTransactions.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'No recent bill payments',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return Column(
                  children: billTransactions.map((transaction) {
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
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.receipt_long,
                              color: Colors.orange,
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
                            'GH₵ ${transaction.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handlePayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      try {
        final amount = double.parse(_amountController.text);
        final provider = _billTypes.firstWhere((bill) => bill['name'] == _selectedBillType)['provider'];
        
        final transaction = Transaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          description: '$provider Bill Payment',
          amount: amount,
          date: DateTime.now(),
          type: 'debit',
          category: 'Bills',
        );

        Provider.of<AppState>(context, listen: false).addTransaction(transaction);

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Payment Successful'),
              content: Text('Your $_selectedBillType bill payment of GH₵ ${amount.toStringAsFixed(2)} has been processed successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _accountNumberController.clear();
                    _amountController.clear();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed. Please try again.')),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}

