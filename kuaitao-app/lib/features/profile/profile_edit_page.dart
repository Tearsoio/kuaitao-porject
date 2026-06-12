import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/kt_theme.dart';
import '../../data/mock/mock_data.dart';
import '../../models/thunder_post.dart';

/// ⑦ 个人信息维护页
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _nicknameCtrl;
  late TextEditingController _bioCtrl;
  late Set<String> _interests;
  bool _obscurePwd = true;

  static const List<String> _allInterests = <String>[
    '🏔 景点',
    '🍜 美食',
    '📱 数码',
    '🛎 服务',
    '💄 美妆',
    '🏨 酒店',
  ];

  @override
  void initState() {
    super.initState();
    final UserProfile u = MockData.currentUser;
    _nicknameCtrl = TextEditingController(text: u.nickname);
    _bioCtrl = TextEditingController(text: u.bio ?? '');
    _interests = Set<String>.from(u.interests);
  }

  @override
  void dispose() {
    _nicknameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProfile u = MockData.currentUser;
    final double topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: KtColors.bg,
      body: Stack(
        children: <Widget>[
          // 渐变背景 + 闪电装饰
          Stack(
            children: <Widget>[
              DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.4, -1),
                    end: Alignment(0.4, 1),
                    colors: <Color>[KtColors.primary, KtColors.bomb, KtColors.dark],
                    stops: <double>[0, 0.5, 1.0],
                  ),
                ),
                child: SizedBox(
                  height: topPad + 220,
                  width: double.infinity,
                ),
              ),
              // 设计稿 .edit-banner::before — 闪电装饰
              Positioned(
                right: -30,
                top: -10,
                child: Transform.rotate(
                  angle: 15 * 3.14159 / 180,
                  child: const Text(
                    '⚡',
                    style: TextStyle(
                      fontSize: 200,
                      color: Color(0x0FFFD60A),
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 内容
          CustomScrollView(
            slivers: <Widget>[
              // 顶部导航栏
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, topPad + 12, 16, 0),
                  // 设计稿 .edit-nav: flex, space-between
                  child: Row(
                    children: <Widget>[
                      // 返回按钮 — 设计稿: 36x36 圆, 半透明白底
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0x5AFFFFFF),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '←',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      // 标题
                      const Expanded(
                        child: Text(
                          '个人信息',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      // 保存按钮 — 设计稿: 渐变药丸 + bomb阴影
                      GestureDetector(
                        onTap: _onSave,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: KtGradients.brand,
                            borderRadius: BorderRadius.circular(KtRadius.pill),
                            boxShadow: KtShadows.bomb,
                          ),
                          child: const Text(
                            '保存',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 头像区域 — 设计稿: margin-top 24px, 居中, 头像下方接小徽章
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _AvatarEditor(avatarChar: u.avatarChar),
                      const SizedBox(height: 12),
                      // 小徽章: "已助 1,234 人避雷" — 居中, 白底半透明 + 自绘盾牌图标
                      Container(
                        padding: const EdgeInsets.fromLTRB(6, 5, 12, 5),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(KtRadius.pill),
                          border: Border.all(
                              color: const Color(0x66FFFFFF), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CustomPaint(painter: _ShieldPainter()),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '已助 ${_fmtCount(u.savedCount)} 人避雷',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 表单卡片 — 设计稿: margin -16px 14px 0, border-radius 16px, shadow
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(KtRadius.xl),
                    boxShadow: KtShadows.card,
                  ),
                  child: Column(
                    children: <Widget>[
                      // 避雷代号
                      _FormRow(
                        icon: '👤',
                        label: '避雷代号',
                        child: TextField(
                          controller: _nicknameCtrl,
                          style: const TextStyle(
                            fontSize: 14,
                            color: KtColors.text1,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                          ),
                        ),
                        showArrow: true,
                      ),
                      const _FormDivider(),
                      // 避雷等级 — 设计稿: 金色渐变药丸 badge
                      _FormRow(
                        icon: '🛡',
                        label: '避雷等级',
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[Color(0xFFFFE066), KtColors.warningDeep],
                            ),
                            borderRadius: BorderRadius.circular(KtRadius.pill),
                          ),
                          child: Text(
                            '🛡 Lv.${u.level} 避雷侠',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: KtColors.dark,
                            ),
                          ),
                        ),
                      ),
                      const _FormDivider(),
                      // 手机号 — 设计稿: 显示星号手机号 + 箭头
                      _FormRow(
                        icon: '📱',
                        label: '手机号',
                        trailing: const Text(
                          '138 **** 6688',
                          style: TextStyle(fontSize: 14, color: KtColors.text2),
                        ),
                        showArrow: true,
                      ),
                      const _FormDivider(),
                      // 登录密码 — 设计稿: 星号 + 修改链接
                      _FormRow(
                        icon: '🗝',
                        label: '登录密码',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _obscurePwd ? '••••••••' : '',
                              style: const TextStyle(fontSize: 14, color: KtColors.text2),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // TODO: 跳转修改密码页
                              },
                              child: const Text(
                                '修改',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: KtColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _FormDivider(),
                      // 个人简介
                      _FormRow(
                        icon: '📝',
                        label: '个人简介',
                        child: TextField(
                          controller: _bioCtrl,
                          style: const TextStyle(fontSize: 14, color: KtColors.text2),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                          ),
                        ),
                        showArrow: true,
                      ),
                    ],
                  ),
                ),
              ),
              // 兴趣标签卡片 — 设计稿: margin 14px, border-radius 16px, padding 16px
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(KtRadius.xl),
                    boxShadow: KtShadows.card,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            '🎯 你最想避哪些雷？',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: KtColors.text1,
                            ),
                          ),
                          Text(
                            '已选 ${_interests.length} / 至少 1 个',
                            style: const TextStyle(fontSize: 11, color: KtColors.text3),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _allInterests.map((String tag) {
                          final bool active = _interests.contains(tag);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (active) {
                                  if (_interests.length > 1) _interests.remove(tag);
                                } else {
                                  _interests.add(tag);
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: active ? KtColors.primary : KtColors.bg,
                                borderRadius: BorderRadius.circular(KtRadius.pill),
                                border: Border.all(
                                  color: active ? KtColors.primary : KtColors.border,
                                ),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: active ? Colors.white : KtColors.text2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              // 退出登录 — 设计稿: margin 24px 14px 40px, primary-light bg, primary border
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(14, 24, 14, 40),
                  child: GestureDetector(
                    onTap: _onLogout,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: KtColors.primaryLight,
                        borderRadius: BorderRadius.circular(KtRadius.lg),
                        border: Border.all(color: KtColors.primary, width: 1.5),
                      ),
                      child: const Text(
                        '退出登录',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: KtColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ 个人信息已保存'),
        backgroundColor: KtColors.dark,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
    context.pop();
  }

  void _onLogout() {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KtRadius.xl),
          ),
          title: const Text('确认退出登录？', style: TextStyle(fontWeight: FontWeight.w900)),
          content: const Text('退出后需要重新登录才能发帖和查看个人雷库'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('取消', style: TextStyle(color: KtColors.text3)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                context.go(AppRoutes.login);
              },
              child: const Text('退出登录',
                  style: TextStyle(color: KtColors.primary, fontWeight: FontWeight.w800)),
            ),
          ],
        );
      },
    );
  }

  static String _fmtCount(int v) {
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

/// 头像编辑器 — 设计稿: 88x88, 渐变, border 3px white, shadow, 相机图标 28x28
class _AvatarEditor extends StatelessWidget {
  final String avatarChar;
  const _AvatarEditor({required this.avatarChar});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 跳转头像选择
      },
      child: SizedBox(
        width: 88,
        height: 88,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: <Color>[KtColors.warningDeep, KtColors.bomb],
                ),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x40FF3B30),
                    blurRadius: 20,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                avatarChar,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            // 相机图标 — 设计稿: right -4px, bottom -4px, 28x28, primary bg, 2px white border
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: KtColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                alignment: Alignment.center,
                child: const Text('📷', style: TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 通用表单行 — 设计稿: padding 14px 16px, label width 72px
class _FormRow extends StatelessWidget {
  final String icon;
  final String label;
  final Widget? child;
  final Widget? trailing;
  final bool showArrow;

  const _FormRow({
    required this.icon,
    required this.label,
    this.child,
    this.trailing,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: KtColors.text1,
              ),
            ),
          ),
          if (child != null)
            Expanded(child: child!)
          else if (trailing != null)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: trailing!,
              ),
            ),
          if (showArrow) ...<Widget>[
            const SizedBox(width: 6),
            const Text('›', style: TextStyle(fontSize: 14, color: KtColors.text3)),
          ],
        ],
      ),
    );
  }
}

