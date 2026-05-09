class TransactionModel {
  final String id;

  final String userId;

  final int amount;

  final String type;

  final String status;

  final String description;

  final String createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.status,
    required this.description,
    required this.createdAt,
  });

  factory TransactionModel.fromMap(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return TransactionModel(
      id: documentId,

      userId: data['userId'] ?? '',

      amount: data['amount'] ?? 0,

      type: data['type'] ?? '',

      status: data['status'] ?? '',

      description: data['description'] ?? '',

      createdAt: data['createdAt'] ?? '',
    );
  }
}
