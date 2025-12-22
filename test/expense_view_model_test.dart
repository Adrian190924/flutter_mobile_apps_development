import 'package:flutter_test/flutter_test.dart';
import 'package:uco_mad_sem4/view_model/expense_view_model.dart';

void main() {
  group('ExpenseViewModel Unit Tests', () {
    late ExpenseViewModel viewModel;
    setUp(() {
      viewModel = ExpenseViewModel();
    });

    // Testing addExpense()
    test('Function 1: addExpense() adds an item to the list', () async {
      // 1. Arrange
      const title = "Tes Nasi Goreng";
      const amount = 20000.0;
      const category = "Food";

      // 2. Act
      await viewModel.addExpense(title, amount, category);

      // 3. Assert
      expect(viewModel.expenses.length, 1, reason: "List should have 1 item");
      expect(viewModel.expenses.first.title, title);
      expect(viewModel.totalExpenses, amount);
    });

    // Testing updateExpense()
    test('Function 2: updateExpense() modifies an existing item', () async {
      // 1. Arrange 
      await viewModel.addExpense("Old Title", 10000, "Food");
      final String id = viewModel.expenses.first.id;
      final DateTime originalDate = viewModel.expenses.first.date;

      // 2. Act
      await viewModel.updateExpense(
        id, 
        "Ojol", 
        50000, // Changed amount
        "Transport", // Changed category 
        originalDate
      );

      // 3. Assert
      final updatedItem = viewModel.expenses.first;
      expect(updatedItem.title, "Ojol");
      expect(updatedItem.amount, 50000);
      expect(updatedItem.category, "Transport");
      expect(viewModel.totalExpenses, 50000, reason: "Total should update too");
    });

    // Testing deleteExpense()
    test('Function 3: deleteExpense() removes an item from the list', () async {
      // 1. Arrange (Add an item first)
      await viewModel.addExpense("Item to Delete", 5000, "Other");
      final String id = viewModel.expenses.first.id;

      // 2. Act
      await viewModel.deleteExpense(id);

      // 3. Assert
      expect(viewModel.expenses.isEmpty, true, reason: "List should be empty after delete");
      expect(viewModel.totalExpenses, 0, reason: "Total should be 0");
    });

    // Testing Budget & Progress Calculation
    test('Function 4: Budget Logic calculates progress and totals correctly', () async {
      // 1. Arrange
      viewModel.setBudget(100000); 

      // 2. Act (Half Budget Scenario)
      await viewModel.addExpense("Groceries", 50000, "Food");

      // 3. Assert
      expect(viewModel.totalExpenses, 50000);
      expect(viewModel.budgetProgress, 0.5); // Progress should be 0.5 (50%)

      // 4. Act (Over Budget Scenario)
      await viewModel.addExpense("Fancy Dinner", 100000, "Food");

      // 5. Assert
      expect(viewModel.totalExpenses, 150000);
      expect(viewModel.budgetProgress, 1.5); // Progress should be 1.5 (150%)
    });
  });
}