import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3d6838),
      surfaceTint: Color(0xff3d6838),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbef0b2),
      onPrimaryContainer: Color(0xff265022),
      secondary: Color(0xff3d6838),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffbdf0b3),
      onSecondaryContainer: Color(0xff255023),
      tertiary: Color(0xff855318),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdcbd),
      onTertiaryContainer: Color(0xff693c00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      onSurfaceVariant: Color(0xff42493f),
      outline: Color(0xff73796f),
      outlineVariant: Color(0xffc2c8bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322b),
      inversePrimary: Color(0xffa3d398),
      primaryFixed: Color(0xffbef0b2),
      onPrimaryFixed: Color(0xff002202),
      primaryFixedDim: Color(0xffa3d398),
      onPrimaryFixedVariant: Color(0xff265022),
      secondaryFixed: Color(0xffbdf0b3),
      onSecondaryFixed: Color(0xff002203),
      secondaryFixedDim: Color(0xffa2d398),
      onSecondaryFixedVariant: Color(0xff255023),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff2c1600),
      tertiaryFixedDim: Color(0xfffcb975),
      onTertiaryFixedVariant: Color(0xff693c00),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4da),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff143e13),
      surfaceTint: Color(0xff3d6838),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4c7745),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff133f13),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4b7846),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff522e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff966125),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff0e120d),
      onSurfaceVariant: Color(0xff32382f),
      outline: Color(0xff4e544b),
      outlineVariant: Color(0xff696f65),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322b),
      inversePrimary: Color(0xffa3d398),
      primaryFixed: Color(0xff4c7745),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff345e2f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4b7846),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff335e30),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff966125),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff7a4a0e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c8bf),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffe6e9e0),
      surfaceContainerHigh: Color(0xffdbded5),
      surfaceContainerHighest: Color(0xffcfd3ca),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff083409),
      surfaceTint: Color(0xff3d6838),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff285224),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff07340a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff275225),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff442500),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c3e02),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282e26),
      outlineVariant: Color(0xff454b42),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322b),
      inversePrimary: Color(0xffa3d398),
      primaryFixed: Color(0xff285224),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff103b10),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff275225),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff0f3b10),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c3e02),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4d2a00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6bab1),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff2e8),
      surfaceContainer: Color(0xffe0e4da),
      surfaceContainerHigh: Color(0xffd2d6cc),
      surfaceContainerHighest: Color(0xffc4c8bf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa3d398),
      surfaceTint: Color(0xffa3d398),
      onPrimary: Color(0xff0e380d),
      primaryContainer: Color(0xff265022),
      onPrimaryContainer: Color(0xffbef0b2),
      secondary: Color(0xffa2d398),
      onSecondary: Color(0xff0c390e),
      secondaryContainer: Color(0xff255023),
      onSecondaryContainer: Color(0xffbdf0b3),
      tertiary: Color(0xfffcb975),
      onTertiary: Color(0xff4a2800),
      tertiaryContainer: Color(0xff693c00),
      onTertiaryContainer: Color(0xffffdcbd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10140f),
      onSurface: Color(0xffe0e4da),
      onSurfaceVariant: Color(0xffc2c8bc),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff42493f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inversePrimary: Color(0xff3d6838),
      primaryFixed: Color(0xffbef0b2),
      onPrimaryFixed: Color(0xff002202),
      primaryFixedDim: Color(0xffa3d398),
      onPrimaryFixedVariant: Color(0xff265022),
      secondaryFixed: Color(0xffbdf0b3),
      onSecondaryFixed: Color(0xff002203),
      secondaryFixedDim: Color(0xffa2d398),
      onSecondaryFixedVariant: Color(0xff255023),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff2c1600),
      tertiaryFixedDim: Color(0xfffcb975),
      onTertiaryFixedVariant: Color(0xff693c00),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb8e9ac),
      surfaceTint: Color(0xffa3d398),
      onPrimary: Color(0xff012d04),
      primaryContainer: Color(0xff6e9c66),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb7eaad),
      onSecondary: Color(0xff002d04),
      secondaryContainer: Color(0xff6e9c67),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd5ad),
      onTertiary: Color(0xff3a1f00),
      tertiaryContainer: Color(0xffbf8445),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8ded2),
      outline: Color(0xffaeb4a8),
      outlineVariant: Color(0xff8c9287),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inversePrimary: Color(0xff275123),
      primaryFixed: Color(0xffbef0b2),
      onPrimaryFixed: Color(0xff001601),
      primaryFixedDim: Color(0xffa3d398),
      onPrimaryFixedVariant: Color(0xff143e13),
      secondaryFixed: Color(0xffbdf0b3),
      onSecondaryFixed: Color(0xff001601),
      secondaryFixedDim: Color(0xffa2d398),
      onSecondaryFixedVariant: Color(0xff133f13),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff1e0d00),
      tertiaryFixedDim: Color(0xfffcb975),
      onTertiaryFixedVariant: Color(0xff522e00),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff42463f),
      surfaceContainerLowest: Color(0xff050805),
      surfaceContainerLow: Color(0xff1b1f19),
      surfaceContainer: Color(0xff252923),
      surfaceContainerHigh: Color(0xff30342d),
      surfaceContainerHighest: Color(0xff3b3f38),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbfdbf),
      surfaceTint: Color(0xffa3d398),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9fcf94),
      onPrimaryContainer: Color(0xff000f01),
      secondary: Color(0xffcbfebf),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9ecf95),
      onSecondaryContainer: Color(0xff000f01),
      tertiary: Color(0xffffeddf),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff8b571),
      onTertiaryContainer: Color(0xff150800),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf2e5),
      outlineVariant: Color(0xffbec5b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inversePrimary: Color(0xff275123),
      primaryFixed: Color(0xffbef0b2),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa3d398),
      onPrimaryFixedVariant: Color(0xff001601),
      secondaryFixed: Color(0xffbdf0b3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffa2d398),
      onSecondaryFixedVariant: Color(0xff001601),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfffcb975),
      onTertiaryFixedVariant: Color(0xff1e0d00),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff4d514a),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d211b),
      surfaceContainer: Color(0xff2d322b),
      surfaceContainerHigh: Color(0xff383d36),
      surfaceContainerHighest: Color(0xff444841),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
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
