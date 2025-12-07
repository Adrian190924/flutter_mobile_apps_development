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
          // 1. Loading
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Show "No Data" Message
          if (viewModel.expenses.isEmpty) {
            return Center(
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
            );
          }

          // 3. Show Expenses List
          return ListView.builder(
            itemCount: viewModel.expenses.length,
            itemBuilder: (context, index) {
              final expense = viewModel.expenses[index];
              
              return Dismissible(
                // Each Dismissible must contain a Key. Keys allow Flutter to uniquely identify widgets.
                key: Key(expense.id),
                direction: DismissDirection.endToStart, // Swipe right to left
                
                // What happens when you swipe
                onDismissed: (direction) {
                  // Call the delete function
                  Provider.of<ExpenseViewModel>(context, listen: false)
                      .deleteExpense(expense.id);

                  // Show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${expense.title} deleted')),
                  );
                },
                
                // The red background behind the item
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                
                // The actual list item
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
                      // Navigate to AddExpensePage but PASS the current expense
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