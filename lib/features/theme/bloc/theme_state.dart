part of 'theme_bloc.dart';

extension BrightnessThemeModeExt on ThemeMode {
  bool get isSystem => this == ThemeMode.system;

  bool get isLight => this == ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;
}

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.system});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  factory ThemeState.initial() {
    return const ThemeState();
  }

  ThemeData getThemeData(Brightness platformBrightness) {
    switch (themeMode) {
      case ThemeMode.light:
        return MaterialTheme().light();
      case ThemeMode.dark:
        return MaterialTheme().dark();
      case ThemeMode.system:
        return platformBrightness == Brightness.dark ? MaterialTheme().dark() : MaterialTheme().light();
    }
  }

  @override
  List<Object> get props => [themeMode];
}
