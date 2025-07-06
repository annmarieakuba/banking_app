
class Account {
  final String id;
  final String name;
  final String accountNumber;
  final double balance;
  final String type;

  Account({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.balance,
    required this.type,
  });
  
///just returns a hidden version of the account 
  String get maskedAccountNumber {
    if (accountNumber.length >= 4) {
      return '****${accountNumber.substring(accountNumber.length - 4)}';
    }
    return accountNumber;
  }
}