import 'package:flutter/material.dart';

import '../app/theme/kt_theme.dart';

/// 「⚡快逃」歪斜 LOGO —— 拥有 3D 偏移字阴影 + 黄色闪电
class KtLogo extends StatelessWidget {
  final double fontSize;
  final Color textColor;
  final Color shadowColor;
  final Color boltColor;
  final double tilt;

  const KtLogo({
    super.key,
    this.fontSize = 32,
    this.textColor = Colors.white,
    this.shadowColor = KtColors.dark,
    this.boltColor = KtColors.warning,
    this.tilt = -8 * 3.14159 / 180,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(tilt),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '⚡',
            style: TextStyle(
              fontSize: fontSize * 0.82,
              color: boltColor,
              height: 1,
              shadows: <Shadow>[
                Shadow(color: shadowColor, offset: const Offset(3, 3)),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '快逃',
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 1,
              shadows: <Shadow>[
                Shadow(color: shadowColor, offset: const Offset(3, 3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 通用标签（药丸形）
class KtTag extends StatelessWidget {
  final String text;
  final Color bg;
  final Color color;
  final double fontSize;
  final EdgeInsets padding;

  const KtTag({
    super.key,
    required this.text,
    this.bg = KtColors.primaryLight,
    this.color = KtColors.primary,
    this.fontSize = 11,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(KtRadius.pill),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
          height: 1.2,
        ),
      ),
    );
  }
}

/// 渐变圆形头像 + 文字 / emoji
class KtAvatar extends StatelessWidget {
  final double size;
  final String char;
  final Gradient gradient;
  final Color borderColor;
  final double borderWidth;
  final double fontSize;

  const KtAvatar({
    super.key,
    required this.char,
    this.size = 40,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [KtColors.bomb, KtColors.warningDeep],
    ),
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
        border:
            borderWidth > 0 ? Border.all(color: borderColor, width: borderWidth) : null,
      ),
      child: Text(
        char,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: fontSize,
        ),
      ),
    );
  }

  /// 评论区按 style(1..4) 取渐变
  static Gradient commentGradient(int style) {
    switch (style) {
      case 1:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B6B), Color(0xFFC44569)],
        );
      case 2:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4ECDC4), Color(0xFF1A535C)],
        );
      case 3:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFB800), Color(0xFFFF6B35)],
        );
      case 4:
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C5CE7), Color(0xFF2D3436)],
        );
    }
  }
}

/// 💣 颗数显示行
class KtBombRow extends StatelessWidget {
  final int count;
  final double size;
  final double spacing;

  const KtBombRow({
    super.key,
    required this.count,
    this.size = 13,
    this.spacing = -2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '💣' * count,
      style: TextStyle(fontSize: size, letterSpacing: spacing, height: 1.1),
    );
  }
}

/// 损失金额（黄底偏移大字 / 红色字）
class KtLossText extends StatelessWidget {
  final double loss;
  final double fontSize;
  final Color color;

  const KtLossText({
    super.key,
    required this.loss,
    this.fontSize = 16,
    this.color = KtColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final String text = '💸 ¥${_formatNum(loss)}';
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w900,
        fontSize: fontSize,
        height: 1.2,
      ),
    );
  }

  static String _formatNum(double v) {
    final int i = v.round();
    final String s = i.toString();
    final StringBuffer out = StringBuffer();
    for (int idx = 0; idx < s.length; idx++) {
      final int rest = s.length - idx;
      out.write(s[idx]);
      if (rest > 1 && rest % 3 == 1) out.write(',');
    }
    return out.toString();
  }
}

/// 已避雷小药丸
class KtAvoidPill extends StatelessWidget {
  final String count;
  const KtAvoidPill({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: KtColors.primaryLight,
        borderRadius: BorderRadius.circular(KtRadius.pill),
      ),
      child: Text(
        '⚡ $count',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: KtColors.primary,
          height: 1.2,
        ),
      ),
    );
  }
}

/// 倾斜 + 字阴影 标语条
class KtSloganBar extends StatelessWidget {
  final String text;
  const KtSloganBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(-6 * 3.14159 / 180),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: KtColors.dark,
          borderRadius: BorderRadius.circular(KtRadius.xs),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
          ),
        ),
      ),
    );
  }
}
