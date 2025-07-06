
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appstate.dart';
import 'models/transaction.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedTransferType = 'Bank Transfer';
  bool _isLoading = false;

  final List<String> _transferTypes = [
    'Bank Transfer',
    'PayShap',
    'Mobile Money',
    'International Wire',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Funds'),
        backgroundColor: Color(0xFF1E74FD),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transfer Type Selection
              Text(
                'Transfer Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedTransferType,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTransferType = newValue!;
                      });
                    },
                    items: _transferTypes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Recipient Information
              Text(
                'Recipient Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _recipientController,
                decoration: InputDecoration(
                  labelText: _selectedTransferType == 'PayShap' 
                      ? 'PayShap ID or Phone Number'
                      : _selectedTransferType == 'Mobile Money'
                          ? 'Mobile Number'
                          : 'Account Number or Email',
                  prefixIcon: Icon(Icons.person_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipient information';
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
                  if (amount > 10000) {
                    return 'Amount cannot exceed GH₵ 10,000';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  prefixIcon: Icon(Icons.note_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 32),

              // Transfer Summary Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transfer Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildSummaryRow('Transfer Type:', _selectedTransferType),
                    _buildSummaryRow('Transfer Fee:', 'GH₵ 2.50'),
                    Divider(),
                    _buildSummaryRow('Total Amount:', 
                      'GH₵ ${(double.tryParse(_amountController.text) ?? 0 + 2.50).toStringAsFixed(2)}',
                      isBold: true),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Transfer Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleTransfer,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('TRANSFER FUNDS'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTransfer() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      //Checks the form, shows a spinner, waits 2 seconds, creates a transaction,
      // saves it, shows a “Transfer Successful” popup, and goes back to the dashboard.
      await Future.delayed(Duration(seconds: 2));

      try {
        final amount = double.parse(_amountController.text);
        final description = _descriptionController.text.isEmpty
            ? '${_selectedTransferType} to ${_recipientController.text}'
            : _descriptionController.text;

        final transaction = Transaction(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          description: description,
          amount: amount,
          date: DateTime.now(),
          type: 'debit',
          category: 'Transfer',
          toAccount: _recipientController.text,
        );

        Provider.of<AppState>(context, listen: false).addTransaction(transaction);

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Transfer Successful'),
              content: Text('Your transfer of GH₵ ${amount.toStringAsFixed(2)} has been completed successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Go back to dashboard
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transfer failed. Please try again.')),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}