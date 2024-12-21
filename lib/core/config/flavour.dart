


enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return baseUrl;
      case Flavor.prod:
        return baseUrl;
      default:
        return '';
    }
  }
}