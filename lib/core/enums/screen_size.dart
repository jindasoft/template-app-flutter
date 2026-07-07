enum ScreenSize { base, large, extra }

extension ScreenSizeTypeValue on ScreenSize {
  int get value {
    switch (this) {
      case ScreenSize.base:
        return 600;
      case ScreenSize.large:
        return 900;
      case ScreenSize.extra:
        return 1200;
    }
  }
}
