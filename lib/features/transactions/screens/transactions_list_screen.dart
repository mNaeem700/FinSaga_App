import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';

class TransactionsListScreen extends StatefulWidget {
  const TransactionsListScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, dynamic>> _allTransactions;
  List<Map<String, dynamic>> _filteredTransactions = [];
  double _totalIncome = 0;
  double _totalExpense = 0;

  final List<String> _tabs = ['All', 'Income', 'Expense'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _initializeTransactions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeTransactions() {
    // Mock transaction data
    _allTransactions = [
      {
        'id': '1',
        'title': 'Salary',
        'category': 'Income',
        'amount': 2800.00,
        'type': 'income',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'icon': Icons.account_balance_wallet,
      },
      {
        'id': '2',
        'title': 'Dinner with friends',
        'category': 'Food',
        'amount': 24.99,
        'type': 'expense',
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'icon': Icons.restaurant,
      },
      {
        'id': '3',
        'title': 'Freelance work',
        'category': 'Income',
        'amount': 450.00,
        'type': 'income',
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'icon': Icons.work,
      },
      {
        'id': '4',
        'title': 'Groceries',
        'category': 'Shopping',
        'amount': 89.50,
        'type': 'expense',
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'icon': Icons.shopping_cart,
      },
      {
        'id': '5',
        'title': 'Electric bill',
        'category': 'Bills',
        'amount': 75.00,
        'type': 'expense',
        'date': DateTime.now().subtract(const Duration(days: 4)),
        'icon': Icons.bolt,
      },
    ];

    _calculateTotals();
    _filterTransactions(_tabController.index);
  }

  void _calculateTotals() {
    _totalIncome = _allTransactions
        .where((t) => t['type'] == 'income')
        .fold(0, (sum, t) => sum + (t['amount'] as double));
    _totalExpense = _allTransactions
        .where((t) => t['type'] == 'expense')
        .fold(0, (sum, t) => sum + (t['amount'] as double));
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _filterTransactions(_tabController.index);
      });
    }
  }

  void _filterTransactions(int tabIndex) {
    setState(() {
      switch (tabIndex) {
        case 1: // Income
          _filteredTransactions = _allTransactions
              .where((t) => t['type'] == 'income')
              .toList();
          break;
        case 2: // Expense
          _filteredTransactions = _allTransactions
              .where((t) => t['type'] == 'expense')
              .toList();
          break;
        default: // All
          _filteredTransactions = List.from(_allTransactions);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Transactions',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: Column(
        children: [
          _buildSummarySection(),
          const SizedBox(height: 20),
          _buildFilterTabs(),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredTransactions.isEmpty
                ? _buildEmptyState()
                : _buildTransactionsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Income',
              _totalIncome,
              AppColors.incomeGreen,
              Icons.arrow_upward,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              'Total Expense',
              _totalExpense,
              AppColors.expenseRed,
              Icons.arrow_downward,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    double amount,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.accentGreen,
        indicatorWeight: 3,
        labelColor: AppColors.accentGreen,
        unselectedLabelColor: AppColors.textSecondary,
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = _filteredTransactions[index];
        return _buildTransactionCard(transaction);
      },
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';
    final amount = transaction['amount'] as double;
    final date = transaction['date'] as DateTime;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isIncome ? AppColors.incomeGreen : AppColors.expenseRed)
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            transaction['icon'] as IconData,
            color: isIncome ? AppColors.incomeGreen : AppColors.expenseRed,
          ),
        ),
        title: Text(
          transaction['title'] as String,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '${transaction['category']} • ${_formatDate(date)}',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: isIncome ? AppColors.incomeGreen : AppColors.expenseRed,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No transactions yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add your first transaction to start tracking!',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
