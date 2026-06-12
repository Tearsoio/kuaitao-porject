import 'package:flutter/material.dart';

/// 「快逃」设计 Token — 与 `design-preview.html` `:root` 完全对齐
/// 任何颜色、阴影、字号都必须从这里取，禁止散落硬编码。
class KtColors {
  KtColors._();

  static const Color primary = Color(0xFFFF3B30);
  static const Color primaryHover = Color(0xFFFF1F12);
  static const Color primaryLight = Color(0xFFFFE5E3);
  static const Color warning = Color(0xFFFFD60A);
  static const Color warningDeep = Color(0xFFFFB800);
  static const Color bomb = Color(0xFFFF6B35);
  static const Color electric = Color(0xFF00E5FF);

  static const Color bg = Color(0xFFFAFAFA);
  static const Color card = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF1A1A1A);

  static const Color text1 = Color(0xFF1A1A1A);
  static const Color text2 = Color(0xFF4A4A4A);
  static const Color text3 = Color(0xFF8C8C8C);

  static const Color border = Color(0xFFEBEBEB);
  static const Color canvas = Color(0xFFE8E8E8);
}

class KtRadius {
  KtRadius._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 14;
  static const double xl = 16;
  static const double xxl = 24;
  static const double pill = 999;
}

class KtShadows {
  KtShadows._();
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
  static const List<BoxShadow> bomb = [
    BoxShadow(color: Color(0x40FF3B30), blurRadius: 16, offset: Offset(0, 4)),
  ];
}

class KtGradients {
  KtGradients._();

  static const LinearGradient brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [KtColors.primary, KtColors.bomb],
  );

  static const LinearGradient header = LinearGradient(
    begin: Alignment(-0.5, -1),
    end: Alignment(0.5, 1),
    colors: [KtColors.primary, KtColors.bomb, KtColors.warningDeep],
    stops: [0, 0.6, 1.0],
  );

  static const LinearGradient splash = LinearGradient(
    begin: Alignment(-0.4, -1),
    end: Alignment(0.4, 1),
    colors: [KtColors.primary, KtColors.primaryHover, KtColors.dark],
    stops: [0, 0.5, 1.0],
  );
}

/// 覆盖封面色块（模拟图片）
class KtCovers {
  KtCovers._();
  static const LinearGradient seafood = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFC44569)],
  );
  static const LinearGradient scenic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4ECDC4), Color(0xFF1A535C)],
  );
  static const LinearGradient hotel = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C5CE7), Color(0xFF2D3436)],
  );
  static const LinearGradient bbq = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF8B500), Color(0xFFB33771)],
  );
  static const LinearGradient digital = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00B894), Color(0xFF0984E3)],
  );
  static const LinearGradient beauty = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFD79A8), Color(0xFFE84393)],
  );

  static LinearGradient byKey(String key) {
    switch (key) {
      case 'seafood':
        return seafood;
      case 'scenic':
        return scenic;
      case 'hotel':
        return hotel;
      case 'bbq':
        return bbq;
      case 'digital':
        return digital;
      case 'beauty':
        return beauty;
      default:
        return seafood;
    }
  }
}

/// 全局 ThemeData — 让 Material 默认控件与设计稿一致
class KtTheme {
  KtTheme._();

  static ThemeData light() {
    const fontFamily = 'PingFang SC';
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: KtColors.bg,
      fontFamily: fontFamily,
      colorScheme: const ColorScheme.light(
        primary: KtColors.primary,
        secondary: KtColors.warningDeep,
        surface: KtColors.card,
        onSurface: KtColors.text1,
      ),
      splashFactory: InkSparkle.splashFactory,
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: KtColors.text1, fontWeight: FontWeight.w900),
        titleLarge: TextStyle(color: KtColors.text1, fontWeight: FontWeight.w800),
        bodyLarge: TextStyle(color: KtColors.text1),
        bodyMedium: TextStyle(color: KtColors.text2),
        bodySmall: TextStyle(color: KtColors.text3),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: KtColors.text1,
      ),
    );
  }
}
