import 'package:equatable/equatable.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';

class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ThemeChangeEvent extends ThemeEvent {
  ThemeChangeEvent({required this.themeType}) : super() {
    PrefUtils().setThemData(themeType);
  }

  final String themeType;

  @override
  List<Object?> get props => [];
}
