import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';
import '../../theme/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/image_source_sheet.dart';
import 'kibbe_processing_screen.dart';

class KibbeCaptureScreen extends StatelessWidget {
  const KibbeCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<KibbeState>();
    final imageBytes = state.imageBytes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Photo'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
              child: imageBytes == null
                  ? const _EmptyState()
                  : _ImagePreview(bytes: imageBytes),
            ),
          ),
          _BottomActions(hasImage: imageBytes != null),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline_rounded, size: 56, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Text('No photo selected', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Choose an option below to add your photo.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final Uint8List bytes;
  const _ImagePreview({required this.bytes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.memory(bytes, fit: BoxFit.contain),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final bool hasImage;
  const _BottomActions({required this.hasImage});

  Future<void> _pickImage(BuildContext context) async {
    final Uint8List? bytes = await ImageSourceSheet.show(context);
    if (bytes != null && context.mounted) {
      context.read<KibbeState>().setImage(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.screenPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasImage) ...[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KibbeProcessingScreen()),
                );
              },
              child: const Text('Analyze My Photo'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _pickImage(context),
              child: const Text('Retake / Choose Different'),
            ),
          ] else ...[
            ElevatedButton(
              onPressed: () => _pickImage(context),
              child: const Text('Add Photo'),
            ),
          ],
        ],
      ),
    );
  }
}
