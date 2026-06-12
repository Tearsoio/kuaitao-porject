import 'package:flutter/material.dart';

import '../../app/theme/kt_theme.dart';
import '../../data/mock/mock_data.dart';
import '../../models/thunder_post.dart';
import '../../widgets/kt_widgets.dart';

/// ④ 雷帖详情
class ThunderDetailPage extends StatefulWidget {
  final String thunderId;
  const ThunderDetailPage({super.key, required this.thunderId});

  @override
  State<ThunderDetailPage> createState() => _ThunderDetailPageState();
}

class _ThunderDetailPageState extends State<ThunderDetailPage> {
  bool _liked = true;

  ThunderPost get _post {
    return MockData.homePosts.firstWhere(
      (ThunderPost p) => p.id == widget.thunderId,
      orElse: () => MockData.homePosts.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThunderPost p = _post;
    return Scaffold(
      backgroundColor: KtColors.bg,
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _Gallery(post: p),
              const SizedBox(height: 0),
              _Poster(post: p),
              _AuthorBar(post: p),
              _Body(post: p),
              _MapCard(post: p),
              const _AvoidCTA(),
              _Comments(),
              const SizedBox(height: 110),
            ],
          ),
          _Header(),
          _BottomBar(
            liked: _liked,
            onLike: () => setState(() => _liked = !_liked),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double topPad = MediaQuery.of(context).padding.top + 8;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, topPad, 16, 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0x73000000), Colors.transparent],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _IconBtn(
              text: '←',
              onTap: () => Navigator.of(context).maybePop(),
            ),
            const _IconBtn(text: '⋯'),
          ],
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const _IconBtn({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.4),
        ),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  final ThunderPost post;
  const _Gallery({required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(gradient: KtCovers.byKey(post.coverKey)),
            alignment: Alignment.center,
            child: Text(post.coverEmoji,
                style: const TextStyle(fontSize: 120, color: Colors.white)),
          ),
          const Positioned(
            top: 80,
            right: 14,
            child: _Pager(text: '1 / 5'),
          ),
          const Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: _Dots(activeIndex: 0, count: 5),
          ),
        ],
      ),
    );
  }
}

class _Pager extends StatelessWidget {
  final String text;
  const _Pager({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(KtRadius.pill),
      ),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }
}

