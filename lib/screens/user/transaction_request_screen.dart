import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class TransactionRequestScreen extends StatefulWidget {
  const TransactionRequestScreen({super.key});

  @override
  State<TransactionRequestScreen> createState() =>
      _TransactionRequestScreenState();
}

class _TransactionRequestScreenState extends State<TransactionRequestScreen> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String transactionType = "Credit";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppAuthProvider>(context);

    final currentUser = authProvider.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(title: const Text("Transactions")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "New Request",

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(labelText: "Amount"),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              initialValue: transactionType,

              items: const [
                DropdownMenuItem(value: "Credit", child: Text("Credit")),

                DropdownMenuItem(value: "Debit", child: Text("Debit")),
              ],

              onChanged: (value) {
                setState(() {
                  transactionType = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,

              maxLines: 3,

              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {
                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance
                      .collection('transactions')
                      .add({
                        'userId': uid,

                        'userName': currentUser?.name ?? '',

                        'userRole': currentUser?.role ?? 'user',

                        'amount': int.parse(amountController.text),

                        'type': transactionType,

                        'status': 'pending',

                        'description': descriptionController.text,

                        'createdAt': Timestamp.now(),
                      });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Request Submitted")),
                  );

                  amountController.clear();

                  descriptionController.clear();
                },

                child: const Text("Submit Request"),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Transaction History",

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
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
                    return const Center(child: Text("No Transactions Yet"));
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

                  return ListView.builder(
                    itemCount: transactions.length,

                    itemBuilder: (context, index) {
                      var data = transactions[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,

                          borderRadius: BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),

                              blurRadius: 10,

                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  data['type'],

                                  style: const TextStyle(
                                    fontSize: 18,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(data['description']),

                                const SizedBox(height: 5),

                                Text(
                                  data['status'],

                                  style: TextStyle(
                                    color: data['status'] == "approved"
                                        ? Colors.green
                                        : data['status'] == "rejected"
                                        ? Colors.red
                                        : Colors.orange,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              "₹ ${data['amount']}",

                              style: TextStyle(
                                fontSize: 20,

                                fontWeight: FontWeight.bold,

                                color: data['type'] == "Credit"
                                    ? Colors.green
                                    : Colors.red,
                              ),
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
    );
  }
}
