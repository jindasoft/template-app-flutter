class Authorize {
  final String authorizeToken;

  Authorize({required this.authorizeToken});

  const Authorize.empty() : authorizeToken = '';

  factory Authorize.fromJson(Map<String, dynamic> json) {
    return Authorize(authorizeToken: json['authorize_token']);
  }

  Map<String, dynamic> toJson() {
    return {'authorize_token': authorizeToken};
  }
}
