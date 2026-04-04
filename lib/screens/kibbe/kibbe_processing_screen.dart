import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';
import '../../services/analysis_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/processing_indicator.dart';
import 'kibbe_results_screen.dart';

class KibbeProcessingScreen extends StatefulWidget {
  const KibbeProcessingScreen({super.key});

  @override
  State<KibbeProcessingScreen> createState() => _KibbeProcessingScreenState();
}

class _KibbeProcessingScreenState extends State<KibbeProcessingScreen> {
  static const _steps = [
    'Examining bone structure...',
    'Analyzing body proportions...',
    'Comparing Kibbe archetypes...',
    'Mapping your silhouette...',
    'Finalizing your type...',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _analyze());
  }

  Future<void> _analyze() async {
    final state = context.read<KibbeState>();
    final service = context.read<AnalysisProvider>();

    if (state.imageBytes == null) {
      Navigator.pop(context);
      return;
    }

    state.setProcessing();

    try {
      final result = await service.analyzeKibbe(state.imageBytes!);
      if (!mounted) return;
      state.setResult(result);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const KibbeResultsScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      state.setError(e.toString());
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.screenPadding),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Analyzing...',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This may take a moment.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 48),
                  const ProcessingIndicator(steps: _steps),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
