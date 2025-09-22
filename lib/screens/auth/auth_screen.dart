import 'package:flutter/material.dart';
import 'package:eta_app/theme/color.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import your home screen here
// import 'package:eta_app/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginMode = true;

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false; // Add loading state

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Add validation methods
  bool _validateLoginForm() {
    if (emailController.text.trim().isEmpty) {
      _showSnackBar('Please enter your email');
      return false;
    }
    if (!_isValidEmail(emailController.text.trim())) {
      _showSnackBar('Please enter a valid email');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showSnackBar('Please enter your password');
      return false;
    }
    return true;
  }

  bool _validateSignUpForm() {
    if (fullNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your full name');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      _showSnackBar('Please enter your email');
      return false;
    }
    if (!_isValidEmail(emailController.text.trim())) {
      _showSnackBar('Please enter a valid email');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showSnackBar('Please enter your password');
      return false;
    }
    if (passwordController.text.length < 6) {
      _showSnackBar('Password must be at least 6 characters');
      return false;
    }
    if (confirmPasswordController.text != passwordController.text) {
      _showSnackBar('Passwords do not match');
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Handle login/signup actions
  Future<void> _handleAuth() async {
    if (isLoading) return;

    bool isValid = isLoginMode ? _validateLoginForm() : _validateSignUpForm();
    if (!isValid) return;

    setState(() {
      isLoading = true;
    });

    try {
      if (isLoginMode) {
        await _performLogin();
      } else {
        await _performSignUp();
      }
    } catch (e) {
      _showSnackBar('${e} An error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  Future<void> _performLogin() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, we'll assume login is successful
    // Replace this with actual authentication logic
    bool loginSuccess = true;

    if (loginSuccess) {
      // Save auth token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', 'demo_auth_token_${DateTime.now().millisecondsSinceEpoch}');

      // Navigate to home screen using Go Router
      if (mounted) {
        context.go('/');
      }
    } else {
      _showSnackBar('Invalid email or password');
    }
  }

  Future<void> _performSignUp() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // For demo purposes, we'll assume signup is successful
    bool signUpSuccess = true;

    if (signUpSuccess) {
      // Save auth token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', 'demo_auth_token_${DateTime.now().millisecondsSinceEpoch}');

      // Navigate to home screen using Go Router
      if (mounted) {
        context.go('/');
      }
    } else {
      _showSnackBar('Failed to create account. Please try again.');
    }
  }

  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
    confirmPasswordController.clear();
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.backgroundTeal, AppTheme.paleGreen],
              ),
            ),
          ),

          // Decorative circles at bottom
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -20,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            right: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primaryTeal.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),

                    // Header
                    _buildHeader(),

                    const SizedBox(height: 30),

                    // Main Content Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Toggle Buttons
                            _buildToggleButtons(),

                            const SizedBox(height: 32),

                            // Form Fields
                            if (isLoginMode)
                              ..._buildLoginForm()
                            else
                              ..._buildSignUpForm(),

                            const SizedBox(height: 24),

                            // Forgot Password (only for login)
                            if (isLoginMode) ...[
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                    // You can navigate to forgot password screen here
                                    // Navigator.pushNamed(context, '/forgot-password');
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primaryTeal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ] else
                              const SizedBox(height: 24),

                            // Action Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _handleAuth,
                                style: AppTheme.primaryButtonStyle,
                                child: isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : Text(
                                        isLoginMode ? "Login" : "Register",
                                        style: AppTheme.buttonTextStyle,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Hello, Welcome To",
          style: TextStyle(
            fontSize: 22,
            color: AppTheme.whiteColor.withOpacity(0.9),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            color: AppTheme.primaryTeal,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppTheme.appName,
          style: TextStyle(
            fontSize: 28,
            color: AppTheme.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 2),
        Text(
          AppTheme.tagline,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.whiteColor.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightGreyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLoginMode = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isLoginMode ? AppTheme.whiteColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: isLoginMode
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isLoginMode
                          ? AppTheme.primaryTeal
                          : AppTheme.greyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLoginMode = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isLoginMode
                      ? AppTheme.whiteColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: !isLoginMode
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: !isLoginMode
                          ? AppTheme.primaryTeal
                          : AppTheme.greyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLoginForm() {
    return [
      _buildTextField(
        controller: emailController,
        hintText: "Email",
        icon: Icons.email_outlined,
      ),

      const SizedBox(height: 16),

      _buildPasswordField(
        controller: passwordController,
        hintText: "Password",
        isVisible: isPasswordVisible,
        onVisibilityToggle: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
      ),
    ];
  }

  List<Widget> _buildSignUpForm() {
    return [
      _buildTextField(
        controller: fullNameController,
        hintText: "Full Name",
        icon: Icons.person_outline,
      ),

      const SizedBox(height: 16),

      _buildTextField(
        controller: emailController,
        hintText: "Email",
        icon: Icons.email_outlined,
      ),

      const SizedBox(height: 16),

      _buildPasswordField(
        controller: passwordController,
        hintText: "Password",
        isVisible: isPasswordVisible,
        onVisibilityToggle: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
      ),

      const SizedBox(height: 16),

      _buildPasswordField(
        controller: confirmPasswordController,
        hintText: "Confirm Password",
        isVisible: isConfirmPasswordVisible,
        onVisibilityToggle: () {
          setState(() {
            isConfirmPasswordVisible = !isConfirmPasswordVisible;
          });
        },
      ),
    ];
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: AppTheme.inputDecoration(hintText, icon),
      style: const TextStyle(fontSize: 14, color: AppTheme.textGrey),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: AppTheme.inputDecoration(hintText, Icons.lock_outline)
          .copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppTheme.greyColor,
                size: 20,
              ),
              onPressed: onVisibilityToggle,
            ),
          ),
      style: const TextStyle(fontSize: 14, color: AppTheme.textGrey),
    );
  }
}
