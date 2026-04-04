import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../utils/constants.dart';
import '../widgets/analysis_card.dart';
import 'kibbe/kibbe_instructions_screen.dart';
import 'color/color_instructions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Discover\nYour Beauty',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w200,
                      height: 1.15,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'AI-powered analysis tailored to you.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              AnalysisCard(
                icon: CupertinoIcons.person_crop_rectangle,
                title: 'Kibbe Body Type',
                subtitle: 'Discover your style identity',
                accentColor: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const KibbeInstructionsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              AnalysisCard(
                icon: CupertinoIcons.sun_max,
                title: 'Seasonal Color',
                subtitle: 'Find your perfect palette',
                accentColor: AppColors.secondary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ColorInstructionsScreen(),
                    ),
                  );
                },
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Powered by Claude & GPT-4o',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
