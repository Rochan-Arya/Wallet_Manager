import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  String searchText = '';

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
                "Users",

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },

                decoration: InputDecoration(
                  hintText: "Search users...",

                  prefixIcon: const Icon(Icons.search),

                  filled: true,

                  fillColor: Theme.of(context).cardColor,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),

                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var users = snapshot.data!.docs.where((user) {
                      var data = user.data() as Map<String, dynamic>;

                      return data['role'] != 'admin' &&
                          data['name'].toString().toLowerCase().contains(
                            searchText,
                          );
                    }).toList();

                    if (users.isEmpty) {
                      return const Center(child: Text("No Users"));
                    }

                    return ListView.builder(
                      itemCount: users.length,

                      itemBuilder: (context, index) {
                        var user = users[index];

                        var data = user.data() as Map<String, dynamic>;

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

                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,

                                backgroundColor: Colors.orange,

                                child: Text(
                                  data['name']
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),

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
                                      data['name'],

                                      style: const TextStyle(
                                        fontSize: 18,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(data['email']),

                                    const SizedBox(height: 3),

                                    Text(
                                      data['upiId'] ?? '',

                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color
                                            ?.withOpacity(0.6),

                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Text(
                                    "Balance",

                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.6),

                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "₹ ${data['walletBalance']}",

                                    style: const TextStyle(
                                      color: Colors.green,

                                      fontSize: 18,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  SizedBox(
                                    height: 35,

                                    child: ElevatedButton(
                                      onPressed: () {
                                        TextEditingController
                                        balanceController =
                                            TextEditingController(
                                              text: data['walletBalance']
                                                  .toString(),
                                            );

                                        showDialog(
                                          context: context,

                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Update Balance",
                                              ),

                                              content: TextField(
                                                controller: balanceController,

                                                keyboardType:
                                                    TextInputType.number,

                                                decoration:
                                                    const InputDecoration(
                                                      labelText:
                                                          "Wallet Balance",
                                                    ),
                                              ),

                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },

                                                  child: const Text("Cancel"),
                                                ),

                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(user.id)
                                                        .update({
                                                          'walletBalance':
                                                              int.parse(
                                                                balanceController
                                                                    .text,
                                                              ),
                                                        });

                                                    Navigator.pop(context);
                                                  },

                                                  child: const Text("Save"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },

                                      child: const Text("Edit"),
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
