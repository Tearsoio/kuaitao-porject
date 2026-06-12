import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/router/app_router.dart';
import 'app/theme/kt_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const KuaitaoApp());
}

class KuaitaoApp extends StatelessWidget {
  const KuaitaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '快逃 · 避雷',
      debugShowCheckedModeBanner: false,
      theme: KtTheme.light(),
      routerConfig: buildAppRouter(),
    );
  }
}
