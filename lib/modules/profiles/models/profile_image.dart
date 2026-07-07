class ProfileImage {
  final String imageId;

  ProfileImage({required this.imageId});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(imageId: json['image_id']);
  }

  Map<String, dynamic> toJson() {
    return {'image_id': imageId};
  }
}
