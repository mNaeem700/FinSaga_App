import 'package:flutter/material.dart';

class SpendingOverview {
  final double income;
  final double expense;
  double get savings => income - expense;
  final double percentageSpent;

  const SpendingOverview({
    required this.income,
    required this.expense,
    required this.percentageSpent,
  });
}

class CategorySpending {
  final String name;
  final double amount;
  final Color color;

  const CategorySpending({
    required this.name,
    required this.amount,
    required this.color,
  });
}

class MonthlyTrend {
  final String month;
  final double amount;

  const MonthlyTrend({required this.month, required this.amount});
}

class AIInsight {
  final String message;
  final IconData icon;
  final bool isPositive;

  const AIInsight({
    required this.message,
    required this.icon,
    required this.isPositive,
  });
}

class SavingGoal {
  final String name;
  final double target;
  final double current;
  double get progress => (current / target).clamp(0.0, 1.0);

  const SavingGoal({
    required this.name,
    required this.target,
    required this.current,
  });
}

// Mock data
class MockData {
  static final spendingOverview = SpendingOverview(
    income: 5200,
    expense: 3800,
    percentageSpent: 0.73,
  );

  static final categorySpending = [
    CategorySpending(
      name: 'Food',
      amount: 1200,
      color: const Color(0xFFFF9F40),
    ),
    CategorySpending(
      name: 'Transport',
      amount: 600,
      color: const Color(0xFF36A2EB),
    ),
    CategorySpending(
      name: 'Shopping',
      amount: 800,
      color: const Color(0xFF8F6EFF),
    ),
    CategorySpending(
      name: 'Groceries',
      amount: 500,
      color: const Color(0xFF3BEA60),
    ),
    CategorySpending(
      name: 'Health',
      amount: 400,
      color: const Color(0xFFFF4D4D),
    ),
    CategorySpending(
      name: 'Others',
      amount: 300,
      color: const Color(0xFF808080),
    ),
  ];

  static final monthlyTrend = [
    MonthlyTrend(month: 'Jun', amount: 3200),
    MonthlyTrend(month: 'Jul', amount: 3600),
    MonthlyTrend(month: 'Aug', amount: 3100),
    MonthlyTrend(month: 'Sep', amount: 3900),
    MonthlyTrend(month: 'Oct', amount: 3500),
    MonthlyTrend(month: 'Nov', amount: 3800),
  ];

  static final aiInsights = [
    AIInsight(
      message:
          'You spent 22% more on dining this month — consider adjusting your food budget.',
      icon: Icons.restaurant,
      isPositive: false,
    ),
    AIInsight(
      message: 'Your savings increased by 8% — great progress!',
      icon: Icons.trending_up,
      isPositive: true,
    ),
    AIInsight(
      message: 'You could save an extra \$100 by limiting subscriptions.',
      icon: Icons.subscriptions,
      isPositive: false,
    ),
  ];

  static final savingGoals = [
    SavingGoal(name: 'Vacation Fund', target: 5000, current: 3500),
    SavingGoal(name: 'Emergency Savings', target: 10000, current: 4500),
  ];
}
