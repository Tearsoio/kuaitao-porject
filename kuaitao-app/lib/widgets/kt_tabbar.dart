import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/router/app_router.dart';
import '../app/theme/kt_theme.dart';

/// 公共底部 TabBar（首页 / 我的 + 中间发布悬浮按钮）
class KtTabBar extends StatelessWidget {
  final KtTabType current;

  const KtTabBar({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.only(bottom: 18),
      decoration: const BoxDecoration(
        color: Color(0xF5FFFFFF),
        border: Border(top: BorderSide(color: KtColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _TabItem(
            icon: '🏠',
            label: '首页',
            active: current == KtTabType.home,
            onTap: () => context.go(AppRoutes.home),
          ),
          _PublishButton(
            onTap: () => context.push(AppRoutes.publish),
          ),
          _TabItem(
            icon: '👤',
            label: '我的',
            active: current == KtTabType.profile,
            onTap: () => context.go(AppRoutes.profile),
          ),
        ],
      ),
    );
  }
}

enum KtTabType { home, profile }

class _TabItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = active ? KtColors.primary : KtColors.text3;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PublishButton extends StatefulWidget {
  final VoidCallback onTap;
  const _PublishButton({required this.onTap});

  @override
  State<_PublishButton> createState() => _PublishButtonState();
}

class _PublishButtonState extends State<_PublishButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();
  late final Animation<double> _spread =
      Tween<double>(begin: 0, end: 14).animate(_ctrl);
  late final Animation<double> _opacity =
      Tween<double>(begin: 0.6, end: 0).animate(_ctrl);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Transform.translate(
        offset: const Offset(0, -22),
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [KtColors.primary, KtColors.bomb],
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: KtColors.primary.withOpacity(_opacity.value),
                    blurRadius: 0,
                    spreadRadius: _spread.value,
                  ),
                  const BoxShadow(
                    color: Color(0x40FF3B30),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  height: 1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Home Indicator —— 屏幕底部安全条
class HomeIndicator extends StatelessWidget {
  final bool light;
  const HomeIndicator({super.key, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: light
              ? Colors.white.withOpacity(0.8)
              : Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
