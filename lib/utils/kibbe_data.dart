import '../models/kibbe_result.dart';

class KibbeTypeData {
  final String displayName;
  final String tagline;
  final String description;
  final List<String> essenceWords;
  final List<String> embrace;
  final List<String> avoid;

  const KibbeTypeData({
    required this.displayName,
    required this.tagline,
    required this.description,
    required this.essenceWords,
    required this.embrace,
    required this.avoid,
  });
}

const Map<KibbeType, KibbeTypeData> kibbeTypeData = {
  KibbeType.dramatic: KibbeTypeData(
    displayName: 'Dramatic',
    tagline: 'Bold, angular, and powerfully striking',
    description:
        'The Dramatic type features sharp, angular bone structure, a tall and narrow frame, and a naturally intense presence. '
        'You have a strong vertical line with minimal curve, creating a commanding silhouette that reads as bold and sophisticated.',
    essenceWords: ['Striking', 'Bold', 'Angular', 'Intense'],
    embrace: [
      'Structured, architectural tailoring',
      'Sharp, geometric lines',
      'Monochromatic head-to-toe looks',
      'Strong shoulder lines',
      'Sleek, minimal silhouettes',
      'Long, unbroken vertical lines',
    ],
    avoid: [
      'Ruffles, frills, or fussy details',
      'Rounded, soft collars',
      'Oversized floral prints',
      'Anything overly sweet or delicate',
      'Horizontal lines that break your vertical',
    ],
  ),

  KibbeType.softDramatic: KibbeTypeData(
    displayName: 'Soft Dramatic',
    tagline: 'Dramatic strength with a sensuous yin undercurrent',
    description:
        'The Soft Dramatic combines the sharp, elongated bone structure of the Dramatic with a lush, voluptuous body flesh. '
        'You have striking facial features and a tall frame, but with curves and softness that call for drama with a sensuous touch.',
    essenceWords: ['Glamorous', 'Sensuous', 'Bold', 'Lush'],
    embrace: [
      'Draped and flowing fabrics with structure',
      'Bold, statement jewelry',
      'Wrap silhouettes that honor curves',
      'Rich, deep, or vibrant colors',
      'Structured tops with soft, flowing skirts',
    ],
    avoid: [
      'Stiff, boxy tailoring without softness',
      'Tiny, delicate prints',
      'Overly casual or sporty looks',
      'Anything that conceals your curves',
      'Overly rigid, mannish silhouettes',
    ],
  ),

  KibbeType.flamboyantNatural: KibbeTypeData(
    displayName: 'Flamboyant Natural',
    tagline: 'Broad, bold, and effortlessly free-spirited',
    description:
        'The Flamboyant Natural has a wide, broad skeletal structure with a tall frame and an easy, uncontrived energy. '
        'You have blunt features, angular bones, and a naturally athletic build that calls for relaxed grandeur.',
    essenceWords: ['Bold', 'Easy', 'Free', 'Expansive'],
    embrace: [
      'Oversized, relaxed silhouettes',
      'Natural, unstructured fabrics',
      'Layering with easy drape',
      'Wide-leg trousers and relaxed blazers',
      'Bold, graphic prints',
    ],
    avoid: [
      'Tight, constricting silhouettes',
      'Fussy or overly decorated details',
      'Stiff, tailored shapes',
      'Delicate, dainty jewelry',
      'Overly polished or formal looks',
    ],
  ),

  KibbeType.natural: KibbeTypeData(
    displayName: 'Natural',
    tagline: 'Blunt, relaxed, and effortlessly grounded',
    description:
        'The Natural type has moderate height with a broad, blunt skeletal frame and an easy, unpretentious energy. '
        'Your features are wide and open, and your style is at its best when relaxed and uncontrived.',
    essenceWords: ['Easy', 'Relaxed', 'Grounded', 'Open'],
    embrace: [
      'Relaxed, comfortable silhouettes',
      'Soft, natural fabrics like linen and cotton',
      'Easy layering',
      'Casual, unfussy separates',
      'Earth tones and natural hues',
    ],
    avoid: [
      'Overly structured or stiff tailoring',
      'Frilly, fussy, or ornate details',
      'Extremely tight or body-con fits',
      'Overly dressy or formal looks',
      'Delicate, dainty aesthetics',
    ],
  ),

  KibbeType.softNatural: KibbeTypeData(
    displayName: 'Soft Natural',
    tagline: 'Natural ease with a gentle, feminine softness',
    description:
        'The Soft Natural has the broad, blunt Natural bone structure combined with a soft, rounded flesh and gentle facial features. '
        'You have a relaxed, approachable energy with a sweet femininity that shines through ease rather than drama.',
    essenceWords: ['Soft', 'Easy', 'Sweet', 'Relaxed'],
    embrace: [
      'Soft, flowing fabrics with easy movement',
      'Relaxed feminine silhouettes',
      'Gentle layering and soft draping',
      'Floral and soft prints',
      'Warm, muted tones',
    ],
    avoid: [
      'Stiff, boxy tailoring',
      'Sharp geometric shapes',
      'Overly dramatic or severe looks',
      'Very tight, constricting fits',
      'Heavy or overpowering fabrics',
    ],
  ),

  KibbeType.classic: KibbeTypeData(
    displayName: 'Classic',
    tagline: 'Symmetrical, balanced, and timelessly elegant',
    description:
        'The Classic type is defined by perfect symmetry and balance — moderate in everything, with no extreme yin or yang. '
        'Your features are even and harmonious, and your style sings with polished, traditional elegance.',
    essenceWords: ['Balanced', 'Elegant', 'Polished', 'Timeless'],
    embrace: [
      'Tailored, well-fitted classics',
      'Clean, symmetrical silhouettes',
      'Traditional, quality fabrics',
      'Neat, refined details',
      'Coordinated, put-together outfits',
    ],
    avoid: [
      'Anything too trendy or avant-garde',
      'Overly dramatic or extreme silhouettes',
      'Too much fuss or ornamentation',
      'Overly casual, sloppy looks',
      'Clashing, high-contrast combinations',
    ],
  ),

  KibbeType.softClassic: KibbeTypeData(
    displayName: 'Soft Classic',
    tagline: 'Classic elegance with a gentle feminine touch',
    description:
        'The Soft Classic is balanced and symmetrical like the Classic, but with a slight yin undercurrent — softly rounded flesh, '
        'and gentle facial features that add a quietly romantic quality to the classic structure.',
    essenceWords: ['Graceful', 'Refined', 'Gentle', 'Elegant'],
    embrace: [
      'Softly tailored, feminine classics',
      'Graceful draping with structure',
      'Delicate details like soft ruffles or pleats',
      'Muted, refined color palettes',
      'Quality fabrics with a soft hand',
    ],
    avoid: [
      'Very stiff or severe tailoring',
      'Bold, dramatic statement pieces',
      'Overly casual or sporty looks',
      'Trendy, avant-garde shapes',
      'Heavy embellishment or ornamentation',
    ],
  ),

  KibbeType.dramaticClassic: KibbeTypeData(
    displayName: 'Dramatic Classic',
    tagline: 'Classic symmetry sharpened by dramatic yang',
    description:
        'The Dramatic Classic has the balanced, symmetrical structure of the Classic with a slight yang undercurrent — '
        'sharper bone structure and a more angular appearance that adds precision and authority to classic elegance.',
    essenceWords: ['Precise', 'Authoritative', 'Sharp', 'Refined'],
    embrace: [
      'Precisely tailored, structured classics',
      'Sharp, clean lines with polish',
      'Monochromatic, confident pairings',
      'Architectural, geometric details',
      'Quality, substantial fabrics',
    ],
    avoid: [
      'Overly soft, drapey, or fluid silhouettes',
      'Sweet, girlish details',
      'Overly casual or sporty looks',
      'Fussy, ornate embellishment',
      'Trendy, avant-garde experimentation',
    ],
  ),

  KibbeType.gamine: KibbeTypeData(
    displayName: 'Gamine',
    tagline: 'Petite, sharp, and playfully spirited',
    description:
        'The Gamine type is compact and petite with a mix of sharp yang bone structure and delicate yin flesh — '
        'an energetic, playful, and quirky combination that gives a distinctive, unconventional charm.',
    essenceWords: ['Spirited', 'Playful', 'Sharp', 'Quirky'],
    embrace: [
      'Mixed, eclectic combinations of yang and yin',
      'Short hemlines that honor your petite frame',
      'Tailored pieces mixed with soft elements',
      'Bold prints and color blocking',
      'Crisp, geometric details',
    ],
    avoid: [
      'Long, flowing skirts that overwhelm your frame',
      'Oversized, baggy silhouettes',
      'Very traditional, conventional dressing',
      'Too much sweetness without edge',
      'Overly formal, serious looks',
    ],
  ),

  KibbeType.softGamine: KibbeTypeData(
    displayName: 'Soft Gamine',
    tagline: 'Compact and sharp with a sweet, doll-like softness',
    description:
        'The Soft Gamine is petite and compact with sharp bone structure softened by rounded flesh and sweet, doll-like facial features. '
        'You have a charming combination of edge and innocence — like a cute, quirky pixie.',
    essenceWords: ['Sweet', 'Quirky', 'Cute', 'Playful'],
    embrace: [
      'Sweet, feminine pieces with a touch of whimsy',
      'Petite florals and cute prints',
      'Short hemlines and compact proportions',
      'Soft colors with playful accents',
      'Rounded details with a fresh, youthful energy',
    ],
    avoid: [
      'Oversized or overwhelming silhouettes',
      'Very severe or stark tailoring',
      'Long, sweeping hemlines',
      'Too much edge without sweetness',
      'Heavy, serious fabrics',
    ],
  ),

  KibbeType.flamboyantGamine: KibbeTypeData(
    displayName: 'Flamboyant Gamine',
    tagline: 'Compact, sharp, and boldly unconventional',
    description:
        'The Flamboyant Gamine is petite but bold — sharp, angular bone structure with a very lean, taut body flesh and '
        'distinctive, striking features. You have an edgy, avant-garde energy that thrives on unconventionality.',
    essenceWords: ['Bold', 'Edgy', 'Unconventional', 'Striking'],
    embrace: [
      'Bold, graphic combinations',
      'Strong geometric shapes in compact form',
      'High-contrast color blocking',
      'Architectural, structured pieces',
      'Eclectic, avant-garde styling',
    ],
    avoid: [
      'Sweet, overly feminine softness',
      'Flowing, draped silhouettes',
      'Traditional, conservative looks',
      'Anything too delicate or dainty',
      'Long, elongated proportions',
    ],
  ),

  KibbeType.romantic: KibbeTypeData(
    displayName: 'Romantic',
    tagline: 'Soft, lush, and utterly feminine',
    description:
        'The Romantic type is defined by extreme yin — rounded, soft bone structure, lush and full body flesh, '
        'and delicate, doll-like facial features. Everything about you calls for soft, sensuous, and overtly feminine dressing.',
    essenceWords: ['Sensuous', 'Soft', 'Lush', 'Feminine'],
    embrace: [
      'Soft, body-skimming silhouettes',
      'Fluid, luxurious fabrics',
      'Feminine details: lace, ruffles, soft pleats',
      'Warm, romantic colors',
      'Delicate, ornate jewelry',
    ],
    avoid: [
      'Sharp, angular, or geometric shapes',
      'Stiff, structured tailoring',
      'Oversized or boxy silhouettes',
      'Masculine or androgynous aesthetics',
      'Anything that conceals or ignores your curves',
    ],
  ),

  KibbeType.theatricalRomantic: KibbeTypeData(
    displayName: 'Theatrical Romantic',
    tagline: 'Delicate softness with an unexpected dramatic edge',
    description:
        'The Theatrical Romantic has the lush, rounded softness of the Romantic with a slight yang undercurrent — '
        'sharper facial features or bone structure that adds a striking, intense quality to the overall delicacy.',
    essenceWords: ['Intense', 'Delicate', 'Dramatic', 'Sensuous'],
    embrace: [
      'Soft, ornate, and slightly dramatic pieces',
      'Luxurious fabrics with rich detail',
      'Romantic silhouettes with an edge',
      'Jewel tones and deep, rich colors',
      'Statement jewelry that echoes facial drama',
    ],
    avoid: [
      'Plain, understated minimalism',
      'Casual, sporty looks',
      'Boxy or very structured silhouettes',
      'Anything that mutes your drama',
      'Very traditional or conservative dressing',
    ],
  ),
};
