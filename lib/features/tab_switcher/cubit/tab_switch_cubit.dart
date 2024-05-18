import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_switch_state.dart';

class TabsSwitchCubit extends Cubit<TabsSwitchState> {
  TabsSwitchCubit() : super(const TabsSwitchState(tab: TabScreen.main));

  void setTab(TabScreen tab) {
    if (state.tab != tab) {
      emit(TabsSwitchState(tab: tab));
    }
  }
}
