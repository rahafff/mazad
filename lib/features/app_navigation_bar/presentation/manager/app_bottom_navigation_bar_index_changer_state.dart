part of 'app_bottom_navigation_bar_index_changer_cubit.dart';

class AppBottomNavigationBarIndexChangerState {
  final int screenIndex;
 const  AppBottomNavigationBarIndexChangerState({required this.screenIndex});

  AppBottomNavigationBarIndexChangerState copyWith({
    int? screenIndex,
  }) {
    return AppBottomNavigationBarIndexChangerState(
      screenIndex: screenIndex ?? this.screenIndex,
    );
  }
}
