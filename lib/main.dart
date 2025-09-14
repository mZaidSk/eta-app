import 'package:eta_app/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🔹 Layouts
import 'package:eta_app/layouts/main_layout.dart';

// 🔹 Screens
// import 'package:eta_app/screens/dashboard_screen.dart';
import 'package:eta_app/screens/profile_screen.dart';
import 'package:eta_app/screens/transactions_screen.dart';
// import 'package:eta_app/screens/budgets_screen.dart';
// import 'package:eta_app/screens/chatbot_screen.dart';

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

    return (authToken?.isNotEmpty ?? false) ? "/transactions" : "/auth";
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

            // 🔹 Main Layout (Dashboard, etc.)
            ShellRoute(
              builder: (context, state, child) => MainLayout(child: child),
              routes: [
                // GoRoute(
                //   path: '/dashboard',
                //   builder: (context, state) => const DashboardScreen(),
                // ),
                GoRoute(
                  path: '/transactions',
                  builder: (context, state) => const TransactionsScreen(),
                ),
                // GoRoute(
                //   path: '/budgets',
                //   builder: (context, state) => const BudgetsScreen(),
                // ),
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const ProfileScreen(),
                ),
                // GoRoute(
                //   path: '/chatbot',
                //   builder: (context, state) => const ChatbotScreen(),
                // ),
              ],
            ),
          ],
        );

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
