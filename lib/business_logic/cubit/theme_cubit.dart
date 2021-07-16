import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.system);

  setTheme(ThemeState newstate) {
    emit(newstate);
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.values.firstWhere((e) =>
        e.toString().toLowerCase().split(".").last ==
        json["value"].toLowerCase().split(".").last);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return <String, String>{'value': state.toString()};
  }
}
