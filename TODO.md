## Security

- [x] Remove `.env` from `pubspec.yaml` assets (web build doesn't use it; keys are loaded via Vercel proxy)
- [x] Rotate `ANTHROPIC_API_KEY` and `OPENAI_API_KEY` — both are materialized in `build/web/assets/.env` on disk
- [x] Add `build/web/assets/.env` to `.gitignore` as an explicit guard
- [x] Add `.vercelignore` with `**/.env` so deployment boundary doesn't rely on `.gitignore` inheritance
- [x] Route native iOS/Android through `WebProxyService` instead of loading API keys from bundled `.env` asset — eliminates client-side keys on all platforms
