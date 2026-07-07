class ProfileDetail {
  final String id;
  final String accountId;
  final String jid;
  final String displayName;
  final String avatarUrl;
  final String bio;

  ProfileDetail({
    required this.id,
    required this.accountId,
    required this.jid,
    required this.displayName,
    required this.avatarUrl,
    this.bio = '',
  });

  static ProfileDetail empty() => ProfileDetail(
    id: '',
    accountId: '',
    jid: '',
    displayName: '',
    avatarUrl: '',
    bio: '',
  );

  factory ProfileDetail.fromJson(Map<String, dynamic> json) {
    return ProfileDetail(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      jid: json['jid'] as String,
      displayName: json['display_name'] as String,
      avatarUrl: json['avatar_url'] as String,
      bio: json['bio'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'jid': jid,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'bio': bio,
    };
  }

  ProfileDetail copyWith({
    String? id,
    String? accountId,
    String? jid,
    String? displayName,
    String? avatarUrl,
    String? bio,
  }) {
    return ProfileDetail(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      jid: jid ?? this.jid,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
    );
  }
}
