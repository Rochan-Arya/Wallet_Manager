import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

import '../services/auth_services.dart';
import '../services/firestore_services.dart';

class AppAuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? _firebaseUser;

  User? get firebaseUser => _firebaseUser;

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<void> checkAuthState() async {
    _firebaseUser = FirebaseAuth.instance.currentUser;

    if (_firebaseUser != null) {
      _currentUser = await _firestoreService.getCurrentUser();

      notifyListeners();
    }
  }

  Future<void> refreshUser() async {
    _currentUser = await _firestoreService.getCurrentUser();

    notifyListeners();
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String mobile,
    required String upiId,
    required String password,
  }) async {
    try {
      _isLoading = true;

      notifyListeners();

      _firebaseUser = await _authService.signUp(
        email: email,
        password: password,
      );

      if (_firebaseUser != null) {
        await _firestoreService.createUser(
          uid: _firebaseUser!.uid,
          name: name,
          email: email,
          mobile: mobile,
          upiId: upiId,
        );

        _currentUser = await _firestoreService.getCurrentUser();
      }

      _isLoading = false;

      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;

      notifyListeners();

      print(e);

      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      _isLoading = true;

      notifyListeners();

      _firebaseUser = await _authService.login(
        email: email,
        password: password,
      );

      if (_firebaseUser != null) {
        _currentUser = await _firestoreService.getCurrentUser();
      }

      _isLoading = false;

      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;

      notifyListeners();

      print(e);

      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();

    _firebaseUser = null;

    _currentUser = null;

    notifyListeners();
  }
}
