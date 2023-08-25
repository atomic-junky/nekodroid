/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/nekodroid_logo_accent.svg
  String get nekodroidLogoAccent => 'assets/images/nekodroid_logo_accent.svg';

  /// File path: assets/images/nekodroid_logo_app.png
  AssetGenImage get nekodroidLogoApp =>
      const AssetGenImage('assets/images/nekodroid_logo_app.png');

  /// File path: assets/images/nekodroid_logo_black.png
  AssetGenImage get nekodroidLogoBlackPng =>
      const AssetGenImage('assets/images/nekodroid_logo_black.png');

  /// File path: assets/images/nekodroid_logo_black.svg
  String get nekodroidLogoBlackSvg => 'assets/images/nekodroid_logo_black.svg';

  /// File path: assets/images/nekodroid_logo_regular.png
  AssetGenImage get nekodroidLogoRegularPng =>
      const AssetGenImage('assets/images/nekodroid_logo_regular.png');

  /// File path: assets/images/nekodroid_logo_regular.svg
  String get nekodroidLogoRegularSvg =>
      'assets/images/nekodroid_logo_regular.svg';

  /// File path: assets/images/nekodroid_logo_regular_black.svg
  String get nekodroidLogoRegularBlack =>
      'assets/images/nekodroid_logo_regular_black.svg';

  /// File path: assets/images/nekodroid_logo_white.svg
  String get nekodroidLogoWhite => 'assets/images/nekodroid_logo_white.svg';

  /// List of all assets
  List<dynamic> get values => [
        nekodroidLogoAccent,
        nekodroidLogoApp,
        nekodroidLogoBlackPng,
        nekodroidLogoBlackSvg,
        nekodroidLogoRegularPng,
        nekodroidLogoRegularSvg,
        nekodroidLogoRegularBlack,
        nekodroidLogoWhite
      ];
}

class $AssetsPlayerGen {
  const $AssetsPlayerGen();

  /// File path: assets/player/adblock.js
  String get adblock => 'assets/player/adblock.js';

  /// File path: assets/player/launch_player.js
  String get launchPlayer => 'assets/player/launch_player.js';

  /// File path: assets/player/nekosama_buttons.user.js
  String get nekosamaButtonsUser => 'assets/player/nekosama_buttons.user.js';

  /// List of all assets
  List<String> get values => [adblock, launchPlayer, nekosamaButtonsUser];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsPlayerGen player = $AssetsPlayerGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
