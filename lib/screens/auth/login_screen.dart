import 'package:eta_app/theme/color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email Field
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.primaryTeal),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Password Field
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.primaryTeal),
            suffixIcon: const Icon(
              Icons.visibility_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Forgot password?",
              style: TextStyle(color: AppTheme.primaryTeal),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Login Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor: AppTheme.primaryTeal,
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 3,
          ),
          onPressed: () {},
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),

        // Divider
        // Row(
        //   children: [
        //     Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        //     const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 8),
        //       child: Text("or"),
        //     ),
        //     Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        //   ],
        // ),
        // const SizedBox(height: 20),

        // // Continue with Apple
        // OutlinedButton(
        //   style: OutlinedButton.styleFrom(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(14),
        //     ),
        //     side: BorderSide(color: Colors.grey.shade300),
        //     padding: const EdgeInsets.symmetric(vertical: 14),
        //   ),
        //   onPressed: () {},
        //   child: const Text(
        //     "Continue with Apple",
        //     style: TextStyle(fontSize: 16, color: Colors.black87),
        //   ),
        // ),
      ],
    );
  }
}
