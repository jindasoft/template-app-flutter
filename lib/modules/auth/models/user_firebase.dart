import 'package:firebase_auth/firebase_auth.dart';

class UserFirebase {
  final String uid;
  final String idToken;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final List<String> provider;

  UserFirebase({
    required this.uid,
    required this.idToken,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.provider,
  });

  UserFirebase.empty()
    : uid = '',
      idToken = '',
      email = '',
      displayName = null,
      photoUrl = null,
      provider = [];

  static Future<UserFirebase> fromUserFirebase(User user) async {
    return UserFirebase(
      uid: user.uid,
      idToken: await user.getIdToken() ?? '',
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      provider: user.providerData.map((info) => info.providerId).toList(),
    );
  }
}
