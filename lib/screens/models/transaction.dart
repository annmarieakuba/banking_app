//represent money transfer or payment 
class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String type; // 'debit' or 'credit'
  final String category;
  final String? toAccount;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.toAccount,
  });
// Booleans that help to check the type of transaction in your code.
  bool get isDebit => type == 'debit';
  bool get isCredit => type == 'credit';
}