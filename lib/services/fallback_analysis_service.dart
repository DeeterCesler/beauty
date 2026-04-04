import 'package:flutter/foundation.dart';
import '../models/kibbe_result.dart';
import '../models/color_result.dart';
import 'analysis_provider.dart';
import 'anthropic_service.dart';
import 'openai_service.dart';
import 'web_proxy_service.dart';

class FallbackAnalysisService implements AnalysisProvider {
  final AnthropicService _primary;
  final OpenAIService _fallback;
  final WebProxyService _webProxy;

  FallbackAnalysisService({
    required AnthropicService primary,
    required OpenAIService fallback,
    required WebProxyService webProxy,
  })  : _primary = primary,
        _fallback = fallback,
        _webProxy = webProxy;

  @override
  Future<KibbeResult> analyzeKibbe(Uint8List imageBytes) async {
    // On web: route through the Vercel proxy (API key stays server-side).
    if (kIsWeb) return await _webProxy.analyzeKibbe(imageBytes);

    // On native: Anthropic first, OpenAI as fallback.
    try {
      return await _primary.analyzeKibbe(imageBytes);
    } on AnalysisException {
      rethrow;
    } catch (e) {
      debugPrint('Anthropic failed for Kibbe, falling back to OpenAI: $e');
      try {
        return await _fallback.analyzeKibbe(imageBytes);
      } on AnalysisException {
        rethrow;
      } catch (e2) {
        debugPrint('OpenAI also failed for Kibbe: $e2');
        throw const AnalysisException(
          'Unable to analyze the photo. Please check your connection and try again.',
        );
      }
    }
  }

  @override
  Future<ColorResult> analyzeColor(Uint8List imageBytes) async {
    // On web: route through the Vercel proxy (API key stays server-side).
    if (kIsWeb) return await _webProxy.analyzeColor(imageBytes);

    // On native: Anthropic first, OpenAI as fallback.
    try {
      return await _primary.analyzeColor(imageBytes);
    } on AnalysisException {
      rethrow;
    } catch (e) {
      debugPrint('Anthropic failed for Color, falling back to OpenAI: $e');
      try {
        return await _fallback.analyzeColor(imageBytes);
      } on AnalysisException {
        rethrow;
      } catch (e2) {
        debugPrint('OpenAI also failed for Color: $e2');
        throw const AnalysisException(
          'Unable to analyze the photo. Please check your connection and try again.',
        );
      }
    }
  }
}