/// 表单分隔线
class _FormDivider extends StatelessWidget {
  const _FormDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: KtColors.border),
    );
  }
}

/// 盾牌+闪电图标 (黄→橙渐变填充, 深色描边, 内部黑色闪电)
class _ShieldPainter extends CustomPainter {
  const _ShieldPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    // 24x24 viewBox 缩放
    final double sx = w / 24;
    final double sy = h / 24;

    final Path shield = Path()
      ..moveTo(12 * sx, 2.2 * sy)
      ..lineTo(20 * sx, 5 * sy)
      ..lineTo(20 * sx, 11.5 * sy)
      ..cubicTo(20 * sx, 16.4 * sy, 16.6 * sx, 20.4 * sy, 12 * sx, 21.8 * sy)
      ..cubicTo(7.4 * sx, 20.4 * sy, 4 * sx, 16.4 * sy, 4 * sx, 11.5 * sy)
      ..lineTo(4 * sx, 5 * sy)
      ..close();

    final Paint fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[KtColors.warning, KtColors.bomb],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(shield, fill);

    final Paint stroke = Paint()
      ..color = KtColors.dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(shield, stroke);

    // 内部闪电
    final Path bolt = Path()
      ..moveTo(13 * sx, 7 * sy)
      ..lineTo(8.5 * sx, 13.2 * sy)
      ..lineTo(11.6 * sx, 13.2 * sy)
      ..lineTo(10.6 * sx, 17.5 * sy)
      ..lineTo(15.2 * sx, 11.2 * sy)
      ..lineTo(12.2 * sx, 11.2 * sy)
      ..close();
    canvas.drawPath(bolt, Paint()..color = KtColors.dark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
