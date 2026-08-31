class ContentImage {
  final String id;
  final String slug;
  final String name;
  final String summary;
  final String imageCover;

  ContentImage({
    required this.id,
    required this.slug,
    required this.name,
    required this.summary,
    required this.imageCover,
  });

  static ContentImage empty() =>
      ContentImage(id: '', slug: '', name: '', summary: '', imageCover: '');

  factory ContentImage.fromJson(Map<String, dynamic> json) {
    return ContentImage(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      summary: json['summary'],
      imageCover: json['image_cover'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'summary': summary,
      'image_cover': imageCover,
    };
  }
}
