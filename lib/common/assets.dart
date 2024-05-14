import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String credentialsDevFile = 'assets/config_dev.json';
const String credentialsProdFile = 'assets/config_production.json';
const String translationsFolderPath = 'assets/i18n';

const _images = 'assets/images';
const _svgs = 'assets/svgs';

/// Images

///Svgs
const String menuIc = '$_svgs/menu.svg';

/// Put there only needed images as it might drastically increase app size. Try to precache images once needed in different functions.
/// Precache of an image should only be called once.
Future<void> precacheImages(BuildContext context) async {
  Future.wait([]);
}

/// Source: https://github.com/dnfield/flutter_svg/issues/841#issuecomment-1416160435
Future<void> precacheSvgs() async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assets = assetManifest.listAssets();
  final svgsPaths = assets.where((path) => path.startsWith(_svgs) && path.endsWith('.svg'));

  for (final svgPath in svgsPaths) {
    final loader = SvgAssetLoader(svgPath);
    await svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}
