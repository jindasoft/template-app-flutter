enum ImageSize { thumbnail, extraSmall, small, medium, large, extraLarge }

extension ImageSizeText on ImageSize {
  String get text {
    switch (this) {
      case ImageSize.thumbnail:
        return 'thumbnail';
      case ImageSize.extraSmall:
        return 'x-small';
      case ImageSize.small:
        return 'small';
      case ImageSize.medium:
        return 'medium';
      case ImageSize.large:
        return 'large';
      case ImageSize.extraLarge:
        return 'x-large';
    }
  }
}
