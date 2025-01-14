import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeType});

  final String themeType;

  @override
  List<Object?> get props => [themeType];
  ThemeState copyWith({String? themeType}) {
    return ThemeState(themeType: themeType ?? this.themeType);
  }
}
