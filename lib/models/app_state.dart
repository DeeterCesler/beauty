import 'package:flutter/foundation.dart';
import 'kibbe_result.dart';
import 'color_result.dart';

enum AnalysisStatus { idle, processing, success, error }

class KibbeState extends ChangeNotifier {
  AnalysisStatus _status = AnalysisStatus.idle;
  Uint8List? _imageBytes;
  KibbeResult? _result;
  String? _errorMessage;

  AnalysisStatus get status => _status;
  Uint8List? get imageBytes => _imageBytes;
  KibbeResult? get result => _result;
  String? get errorMessage => _errorMessage;

  void setImage(Uint8List bytes) {
    _imageBytes = bytes;
    _status = AnalysisStatus.idle;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  void setProcessing() {
    _status = AnalysisStatus.processing;
    _errorMessage = null;
    notifyListeners();
  }

  void setResult(KibbeResult result) {
    _result = result;
    _status = AnalysisStatus.success;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    _status = AnalysisStatus.error;
    notifyListeners();
  }

  void reset() {
    _status = AnalysisStatus.idle;
    _imageBytes = null;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }
}

class ColorState extends ChangeNotifier {
  AnalysisStatus _status = AnalysisStatus.idle;
  Uint8List? _imageBytes;
  ColorResult? _result;
  String? _errorMessage;

  AnalysisStatus get status => _status;
  Uint8List? get imageBytes => _imageBytes;
  ColorResult? get result => _result;
  String? get errorMessage => _errorMessage;

  void setImage(Uint8List bytes) {
    _imageBytes = bytes;
    _status = AnalysisStatus.idle;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  void setProcessing() {
    _status = AnalysisStatus.processing;
    _errorMessage = null;
    notifyListeners();
  }

  void setResult(ColorResult result) {
    _result = result;
    _status = AnalysisStatus.success;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    _status = AnalysisStatus.error;
    notifyListeners();
  }

  void reset() {
    _status = AnalysisStatus.idle;
    _imageBytes = null;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }
}
