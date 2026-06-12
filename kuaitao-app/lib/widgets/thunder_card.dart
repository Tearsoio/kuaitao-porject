import 'package:flutter/material.dart';

import '../app/theme/kt_theme.dart';
import '../models/thunder_post.dart';

/// 雷帖瀑布流卡片 —— 与设计稿 .thunder-card 1:1 还原
class ThunderCard extends StatelessWidget {
  final ThunderPost post;
  final VoidCallback? onTap;

  const ThunderCard({super.key, required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool bigBadge = post.bombs >= 4 && post.badge == null;
    final String badgeText = post.badge ?? '💣 ${post.bombs}颗雷';
    final bool isBig = bigBadge;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(KtRadius.lg),
          boxShadow: KtShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // 封面
            Stack(
              children: <Widget>[
                Container(
                  height: post.coverHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(gradient: KtCovers.byKey(post.coverKey)),
                  alignment: Alignment.center,
                  child: Text(
                    post.coverEmoji,
                    style: const TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: _CoverBadge(text: badgeText, isBig: isBig),
                ),
              ],
            ),
            // body
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: KtColors.text1,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (post.badge != null) ...<Widget>[
                    Text(
                      '💣' * post.bombs,
                      style: const TextStyle(fontSize: 13, letterSpacing: -2),
                    ),
                    const SizedBox(height: 6),
                  ],
                  Text(
                    '💸 ¥${_fmt(post.loss)}',
                    style: const TextStyle(
                      color: KtColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '📍 ${post.location}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: KtColors.text3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _AvoidPill(count: post.avoidCount),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _fmt(double v) {
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

class _CoverBadge extends StatelessWidget {
  final String text;
  final bool isBig;
  const _CoverBadge({required this.text, required this.isBig});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isBig
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isBig ? KtColors.primary : KtColors.dark,
        borderRadius: BorderRadius.circular(KtRadius.xs),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isBig ? Colors.white : KtColors.warning,
          fontSize: isBig ? 11 : 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _AvoidPill extends StatelessWidget {
  final String count;
  const _AvoidPill({required this.count});

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
          color: KtColors.primary,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }
}
