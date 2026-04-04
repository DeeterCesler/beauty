import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/kibbe_result.dart';
import '../models/color_result.dart';
import '../utils/constants.dart';
import 'analysis_provider.dart';
import 'image_service.dart';

class AnthropicService implements AnalysisProvider {
  String get _apiKey => dotenv.env['ANTHROPIC_API_KEY'] ?? '';

  static const _kibbePrompt = '''
You are an expert in the Kibbe Body Type system. Analyze the photograph and determine the person's Kibbe body type.

The 13 valid types: Dramatic, Soft Dramatic, Flamboyant Natural, Natural, Soft Natural, Classic, Soft Classic, Dramatic Classic, Gamine, Soft Gamine, Flamboyant Gamine, Romantic, Theatrical Romantic

Evaluate: bone structure (sharp/angular vs wide/blunt vs small/delicate), body flesh (lean/taut vs soft/full), facial features, and overall vertical line (elongated vs petite/compact).

Respond ONLY with valid JSON — no markdown, no surrounding text:
{
  "kibbeType": "Soft Dramatic",
  "confidence": 0.82,
  "summary": "2-3 sentence explanation based on what you observe in the photo.",
  "bodyTraits": ["Angular jawline and cheekbones", "Strong vertical line"],
  "styleAdvice": ["Structured shoulders with soft draping", "Avoid stiff tailoring without softness"]
}

If the person is not clearly visible, set "kibbeType": null and explain in "summary".
''';

  static const _colorPrompt = '''
You are an expert in 12-season color analysis. Analyze the photograph and determine the person's seasonal color type.

The 12 valid types: True Spring, Light Spring, Warm Spring, True Summer, Light Summer, Cool Summer, True Autumn, Soft Autumn, Dark Autumn, True Winter, Bright Winter, Dark Winter

Evaluate: skin undertone (warm/golden vs cool/pink vs neutral), skin depth (light/medium/deep), natural hair depth and warmth, eye color and warmth, overall contrast level between features.

Respond ONLY with valid JSON — no markdown, no surrounding text:
{
  "seasonalType": "Soft Autumn",
  "confidence": 0.79,
  "summary": "2-3 sentence explanation based on what you observe in the photo.",
  "observedTraits": ["Warm golden-brown undertone in skin", "Low-medium contrast between hair and skin"],
  "bestColors": ["Warm camel", "Dusty terracotta", "Olive green", "Soft rust"],
  "avoidColors": ["Icy blues", "Pure white", "Cool charcoal"]
}

If lighting is artificial or features are unclear, set "seasonalType": null and explain in "summary".
''';

  @override
  Future<KibbeResult> analyzeKibbe(Uint8List imageBytes) async {
    final response = await _callApi(imageBytes, _kibbePrompt);
    return _parseKibbeResponse(response);
  }

  @override
  Future<ColorResult> analyzeColor(Uint8List imageBytes) async {
    final response = await _callApi(imageBytes, _colorPrompt);
    return _parseColorResponse(response);
  }

  Future<String> _callApi(Uint8List imageBytes, String prompt) async {
    final base64Image = ImageService.toBase64(imageBytes);
    final body = jsonEncode({
      'model': AppConstants.anthropicModel,
      'max_tokens': AppConstants.apiMaxTokens,
      'messages': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'image',
              'source': {
                'type': 'base64',
                'media_type': 'image/jpeg',
                'data': base64Image,
              },
            },
            {
              'type': 'text',
              'text': prompt,
            },
          ],
        },
      ],
    });

    final response = await http.post(
      Uri.parse(AppConstants.anthropicApiUrl),
      headers: {
        'x-api-key': _apiKey,
        'anthropic-version': AppConstants.anthropicVersion,
        'content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      debugPrint('Anthropic error ${response.statusCode}: ${response.body}');
      throw AnalysisException('Anthropic API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content = data['content'] as List<dynamic>;
    return (content.first as Map<String, dynamic>)['text'] as String;
  }

  KibbeResult _parseKibbeResponse(String raw) {
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
        bodyTraits: _toStringList(json['bodyTraits']),
        styleAdvice: _toStringList(json['styleAdvice']),
        rawResponse: raw,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (e is AnalysisException) rethrow;
      debugPrint('Kibbe parse error: $e\nRaw: $raw');
      throw const AnalysisException('Could not parse analysis result. Please try again.');
    }
  }

  ColorResult _parseColorResponse(String raw) {
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
        observedTraits: _toStringList(json['observedTraits']),
        bestColors: _toStringList(json['bestColors']),
        avoidColors: _toStringList(json['avoidColors']),
        rawResponse: raw,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      if (e is AnalysisException) rethrow;
      debugPrint('Color parse error: $e\nRaw: $raw');
      throw const AnalysisException('Could not parse analysis result. Please try again.');
    }
  }

  List<String> _toStringList(dynamic value) {
    if (value is List) return value.cast<String>();
    return [];
  }
}
