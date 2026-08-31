class DeleteAccountRequest {
  final String refreshToken;

  DeleteAccountRequest({required this.refreshToken});

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) {
    return DeleteAccountRequest(refreshToken: json['refresh_token']);
  }

  Map<String, dynamic> toJson() {
    return {'refresh_token': refreshToken};
  }
}
