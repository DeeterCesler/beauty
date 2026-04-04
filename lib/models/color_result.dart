enum SeasonalType {
  trueSpring,
  lightSpring,
  warmSpring,
  trueSummer,
  lightSummer,
  coolSummer,
  trueAutumn,
  softAutumn,
  darkAutumn,
  trueWinter,
  brightWinter,
  darkWinter,
}

class ColorResult {
  final SeasonalType type;
  final String typeName;
  final double confidence;
  final String summary;
  final List<String> observedTraits;
  final List<String> bestColors;
  final List<String> avoidColors;
  final String rawResponse;
  final DateTime timestamp;

  const ColorResult({
    required this.type,
    required this.typeName,
    required this.confidence,
    required this.summary,
    required this.observedTraits,
    required this.bestColors,
    required this.avoidColors,
    required this.rawResponse,
    required this.timestamp,
  });

  static SeasonalType? typeFromString(String name) {
    const map = {
      'true spring': SeasonalType.trueSpring,
      'light spring': SeasonalType.lightSpring,
      'warm spring': SeasonalType.warmSpring,
      'true summer': SeasonalType.trueSummer,
      'light summer': SeasonalType.lightSummer,
      'cool summer': SeasonalType.coolSummer,
      'true autumn': SeasonalType.trueAutumn,
      'soft autumn': SeasonalType.softAutumn,
      'dark autumn': SeasonalType.darkAutumn,
      'true winter': SeasonalType.trueWinter,
      'bright winter': SeasonalType.brightWinter,
      'dark winter': SeasonalType.darkWinter,
    };
    return map[name.toLowerCase().trim()];
  }
}
