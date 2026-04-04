import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'screens/home_screen.dart';
import 'services/analysis_provider.dart';
import 'services/anthropic_service.dart';
import 'services/fallback_analysis_service.dart';
import 'services/openai_service.dart';
import 'services/web_proxy_service.dart';
import 'theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const BeautyApp());
}

class BeautyApp extends StatelessWidget {
  const BeautyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KibbeState()),
        ChangeNotifierProvider(create: (_) => ColorState()),
        Provider<AnalysisProvider>(
          create: (_) => FallbackAnalysisService(
            primary: AnthropicService(),
            fallback: OpenAIService(),
            webProxy: WebProxyService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Beauty Analysis',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
