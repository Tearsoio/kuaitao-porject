import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/kt_theme.dart';

/// ⑤ 发布避雷帖
class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  int _bombs = 4;
  static const List<String> _topics = <String>['#三亚海鲜刺客', '#旅游避雷'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KtColors.bg,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _TopBar(onClose: () => context.pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _Uploader(),
                    const SizedBox(height: 16),
                    _TitleInput(),
                    const SizedBox(height: 12),
                    _ContentArea(),
                    const SizedBox(height: 16),
                    _RatingBlock(
                      bombs: _bombs,
                      onChange: (int v) => setState(() => _bombs = v),
                    ),
                    const SizedBox(height: 16),
                    const _FormRow(
                      icon: '📍',
                      label: '地点/商家',
                      value: '三亚第一市场某海鲜大排档',
                    ),
                    _FormRow(
                      icon: '💸',
                      label: '损失金额',
                      valueWidget: const Text.rich(
                        TextSpan(children: <InlineSpan>[
                          TextSpan(
                            text: '¥ ',
                            style: TextStyle(
                              color: KtColors.primary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: '3,800',
                            style: TextStyle(
                              color: KtColors.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    const _FormRow(icon: '📂', label: '所属分类', value: '🍜 美食'),
                    const SizedBox(height: 8),
                    _TopicRow(topics: _topics),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onClose;
  const _TopBar({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: KtColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: onClose,
            child: const Text('✕',
                style: TextStyle(fontSize: 22, color: KtColors.text2)),
          ),
          const Text('曝光这个大雷！',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              gradient: KtGradients.brand,
              borderRadius: BorderRadius.circular(KtRadius.pill),
            ),
            child: const Text('发布',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _Uploader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[
      _UploadItem(gradient: KtCovers.seafood, emoji: '🦀'),
      _UploadItem(gradient: KtCovers.bbq, emoji: '🍤'),
      const _UploadEmpty(),
    ];
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: items,
    );
  }
}

class _UploadItem extends StatelessWidget {
  final LinearGradient gradient;
  final String emoji;
  const _UploadItem({required this.gradient, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(KtRadius.sm + 2),
            ),
            alignment: Alignment.center,
            child: Text(emoji,
                style: const TextStyle(fontSize: 38, color: Colors.white)),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Text('✕',
                  style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadEmpty extends StatelessWidget {
  const _UploadEmpty();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: KtColors.bg,
          borderRadius: BorderRadius.circular(KtRadius.sm + 2),
          border: Border.all(
              color: KtColors.border, width: 2, style: BorderStyle.solid),
        ),
        alignment: Alignment.center,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('+', style: TextStyle(fontSize: 28, color: KtColors.text3)),
            SizedBox(height: 2),
            Text('0/9',
                style: TextStyle(fontSize: 10, color: KtColors.text3)),
          ],
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: KtColors.border)),
      ),
      child: const TextField(
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: KtColors.text1,
        ),
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          hintText: '用大字报告诉大家...',
          hintStyle: TextStyle(
            color: KtColors.text3,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        maxLines: 1,
      ),
    );
  }
}

class _ContentArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: KtColors.border)),
      ),
      child: const TextField(
        maxLines: null,
        minLines: 4,
        style: TextStyle(fontSize: 14, color: KtColors.text2, height: 1.7),
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          hintText: '详细吐槽下你的踩雷过程吧 ~（踩雷时间、过程、对方态度，最好附图证据）',
          hintStyle: TextStyle(color: KtColors.text3, fontSize: 14),
        ),
      ),
    );
  }
}

class _RatingBlock extends StatelessWidget {
  final int bombs;
  final ValueChanged<int> onChange;
  const _RatingBlock({required this.bombs, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFF8C5), KtColors.primaryLight],
        ),
        border: Border.all(color: KtColors.dark, width: 2),
        borderRadius: BorderRadius.circular(KtRadius.lg),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: KtColors.dark, offset: Offset(3, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('💣 雷点几颗？',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
              Text('已选 $bombs 颗 · ${_level(bombs)}',
                  style: const TextStyle(
                    color: KtColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List<Widget>.generate(5, (int i) {
              final bool on = i < bombs;
              return GestureDetector(
                onTap: () => onChange(i + 1),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Opacity(
                    opacity: on ? 1 : 0.25,
                    child: ColorFiltered(
                      colorFilter: on
                          ? const ColorFilter.mode(
                              Colors.transparent, BlendMode.multiply)
                          : const ColorFilter.matrix(<double>[
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0, 0, 0, 1, 0,
                            ]),
                      child: const Text('💣',
                          style: TextStyle(fontSize: 30, letterSpacing: 2)),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  static String _level(int b) {
    if (b >= 5) return '致命级';
    if (b == 4) return '危险级';
    if (b == 3) return '警告级';
    if (b == 2) return '注意级';
    return '轻微';
  }
}

class _FormRow extends StatelessWidget {
  final String icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  const _FormRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: KtColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: valueWidget ??
                Text(value ?? '',
                    style: const TextStyle(
                        color: KtColors.text2, fontSize: 14)),
          ),
          const Text('›',
              style: TextStyle(color: KtColors.text3, fontSize: 16)),
        ],
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  final List<String> topics;
  const _TopicRow({required this.topics});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('🏷 添加话题',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: <Widget>[
              ...topics.map((String t) => _TopicChip(text: t, removable: true)),
              const _TopicChip(text: '+ 添加', removable: false, dashed: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  final String text;
  final bool removable;
  final bool dashed;
  const _TopicChip({
    required this.text,
    required this.removable,
    this.dashed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: dashed ? Colors.transparent : KtColors.primaryLight,
        borderRadius: BorderRadius.circular(KtRadius.pill),
        border: dashed ? Border.all(color: KtColors.border) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text,
              style: TextStyle(
                color: dashed ? KtColors.text3 : KtColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              )),
          if (removable) ...<Widget>[
            const SizedBox(width: 4),
            const Text('✕',
                style: TextStyle(color: KtColors.primary, fontSize: 10)),
          ],
        ],
      ),
    );
  }
}
