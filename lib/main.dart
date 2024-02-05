import 'package:flutter/material.dart';
import 'providers/tema_aktif_provider.dart';
import 'constants/tema.dart';
import 'screens/chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temaAktif = ref.watch(temaAktifProvider);
    return MaterialApp(
      theme: modeSiang,
      darkTheme: modeMalam,
      debugShowCheckedModeBanner: false,
      themeMode: temaAktif == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: const ChatScreen(),
    );
  }
}