class _Dots extends StatelessWidget {
  final int activeIndex;
  final int count;
  const _Dots({required this.activeIndex, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, (int i) {
        final bool active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          width: active ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _Poster extends StatelessWidget {
  final ThunderPost post;
  const _Poster({required this.post});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        decoration: BoxDecoration(
          color: KtColors.dark,
          borderRadius: BorderRadius.circular(KtRadius.xl),
          border: Border.all(color: KtColors.primary, width: 3),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Color(0x4D000000), blurRadius: 24, offset: Offset(0, 8)),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              top: -28,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: KtColors.primary,
                  borderRadius: BorderRadius.circular(KtRadius.xs),
                ),
                child: const Text(
                  '踩雷警告',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '💣' * post.bombs,
                      style:
                          const TextStyle(fontSize: 22, letterSpacing: -3, height: 1.1),
                    ),
                    Text('${post.bombs} 颗雷 · 致命级',
                        style: const TextStyle(
                          color: KtColors.warning,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        )),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const Text('本次踩雷损失 ',
                        style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11)),
                    Transform(
                      transform: Matrix4.skewX(-4 * 3.14159 / 180),
                      alignment: Alignment.center,
                      child: Text(
                        '¥${_fmt(post.loss)}',
                        style: const TextStyle(
                          color: KtColors.warning,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          height: 1,
                          shadows: <Shadow>[
                            Shadow(color: KtColors.primary, offset: Offset(1, 0)),
                            Shadow(color: KtColors.primary, offset: Offset(-1, 0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0x33FFFFFF), width: 1),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Text('📍'),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          post.location,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

class _AuthorBar extends StatelessWidget {
  final ThunderPost post;
  const _AuthorBar({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
      child: Row(
        children: <Widget>[
          KtAvatar(char: post.authorAvatarChar ?? '?', size: 40, fontSize: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(post.authorName ?? '匿名雷友',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                const Text('2 小时前 · 来自 三亚',
                    style: TextStyle(fontSize: 11, color: KtColors.text3)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: KtColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(KtRadius.pill),
            ),
            child: const Text('+ 关注',
                style: TextStyle(
                    color: KtColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ThunderPost post;
  const _Body({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '所谓的"现捞海鲜"原来全是套路，过秤少了快一半！',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            post.content ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: KtColors.text2,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: post.topics
                .map((String t) => Text(t,
                    style: const TextStyle(
                      color: KtColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    )))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  final ThunderPost post;
  const _MapCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: KtColors.border),
        borderRadius: BorderRadius.circular(KtRadius.lg),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFE8F1E8), Color(0xFFDCEADC)],
              ),
            ),
            alignment: Alignment.center,
            child: const Text('📍', style: TextStyle(fontSize: 28)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('三亚第一市场海鲜大排档',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      const Text('📌 距你 1,243 km',
                          style: TextStyle(
                              color: KtColors.text3, fontSize: 11)),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: KtColors.primary,
                    borderRadius: BorderRadius.circular(KtRadius.pill),
                  ),
                  child: const Text('导航绕开',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvoidCTA extends StatelessWidget {
  const _AvoidCTA();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 18, 14, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: KtGradients.brand,
        borderRadius: BorderRadius.circular(KtRadius.xl),
        boxShadow: KtShadows.bomb,
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.2,
              child: Text('⚡',
                  style: TextStyle(fontSize: 80, color: Colors.white)),
            ),
          ),
          Row(
            children: <Widget>[
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('1,234',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1)),
                  SizedBox(height: 4),
                  Text('⚡ 人已成功避雷',
                      style: TextStyle(
                          color: Color(0xE6FFFFFF), fontSize: 11)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(KtRadius.pill),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 10,
                        offset: Offset(0, 4)),
                  ],
                ),
                child: const Text('我也避了',
                    style: TextStyle(
                        color: KtColors.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Comments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('💬 评论 (89)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ...MockData.demoComments.map(_CommentTile.new),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final CommentItem item;
  const _CommentTile(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          KtAvatar(
            char: item.avatarChar,
            size: 32,
            fontSize: 12,
            gradient: KtAvatar.commentGradient(item.avatarStyle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: KtColors.text2)),
                    const SizedBox(width: 6),
                    Text('· ${item.time}',
                        style: const TextStyle(
                            fontSize: 12, color: KtColors.text3)),
                  ],
                ),
                const SizedBox(height: 3),
                Text(item.content,
                    style: const TextStyle(
                        fontSize: 13, color: KtColors.text1, height: 1.5)),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text('👍 ${item.likes}',
                        style: const TextStyle(
                            fontSize: 11, color: KtColors.text3)),
                    const SizedBox(width: 14),
                    const Text('💬 回复',
                        style: TextStyle(
                            fontSize: 11, color: KtColors.text3)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool liked;
  final VoidCallback onLike;
  const _BottomBar({required this.liked, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: KtColors.border)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: KtColors.bg,
                  borderRadius: BorderRadius.circular(KtRadius.pill),
                ),
                child: const Text('说点什么...',
                    style: TextStyle(
                        fontSize: 12, color: KtColors.text3)),
              ),
            ),
            const SizedBox(width: 10),
            _BottomIcon(emoji: '❤', label: '1.2k', active: liked, onTap: onLike),
            const SizedBox(width: 10),
            const _BottomIcon(emoji: '⭐', label: '收藏'),
            const SizedBox(width: 10),
            const _BottomIcon(emoji: '↗', label: '分享'),
          ],
        ),
      ),
    );
  }
}

class _BottomIcon extends StatelessWidget {
  final String emoji;
  final String label;
  final bool active;
  final VoidCallback? onTap;
  const _BottomIcon({
    required this.emoji,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = active ? KtColors.primary : KtColors.text2;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(emoji, style: TextStyle(fontSize: 18, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: active ? KtColors.primary : KtColors.text3)),
          ],
        ),
      ),
    );
  }
}
