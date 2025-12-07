import '../../model/expense.dart';

class ExpenseRepository {
  // Using Local Database (Placeholder for actual DB implementation)
  final List<Expense> _expenses = [];

  Future<List<Expense>> getExpenses() async {
    // Simulate a delay for database fetch
    await Future.delayed(const Duration(milliseconds: 500)); 
    return _expenses;
  }

  // Create
  Future<void> addExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _expenses.add(expense);
  }

  // Delete
  Future<void> deleteExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _expenses.removeWhere((e) => e.id == id);
  }

  //Update
  Future<void> updateExpense(String id, Expense newExpense) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _expenses.indexWhere((e) => e.id == id);
    if (index != -1) {
      _expenses[index] = newExpense;
    }
  }
}