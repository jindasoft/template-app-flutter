class TokenRequest {
  final String authorizeToken;
  final String verifierCode;

  TokenRequest({required this.authorizeToken, required this.verifierCode});

  factory TokenRequest.fromJson(Map<String, dynamic> json) {
    return TokenRequest(
      authorizeToken: json['authorize_token'],
      verifierCode: json['verifier_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'authorize_token': authorizeToken, 'verifier_code': verifierCode};
  }
}
