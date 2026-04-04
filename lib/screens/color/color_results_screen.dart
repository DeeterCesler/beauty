import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';
import '../../theme/colors.dart';
import '../../utils/color_data.dart';
import '../../utils/constants.dart';
import '../../widgets/color_swatch_row.dart';

class ColorResultsScreen extends StatelessWidget {
  const ColorResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ColorState>();
    final result = state.result;

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final data = seasonalTypeData[result.type];

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
                    colors: data != null && data.paletteColors.length >= 2
                        ? [data.paletteColors[0], data.paletteColors[1]]
                        : [AppColors.secondary, AppColors.accent],
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
                                shadows: [
                                  const Shadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                        ),
                        if (data != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            data.tagline,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shadows: [
                                    const Shadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
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
                if (data != null) ...[
                  _Section(
                    title: 'Your Palette',
                    child: ColorSwatchRow(colors: data.paletteColors),
                  ),
                  const SizedBox(height: 24),
                ],
                _Section(
                  title: 'Your Analysis',
                  child: Text(result.summary, style: Theme.of(context).textTheme.bodyLarge),
                ),
                const SizedBox(height: 24),
                if (result.observedTraits.isNotEmpty) ...[
                  _Section(
                    title: 'Observed Features',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: result.observedTraits.map((t) => Chip(label: Text(t))).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                _Section(
                  title: 'Wear More Of',
                  child: _ColorList(
                    items: data?.bestColors ?? result.bestColors,
                    color: AppColors.success,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                ),
                const SizedBox(height: 24),
                _Section(
                  title: 'Minimize',
                  child: _ColorList(
                    items: data?.avoidColors ?? result.avoidColors,
                    color: AppColors.primary,
                    icon: Icons.remove_circle_outline_rounded,
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {
                    context.read<ColorState>().reset();
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
                color: AppColors.secondary,
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

class _ColorList extends StatelessWidget {
  final List<String> items;
  final Color color;
  final IconData icon;

  const _ColorList({required this.items, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Padding(
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
              ))
          .toList(),
    );
  }
}
