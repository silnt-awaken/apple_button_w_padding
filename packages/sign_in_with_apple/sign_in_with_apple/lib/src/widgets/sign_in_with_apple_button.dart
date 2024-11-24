import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/src/widgets/apple_logo_painter.dart';

/// The scale based on the height of the button
const _appleIconSizeScale = 28 / 44;

/// A `Sign in with Apple` button according to the Apple Guidelines.
///
/// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
class SignInWithAppleButton extends StatelessWidget {
  const SignInWithAppleButton({
    super.key,
    required this.onPressed,
    this.text = 'Sign in with Apple',
    this.height = 44,
    this.style = SignInWithAppleButtonStyle.black,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.iconAlignment = IconAlignment.center,
    this.verticalPadding = 8.0, // Default vertical padding
  });

  final VoidCallback onPressed;
  final String text;
  final double height;
  final SignInWithAppleButtonStyle style;
  final BorderRadius borderRadius;
  final IconAlignment iconAlignment;
  final double verticalPadding;

  Color get _backgroundColor {
    switch (style) {
      case SignInWithAppleButtonStyle.black:
        return Colors.black;
      case SignInWithAppleButtonStyle.white:
      case SignInWithAppleButtonStyle.whiteOutlined:
        return Colors.white;
    }
  }

  Color get _contrastColor {
    switch (style) {
      case SignInWithAppleButtonStyle.black:
        return Colors.white;
      case SignInWithAppleButtonStyle.white:
      case SignInWithAppleButtonStyle.whiteOutlined:
        return Colors.black;
    }
  }

  Decoration? get _decoration {
    switch (style) {
      case SignInWithAppleButtonStyle.black:
      case SignInWithAppleButtonStyle.white:
        return null;

      case SignInWithAppleButtonStyle.whiteOutlined:
        return BoxDecoration(
          border: Border.all(width: 1, color: _contrastColor),
          borderRadius: borderRadius,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = height * 0.43;

    final textWidget = Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        inherit: false,
        fontSize: fontSize,
        color: _contrastColor,
        fontFamily: '.SF Pro Text',
        letterSpacing: -0.41,
      ),
    );

    final appleIcon = Container(
      width: _appleIconSizeScale * height,
      height: _appleIconSizeScale * height + 2,
      padding: EdgeInsets.only(
        bottom: (4 / 44) * height,
      ),
      child: Center(
        child: SizedBox(
          width: fontSize * (25 / 31),
          height: fontSize,
          child: CustomPaint(
            painter: AppleLogoPainter(
              color: _contrastColor,
            ),
          ),
        ),
      ),
    );

    var children = <Widget>[];

    switch (iconAlignment) {
      case IconAlignment.center:
        children = [
          appleIcon,
          Flexible(
            child: textWidget,
          ),
        ];
        break;
      case IconAlignment.left:
        children = [
          appleIcon,
          Expanded(
            child: textWidget,
          ),
          SizedBox(
            width: _appleIconSizeScale * height,
          ),
        ];
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: SizedBox(
        height:
            height + verticalPadding * 2, // Adjust height to include padding
        child: CupertinoButton(
          borderRadius: borderRadius,
          padding: EdgeInsets.zero,
          color: _backgroundColor,
          onPressed: onPressed,
          child: Container(
            decoration: _decoration,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            height: height, // Keep original height for inner content
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

/// The style of the button according to Apple's documentation.
///
/// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
enum SignInWithAppleButtonStyle {
  /// A black button with white text and white icon
  ///
  /// ![Black Button](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/black_button.png)
  black,

  /// A white button with black text and black icon
  ///
  /// ![White Button](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/white_button.png)
  white,

  /// A white button which has a black outline
  ///
  /// ![White Outline Button](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/white_outlined_button.png)
  whiteOutlined,
}

/// This controls the alignment of the Apple Logo on the [SignInWithAppleButton]
enum IconAlignment {
  /// The icon will be centered together with the text
  ///
  /// ![Center Icon Alignment](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/center_aligned_icon.png)
  center,

  /// The icon will be on the left side, while the text will be centered accordingly
  ///
  /// ![Left Icon Alignment](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/left_aligned_icon.png)
  left,
}
