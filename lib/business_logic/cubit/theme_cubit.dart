import 'package:bloc/bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.system);

  setTheme(ThemeState newstate) {
    emit(newstate);
  }

  @override
  void onChange(Change<ThemeState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
