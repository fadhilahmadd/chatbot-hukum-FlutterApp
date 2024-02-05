import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tema_aktif_provider.dart';

class GantiTema extends ConsumerStatefulWidget {
  const GantiTema({super.key});

  @override
  ConsumerState<GantiTema> createState() => _GantiTemaState();
}

class _GantiTemaState extends ConsumerState<GantiTema> {
  void tombolTema(bool value) {
    ref.read(temaAktifProvider.notifier).state =
        value ? Themes.dark : Themes.light;
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: ref.watch(temaAktifProvider) == Themes.dark,
      onChanged: tombolTema,
    );
  }
}
