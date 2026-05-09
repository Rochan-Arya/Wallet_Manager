import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String balance;

  final String upiId;

  const WalletCard({super.key, required this.balance, required this.upiId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF334155), const Color(0xFF475569)]
              : [const Color(0xFF2563EB), const Color(0xFF3B82F6)],
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),

            blurRadius: 12,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                "Total Balance",

                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              Container(
                padding: const EdgeInsets.all(8),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(50),
                ),

                child: const Icon(
                  Icons.account_balance_wallet,

                  color: Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Text(
            "₹ $balance",

            style: const TextStyle(
              color: Colors.white,

              fontSize: 34,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Text("UPI ID: $upiId", style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
