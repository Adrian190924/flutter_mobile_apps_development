import 'package:flutter/foundation.dart';
import 'package:uco_mad_sem4/repository/expense_repository.dart';
import '../model/expense.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository _repository = ExpenseRepository();
  
  List<Expense> _expenses = [];
  bool _isLoading = false;

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;

  // Read
  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _expenses = await _repository.getExpenses();
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create
  Future<void> addExpense(String title, double amount, String category) async {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: category,
    );

    _expenses.add(newExpense); 
    //call _repository.addExpense(newExpense) here later
    notifyListeners();
  }

  // Delete
  Future<void> deleteExpense(String id) async {
    // Delete from repository
    await _repository.deleteExpense(id);
    
    // Remove from local list
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // Update
  Future<void> updateExpense(String id, String title, double amount, String category, DateTime oldDate) async {
    final updatedExpense = Expense(
      id: id,
      title: title,
      amount: amount,
      date: oldDate, // Keep original date
      category: category,
    );

    // Update Repository
    await _repository.updateExpense(id, updatedExpense);

    // Update Local List
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
    }

    notifyListeners();
  }
}