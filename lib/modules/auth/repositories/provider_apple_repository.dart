import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/user_firebase.dart';
import 'provider_repository.dart';

class ProviderAppleRepository implements ProviderRepository {
  final logger = AppLogger.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserFirebase> signInWithApple() async {
    try {
      // Trigger the Apple Sign-In flow
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create a credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the Apple credential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(oauthCredential);

      final User? userDetails = userCredential.user;

      if (userDetails == null) throw Exception('Firebase sign-in failed');
      final userFirebase = await UserFirebase.fromUserFirebase(userDetails);

      return userFirebase;
    } catch (e) {
      logger.e('Apple Sign-In failed: $e');
      throw Exception('Apple Sign-In failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      logger.e('Sign out failed: $e');
      throw Exception('Sign out failed: $e');
    }
  }

  @override
  Future<void> removeAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user currently signed in to delete');
      }
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        final user = _firebaseAuth.currentUser;
        if (user != null) {
          final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          final oauthCredential = OAuthProvider("apple.com").credential(
            idToken: appleCredential.identityToken,
            accessToken: appleCredential.authorizationCode,
          );

          await user.reauthenticateWithCredential(oauthCredential);
          await user.delete();
        }
      } else {
        rethrow;
      }
    } catch (e) {
      logger.e('Remove account failed: $e');
      throw Exception('Remove account failed: $e');
    }
  }
}
