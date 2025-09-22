// screens/transactions/normal_transaction_screen.dart
import 'package:flutter/material.dart';

import '../../widget/transaction_cards.dart';

class NormalTransactionScreen extends StatelessWidget {
  const NormalTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Normal Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            
            // Transaction List
        TransactionItem(
              icon: Icons.local_cafe,
              iconColor: Colors.orange,
              title: 'Starbucks',
              subtitle: 'Food & Drinks',
              amount: '-\₹650',
              amountColor: Colors.red,
              date: 'Today, 2:30 PM',
            ),
            TransactionItem(
              icon: Icons.local_gas_station,
              iconColor: Colors.blue,
              title: 'Shell Gas Station',
              subtitle: 'Transportation',
              amount: '-\₹45.20',
              amountColor: Colors.red,
              date: 'Yesterday, 8:15 AM',
            ),
            TransactionItem(
              icon: Icons.account_balance,
              iconColor: Colors.green,
              title: 'Salary Deposit',
              subtitle: 'Income',
              amount: '+\₹2,5000',
              amountColor: Colors.green,
              date: 'Sep 18, 9:00 AM',
            ),
            TransactionItem(
              icon: Icons.shopping_cart,
              iconColor: Colors.purple,
              title: 'Grocery Store',
              subtitle: 'Food & Groceries',
              amount: '-\₹1500',
              amountColor: Colors.red,
              date: 'Sep 17, 6:45 PM',
            ),
            TransactionItem(
              icon: Icons.movie,
              iconColor: Colors.red,
              title: 'Netflix Subscription',
              subtitle: 'Entertainment',
              amount: '-\₹159',
              amountColor: Colors.red,
              date: 'Sep 15, 12:00 PM',
            ),
          ],
        ),
      ),
    );
  }
}
