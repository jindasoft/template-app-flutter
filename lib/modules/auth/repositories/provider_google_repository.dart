import 'dart:async';
import 'package:template_app_flutter/configs/env_config.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_firebase.dart';
import 'provider_repository.dart';

class ProviderGoogleRepository implements ProviderRepository {
  final logger = AppLogger.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  GoogleSignInAccount? _currentGoogleUser;
  StreamSubscription<GoogleSignInAuthenticationEvent>?
  _authenticationSubscription;
  Future<void>? _initializationFuture;

  ProviderGoogleRepository() {
    _initializationFuture = _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      final envConfig = EnvConfig();
      await _googleSignIn.initialize(
        serverClientId: envConfig.googleServerClientId,
      );
      await _authenticationSubscription?.cancel();
      _authenticationSubscription = _googleSignIn.authenticationEvents.listen(
        _handleAuthenticationEvent,
        onError: (Object error, StackTrace stackTrace) {
          logger.e('Google authentication event error: $error');
        },
      );
      await _googleSignIn.attemptLightweightAuthentication();
    } catch (e) {
      logger.e('Google Sign-In initialization failed: $e');
    }
  }

  Future<void> _ensureInitialized() async {
    await (_initializationFuture ??= _initializeGoogleSignIn());
  }

  Future<void> initializeGoogleSignIn() async => _ensureInitialized();

  bool get hasActiveSession => _currentGoogleUser != null;

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };
    _currentGoogleUser = user;
  }

  Future<UserFirebase> signInWithGoogle() async {
    await _ensureInitialized();
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Retrieve authentication details
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a credential for Firebase - ใช้ OAuthCredential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final User? userDetails = userCredential.user;

      if (userDetails == null) throw Exception('Firebase sign-in failed');
      final userFirebase = await UserFirebase.fromUserFirebase(userDetails);

      return userFirebase;
    } catch (e) {
      logger.e('Google Sign-In failed: $e');
      throw Exception('Google Sign-In failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      _currentGoogleUser = null;
    } catch (e) {
      logger.e('Sign out failed: $e');
      throw Exception('Sign out failed: $e');
    }
  }

  @override
  Future<void> removeAccount() async {
    await _ensureInitialized();
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('No user currently signed in to delete');
      }
      // Force interactive account selection for reauthentication.
      // Prefer existing Google session first to avoid unnecessary canceled errors.
      GoogleSignInAccount googleUser;
      if (_currentGoogleUser != null) {
        googleUser = _currentGoogleUser!;
      } else {
        try {
          googleUser = await _googleSignIn.authenticate();
        } on GoogleSignInException catch (e) {
          if (e.code == GoogleSignInExceptionCode.canceled) {
            // Refresh stale SDK state and retry once.
            await _googleSignIn.disconnect();
            googleUser = await _googleSignIn.authenticate();
          } else {
            rethrow;
          }
        }
      }
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null || googleAuth.idToken!.isEmpty) {
        throw Exception('Failed to get Google ID token for reauthentication');
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await user.reauthenticateWithCredential(credential);
      await user.delete();
      await _googleSignIn.disconnect();
      _currentGoogleUser = null;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        logger.e('Account removal canceled by user');
        rethrow;
      }
      logger.e('GoogleSignInException during removeAccount: $e');
      throw Exception('Remove account failed: $e');
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException during removeAccount: $e');
      rethrow;
    } catch (e) {
      logger.e('Remove account failed: $e');
      throw Exception('Remove account failed: $e');
    }
  }
}
