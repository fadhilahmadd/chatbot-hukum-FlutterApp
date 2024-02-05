import 'package:flutter_riverpod/flutter_riverpod.dart';

final temaAktifProvider = StateProvider<Themes>(
  (ref) => Themes.dark,
);

enum Themes {
  dark,
  light,
}
