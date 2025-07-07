import 'package:equatable/equatable.dart';

class ThemeConfigurationEntity extends Equatable{
  final ThemeEntity? dark;
  final ThemeEntity? light;

  const ThemeConfigurationEntity({
    this.dark,
    this.light,
  });

  @override
  List<Object?> get props => [dark, light];

  @override
  bool? get stringify => true;

}
/// Entity for a Theme
class ThemeEntity extends Equatable {
  final String? name;
  final String? prefix;
  final String? font;
  final Map<String, String>? colors;

  const ThemeEntity({
    required this.name,
    required this.prefix,
    required this.font,
    required this.colors,
  });

  @override
  List<Object?> get props => [
    name,
    prefix,
    font,
    colors,
  ];

  @override
  bool? get stringify => true;
}