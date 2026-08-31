class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequest(refreshToken: json['refresh_token']);
  }

  Map<String, dynamic> toJson() {
    return {'refresh_token': refreshToken};
  }
}
