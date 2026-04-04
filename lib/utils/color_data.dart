import 'package:flutter/material.dart';
import '../models/color_result.dart';

class SeasonalTypeData {
  final String displayName;
  final String tagline;
  final String description;
  final List<String> bestColors;
  final List<String> avoidColors;
  final List<Color> paletteColors;

  const SeasonalTypeData({
    required this.displayName,
    required this.tagline,
    required this.description,
    required this.bestColors,
    required this.avoidColors,
    required this.paletteColors,
  });
}

const Map<SeasonalType, SeasonalTypeData> seasonalTypeData = {
  SeasonalType.trueSpring: SeasonalTypeData(
    displayName: 'True Spring',
    tagline: 'Warm, clear, and delightfully fresh',
    description:
        'True Spring coloring is warm and clear — golden or peachy skin tone, warm golden-brown or strawberry blonde hair, '
        'and bright, warm eyes (hazel, golden brown, or warm green). You have a fresh, luminous quality that shines with warm, clear colors.',
    bestColors: ['Warm coral', 'Golden yellow', 'Camel', 'Warm peach', 'Bright warm green', 'Clear turquoise'],
    avoidColors: ['Cool grays', 'Icy pastels', 'Pure black', 'Cool fuchsia', 'Blue-based reds'],
    paletteColors: [
      Color(0xFFFF7F50),
      Color(0xFFFFD700),
      Color(0xFFC19A6B),
      Color(0xFFFFB347),
      Color(0xFF90EE90),
    ],
  ),

  SeasonalType.lightSpring: SeasonalTypeData(
    displayName: 'Light Spring',
    tagline: 'Delicate, warm, and peachy-fresh',
    description:
        'Light Spring coloring is light and warm — very fair or light peachy skin, light warm blonde or strawberry hair, '
        'and light eyes (light hazel, warm blue, or light green). Your overall impression is delicate and luminous.',
    bestColors: ['Warm blush', 'Peach', 'Light coral', 'Warm ivory', 'Soft warm pink', 'Light golden yellow'],
    avoidColors: ['Dark, heavy colors', 'Cool charcoal', 'Pure black', 'Icy cool tones', 'Muddy earth tones'],
    paletteColors: [
      Color(0xFFFFB6C1),
      Color(0xFFFFDAB9),
      Color(0xFFFFF0E0),
      Color(0xFFFFCBA4),
      Color(0xFFFDE8D8),
    ],
  ),

  SeasonalType.warmSpring: SeasonalTypeData(
    displayName: 'Warm Spring',
    tagline: 'Deeply warm, rich, and golden-glowing',
    description:
        'Warm Spring coloring is distinctly warm — golden or olive skin with a pronounced warm undertone, '
        'auburn or warm brown hair, and warm hazel or amber eyes. Your palette needs warmth and richness to match your golden glow.',
    bestColors: ['Tomato red', 'Warm orange', 'Golden yellow', 'Olive green', 'Warm camel', 'Copper'],
    avoidColors: ['Cool pinks', 'Icy blues', 'Cool charcoal', 'Blue-based purples', 'Pure white'],
    paletteColors: [
      Color(0xFFFF6347),
      Color(0xFFD4AF37),
      Color(0xFFB8860B),
      Color(0xFF8B7355),
      Color(0xFFCD853F),
    ],
  ),

  SeasonalType.trueSummer: SeasonalTypeData(
    displayName: 'True Summer',
    tagline: 'Cool, soft, and elegantly muted',
    description:
        'True Summer coloring is cool and muted — pink or rosy skin tone, ash brown or dark blonde hair with cool undertones, '
        'and cool blue-gray or soft blue eyes. Your palette is characterized by cool, soft, and dusty tones.',
    bestColors: ['Dusty rose', 'Soft lavender', 'Cool mauve', 'Powder blue', 'Soft raspberry', 'Muted teal'],
    avoidColors: ['Warm oranges', 'Golden yellows', 'Warm camel', 'Earthy browns', 'Bright warm reds'],
    paletteColors: [
      Color(0xFFDDA0DD),
      Color(0xFFB0C4DE),
      Color(0xFFBC8F8F),
      Color(0xFF8FBC8F),
      Color(0xFFD8BFD8),
    ],
  ),

  SeasonalType.lightSummer: SeasonalTypeData(
    displayName: 'Light Summer',
    tagline: 'Fair, cool, and softly luminous',
    description:
        'Light Summer coloring is cool and light — very fair pinkish or neutral skin, light ash blonde or light ash brown hair, '
        'and light eyes (blue, gray, or cool green). Your coloring is the most delicate of the cool seasons.',
    bestColors: ['Soft powder blue', 'Cool blush', 'Lavender', 'Pale mint', 'Soft rose', 'Cool ivory'],
    avoidColors: ['Warm oranges', 'Rich earth tones', 'Pure black', 'Very saturated warm colors', 'Golden yellow'],
    paletteColors: [
      Color(0xFFADD8E6),
      Color(0xFFFFB6C1),
      Color(0xFFE6E6FA),
      Color(0xFFB2DFDB),
      Color(0xFFF0E6F6),
    ],
  ),

  SeasonalType.coolSummer: SeasonalTypeData(
    displayName: 'Cool Summer',
    tagline: 'Cool, clear, and distinctly rosy',
    description:
        'Cool Summer coloring has a pronounced cool undertone — pink or rose-tinted skin, cool brown or dark ash blonde hair, '
        'and cool eyes (blue-gray, cool green, or cool brown). You are the most saturated of the summer seasons.',
    bestColors: ['Cool raspberry', 'Cobalt blue', 'Cool fuchsia', 'Clear lavender', 'Cool teal', 'Rose red'],
    avoidColors: ['Warm oranges', 'Earthy tones', 'Golden yellow', 'Warm coral', 'Olive green'],
    paletteColors: [
      Color(0xFFE75480),
      Color(0xFF0047AB),
      Color(0xFF8B008B),
      Color(0xFF008B8B),
      Color(0xFF9400D3),
    ],
  ),

  SeasonalType.trueAutumn: SeasonalTypeData(
    displayName: 'True Autumn',
    tagline: 'Rich, warm, and deeply earthy',
    description:
        'True Autumn coloring is warm and rich — golden or olive skin with a definite warm undertone, '
        'deep auburn or rich warm brown hair, and warm brown, hazel, or golden eyes. Your palette calls for nature\'s richest warm hues.',
    bestColors: ['Rich terracotta', 'Burnt orange', 'Olive green', 'Warm brown', 'Deep gold', 'Brick red'],
    avoidColors: ['Icy pastels', 'Cool pinks', 'Pure black', 'Icy blue', 'Cool gray'],
    paletteColors: [
      Color(0xFFCC5500),
      Color(0xFF6B8E23),
      Color(0xFF8B4513),
      Color(0xFFDAA520),
      Color(0xFF556B2F),
    ],
  ),

  SeasonalType.softAutumn: SeasonalTypeData(
    displayName: 'Soft Autumn',
    tagline: 'Muted, warm, and softly earthy',
    description:
        'Soft Autumn coloring is warm but muted — golden-beige or light olive skin with soft undertones, '
        'ash-brown or warm dark blonde hair, and soft warm eyes (hazel, light brown, or warm gray-green). '
        'Your features share similar low-contrast, muted tones throughout.',
    bestColors: ['Warm camel', 'Dusty rose', 'Sage green', 'Warm taupe', 'Soft terracotta', 'Muted gold'],
    avoidColors: ['Pure white', 'Icy pastels', 'Cool charcoal', 'Bright saturated colors', 'Cool navy'],
    paletteColors: [
      Color(0xFFC19A6B),
      Color(0xFFD4A0A8),
      Color(0xFF8B9E6B),
      Color(0xFF9E8B7B),
      Color(0xFFB87333),
    ],
  ),

  SeasonalType.darkAutumn: SeasonalTypeData(
    displayName: 'Dark Autumn',
    tagline: 'Deep, warm, and dramatically rich',
    description:
        'Dark Autumn coloring is warm and deep — medium to dark skin with warm undertones, '
        'very dark brown or black-brown hair, and deep, warm eyes (dark brown or dark hazel). '
        'Your coloring has the deepest warmth of all the autumn seasons.',
    bestColors: ['Deep chocolate brown', 'Forest green', 'Rust', 'Deep gold', 'Burgundy', 'Warm black'],
    avoidColors: ['Light pastels', 'Icy cool tones', 'Cool pink', 'Pure bright white', 'Pale yellow'],
    paletteColors: [
      Color(0xFF3B1F0A),
      Color(0xFF2D4A1E),
      Color(0xFF8B3A1A),
      Color(0xFF5C4A00),
      Color(0xFF4A1942),
    ],
  ),

  SeasonalType.trueWinter: SeasonalTypeData(
    displayName: 'True Winter',
    tagline: 'Cool, clear, and strikingly high-contrast',
    description:
        'True Winter coloring features high contrast and cool clarity — cool or neutral-cool skin (often porcelain or olive), '
        'dark black-brown or black hair, and clear, cool eyes (dark brown, black-brown, or bright blue). '
        'Your coloring demands crisp, clear, and cool colors.',
    bestColors: ['Pure white', 'True black', 'Icy blue', 'Clear red', 'Cool fuchsia', 'Bright cool blue'],
    avoidColors: ['Warm oranges', 'Earth tones', 'Muted or dusty tones', 'Golden yellow', 'Warm beige'],
    paletteColors: [
      Color(0xFF000000),
      Color(0xFFFFFFFF),
      Color(0xFF0000CD),
      Color(0xFFCC0000),
      Color(0xFF800080),
    ],
  ),

  SeasonalType.brightWinter: SeasonalTypeData(
    displayName: 'Bright Winter',
    tagline: 'Cool, vivid, and brilliantly clear',
    description:
        'Bright Winter coloring is cool and highly saturated — clear, cool skin (often with a porcelain or blue-tinted quality), '
        'dark hair with high contrast to skin, and bright, striking eyes (vivid blue, bright green, or intense dark brown). '
        'You can carry the most vivid, saturated colors of any season.',
    bestColors: ['Vivid fuchsia', 'Electric blue', 'Bright red', 'Clear emerald', 'Royal purple', 'Bright white'],
    avoidColors: ['Muted, dusty tones', 'Warm earth tones', 'Soft pastels', 'Golden yellow', 'Warm brown'],
    paletteColors: [
      Color(0xFFFF1493),
      Color(0xFF0080FF),
      Color(0xFF009B77),
      Color(0xFF6600CC),
      Color(0xFFFF0040),
    ],
  ),

  SeasonalType.darkWinter: SeasonalTypeData(
    displayName: 'Dark Winter',
    tagline: 'Deep, cool, and intensely dramatic',
    description:
        'Dark Winter coloring is deep and cool — medium to dark or very dark skin with cool or neutral undertones, '
        'very dark hair, and deep, cool eyes (very dark brown, dark gray, or deep blue). '
        'You are the deepest and most dramatic of the winter seasons.',
    bestColors: ['Deep burgundy', 'Midnight navy', 'Deep plum', 'Dark forest green', 'Rich wine', 'Deep cool brown'],
    avoidColors: ['Light pastels', 'Warm earth tones', 'Golden yellow', 'Warm coral', 'Light peach'],
    paletteColors: [
      Color(0xFF800020),
      Color(0xFF003153),
      Color(0xFF4B0082),
      Color(0xFF006400),
      Color(0xFF1C0A00),
    ],
  ),
};
