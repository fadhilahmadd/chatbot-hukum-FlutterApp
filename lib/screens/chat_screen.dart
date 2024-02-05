import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chats_provider.dart';
import '../widgets/chat_item.dart';
import '../widgets/myApp_bar.dart';
import '../widgets/text_dan_suara_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final chats = ref.watch(chatsProvider);
              // ScrollController for auto-scrolling
              final ScrollController _scrollController = ScrollController();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Scroll to the bottom after the frame has been rendered
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });
              return ListView.builder(
                controller: _scrollController,
                itemCount: chats.length,
                itemBuilder: (context, index) => ChatItem(
                  text: chats[index].message,
                  iniUser: chats[index].iniUser,
                ),
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: TextDanSuaraField(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
