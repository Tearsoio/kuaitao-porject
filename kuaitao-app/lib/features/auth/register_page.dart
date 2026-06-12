import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/kt_theme.dart';
import '../../widgets/kt_tabbar.dart' show HomeIndicator;
import 'widgets/auth_widgets.dart';

/// ② 注册 / 完善资料
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agree = true;
  final Set<String> _interests = <String>{'🏔 景点', '🍜 美食', '💄 美妆'};

  static const List<String> _allInterests = <String>[
    '🏔 景点',
    '🍜 美食',
    '📱 数码',
    '🛎 服务',
    '💄 美妆',
    '🏨 酒店',
  ];

  void _toggle(String tag) {
    setState(() {
      if (_interests.contains(tag)) {
        _interests.remove(tag);
      } else {
        _interests.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KtColors.bg,
      body: Stack(
        children: <Widget>[
          const AuthBgDecor(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  const AuthMiniLogo(),
                  const SizedBox(height: 28),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: KtColors.text1,
                        height: 1.3,
                      ),
                      children: <InlineSpan>[
                        TextSpan(text: '开始你的 '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: _HighlightWord(text: '避雷侠'),
                        ),
                        TextSpan(text: ' 之路 🛡'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: KtColors.text3, fontSize: 13, height: 1.6),
                      children: <InlineSpan>[
                        TextSpan(text: '已有 '),
                        TextSpan(
                          text: '128 万',
                          style: TextStyle(
                            color: KtColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' 用户帮你扫雷'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 头像 + 提示
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(KtRadius.lg),
                      border: Border.all(color: KtColors.border, width: 1.5),
                      boxShadow: KtShadows.card,
                    ),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Container(
                              width: 52,
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(colors: <Color>[
                                  KtColors.bomb,
                                  KtColors.warningDeep,
                                ]),
                                border: Border.all(color: KtColors.dark, width: 2),
                              ),
                              child: const Text(
                                '明',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              bottom: -2,
                              child: Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: KtColors.primary,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Text('📷',
                                    style: TextStyle(fontSize: 9)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('设置你的避雷代号',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w800)),
                              SizedBox(height: 4),
                              Text('建议起个让人过目不忘的昵称',
                                  style: TextStyle(
                                      color: KtColors.text3, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const AuthTextField(
                    leading: '👤',
                    hint: '昵称',
                    initialValue: '小明被坑日记',
                    focused: true,
                  ),
                  const AuthTextField(
                    leading: '📱',
                    hint: '手机号',
                    initialValue: '138 8888 6688',
                    keyboardType: TextInputType.phone,
                  ),
                  const AuthTextField(
                    leading: '🔐',
                    hint: '请输入 6 位验证码',
                    keyboardType: TextInputType.number,
                    trailing: AuthCodeBtn(text: '58s 后重发', disabled: true),
                  ),
                  const AuthTextField(
                    leading: '🗝',
                    hint: '设置登录密码（8-20 位）',
                    obscure: true,
                    trailing: Text('👁',
                        style: TextStyle(fontSize: 16, color: KtColors.text3)),
                  ),

                  // 兴趣
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(KtRadius.lg),
                      border: Border.all(color: KtColors.border, width: 1.5),
                      boxShadow: KtShadows.card,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('🎯 你最想避哪些雷？',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w800)),
                            Text('已选 ${_interests.length} / 至少 1 个',
                                style: const TextStyle(
                                    color: KtColors.text3, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _allInterests.map((String t) {
                            final bool active = _interests.contains(t);
                            return GestureDetector(
                              onTap: () => _toggle(t),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: active ? KtColors.primary : KtColors.bg,
                                  borderRadius: BorderRadius.circular(KtRadius.pill),
                                  border: Border.all(
                                    color:
                                        active ? KtColors.primary : KtColors.border,
                                  ),
                                ),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                    color: active ? Colors.white : KtColors.text2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 16),
                    child: AuthAgreeRow(
                      checked: _agree,
                      onToggle: () => setState(() => _agree = !_agree),
                    ),
                  ),

                  AuthSubmitBtn(
                    text: '注 册 并 进 入',
                    onTap: () => context.go(AppRoutes.home),
                  ),

                  const SizedBox(height: 18),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: const Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 13, color: KtColors.text3),
                          children: <InlineSpan>[
                            TextSpan(text: '已有账号？'),
                            TextSpan(
                              text: '返回登录 ›',
                              style: TextStyle(
                                color: KtColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          const HomeIndicator(),
        ],
      ),
    );
  }
}

class _HighlightWord extends StatelessWidget {
  final String text;
  const _HighlightWord({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: <double>[0.6, 0.6, 0.9, 0.9],
          colors: <Color>[
            Colors.transparent,
            KtColors.warning,
            KtColors.warning,
            Colors.transparent,
          ],
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: KtColors.primary,
          height: 1.3,
        ),
      ),
    );
  }
}
