import 'package:eta_app/screens/account/account_category.dart';
import 'package:eta_app/screens/analytics/analytics_screen.dart';
import 'package:eta_app/screens/auth/auth_screen.dart';
import 'package:eta_app/screens/budget/budget_screen.dart';
import 'package:eta_app/screens/category/category_screen.dart';
import 'package:eta_app/screens/home/home_page.dart';
import 'package:eta_app/screens/transaction/normal_transaction.dart';
import 'package:eta_app/screens/transaction/recurring_transaction.dart';
import 'package:eta_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🔹 Layouts
import 'package:eta_app/layouts/main_layout.dart';
import 'package:eta_app/layouts/transaction_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 🔹 Check SharedPreferences for token
  Future<String> _getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setString(
    //   "authToken",
    //   "VGhpcyBpcyB0aGUgcHJlZml4IGZvciBhIGxpc3Qu",
    // ); // Remove this line in production

    prefs.clear(); // Remove this line in production
    final String? authToken = prefs.getString("authToken");

    return (authToken?.isNotEmpty ?? false) ? "/" : "/auth";
    // return "/";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        // 🔹 Show loader while checking prefs
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final GoRouter router = GoRouter(
          initialLocation: snapshot.data!,
          routes: [
            // 🔹 Auth Routes
            GoRoute(
              path: "/auth",
              builder: (context, state) => const AuthScreen(),
            ),

            // 🔹 Main Layout Routes
            ShellRoute(
              builder: (context, state, child) => MainLayout(child: child),
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const HomeScreen(),
                ),
                GoRoute(
                  path: '/category',
                  builder: (context, state) => const CategoryScreen(),
                ),
                GoRoute(
                  path: '/account',
                  builder: (context, state) => const AccountScreen(),
                ),
                GoRoute(
                  path: '/budget',
                  builder: (context, state) => const BudgetScreen(),
                ),
                GoRoute(
                  path: '/analytics',
                  builder: (context, state) => const AnalyticsScreen(),
                ),
              ],
            ),

            // 🔹 Transaction Routes (with extended layout)
            ShellRoute(
              builder: (context, state, child) =>
                  TransactionLayout(child: child),
              routes: [
                GoRoute(
                  path: '/transactions/normal',
                  builder: (context, state) => const NormalTransactionScreen(),
                ),
                GoRoute(
                  path: '/transactions/recurring',
                  builder: (context, state) =>
                      const RecurringTransactionScreen(),
                ),
              ],
            ),
          ],
        );

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Inter',
          ),
          routerConfig: router,
        );
      },
    );
  }
}
