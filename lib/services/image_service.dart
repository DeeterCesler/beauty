import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../utils/constants.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<Uint8List?> pickFromGallery() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: AppConstants.maxImageDimension.toDouble(),
      maxHeight: AppConstants.maxImageDimension.toDouble(),
      imageQuality: AppConstants.imageQuality,
    );
    if (picked == null) return null;
    final bytes = await picked.readAsBytes();
    return _resizeBytes(bytes);
  }

  static Future<Uint8List?> takePhoto() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: AppConstants.maxImageDimension.toDouble(),
      maxHeight: AppConstants.maxImageDimension.toDouble(),
      imageQuality: AppConstants.imageQuality,
    );
    if (picked == null) return null;
    final bytes = await picked.readAsBytes();
    return _resizeBytes(bytes);
  }

  static Uint8List _resizeBytes(Uint8List bytes) {
    img.Image? image = img.decodeImage(bytes);
    if (image == null) return bytes;

    if (image.width > AppConstants.maxImageDimension ||
        image.height > AppConstants.maxImageDimension) {
      image = img.copyResize(
        image,
        width: image.width > image.height ? AppConstants.maxImageDimension : null,
        height: image.height >= image.width ? AppConstants.maxImageDimension : null,
        maintainAspect: true,
      );
    }

    return Uint8List.fromList(
      img.encodeJpg(image, quality: AppConstants.imageQuality),
    );
  }

  static String toBase64(Uint8List bytes) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    final result = StringBuffer();
    int i = 0;
    while (i + 2 < bytes.length) {
      final b0 = bytes[i];
      final b1 = bytes[i + 1];
      final b2 = bytes[i + 2];
      result.write(chars[b0 >> 2]);
      result.write(chars[((b0 & 0x3) << 4) | (b1 >> 4)]);
      result.write(chars[((b1 & 0xF) << 2) | (b2 >> 6)]);
      result.write(chars[b2 & 0x3F]);
      i += 3;
    }
    if (i + 1 == bytes.length) {
      final b0 = bytes[i];
      result.write(chars[b0 >> 2]);
      result.write(chars[(b0 & 0x3) << 4]);
      result.write('==');
    } else if (i + 2 == bytes.length) {
      final b0 = bytes[i];
      final b1 = bytes[i + 1];
      result.write(chars[b0 >> 2]);
      result.write(chars[((b0 & 0x3) << 4) | (b1 >> 4)]);
      result.write(chars[(b1 & 0xF) << 2]);
      result.write('=');
    }
    return result.toString();
  }
}
