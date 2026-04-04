import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/constants.dart';
import 'color_capture_screen.dart';

class ColorInstructionsScreen extends StatelessWidget {
  const ColorInstructionsScreen({super.key});

  static const List<_Instruction> _instructions = [
    _Instruction(
      icon: CupertinoIcons.sun_max_fill,
      title: 'Natural outdoor light only',
      body: 'Go outside or stand near a large window with natural daylight. '
          'Indoor lighting — including warm bulbs, fluorescent lights, or lamps — '
          'distorts skin tone and will produce inaccurate results.',
    ),
    _Instruction(
      icon: CupertinoIcons.cloud_sun,
      title: 'Overcast midday is ideal',
      body: 'The best lighting is a bright overcast day around midday — the clouds diffuse '
          'the light evenly, eliminating harsh shadows. Avoid direct sunlight, which '
          'creates overexposure and washes out your true undertone.',
    ),
    _Instruction(
      icon: CupertinoIcons.person_crop_circle,
      title: 'Clear, close-up face shot',
      body: 'Take a close-up photo of your face with nothing obscuring it. '
          'Hair pulled back from your face is helpful. Your face should fill '
          'most of the frame.',
    ),
    _Instruction(
      icon: CupertinoIcons.xmark_circle,
      title: 'No filters or editing',
      body: 'Use your camera\'s standard photo mode — no beauty filters, '
          'no color correction, no HDR processing. The photo should be as '
          'natural and unedited as possible.',
    ),
    _Instruction(
      icon: CupertinoIcons.paintbrush,
      title: 'Minimize heavy makeup',
      body: 'If possible, take the photo without heavy foundation or contouring. '
          'Light, natural makeup is fine. Heavy color correction products '
          'can mask your true skin undertone.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seasonal Color'),
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
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lighting is everything',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Seasonal color analysis determines your skin undertone, depth, and natural contrast. '
                          'Accurate lighting is the single most important factor — please read these guidelines carefully.',
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
                  MaterialPageRoute(builder: (_) => const ColorCaptureScreen()),
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
              color: AppColors.secondary,
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
