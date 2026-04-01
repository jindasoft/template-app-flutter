import 'dart:convert' show json;
import 'package:template_app_flutter/configs/env_config.dart';
import 'package:http/http.dart' as http;

import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_firebase.dart';
import 'provider_repository.dart';

const List<String> scopes = <String>[
  'https://www.googleapis.com/auth/contacts.readonly',
];

class GoogleProviderRepository implements ProviderRepository {
  final logger = AppLogger.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  GoogleSignInAccount? _currentGoogleUser;

  GoogleProviderRepository() {
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      final envConfig = EnvConfig();
      await _googleSignIn.initialize(
        serverClientId: envConfig.googleServerClientId,
      );
      _googleSignIn.authenticationEvents.listen(_handleAuthenticationEvent);
      await _googleSignIn.attemptLightweightAuthentication();
    } catch (e) {
      logger.e('Google Sign-In initialization failed: $e');
    }
  }

  Future<void> initializeGoogleSignIn() async => _initializeGoogleSignIn();

  bool get hasActiveSession => _currentGoogleUser != null;

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };
    _currentGoogleUser = user;

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes(scopes);

    if (user != null && authorization != null) {
      await _fetchContact(user);
    }
  }

  Future<void> _fetchContact(GoogleSignInAccount user) async {
    try {
      final headers = await user.authorizationClient.authorizationHeaders(
        scopes,
      );
      if (headers == null) {
        throw Exception('Failed to construct authorization headers.');
      }

      final response = await http.get(
        Uri.parse(
          '${EnvConfig().googlePeopleApiUrl}?requestMask.includeField=person.names',
        ),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('People API error: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      _extractContactName(data);
    } catch (e) {
      logger.e('Fetching contact failed: $e');
    }
  }

  String? _extractContactName(Map<String, dynamic> data) {
    final connections = data['connections'] as List<dynamic>?;
    final contact =
        connections?.firstWhere(
              (contact) => (contact as Map<String, dynamic>)['names'] != null,
              orElse: () => null,
            )
            as Map<String, dynamic>?;

    if (contact != null) {
      final names = contact['names'] as List<dynamic>;
      final name =
          names.firstWhere(
                (name) => (name as Map<String, dynamic>)['displayName'] != null,
                orElse: () => null,
              )
              as Map<String, dynamic>?;

      return name?['displayName'] as String?;
    }
    return null;
  }

  Future<UserFirebase> signInWithGoogle() async {
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
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        logger.e('Account removal canceled by user');
        rethrow;
      }
      logger.e('GoogleSignInException during removeAccount: $e');
      throw Exception('Remove account failed: $e');
    } catch (e) {
      logger.e('Remove account failed: $e');
      throw Exception('Remove account failed: $e');
    }
  }
}
