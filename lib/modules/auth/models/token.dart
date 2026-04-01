class Token {
  final String tokenType;
  final String accessToken;
  final int expireIn;
  final String refreshToken;

  Token({
    required this.tokenType,
    required this.accessToken,
    required this.expireIn,
    required this.refreshToken,
  });

  const Token.empty()
    : tokenType = '',
      accessToken = '',
      expireIn = 0,
      refreshToken = '';

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenType: json['token_type'] as String,
      accessToken: json['access_token'] as String,
      expireIn: json['expire_in'] as int,
      refreshToken: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
      'expire_in': expireIn,
      'refresh_token': refreshToken,
    };
  }
}
