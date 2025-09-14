import 'package:eta_app/screens/auth/login_screen.dart';
import 'package:eta_app/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentIndex = 0;
  final _pageController = PageController();

  final tabs = const ["Login", "Register"];

  void _switchTab(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 Floating bubbles (more added)
          Positioned(
            top: -60,
            left: -40,
            child: _buildCircle(140, Colors.white.withOpacity(0.08)),
          ),
          Positioned(
            bottom: -80,
            right: -30,
            child: _buildCircle(200, Colors.white.withOpacity(0.08)),
          ),
          Positioned(
            top: 120,
            right: -50,
            child: _buildCircle(100, Colors.white.withOpacity(0.06)),
          ),
          Positioned(
            bottom: 150,
            left: -60,
            child: _buildCircle(120, Colors.white.withOpacity(0.07)),
          ),
          Positioned(
            top: 300,
            left: 80,
            child: _buildCircle(60, Colors.white.withOpacity(0.05)),
          ),

          // 🔹 Auth Card
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔹 Logo + Brand
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        size: 42,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Spendwise",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Track your expenses smartly",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    const SizedBox(height: 26),

                    // 🔹 Modern Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: List.generate(tabs.length, (i) {
                          final isActive = i == _currentIndex;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => _switchTab(i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: isActive
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.white
                                        : const Color(0xFF388E3C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: isActive ? 16 : 14,
                                  ),
                                  child: Text(
                                    tabs[i],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // 🔹 PageView (only login & register)
                    SizedBox(
                      height: 400,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (i) {
                          setState(() => _currentIndex = i);
                        },
                        children: const [LoginScreen(), RegisterScreen()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
