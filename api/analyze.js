import { kv } from '@vercel/kv';

const THRESHOLDS = [10, 50, 500];

const KIBBE_PROMPT = `You are an expert in the Kibbe Body Type system. Analyze the photograph and determine the person's Kibbe body type.

The 13 valid types: Dramatic, Soft Dramatic, Flamboyant Natural, Natural, Soft Natural, Classic, Soft Classic, Dramatic Classic, Gamine, Soft Gamine, Flamboyant Gamine, Romantic, Theatrical Romantic

Evaluate: bone structure (sharp/angular vs wide/blunt vs small/delicate), body flesh (lean/taut vs soft/full), facial features, and overall vertical line (elongated vs petite/compact).

Respond ONLY with valid JSON — no markdown, no surrounding text:
{
  "kibbeType": "Soft Dramatic",
  "confidence": 0.82,
  "summary": "2-3 sentence explanation based on what you observe in the photo.",
  "bodyTraits": ["Angular jawline and cheekbones", "Strong vertical line"],
  "styleAdvice": ["Structured shoulders with soft draping", "Avoid stiff tailoring without softness"]
}

If the person is not clearly visible, set "kibbeType": null and explain in "summary".`;

const COLOR_PROMPT = `You are an expert in 12-season color analysis. Analyze the photograph and determine the person's seasonal color type.

The 12 valid types: True Spring, Light Spring, Warm Spring, True Summer, Light Summer, Cool Summer, True Autumn, Soft Autumn, Dark Autumn, True Winter, Bright Winter, Dark Winter

Evaluate: skin undertone (warm/golden vs cool/pink vs neutral), skin depth (light/medium/deep), natural hair depth and warmth, eye color and warmth, overall contrast level between features.

Respond ONLY with valid JSON — no markdown, no surrounding text:
{
  "seasonalType": "Soft Autumn",
  "confidence": 0.79,
  "summary": "2-3 sentence explanation based on what you observe in the photo.",
  "observedTraits": ["Warm golden-brown undertone in skin", "Low-medium contrast between hair and skin"],
  "bestColors": ["Warm camel", "Dusty terracotta", "Olive green", "Soft rust"],
  "avoidColors": ["Icy blues", "Pure white", "Cool charcoal"]
}

If lighting is artificial or features are unclear, set "seasonalType": null and explain in "summary".`;

async function sendAlert(count, type) {
  const topic = process.env.NTFY_TOPIC;
  if (!topic) return;
  await fetch(`https://ntfy.sh/${topic}`, {
    method: 'POST',
    headers: {
      Title: `Beauty app: ${count} AI analyses`,
      Priority: count >= 500 ? 'high' : 'default',
      Tags: count >= 500 ? 'warning' : 'sparkles',
    },
    body: `Milestone reached: ${count} total AI analyses on the beauty app. Latest: ${type} analysis.`,
  });
}

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { type, imageBase64 } = req.body;

  if (!type || !imageBase64) {
    return res.status(400).json({ error: 'Missing type or imageBase64' });
  }

  const prompt = type === 'kibbe' ? KIBBE_PROMPT : COLOR_PROMPT;

  const openAiRes = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${process.env.OPENAI_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'gpt-4o',
      max_tokens: 1024,
      messages: [
        {
          role: 'user',
          content: [
            {
              type: 'image_url',
              image_url: { url: `data:image/jpeg;base64,${imageBase64}` },
            },
            { type: 'text', text: prompt },
          ],
        },
      ],
    }),
  });

  if (!openAiRes.ok) {
    const err = await openAiRes.text();
    console.error('OpenAI error:', err);
    return res.status(openAiRes.status).json({ error: 'OpenAI API error' });
  }

  const data = await openAiRes.json();
  const content = data.choices[0].message.content;

  // Increment counter and check thresholds (fire-and-forget — don't block the response).
  (async () => {
    try {
      const count = await kv.incr('beauty:api_calls');
      const prev = count - 1;
      const crossed = THRESHOLDS.find(t => count >= t && prev < t);
      if (crossed) await sendAlert(count, type);
    } catch (e) {
      console.error('KV/alert error:', e);
    }
  })();

  res.status(200).send(content);
}
