class ProfileImage {
  final String avatarUrl;

  ProfileImage({required this.avatarUrl});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(avatarUrl: json['avatar_url']);
  }

  Map<String, dynamic> toJson() {
    return {'avatar_url': avatarUrl};
  }
}
