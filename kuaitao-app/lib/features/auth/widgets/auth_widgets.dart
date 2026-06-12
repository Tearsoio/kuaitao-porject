import 'package:flutter/material.dart';

import '../../../app/theme/kt_theme.dart';

/// 登录/注册共用的背景装饰圆 + 顶部 Mini Logo + 双输入框样式
/// 这里仅暴露最常用的组件供 login/register 复用
class AuthBgDecor extends StatelessWidget {
  const AuthBgDecor({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -50,
          right: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[Color(0x1FFF3B30), Color(0x00FF3B30)],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: -100,
          child: Container(
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[Color(0x2EFFD60A), Color(0x00FFD60A)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AuthMiniLogo extends StatelessWidget {
  const AuthMiniLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(-8 * 3.14159 / 180),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text(
            '⚡',
            style: TextStyle(
              fontSize: 32,
              color: KtColors.warning,
              height: 1,
              shadows: <Shadow>[Shadow(color: KtColors.dark, offset: Offset(1.5, 1.5))],
            ),
          ),
          SizedBox(width: 4),
          Text(
            '快逃',
            style: TextStyle(
              fontSize: 38,
              color: KtColors.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 1,
              shadows: <Shadow>[Shadow(color: KtColors.dark, offset: Offset(2, 2))],
            ),
          ),
        ],
      ),
    );
  }
}

/// 通用输入框（外观）：圆角白底 + 左侧 emoji + 右侧 trailing
class AuthTextField extends StatefulWidget {
  final String leading;
  final String hint;
  final String? initialValue;
  final bool obscure;
  final TextInputType keyboardType;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;
  final bool focused;

  const AuthTextField({
    super.key,
    required this.leading,
    required this.hint,
    this.initialValue,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.trailing,
    this.onChanged,
    this.focused = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final FocusNode _node = FocusNode();
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.initialValue);
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focused = widget.focused;
    _node.addListener(() => setState(() => _focused = _node.hasFocus));
  }

  @override
  void dispose() {
    _node.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(KtRadius.lg),
        border: Border.all(
          color: _focused ? KtColors.primary : KtColors.border,
          width: 1.5,
        ),
        boxShadow: _focused
            ? <BoxShadow>[
                BoxShadow(
                  color: KtColors.primary.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : KtShadows.card,
      ),
      child: Row(
        children: <Widget>[
          Text(widget.leading, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _ctrl,
              focusNode: _node,
              obscureText: widget.obscure,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              style: const TextStyle(
                fontSize: 14,
                color: KtColors.text1,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: const TextStyle(color: KtColors.text3, fontSize: 14),
              ),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}

/// 验证码按钮（药丸样式）
class AuthCodeBtn extends StatelessWidget {
  final String text;
  final bool disabled;
  final VoidCallback? onTap;
  const AuthCodeBtn({
    super.key,
    required this.text,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: disabled ? KtColors.bg : KtColors.primaryLight,
          borderRadius: BorderRadius.circular(KtRadius.pill),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: disabled ? KtColors.text3 : KtColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

/// 主按钮 —— 红橙渐变 + 倾斜 + 右侧闪电
class AuthSubmitBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AuthSubmitBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform(
        transform: Matrix4.skewX(-2 * 3.14159 / 180),
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: KtGradients.brand,
            borderRadius: BorderRadius.circular(KtRadius.lg),
            boxShadow: KtShadows.bomb,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
              const Positioned(
                right: 2,
                child: Text(
                  '⚡',
                  style: TextStyle(fontSize: 18, color: KtColors.warning),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 同意条款行 + 协议链接
class AuthAgreeRow extends StatelessWidget {
  final bool checked;
  final VoidCallback onToggle;

  const AuthAgreeRow({super.key, required this.checked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: checked ? KtColors.primary : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: KtColors.text3, width: 1),
            ),
            alignment: Alignment.center,
            child: checked
                ? const Text('✓',
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900))
                : null,
          ),
        ),
        const SizedBox(width: 6),
        const Flexible(
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 12, color: KtColors.text3),
              children: <InlineSpan>[
                TextSpan(text: '已阅读并同意 '),
                TextSpan(text: '《用户协议》', style: TextStyle(color: KtColors.primary)),
                TextSpan(text: ' '),
                TextSpan(text: '《隐私政策》', style: TextStyle(color: KtColors.primary)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 三方登录按钮
class ThirdLoginBtn extends StatelessWidget {
  final Color bg;
  final String emoji;
  final Color fg;
  final VoidCallback? onTap;

  const ThirdLoginBtn({
    super.key,
    required this.bg,
    required this.emoji,
    this.fg = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: KtShadows.card,
        ),
        child: Text(emoji, style: TextStyle(fontSize: 24, color: fg)),
      ),
    );
  }
}
