import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/providers/auth_provider.dart';

import '../../widgets/wallet_card.dart';
import '../../widgets/stats_card.dart';
import '../../widgets/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AppAuthProvider>();

    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Welcome Back",

                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          user?.name ?? '',

                          style: const TextStyle(
                            fontSize: 28,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    CircleAvatar(
                      radius: 24,

                      backgroundColor: Colors.orange,

                      child: Text(
                        user != null
                            ? user.name.substring(0, 1).toUpperCase()
                            : "U",

                        style: const TextStyle(
                          color: Colors.black,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                WalletCard(
                  balance: user?.walletBalance.toString() ?? '0',

                  upiId: user?.upiId ?? '',
                ),

                const SizedBox(height: 30),

                const Text(
                  "Quick Stats",

                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('transactions')
                      .where(
                        'userId',

                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),

                  builder: (context, snapshot) {
                    int credits = 0;

                    int debits = 0;

                    int pending = 0;

                    if (snapshot.hasData) {
                      for (var doc in snapshot.data!.docs) {
                        var data = doc.data() as Map<String, dynamic>;

                        if (data['type'] == "Credit") {
                          credits += data['amount'] as int;
                        }

                        if (data['type'] == "Debit") {
                          debits += data['amount'] as int;
                        }

                        if (data['status'] == "pending") {
                          pending++;
                        }
                      }
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            title: "Credits",

                            amount: "₹ $credits",

                            icon: Icons.arrow_downward,

                            iconColor: Colors.green,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: StatsCard(
                            title: "Debits",

                            amount: "₹ $debits",

                            icon: Icons.arrow_upward,

                            iconColor: Colors.orange,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: StatsCard(
                            title: "Pending",

                            amount: pending.toString(),

                            icon: Icons.access_time,

                            iconColor: Colors.amber,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Recent Transactions",

                      style: TextStyle(
                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "See All",

                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('transactions')
                      .where(
                        'userId',

                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),

                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text("No Transactions Yet");
                    }

                    var transactions = snapshot.data!.docs;

                    transactions.sort((a, b) {
                      dynamic rawA = a['createdAt'];

                      dynamic rawB = b['createdAt'];

                      DateTime timeA;

                      DateTime timeB;

                      if (rawA is Timestamp) {
                        timeA = rawA.toDate();
                      } else {
                        timeA = DateTime.parse(rawA);
                      }

                      if (rawB is Timestamp) {
                        timeB = rawB.toDate();
                      } else {
                        timeB = DateTime.parse(rawB);
                      }

                      return timeB.compareTo(timeA);
                    });

                    transactions = transactions.take(3).toList();

                    return Column(
                      children: transactions.map((transaction) {
                        var data = transaction.data() as Map<String, dynamic>;

                        return TransactionTile(
                          title: data['description'],

                          time: data['status'],

                          amount: data['amount'].toString(),

                          isCredit: data['type'] == "Credit",
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
