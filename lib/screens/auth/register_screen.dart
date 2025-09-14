import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Name Field
        TextFormField(
          decoration: InputDecoration(
            labelText: "Full Name",
            prefixIcon: const Icon(Icons.person_outline, color: Colors.teal),
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

        // Email Field
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.teal),
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
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.teal),
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
        const SizedBox(height: 16),

        // Confirm Password
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            prefixIcon: const Icon(
              Icons.lock_reset_outlined,
              color: Colors.teal,
            ),
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
        const SizedBox(height: 20),

        // Register Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 3,
          ),
          onPressed: () {},
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
