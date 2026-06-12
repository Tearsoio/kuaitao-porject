import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/kt_theme.dart';
import '../../widgets/kt_tabbar.dart' show HomeIndicator;
import '../../widgets/kt_widgets.dart';

/// ⓪ 启动加载页 —— 1.8 s 后自动跳转登录
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _logoCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..forward();
  late final Animation<double> _scale = TweenSequence<double>(<TweenSequenceItem<double>>[
    TweenSequenceItem<double>(tween: Tween<double>(begin: 0.6, end: 1.1), weight: 60),
    TweenSequenceItem<double>(tween: Tween<double>(begin: 1.1, end: 1.0), weight: 40),
  ]).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOut));

  late final AnimationController _shakeCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  late final AnimationController _barCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) context.go(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _logoCtrl.dispose();
    _shakeCtrl.dispose();
    _barCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: KtGradients.splash),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // ⚡ 巨型背景
            Positioned(
              top: 60,
              right: -60,
              child: Transform.rotate(
                angle: 15 * 3.14159 / 180,
                child: const Text(
                  '⚡',
                  style: TextStyle(
                    fontSize: 380,
                    color: Color(0x14FFD60A),
                    height: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -30,
              child: Opacity(
                opacity: 0.08,
                child: Text('💣',
                    style: TextStyle(fontSize: 200, color: Colors.white)),
              ),
            ),
            // 中央 Logo
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _logoCtrl,
                    builder: (_, __) {
                      return Transform.scale(
                        scale: _scale.value,
                        child: Opacity(
                          opacity: _logoCtrl.value.clamp(0.0, 1.0),
                          child: _SplashLogo(shakeCtrl: _shakeCtrl),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const KtSloganBar(text: '看清这世界的雷'),
                  const SizedBox(height: 14),
                  const Text(
                    'AVOID · THE · TRAP',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            // 底部 loading bar
            Positioned(
              bottom: 110,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 160,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: AnimatedBuilder(
                      animation: _barCtrl,
                      builder: (_, __) {
                        final double w = 0.1 + 0.75 * _barCtrl.value;
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: w,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: const LinearGradient(colors: <Color>[
                                  KtColors.warning,
                                  Colors.white,
                                ]),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '正在为你扫描新雷区...',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xB3FFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '© 2026 KUAITAO  ·  v1.0.0',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0x80FFFFFF),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const HomeIndicator(light: true),
          ],
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  final AnimationController shakeCtrl;
  const _SplashLogo({required this.shakeCtrl});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(-10 * 3.14159 / 180),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: shakeCtrl,
            builder: (_, __) {
              final double t = shakeCtrl.value; // 0..1
              final double angle = (-8 + 16 * t) * 3.14159 / 180;
              return Transform.rotate(
                angle: angle,
                child: const Text(
                  '⚡',
                  style: TextStyle(
                    fontSize: 64,
                    color: KtColors.warning,
                    height: 1,
                    shadows: <Shadow>[
                      Shadow(color: KtColors.dark, offset: Offset(3, 3)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          const Text(
            '快逃',
            style: TextStyle(
              fontSize: 84,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -2,
              height: 1,
              shadows: <Shadow>[
                Shadow(color: KtColors.dark, offset: Offset(4, 4)),
                Shadow(color: KtColors.warning, offset: Offset(8, 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
