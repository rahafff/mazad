import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class FireBaseRemoteDataSource {
  Future<Map<String, String?>> sendCode(String? phoneNumber);
  Future<Map<String, String?>> verify(String? otp);
}

class FireBaseRemoteDataSourceImp implements FireBaseRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  String _verificationId = '';
  final Map<String, String?> _userIdAndToken = {};
  FireBaseRemoteDataSourceImp(this._firebaseAuth);

  @override
  Future<Map<String, String?>> sendCode(String? phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 14),
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        verificationCompleted: _verificationCompleted,
      );
      return _userIdAndToken;
    } catch (e) {
      rethrow;
    }
  }

  _verificationCompleted(PhoneAuthCredential credential) {}

  @override
  Future<Map<String, String?>> verify(String? otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp!);

    return await _signIn(credential);
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    if (kDebugMode) {
      print('codeAutoRetrievalTimeout');
    }
  }

  void _verificationFailed(FirebaseAuthException error) {}

  Future<Map<String, String?>> _signIn(PhoneAuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential).then(
        (value) async {
          _userIdAndToken['idToken'] = await _getUserId();
          _userIdAndToken['userId'] = value.user?.uid;
        },
      );
      return _userIdAndToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _getUserId() async {
    String? tokenId = await _firebaseAuth.currentUser?.getIdToken(true);
    return tokenId;
  }

  void _codeSent(String verificationId, int? resendToken) {
    if (kDebugMode) {
      print('codeSent');
    }
    this._verificationId = verificationId;
    if (kDebugMode) {
      print("verificationId : $verificationId");
    }
  }
}
