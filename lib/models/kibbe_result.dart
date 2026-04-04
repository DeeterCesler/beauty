enum KibbeType {
  dramatic,
  softDramatic,
  flamboyantNatural,
  natural,
  softNatural,
  classic,
  softClassic,
  dramaticClassic,
  gamine,
  softGamine,
  flamboyantGamine,
  romantic,
  theatricalRomantic,
}

class KibbeResult {
  final KibbeType type;
  final String typeName;
  final double confidence;
  final String summary;
  final List<String> bodyTraits;
  final List<String> styleAdvice;
  final String rawResponse;
  final DateTime timestamp;

  const KibbeResult({
    required this.type,
    required this.typeName,
    required this.confidence,
    required this.summary,
    required this.bodyTraits,
    required this.styleAdvice,
    required this.rawResponse,
    required this.timestamp,
  });

  static KibbeType? typeFromString(String name) {
    const map = {
      'dramatic': KibbeType.dramatic,
      'soft dramatic': KibbeType.softDramatic,
      'flamboyant natural': KibbeType.flamboyantNatural,
      'natural': KibbeType.natural,
      'soft natural': KibbeType.softNatural,
      'classic': KibbeType.classic,
      'soft classic': KibbeType.softClassic,
      'dramatic classic': KibbeType.dramaticClassic,
      'gamine': KibbeType.gamine,
      'soft gamine': KibbeType.softGamine,
      'flamboyant gamine': KibbeType.flamboyantGamine,
      'romantic': KibbeType.romantic,
      'theatrical romantic': KibbeType.theatricalRomantic,
    };
    return map[name.toLowerCase().trim()];
  }
}
