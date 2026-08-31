class SignOutRequest {
  final String refreshToken;

  SignOutRequest({required this.refreshToken});

  factory SignOutRequest.fromJson(Map<String, dynamic> json) {
    return SignOutRequest(refreshToken: json['refresh_token']);
  }

  Map<String, dynamic> toJson() {
    return {'refresh_token': refreshToken};
  }
}
