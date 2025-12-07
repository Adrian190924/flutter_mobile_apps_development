part of 'pages.dart';

class AddExpensePage extends StatefulWidget {
  // Optional parameter: if null, add. If not null, edit.
  final Expense? expenseToEdit;

  const AddExpensePage({super.key, this.expenseToEdit});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Food';
  final _formKey = GlobalKey<FormState>();
  
  final List<String> _categories = ['Food', 'Transport', 'Subscription', 'Other'];

  @override
  void initState() {
    super.initState();
    // If edit, use existing data
    if (widget.expenseToEdit != null) {
      _titleController.text = widget.expenseToEdit!.title;
      _amountController.text = widget.expenseToEdit!.amount.toStringAsFixed(0);
      _selectedCategory = widget.expenseToEdit!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final amount = double.tryParse(_amountController.text) ?? 0;

      if (widget.expenseToEdit == null) {
        // ADD Mode
        Provider.of<ExpenseViewModel>(context, listen: false)
            .addExpense(title, amount, _selectedCategory);
      } else {
        // EDIT Mode
        Provider.of<ExpenseViewModel>(context, listen: false).updateExpense(
          widget.expenseToEdit!.id,
          title,
          amount,
          _selectedCategory,
          widget.expenseToEdit!.date, // Keep original date
        );
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Change title based on mode
    final isEditing = widget.expenseToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Expense" : "Add New Expense"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount (Rp)",
                  prefixText: "Rp ",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter an amount';
                  if (double.tryParse(value) == null) return 'Please enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder()),
                items: _categories.map((category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveExpense,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(isEditing ? "Update Changes" : "Save Expense"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}