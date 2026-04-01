class RefreshTokenRequest {
  final String refreshToken;
  final String verifierCode;

  RefreshTokenRequest({required this.refreshToken, required this.verifierCode});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequest(
      refreshToken: json['refresh_token'],
      verifierCode: json['verifier_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'refresh_token': refreshToken, 'verifier_code': verifierCode};
  }
}
