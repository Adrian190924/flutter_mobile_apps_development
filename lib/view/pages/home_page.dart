part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseViewModel>(context, listen: false).fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExpenseViewModel>(
        builder: (context, viewModel, child) {
          // 1. Show Loading Indicator
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Main Content (Column with Budget Card + List)
          return Column(
            children: [
              // Budget Card
              Card(
                margin: const EdgeInsets.all(16),
                color: Colors.blue.shade50,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Monthly Budget",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp ${viewModel.totalExpenses.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),

                          Text(
                            "/ Rp ${viewModel.budgetLimit.toStringAsFixed(0)}",
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      // Linear Progress Bar
                      LinearProgressIndicator(
                        value: viewModel.budgetProgress > 1.0 ? 1.0 : viewModel.budgetProgress,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          viewModel.totalExpenses > viewModel.budgetLimit 
                              ? Colors.red          // Over Budget
                              : Colors.blueAccent,  // Safe Spending
                        ),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      const SizedBox(height: 8),
                      Text(
                        viewModel.totalExpenses > viewModel.budgetLimit 
                            ? "Over Budget!" 
                            : "Safe Spending",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: viewModel.totalExpenses > viewModel.budgetLimit 
                              ? Colors.red 
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),

              // Expense List (Using Expanded to fill the rest of the screen)
              Expanded(
                child: viewModel.expenses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.money_off, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text(
                              "No expenses yet!",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Text("Tap the + button to add one."),
                          ],
                        ),
                      )

                    : ListView.builder(
                        itemCount: viewModel.expenses.length,
                        itemBuilder: (context, index) {
                          final expense = viewModel.expenses[index];
                          return Dismissible(
                            key: Key(expense.id),
                            direction: DismissDirection.endToStart, // Swipe right to left
                            
                            // Delete Action
                            onDismissed: (direction) {
                              Provider.of<ExpenseViewModel>(context, listen: false)
                                  .deleteExpense(expense.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${expense.title} deleted')),
                              );
                            },
                            
                            // Delete Action Red Background
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            
                            // The List
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade100,
                                  child: Icon(_getCategoryIcon(expense.category)),
                                ),

                                title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(expense.category),
                                trailing: Text(
                                  "Rp ${expense.amount.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                onTap: () {
                                  // Access Edit Mode
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddExpensePage(expenseToEdit: expense),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Icons based on category
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.fastfood;
      case 'transport':
        return Icons.directions_bus;
      case 'subscription':
        return Icons.subscriptions;
      default:
        return Icons.attach_money;
    }
  }
}