import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/kt_theme.dart';
import '../../widgets/kt_tabbar.dart' show HomeIndicator;
import 'widgets/auth_widgets.dart';

/// ① 登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _tab = 0; // 0 验证码 / 1 密码
  bool _agree = true;

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
                  const SizedBox(height: 40),
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
                        TextSpan(text: '欢迎回来，\n继续 '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: _HighlightWord(text: '避雷'),
                        ),
                        TextSpan(text: ' 之旅 💣'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '登录后可发帖、收藏、查看个人雷库',
                    style: TextStyle(color: KtColors.text3, fontSize: 13, height: 1.6),
                  ),
                  const SizedBox(height: 18),
                  _LoginTabs(
                    index: _tab,
                    onChange: (int i) => setState(() => _tab = i),
                  ),
                  const SizedBox(height: 22),
                  if (_tab == 0) ...<Widget>[
                    const AuthTextField(
                      leading: '📱',
                      hint: '请输入手机号',
                      initialValue: '138 **** 6688',
                      keyboardType: TextInputType.phone,
                      focused: true,
                    ),
                    AuthTextField(
                      leading: '🔐',
                      hint: '请输入 6 位验证码',
                      keyboardType: TextInputType.number,
                      trailing: const AuthCodeBtn(text: '获取验证码'),
                    ),
                  ] else ...<Widget>[
                    const AuthTextField(
                      leading: '📱',
                      hint: '请输入手机号',
                      keyboardType: TextInputType.phone,
                      focused: true,
                    ),
                    const AuthTextField(
                      leading: '🗝',
                      hint: '请输入登录密码',
                      obscure: true,
                      trailing: Text('👁',
                          style: TextStyle(fontSize: 16, color: KtColors.text3)),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4, bottom: 22),
                    child: AuthAgreeRow(
                      checked: _agree,
                      onToggle: () => setState(() => _agree = !_agree),
                    ),
                  ),
                  AuthSubmitBtn(
                    text: '登 录',
                    onTap: () => context.go(AppRoutes.home),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push(AppRoutes.register),
                      child: const Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 13, color: KtColors.text3),
                          children: <InlineSpan>[
                            TextSpan(text: '还没账号？'),
                            TextSpan(
                              text: '立即注册 ›',
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
                  const SizedBox(height: 32),
                  Row(
                    children: const <Widget>[
                      Expanded(child: Divider(color: KtColors.border, height: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('其他方式登录',
                            style: TextStyle(color: KtColors.text3, fontSize: 11)),
                      ),
                      Expanded(child: Divider(color: KtColors.border, height: 1)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      ThirdLoginBtn(bg: Color(0xFF07C160), emoji: '💬'),
                      SizedBox(width: 24),
                      ThirdLoginBtn(bg: Color(0xFF12B7F5), emoji: '🐧'),
                      SizedBox(width: 24),
                      ThirdLoginBtn(bg: KtColors.dark, emoji: ''),
                    ],
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

class _LoginTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;

  const _LoginTabs({required this.index, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _tabItem('验证码登录', 0),
        const SizedBox(width: 22),
        _tabItem('密码登录', 1),
      ],
    );
  }

  Widget _tabItem(String text, int i) {
    final bool active = index == i;
    return GestureDetector(
      onTap: () => onChange(i),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Stack(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: active ? KtColors.text1 : KtColors.text3,
                fontSize: active ? 16 : 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (active)
              Positioned(
                bottom: -3,
                left: 0,
                child: Container(
                  width: 28,
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
