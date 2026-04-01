class AuthorizeRequest {
  final String firebaseUid;
  final String email;
  final String name;
  final List<String> provider;
  final String challengeCode;
  final String userSource;

  AuthorizeRequest({
    required this.firebaseUid,
    required this.email,
    required this.name,
    required this.provider,
    required this.challengeCode,
    required this.userSource,
  });

  Map<String, dynamic> toJson() => {
    "firebase_uid": firebaseUid,
    "email": email,
    "name": name,
    "provider": provider,
    "challenge_code": challengeCode,
    "user_source": userSource,
  };
}
