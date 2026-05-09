import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String title;

  final String amount;

  final IconData icon;

  final Color iconColor;

  const StatsCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CircleAvatar(
            radius: 15,

            backgroundColor: iconColor.withOpacity(0.2),

            child: Icon(icon, color: iconColor, size: 18),
          ),

          const SizedBox(height: 15),

          Text(
            amount,

            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text(
            title,

            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.7),

              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
