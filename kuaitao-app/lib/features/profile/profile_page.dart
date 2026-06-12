import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/kt_theme.dart';
import '../../data/mock/mock_data.dart';
import '../../models/thunder_post.dart';
import '../../widgets/kt_tabbar.dart';
import '../../widgets/thunder_card.dart';

/// ⑥ 个人中心
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final UserProfile u = MockData.currentUser;

    return Scaffold(
      backgroundColor: KtColors.bg,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _Banner(user: u)),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -50),
                  child: _SaveMedal(savedCount: u.savedCount),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -38),
                  child: _StatsRow(user: u),
                ),
              ),
              SliverToBoxAdapter(
                child: _ProfileTabs(
                  index: _tab,
                  onChange: (int i) => setState(() => _tab = i),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 110),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  childCount: MockData.profilePosts.length,
                  itemBuilder: (BuildContext context, int i) {
                    final ThunderPost p = MockData.profilePosts[i];
                    return ThunderCard(
                      post: p,
                      onTap: () => context.push(AppRoutes.thunderDetail(p.id)),
                    );
                  },
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: KtTabBar(current: KtTabType.profile),
          ),
          const HomeIndicator(),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final UserProfile user;
  const _Banner({required this.user});

  @override
  Widget build(BuildContext context) {
    final double topPad = MediaQuery.of(context).padding.top + 12;
    return Container(
      padding: EdgeInsets.fromLTRB(16, topPad, 16, 70),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.4, -1),
          end: Alignment(0.4, 1),
          colors: <Color>[KtColors.primary, KtColors.bomb, KtColors.dark],
          stops: <double>[0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            right: -10,
            top: 18,
            child: Transform.rotate(
              angle: -10 * 3.14159 / 180,
              child: const Text(
                '避雷侠',
                style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.w900,
                  color: Color(0x14FFFFFF),
                  letterSpacing: 2,
                  height: 1,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerRight,
                child: Text('⚙',
                    style: TextStyle(
                        color: Color(0xCCFFFFFF), fontSize: 20)),
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(colors: <Color>[
                        KtColors.warningDeep,
                        KtColors.bomb,
                      ]),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Text(
                      user.avatarChar,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(user.nickname,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: KtColors.warning,
                          borderRadius: BorderRadius.circular(KtRadius.pill),
                        ),
                        child: Text(
                          '🛡 Lv.${user.level} 避雷侠',
                          style: const TextStyle(
                            color: KtColors.dark,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SaveMedal extends StatelessWidget {
  final int savedCount;
  const _SaveMedal({required this.savedCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFE066), KtColors.warningDeep],
        ),
        border: Border.all(color: KtColors.dark, width: 3),
        borderRadius: BorderRadius.circular(KtRadius.xl),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: KtColors.dark, offset: Offset(4, 4)),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Text('🛡', style: TextStyle(fontSize: 42)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _fmt(savedCount),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: KtColors.primary,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('人因你成功避雷',
                    style: TextStyle(
                      color: KtColors.dark,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
          ),
          const Text('›',
              style: TextStyle(fontSize: 18, color: KtColors.dark)),
        ],
      ),
    );
  }

  static String _fmt(int v) {
    final String s = v.toString();
    final StringBuffer out = StringBuffer();
    for (int idx = 0; idx < s.length; idx++) {
      final int rest = s.length - idx;
      out.write(s[idx]);
      if (rest > 1 && rest % 3 == 1) out.write(',');
    }
    return out.toString();
  }
}

class _StatsRow extends StatelessWidget {
  final UserProfile user;
  const _StatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(KtRadius.md),
        boxShadow: KtShadows.card,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _Cell(value: '${user.postCount}', label: '发布雷帖'),
          const _Divider(),
          _Cell(value: '${user.favoriteCount}', label: '收藏'),
          const _Divider(),
          _Cell(value: user.likes, label: '被赞'),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String value;
  final String label;
  const _Cell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(fontSize: 11, color: KtColors.text3)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 24, color: KtColors.border);
  }
}

class _ProfileTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;
  const _ProfileTabs({required this.index, required this.onChange});

  static const List<String> _titles = <String>['我的雷帖', '收藏', '浏览历史'];

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: KtColors.border)),
        ),
        child: Row(
          children: List<Widget>.generate(_titles.length, (int i) {
            final bool active = i == index;
            return GestureDetector(
              onTap: () => onChange(i),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Text(_titles[i],
                        style: TextStyle(
                          color: active ? KtColors.text1 : KtColors.text3,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                    if (active)
                      Positioned(
                        bottom: -10,
                        child: Container(
                          width: 24,
                          height: 3,
                          decoration: BoxDecoration(
                            color: KtColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
