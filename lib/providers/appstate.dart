 
 //import necessary packages 
 import 'package:flutter/foundation.dart';
import '../screens/models/user.dart';
import '../screens/models/account.dart';
import '../screens/models/transaction.dart';
 
 
 class AppState extends ChangeNotifier {
  User? _currentUser;//stores the current logged in user 
  List<Account> _accounts = [];//declares  a private list of accounts to store account objects, initialized as an empty list.
  List<Transaction> _transactions = [];

  User? get currentUser => _currentUser;
  List<Account> get accounts => _accounts;//read only access 
  List<Transaction> get transactions => _transactions;

  double get totalBalance {
    return _accounts.fold(0.0, (sum, account) => sum + account.balance);//Defines a getter totalBalance that calculates the sum of balances across all accounts
  }
// this defines the  login method that takes email and password parameters
  void login(String email, String password) {

    //this helps to set current user to the user
    _currentUser = User(
      id: '1',
      firstName: email.split('@')[0], 
      lastName: 'Default', 
      email: email,
      phone: '+233 123 456 789',
    );
    
    _loadMockData();//population the accounts and transaction with sample data/information

    notifyListeners();//notifies to the listeners that an update has been made 
  }

  void signup(String firstName, String lastName, String email, String password) {
    _currentUser = User(
    //Generates a unique ID based on the current time (in milliseconds), then converts it to a string. 
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: '',
    );
    
    _loadMockData();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _accounts.clear();
    _transactions.clear();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);
    
    //  A for loop to iterate through and Update account balance
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].id == 'main') {
        double newBalance = _accounts[i].balance;
        //- the amount if it's a debit transaction, or + it if it's a credit transaction.
        if (transaction.isDebit) {
          newBalance -= transaction.amount;
        } else {
          newBalance += transaction.amount;
        }
        
        _accounts[i] = Account(
          id: _accounts[i].id,
          name: _accounts[i].name,
          accountNumber: _accounts[i].accountNumber,
          balance: newBalance,
          type: _accounts[i].type,
        );
        break;
      }
    }
    
    notifyListeners();
  }
//the mock/random  data 
  void _loadMockData() {
    _accounts = [
      Account(
        id: 'main',
        name: 'Primary Checking',
        accountNumber: '1234567890',
        balance: 23789.50,
        type: 'Checking',
      ),
      Account(
        id: 'savings',
        name: 'Savings Account',
        accountNumber: '4444567891',
        balance: 9754.00,
        type: 'Savings',
      ),
      Account(
        id: 'credit',
        name: 'Credit Card',
        accountNumber: '7809870123',
        balance: -2340.25,
        type: 'Credit',
      ),
    ];
//mock data
    _transactions = [
      Transaction(
        id: '1',
        description: 'PayShap Transfer to Jon Snow ',
        amount: 700.00,
        date: DateTime.now().subtract(Duration(hours: 2)),
        type: 'debit',
        category: 'Transfer',
      ),
      Transaction(
        id: '2',
        description: 'Salary Deposit',
        amount: 4500.00,
        date: DateTime.now().subtract(Duration(days: 1)),
        type: 'credit',
        category: 'Income',
      ),
      Transaction(
        id: '3',
        description: 'MTN Mobile Money',
        amount: 70.00,
        date: DateTime.now().subtract(Duration(days: 2)),
        type: 'debit',
        category: 'Bills',
      ),
      Transaction(
        id: '4',
        description: 'ECG Bill Payment',
        amount: 300.00,
        date: DateTime.now().subtract(Duration(days: 3)),
        type: 'debit',
        category: 'Bills',
      ),
    ];
  }
}