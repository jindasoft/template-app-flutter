class ProfileEdit {
  final String displayName;
  final String bio;

  ProfileEdit({required this.displayName, required this.bio});

  factory ProfileEdit.empty() {
    return ProfileEdit(displayName: '', bio: '');
  }

  Map<String, dynamic> toJson() {
    return {'display_name': displayName, 'bio': bio};
  }

  ProfileEdit copyWith({String? displayName, String? bio}) {
    return ProfileEdit(
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
    );
  }
}
