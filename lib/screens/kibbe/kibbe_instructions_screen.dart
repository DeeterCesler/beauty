import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/constants.dart';
import 'kibbe_capture_screen.dart';

class KibbeInstructionsScreen extends StatelessWidget {
  const KibbeInstructionsScreen({super.key});

  static const List<_Instruction> _instructions = [
    _Instruction(
      icon: CupertinoIcons.person_fill,
      title: 'Wear form-fitting clothes',
      body: 'Choose fitted clothing that clearly shows the outline of your body — '
          'a fitted top and jeans or leggings work well. Avoid oversized, baggy, or '
          'heavily structured pieces that obscure your natural silhouette.',
    ),
    _Instruction(
      icon: CupertinoIcons.camera_viewfinder,
      title: 'Full body in the frame',
      body: 'Stand far enough from the camera so your full body — head to toe — '
          'is clearly visible. A neutral or plain background is ideal.',
    ),
    _Instruction(
      icon: CupertinoIcons.arrow_up_arrow_down,
      title: 'Stand naturally',
      body: 'Stand in a relaxed, natural posture. No dramatic poses — '
          'just how you normally stand. Face forward with arms at your sides.',
    ),
    _Instruction(
      icon: CupertinoIcons.lightbulb,
      title: 'Good, even lighting',
      body: 'Use even, diffused lighting so your body proportions are clearly visible. '
          'Avoid harsh shadows that could obscure your silhouette.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kibbe Body Type'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.screenPadding,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Before you take your photo',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'The Kibbe system analyzes your bone structure, proportions, '
                          'and overall silhouette. For the most accurate result, follow these guidelines.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ..._instructions.asMap().entries.map((entry) {
                    return _InstructionTile(
                      number: entry.key + 1,
                      instruction: entry.value,
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.screenPadding),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KibbeCaptureScreen()),
                );
              },
              child: const Text("I'm Ready — Take My Photo"),
            ),
          ),
        ],
      ),
    );
  }
}

class _Instruction {
  final IconData icon;
  final String title;
  final String body;
  const _Instruction({required this.icon, required this.title, required this.body});
}

class _InstructionTile extends StatelessWidget {
  final int number;
  final _Instruction instruction;

  const _InstructionTile({required this.number, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  instruction.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  instruction.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
