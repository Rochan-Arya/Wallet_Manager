class UserModel {
  final String id;

  final String name;

  final String email;

  final String mobile;

  final String upiId;

  final int walletBalance;

  final String role;

  UserModel({
    required this.id,

    required this.name,

    required this.email,

    required this.mobile,

    required this.upiId,

    required this.walletBalance,

    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,

      name: map['name'] ?? '',

      email: map['email'] ?? '',

      mobile: map['mobile'] ?? '',

      upiId: map['upiId'] ?? '',

      walletBalance: map['walletBalance'] ?? 0,

      role: map['role'] ?? 'user',
    );
  }
}
