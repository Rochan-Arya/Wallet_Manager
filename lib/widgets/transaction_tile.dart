import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;

  final String time;

  final String amount;

  final bool isCredit;

  const TransactionTile({
    super.key,
    required this.title,
    required this.time,
    required this.amount,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 24,

            backgroundColor: Colors.orange,

            child: Text(
              title.substring(0, 1).toUpperCase(),

              style: const TextStyle(
                color: Colors.black,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 16,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  time,

                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),

                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Text(
            isCredit ? "+ ₹$amount" : "- ₹$amount",

            style: TextStyle(
              color: isCredit ? Colors.green : Colors.red,

              fontWeight: FontWeight.bold,

              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
