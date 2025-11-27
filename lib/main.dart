import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/onboarding_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/transactions/screens/add_transaction_screen.dart';
import 'features/transactions/screens/transactions_list_screen.dart';
import 'features/insights/screens/insights_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'navigation/main_navigation.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const FinSageApp());
}

class FinSageApp extends StatelessWidget {
  const FinSageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinSage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
            .apply(
              bodyColor: AppColors.textPrimary,
              displayColor: AppColors.textPrimary,
            ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentGreen,
          secondary: AppColors.accentGreen,
          surface: AppColors.cardBackground,
          background: AppColors.background,
        ),
        cardColor: AppColors.cardBackground,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.cardBackground,
          selectedItemColor: AppColors.accentGreen,
          unselectedItemColor: AppColors.textSecondary,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainNavigation(),
        '/dashboard': (context) => const DashboardScreen(),
        '/transactions': (context) => const TransactionsListScreen(),
        '/insights': (context) => const InsightsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/add_transaction': (context) => const AddTransactionScreen(),
      },
    );
  }
}
