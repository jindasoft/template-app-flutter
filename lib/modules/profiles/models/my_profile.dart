class MyProfile {
  final String profileId;
  final String jid;
  final String displayName;
  final String avatarUrl;
  final String bio;

  MyProfile({
    required this.profileId,
    required this.jid,
    required this.displayName,
    required this.avatarUrl,
    this.bio = '',
  });

  static MyProfile empty() => MyProfile(
    profileId: '',
    jid: '',
    displayName: '',
    avatarUrl: '',
    bio: '',
  );

  factory MyProfile.fromJson(Map<String, dynamic> json) {
    return MyProfile(
      profileId: json['profile_id'] as String,
      jid: json['jid'] as String,
      displayName: json['display_name'] as String,
      avatarUrl: json['avatar_url'] as String,
      bio: json['bio'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'jid': jid,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'bio': bio,
    };
  }

  MyProfile copyWith({
    String? profileId,
    String? jid,
    String? displayName,
    String? avatarUrl,
    String? bio,
  }) {
    return MyProfile(
      profileId: profileId ?? this.profileId,
      jid: jid ?? this.jid,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
    );
  }
}
