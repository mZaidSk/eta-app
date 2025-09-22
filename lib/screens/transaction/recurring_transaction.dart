// screens/transactions/recurring_transaction_screen.dart
import 'package:eta_app/theme/color.dart';
import 'package:flutter/material.dart';

import '../../widget/transaction_cards.dart';

class RecurringTransactionScreen extends StatelessWidget {
  const RecurringTransactionScreen({super.key});

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
              'Recurring Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            
            // Recurring Transaction List
            RecurringTransactionItem(
              icon: Icons.movie,
              iconColor: Colors.red,
              title: 'Netflix Subscription',
              subtitle: 'Entertainment',
              amount: '-\₹159',
              amountColor: Colors.red,
              frequency: 'Monthly',
              nextDate: 'Next: Oct 15',
            ),
            RecurringTransactionItem(
              icon: Icons.account_balance,
              iconColor: Colors.blue,
              title: 'Salary',
              subtitle: 'Income',
              amount: '+\₹2,5000',
              amountColor: Colors.green,
              frequency: 'Monthly',
              nextDate: 'Next: Oct 1',
            ),
            RecurringTransactionItem(
              icon: Icons.home,
              iconColor: Colors.orange,
              title: 'Rent Payment',
              subtitle: 'Housing',
              amount: '-\₹5,000',
              amountColor: Colors.red,
              frequency: 'Monthly',
              nextDate: 'Next: Oct 1',
            ),
            RecurringTransactionItem(
              icon: Icons.flash_on,
              iconColor: Colors.yellow,
              title: 'Electricity Bill',
              subtitle: 'Utilities',
              amount: '-\₹1,200',
              amountColor: Colors.red,
              frequency: 'Monthly',
              nextDate: 'Next: Oct 12',
            ),
          ],
        ),
      ),
    );
  }


}