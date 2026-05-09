import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AdminRequestsScreen extends StatelessWidget {
  const AdminRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              const Text(
                "All Requests",

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('transactions')
                      .snapshots(),

                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var requests = snapshot.data!.docs.where((request) {
                      var data = request.data() as Map<String, dynamic>;

                      return data['userRole'] != 'admin';
                    }).toList();

                    if (requests.isEmpty) {
                      return const Center(child: Text("No Requests"));
                    }

                    requests.sort((a, b) {
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

                    return ListView.builder(
                      itemCount: requests.length,

                      itemBuilder: (context, index) {
                        var request = requests[index];

                        var data = request.data() as Map<String, dynamic>;

                        DateTime createdAt;

                        if (data['createdAt'] is Timestamp) {
                          createdAt = (data['createdAt'] as Timestamp).toDate();
                        } else {
                          createdAt = DateTime.parse(data['createdAt']);
                        }

                        String formattedTime =
                            "${createdAt.day}/${createdAt.month}/${createdAt.year}  ${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}";
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),

                          padding: const EdgeInsets.all(18),

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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(
                                    data['type'],

                                    style: const TextStyle(
                                      fontSize: 20,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "₹ ${data['amount']}",

                                    style: TextStyle(
                                      color: data['type'] == "Credit"
                                          ? Colors.green
                                          : Colors.red,

                                      fontSize: 22,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "User: ${data['userName'] ?? 'Unknown'}",

                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "Requested At: $formattedTime",

                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.7),

                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(data['description']),

                              const SizedBox(height: 8),

                              Text(
                                "Status: ${data['status']}",

                                style: TextStyle(
                                  color: data['status'] == "approved"
                                      ? Colors.green
                                      : data['status'] == "rejected"
                                      ? Colors.red
                                      : Colors.orange,
                                ),
                              ),

                              const SizedBox(height: 15),

                              if (data['status'] == "pending")
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          String userId = data['userId'];

                                          int amount = data['amount'];

                                          String type = data['type'];

                                          DocumentReference userRef =
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(userId);

                                          DocumentSnapshot userDoc =
                                              await userRef.get();

                                          Map<String, dynamic> userData =
                                              userDoc.data()
                                                  as Map<String, dynamic>;

                                          int currentBalance =
                                              userData['walletBalance'] ?? 0;

                                          int newBalance = currentBalance;

                                          if (type == "Credit") {
                                            newBalance =
                                                currentBalance + amount;
                                          } else {
                                            newBalance =
                                                currentBalance - amount;
                                          }

                                          await userRef.update({
                                            'walletBalance': newBalance,
                                          });

                                          await FirebaseFirestore.instance
                                              .collection('transactions')
                                              .doc(request.id)
                                              .update({'status': 'approved'});

                                          await Provider.of<AppAuthProvider>(
                                            context,
                                            listen: false,
                                          ).refreshUser();
                                        },

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),

                                        child: const Text(
                                          "Approve",

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('transactions')
                                              .doc(request.id)
                                              .update({'status': 'rejected'});
                                        },

                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),

                                        child: const Text(
                                          "Reject",

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
