class ProfileEdit {
  final String id;
  final String displayName;
  final String bio;

  ProfileEdit({required this.id, required this.displayName, required this.bio});

  Map<String, dynamic> toJson() {
    return {'id': id, 'display_name': displayName, 'bio': bio};
  }

  ProfileEdit copyWith({String? displayName, String? bio}) {
    return ProfileEdit(
      id: id,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
    );
  }
}
