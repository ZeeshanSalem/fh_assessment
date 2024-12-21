class AppConfig {
  final String appName;
  final String flavorName;
  final String locale;
  final String currency;
  final String countryCode;

  AppConfig(
      {required this.appName,
        required this.flavorName,
        required this.locale,
        required this.currency,
        required this.countryCode});
}