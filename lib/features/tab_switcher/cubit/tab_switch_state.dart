part of 'tab_switch_cubit.dart';

enum TabScreen {
  main,
  profile;

  bool get isMainTab => this == TabScreen.main;

  bool get isProfileTab => this == TabScreen.profile;
}

class TabsSwitchState {
  final TabScreen tab;

  const TabsSwitchState({required this.tab});

  @override
  String toString() {
    return 'TabsSwitchState{tab: $tab}';
  }
}
