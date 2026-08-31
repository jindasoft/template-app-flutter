class ProfileDetail {
  final String profileId;
  final String displayName;
  final String bio;

  ProfileDetail({
    required this.profileId,
    required this.displayName,
    this.bio = '',
  });

  static ProfileDetail empty() =>
      ProfileDetail(profileId: '', displayName: '', bio: '');

  factory ProfileDetail.fromJson(Map<String, dynamic> json) {
    return ProfileDetail(
      profileId: json['profile_id'] as String,
      displayName: json['display_name'] as String,
      bio: json['bio'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'profile_id': profileId, 'display_name': displayName, 'bio': bio};
  }

  ProfileDetail copyWith({
    String? profileId,
    String? jid,
    String? displayName,
    String? avatarUrl,
    String? bio,
  }) {
    return ProfileDetail(
      profileId: profileId ?? this.profileId,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
    );
  }
}
