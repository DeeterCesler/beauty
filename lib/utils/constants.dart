class AppConstants {
  AppConstants._();

  static const String anthropicApiUrl = 'https://api.anthropic.com/v1/messages';
  static const String openAiApiUrl = 'https://api.openai.com/v1/chat/completions';

  static const String anthropicModel = 'claude-sonnet-4-6';
  static const String openAiModel = 'gpt-4o';
  static const String anthropicVersion = '2023-06-01';

  static const int maxImageDimension = 1024;
  static const int imageQuality = 85;
  static const int apiMaxTokens = 1024;

  static const double screenPadding = 20.0;
  static const double cardRadius = 16.0;
  static const double buttonRadius = 14.0;
}
