import 'package:flutter/material.dart';

class TextStyles {
  static const notifierTextLabel = TextStyle(
    fontSize: 26,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
  );
}

class MaterialTheme {
  final TextTheme textTheme = const TextTheme();

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff805610),
      surfaceTint: Color(0xff805610),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffddb4),
      onPrimaryContainer: Color(0xff291800),
      secondary: Color(0xff705b40),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffbdebc),
      onSecondaryContainer: Color(0xff271904),
      tertiary: Color(0xff52643f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd4eabb),
      onTertiaryContainer: Color(0xff102003),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f4),
      onBackground: Color(0xff211b13),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff211b13),
      surfaceVariant: Color(0xfff0e0cf),
      onSurfaceVariant: Color(0xff4f4539),
      outline: Color(0xff817567),
      outlineVariant: Color(0xffd3c4b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f27),
      inverseOnSurface: Color(0xfffcefe2),
      inversePrimary: Color(0xfff5bc6f),
      primaryFixed: Color(0xffffddb4),
      onPrimaryFixed: Color(0xff291800),
      primaryFixedDim: Color(0xfff5bc6f),
      onPrimaryFixedVariant: Color(0xff633f00),
      secondaryFixed: Color(0xfffbdebc),
      onSecondaryFixed: Color(0xff271904),
      secondaryFixedDim: Color(0xffddc2a1),
      onSecondaryFixedVariant: Color(0xff56442b),
      tertiaryFixed: Color(0xffd4eabb),
      onTertiaryFixed: Color(0xff102003),
      tertiaryFixedDim: Color(0xffb8cda1),
      onTertiaryFixedVariant: Color(0xff3a4c29),
      surfaceDim: Color(0xffe4d8cc),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e5),
      surfaceContainer: Color(0xfff9ecdf),
      surfaceContainerHigh: Color(0xfff3e6da),
      surfaceContainerHighest: Color(0xffede0d4),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff5e3c00),
      surfaceTint: Color(0xff805610),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff996c26),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff524027),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff877155),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff374826),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff677b54),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f4),
      onBackground: Color(0xff211b13),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff211b13),
      surfaceVariant: Color(0xfff0e0cf),
      onSurfaceVariant: Color(0xff4b4135),
      outline: Color(0xff685d50),
      outlineVariant: Color(0xff85796b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f27),
      inverseOnSurface: Color(0xfffcefe2),
      inversePrimary: Color(0xfff5bc6f),
      primaryFixed: Color(0xff996c26),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff7d540e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff877155),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6d583e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff677b54),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4f623d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe4d8cc),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e5),
      surfaceContainer: Color(0xfff9ecdf),
      surfaceContainerHigh: Color(0xfff3e6da),
      surfaceContainerHighest: Color(0xffede0d4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff321e00),
      surfaceTint: Color(0xff805610),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5e3c00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e1f09),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff524027),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff172608),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff374826),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f4),
      onBackground: Color(0xff211b13),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xfff0e0cf),
      onSurfaceVariant: Color(0xff2b2318),
      outline: Color(0xff4b4135),
      outlineVariant: Color(0xff4b4135),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f27),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffe9cf),
      primaryFixed: Color(0xff5e3c00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff402800),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff524027),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3a2a13),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff374826),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff213112),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe4d8cc),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e5),
      surfaceContainer: Color(0xfff9ecdf),
      surfaceContainerHigh: Color(0xfff3e6da),
      surfaceContainerHighest: Color(0xffede0d4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5bc6f),
      surfaceTint: Color(0xfff5bc6f),
      onPrimary: Color(0xff452b00),
      primaryContainer: Color(0xff633f00),
      onPrimaryContainer: Color(0xffffddb4),
      secondary: Color(0xffddc2a1),
      onSecondary: Color(0xff3e2d16),
      secondaryContainer: Color(0xff56442b),
      onSecondaryContainer: Color(0xfffbdebc),
      tertiary: Color(0xffb8cda1),
      onTertiary: Color(0xff253515),
      tertiaryContainer: Color(0xff3a4c29),
      onTertiaryContainer: Color(0xffd4eabb),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff18120b),
      onBackground: Color(0xffede0d4),
      surface: Color(0xff18120b),
      onSurface: Color(0xffede0d4),
      surfaceVariant: Color(0xff4f4539),
      onSurfaceVariant: Color(0xffd3c4b4),
      outline: Color(0xff9c8f80),
      outlineVariant: Color(0xff4f4539),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffede0d4),
      inverseOnSurface: Color(0xff362f27),
      inversePrimary: Color(0xff805610),
      primaryFixed: Color(0xffffddb4),
      onPrimaryFixed: Color(0xff291800),
      primaryFixedDim: Color(0xfff5bc6f),
      onPrimaryFixedVariant: Color(0xff633f00),
      secondaryFixed: Color(0xfffbdebc),
      onSecondaryFixed: Color(0xff271904),
      secondaryFixedDim: Color(0xffddc2a1),
      onSecondaryFixedVariant: Color(0xff56442b),
      tertiaryFixed: Color(0xffd4eabb),
      onTertiaryFixed: Color(0xff102003),
      tertiaryFixedDim: Color(0xffb8cda1),
      onTertiaryFixedVariant: Color(0xff3a4c29),
      surfaceDim: Color(0xff18120b),
      surfaceBright: Color(0xff3f3830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211b13),
      surfaceContainer: Color(0xff251f17),
      surfaceContainerHigh: Color(0xff302921),
      surfaceContainerHighest: Color(0xff3b342b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9c173),
      surfaceTint: Color(0xfff5bc6f),
      onPrimary: Color(0xff221300),
      primaryContainer: Color(0xffb98740),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe2c6a5),
      onSecondary: Color(0xff211402),
      secondaryContainer: Color(0xffa58d6f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbdd2a4),
      onTertiary: Color(0xff0b1a01),
      tertiaryContainer: Color(0xff83976e),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff18120b),
      onBackground: Color(0xffede0d4),
      surface: Color(0xff18120b),
      onSurface: Color(0xfffffaf7),
      surfaceVariant: Color(0xff4f4539),
      onSurfaceVariant: Color(0xffd7c8b8),
      outline: Color(0xffaea192),
      outlineVariant: Color(0xff8e8173),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffede0d4),
      inverseOnSurface: Color(0xff302921),
      inversePrimary: Color(0xff644000),
      primaryFixed: Color(0xffffddb4),
      onPrimaryFixed: Color(0xff1b0e00),
      primaryFixedDim: Color(0xfff5bc6f),
      onPrimaryFixedVariant: Color(0xff4d3000),
      secondaryFixed: Color(0xfffbdebc),
      onSecondaryFixed: Color(0xff1b0e00),
      secondaryFixedDim: Color(0xffddc2a1),
      onSecondaryFixedVariant: Color(0xff44331b),
      tertiaryFixed: Color(0xffd4eabb),
      onTertiaryFixed: Color(0xff071500),
      tertiaryFixedDim: Color(0xffb8cda1),
      onTertiaryFixedVariant: Color(0xff2a3b1a),
      surfaceDim: Color(0xff18120b),
      surfaceBright: Color(0xff3f3830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211b13),
      surfaceContainer: Color(0xff251f17),
      surfaceContainerHigh: Color(0xff302921),
      surfaceContainerHighest: Color(0xff3b342b),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf7),
      surfaceTint: Color(0xfff5bc6f),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xfff9c173),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe2c6a5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff3ffe1),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbdd2a4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff18120b),
      onBackground: Color(0xffede0d4),
      surface: Color(0xff18120b),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff4f4539),
      onSurfaceVariant: Color(0xfffffaf7),
      outline: Color(0xffd7c8b8),
      outlineVariant: Color(0xffd7c8b8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffede0d4),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff3d2500),
      primaryFixed: Color(0xffffe2c0),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xfff9c173),
      onPrimaryFixedVariant: Color(0xff221300),
      secondaryFixed: Color(0xffffe2c0),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe2c6a5),
      onSecondaryFixedVariant: Color(0xff211402),
      tertiaryFixed: Color(0xffd9eebf),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbdd2a4),
      onTertiaryFixedVariant: Color(0xff0b1a01),
      surfaceDim: Color(0xff18120b),
      surfaceBright: Color(0xff3f3830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211b13),
      surfaceContainer: Color(0xff251f17),
      surfaceContainerHigh: Color(0xff302921),
      surfaceContainerHighest: Color(0xff3b342b),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
