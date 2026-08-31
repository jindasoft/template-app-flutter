class AuthorizeRequest {
  final String firebaseUid;
  final String email;
  final String displayName;
  final List<String> provider;
  final String challengeCode;

  AuthorizeRequest({
    required this.firebaseUid,
    required this.email,
    required this.displayName,
    required this.provider,
    required this.challengeCode,
  });

  Map<String, dynamic> toJson() => {
    "firebase_uid": firebaseUid,
    "email": email,
    "display_name": displayName,
    "provider": provider,
    "challenge_code": challengeCode,
  };
}
