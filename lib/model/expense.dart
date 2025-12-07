class Expense {
  final String id;
  final String title; // e.g., "Nasi Goreng"
  final double amount; // e.g., 15000
  final DateTime date;
  final String category; // e.g., "Food"

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}