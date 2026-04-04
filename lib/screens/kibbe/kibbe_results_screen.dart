import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';
import '../../theme/colors.dart';
import '../../utils/constants.dart';
import '../../utils/kibbe_data.dart';

class KibbeResultsScreen extends StatelessWidget {
  const KibbeResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<KibbeState>();
    final result = state.result;

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final data = kibbeTypeData[result.type];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.screenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          data?.displayName ?? result.typeName,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                        if (data != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            data.tagline,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                          ),
                        ],
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppConstants.screenPadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Section(
                  title: 'Your Analysis',
                  child: Text(result.summary, style: Theme.of(context).textTheme.bodyLarge),
                ),
                const SizedBox(height: 24),
                if (result.bodyTraits.isNotEmpty) ...[
                  _Section(
                    title: 'Observed Traits',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: result.bodyTraits.map((t) => Chip(label: Text(t))).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (data != null) ...[
                  _Section(
                    title: 'Style Guide',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StyleList(
                          label: 'Embrace',
                          items: data.embrace,
                          color: AppColors.success,
                          icon: Icons.check_circle_outline_rounded,
                        ),
                        const SizedBox(height: 16),
                        _StyleList(
                          label: 'Minimize',
                          items: data.avoid,
                          color: AppColors.primary,
                          icon: Icons.remove_circle_outline_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _Section(
                    title: 'Your Essence',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: data.essenceWords
                          .map((w) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  w,
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: AppColors.primaryDark,
                                      ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                OutlinedButton(
                  onPressed: () {
                    context.read<KibbeState>().reset();
                    Navigator.of(context).popUntil((r) => r.isFirst);
                  },
                  child: const Text('Start Over'),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _StyleList extends StatelessWidget {
  final String label;
  final List<String> items;
  final Color color;
  final IconData icon;

  const _StyleList({
    required this.label,
    required this.items,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: color, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
