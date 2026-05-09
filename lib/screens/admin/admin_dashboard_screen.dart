import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),

            builder: (context, userSnapshot) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .snapshots(),

                builder: (context, transactionSnapshot) {
                  if (!userSnapshot.hasData || !transactionSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var users = userSnapshot.data!.docs;

                  var transactions = transactionSnapshot.data!.docs;

                  int totalUsers = users.length;

                  int pending = 0;

                  int totalTransactions = transactions.length;

                  int walletTotal = 0;

                  for (var user in users) {
                    var data = user.data();

                    walletTotal += (data['walletBalance'] ?? 0) as int;
                  }

                  for (var transaction in transactions) {
                    var data = transaction.data();

                    if (data['status'] == "pending") {
                      pending++;
                    }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 10),

                      const Text(
                        "Admin Dashboard",

                        style: TextStyle(
                          fontSize: 28,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),

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
                                  Text(
                                    "Total Users",

                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.7),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    totalUsers.toString(),

                                    style: const TextStyle(
                                      fontSize: 28,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),

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
                                  Text(
                                    "Pending",

                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.7),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    pending.toString(),

                                    style: const TextStyle(
                                      fontSize: 28,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),

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
                                  Text(
                                    "Transactions",

                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.7),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    totalTransactions.toString(),

                                    style: const TextStyle(
                                      fontSize: 28,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),

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
                                  Text(
                                    "Wallet Total",

                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.7),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "₹ $walletTotal",

                                    style: const TextStyle(
                                      fontSize: 28,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
