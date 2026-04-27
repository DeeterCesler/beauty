import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/kibbe_result.dart';
import '../models/color_result.dart';
import 'analysis_provider.dart';
import 'image_service.dart';

// Native builds: supply the deployed URL at build time via
//   flutter build <target> --dart-define=VERCEL_URL=https://your-app.vercel.app
const _vercelUrl = String.fromEnvironment('VERCEL_URL');

class WebProxyService implements AnalysisProvider {
  static Uri get _endpoint {
    if (kIsWeb) return Uri.base.replace(path: '/api/analyze');
    assert(_vercelUrl.isNotEmpty, 'Set --dart-define=VERCEL_URL=https://... for native builds');
    return Uri.parse('$_vercelUrl/api/analyze');
  }

  @override
  Future<KibbeResult> analyzeKibbe(Uint8List imageBytes) async {
    final raw = await _call('kibbe', imageBytes);
    return _parseKibbe(raw);
  }

  @override
  Future<ColorResult> analyzeColor(Uint8List imageBytes) async {
    final raw = await _call('color', imageBytes);
    return _parseColor(raw);
  }

  Future<String> _call(String type, Uint8List imageBytes) async {
    final base64Image = ImageService.toBase64(imageBytes);
    final response = await http.post(
      _endpoint,
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'type': type, 'imageBase64': base64Image}),
    );

    if (response.statusCode != 200) {
      debugPrint('Proxy error ${response.statusCode}: ${response.body}');
      throw AnalysisException('Analysis failed (${response.statusCode}). Please try again.');
    }

    return response.body;
  }

  KibbeResult _parseKibbe(String raw) {
    try {
      final json = jsonDecode(raw.trim()) as Map<String, dynamic>;
      final typeName = json['kibbeType'] as String?;
      final type = typeName != null ? KibbeResult.typeFromString(typeName) : null;

      if (type == null) {
        throw AnalysisException(
          json['summary'] as String? ?? 'Could not determine Kibbe type from this photo.',
        );
      }

      return KibbeResult(
        type: type,
        typeName: typeName!,
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0.75,
        summary: json['summary'] as String? ?? '',
        bodyTraits: _toList(json['bodyTraits']),
        styleAdvice: _toList(json['styleAdvice']),
        rawResponse: raw,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (e is AnalysisException) rethrow;
      throw const AnalysisException('Could not parse analysis result. Please try again.');
    }
  }

  ColorResult _parseColor(String raw) {
    try {
      final json = jsonDecode(raw.trim()) as Map<String, dynamic>;
      final typeName = json['seasonalType'] as String?;
      final type = typeName != null ? ColorResult.typeFromString(typeName) : null;

      if (type == null) {
        throw AnalysisException(
          json['summary'] as String? ?? 'Could not determine seasonal color type from this photo.',
        );
      }

      return ColorResult(
        type: type,
        typeName: typeName!,
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0.75,
        summary: json['summary'] as String? ?? '',
        observedTraits: _toList(json['observedTraits']),
        bestColors: _toList(json['bestColors']),
        avoidColors: _toList(json['avoidColors']),
        rawResponse: raw,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (e is AnalysisException) rethrow;
      throw const AnalysisException('Could not parse analysis result. Please try again.');
    }
  }

  List<String> _toList(dynamic value) {
    if (value is List) return value.cast<String>();
    return [];
  }
}
