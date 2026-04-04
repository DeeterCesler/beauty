import 'dart:typed_data';
import '../models/kibbe_result.dart';
import '../models/color_result.dart';

abstract class AnalysisProvider {
  Future<KibbeResult> analyzeKibbe(Uint8List imageBytes);
  Future<ColorResult> analyzeColor(Uint8List imageBytes);
}

class AnalysisException implements Exception {
  final String message;
  const AnalysisException(this.message);

  @override
  String toString() => message;
}
