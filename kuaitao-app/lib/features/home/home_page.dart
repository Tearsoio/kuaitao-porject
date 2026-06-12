import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/kt_theme.dart';
import '../../data/mock/mock_data.dart';
import '../../models/thunder_post.dart';
import '../../widgets/kt_tabbar.dart';
import '../../widgets/kt_widgets.dart';
import '../../widgets/thunder_card.dart';

/// ③ 首页 · 雷区广场
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _catIndex = 0;

  List<ThunderPost> get _posts {
    if (_catIndex == 0) return MockData.homePosts;
    final String cat = MockData.categories[_catIndex];
    final List<ThunderPost> filtered =
        MockData.homePosts.where((ThunderPost p) => p.category == cat).toList();
    return filtered.isEmpty ? MockData.homePosts : filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KtColors.bg,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _Header()),
              const SliverToBoxAdapter(child: SizedBox(height: 18)),
              SliverToBoxAdapter(child: _AnnounceBar()),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(child: _HotBanner()),
              const SliverToBoxAdapter(child: SizedBox(height: 4)),
              SliverToBoxAdapter(
                child: _CategoryTabs(
                  index: _catIndex,
                  onChange: (int i) => setState(() => _catIndex = i),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  childCount: _posts.length,
                  itemBuilder: (BuildContext context, int i) {
                    final ThunderPost p = _posts[i];
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
            child: KtTabBar(current: KtTabType.home),
          ),
          const HomeIndicator(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double topPad = MediaQuery.of(context).padding.top + 12;
    return Container(
      padding: EdgeInsets.fromLTRB(16, topPad, 16, 32),
      decoration: const BoxDecoration(
        gradient: KtGradients.header,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const KtLogo(fontSize: 32),
              GestureDetector(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Text('🔔',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(KtRadius.pill),
            ),
            child: Row(
              children: const <Widget>[
                Text('🔍', style: TextStyle(fontSize: 13)),
                SizedBox(width: 8),
                Text('搜你想避的雷...',
                    style: TextStyle(fontSize: 13, color: KtColors.text3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnounceBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: KtColors.warning,
        border: Border.all(color: KtColors.dark, width: 2),
        borderRadius: BorderRadius.circular(KtRadius.md),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: KtColors.dark, offset: Offset(3, 3)),
        ],
      ),
      child: const Row(
        children: <Widget>[
          Text('📢', style: TextStyle(fontSize: 14)),
          SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: KtColors.dark,
                  fontWeight: FontWeight.w700,
                ),
                children: <InlineSpan>[
                  TextSpan(text: '今日新增 '),
                  TextSpan(
                    text: '287',
                    style: TextStyle(
                      color: KtColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: ' 雷，已救 '),
                  TextSpan(
                    text: '1.2万',
                    style: TextStyle(
                      color: KtColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: ' 人，本周热词「海鲜刺客」'),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _HotBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[KtColors.dark, Color(0xFF2D2D2D)],
        ),
        borderRadius: BorderRadius.circular(KtRadius.lg),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            right: -10,
            bottom: -20,
            child: Opacity(
              opacity: 0.15,
              child: Text('🔥',
                  style: TextStyle(fontSize: 80, color: Colors.white)),
            ),
          ),
          Row(
            children: <Widget>[
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('本周大雷榜 TOP10',
                        style: TextStyle(
                          color: KtColors.warning,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        )),
                    SizedBox(height: 2),
                    Text('10 个让人哭的离谱踩雷现场',
                        style:
                            TextStyle(color: Color(0xB3FFFFFF), fontSize: 11)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: KtColors.warning,
                  borderRadius: BorderRadius.circular(KtRadius.pill),
                ),
                child: const Text(
                  '围观',
                  style: TextStyle(
                    color: KtColors.dark,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;

  const _CategoryTabs({required this.index, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
        itemCount: MockData.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int i) {
          final bool active = index == i;
          return GestureDetector(
            onTap: () => onChange(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: active ? KtColors.dark : Colors.white,
                border: Border.all(
                    color: active ? KtColors.dark : KtColors.border, width: 1),
                borderRadius: BorderRadius.circular(KtRadius.pill),
              ),
              alignment: Alignment.center,
              child: Text(
                MockData.categories[i],
                style: TextStyle(
                  color: active ? KtColors.warning : KtColors.text2,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
