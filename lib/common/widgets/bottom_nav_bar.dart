import 'package:day_planner/features/tab_switcher/cubit/tab_switch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBottomNavBar extends StatelessWidget {
  CommonBottomNavBar({super.key});

  final Map<int, TabScreen> routes = {
    0: TabScreen.main,
    1: TabScreen.profile,
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsSwitchCubit, TabsSwitchState>(
      builder: (context, state) => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _getIndex(state),
        onTap: (index) => _navigateBetweenPages(context, index),
      ),
    );
  }

  int _getIndex(TabsSwitchState state) {
    int index = 0;
    routes.forEach((key, value) {
      if (value == state.tab) {
        index = key;
      }
    });
    return index;
  }

  void _navigateBetweenPages(BuildContext context, int index) {
    context.read<TabsSwitchCubit>().setTab(routes[index] ?? TabScreen.main);
  }
}
