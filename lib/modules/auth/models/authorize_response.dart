class AuthorizeResponse {
  final String authorizeToken;

  AuthorizeResponse({required this.authorizeToken});

  AuthorizeResponse.empty() : authorizeToken = '';

  factory AuthorizeResponse.fromJson(Map<String, dynamic> json) {
    return AuthorizeResponse(authorizeToken: json['authorize_token']);
  }

  Map<String, dynamic> toJson() {
    return {'authorize_token': authorizeToken};
  }
}
