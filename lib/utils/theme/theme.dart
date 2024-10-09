import "package:flutter/material.dart";

class MaterialTheme {
  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff003f99),
      surfaceTint: Color(0xff1959c4),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2a63ce),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff4d5d87),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc6d4ff),
      onSecondaryContainer: Color(0xff2e3f66),
      tertiary: Color(0xff6c1d86),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9446ad),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff191b22),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff191b22),
      surfaceVariant: Color(0xffdfe2f2),
      onSurfaceVariant: Color(0xff434653),
      outline: Color(0xff737784),
      outlineVariant: Color(0xffc3c6d5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3037),
      inverseOnSurface: Color(0xfff0f0fa),
      inversePrimary: Color(0xffb0c6ff),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff001946),
      primaryFixedDim: Color(0xffb0c6ff),
      onPrimaryFixedVariant: Color(0xff00419d),
      secondaryFixed: Color(0xffd9e2ff),
      onSecondaryFixed: Color(0xff051a40),
      secondaryFixedDim: Color(0xffb5c6f6),
      onSecondaryFixedVariant: Color(0xff35466e),
      tertiaryFixed: Color(0xfffbd7ff),
      onTertiaryFixed: Color(0xff330044),
      tertiaryFixedDim: Color(0xfff0b0ff),
      onTertiaryFixedVariant: Color(0xff6f2089),
      surfaceDim: Color(0xffd9d9e3),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fc),
      surfaceContainer: Color(0xffededf7),
      surfaceContainerHigh: Color(0xffe7e7f1),
      surfaceContainerHighest: Color(0xffe1e2eb),
    );
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb0c6ff),
      surfaceTint: Color(0xffb0c6ff),
      onPrimary: Color(0xff002c70),
      primaryContainer: Color(0xff0049ae),
      onPrimaryContainer: Color(0xffebeeff),
      secondary: Color(0xffb5c6f6),
      onSecondary: Color(0xff1e2f56),
      secondaryContainer: Color(0xff2e3f67),
      onSecondaryContainer: Color(0xffc5d4ff),
      tertiary: Color(0xfff0b0ff),
      onTertiary: Color(0xff54006d),
      tertiaryContainer: Color(0xff7a2c93),
      onTertiaryContainer: Color(0xffffeaff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff11131a),
      onBackground: Color(0xffe1e2eb),
      surface: Color(0xff11131a),
      onSurface: Color(0xffe1e2eb),
      surfaceVariant: Color(0xff434653),
      onSurfaceVariant: Color(0xffc3c6d5),
      outline: Color(0xff8d909f),
      outlineVariant: Color(0xff434653),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2eb),
      inverseOnSurface: Color(0xff2e3037),
      inversePrimary: Color(0xff1959c4),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff001946),
      primaryFixedDim: Color(0xffb0c6ff),
      onPrimaryFixedVariant: Color(0xff00419d),
      secondaryFixed: Color(0xffd9e2ff),
      onSecondaryFixed: Color(0xff051a40),
      secondaryFixedDim: Color(0xffb5c6f6),
      onSecondaryFixedVariant: Color(0xff35466e),
      tertiaryFixed: Color(0xfffbd7ff),
      onTertiaryFixed: Color(0xff330044),
      tertiaryFixedDim: Color(0xfff0b0ff),
      onTertiaryFixedVariant: Color(0xff6f2089),
      surfaceDim: Color(0xff11131a),
      surfaceBright: Color(0xff373940),
      surfaceContainerLowest: Color(0xff0c0e14),
      surfaceContainerLow: Color(0xff191b22),
      surfaceContainer: Color(0xff1d1f26),
      surfaceContainerHigh: Color(0xff282a31),
      surfaceContainerHighest: Color(0xff33343c),
    );
  }
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
      surfaceTint: surfaceTint,
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
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      inversePrimary: inversePrimary,
      primaryFixed: primaryFixed,
      onPrimaryFixed: onPrimaryFixed,
      primaryFixedDim: primaryFixedDim,
      onPrimaryFixedVariant: onPrimaryFixedVariant,
      secondaryFixed: secondaryFixed,
      onSecondaryFixed: onSecondaryFixed,
      secondaryFixedDim: secondaryFixedDim,
      onSecondaryFixedVariant: onSecondaryFixedVariant,
      tertiaryFixed: tertiaryFixed,
      onTertiaryFixed: onTertiaryFixed,
      tertiaryFixedDim: tertiaryFixedDim,
      onTertiaryFixedVariant: onTertiaryFixedVariant,
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
    );
  }
}
