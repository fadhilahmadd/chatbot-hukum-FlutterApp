import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_model.dart';
import '../providers/chats_provider.dart';
import '../services/ai_handler.dart';
import '../services/voice_handler.dart';
import '../widgets/toggle_button.dart';

enum InputMode {
  text,
  suara,
}

class TextDanSuaraField extends ConsumerStatefulWidget {
  const TextDanSuaraField({super.key});

  @override
  ConsumerState<TextDanSuaraField> createState() => _TextDanSuaraFieldState();
}

class _TextDanSuaraFieldState extends ConsumerState<TextDanSuaraField> {
  InputMode _inputMode = InputMode.suara;
  final _pesanController = TextEditingController();
  final AIHandler _chatbot = AIHandler();
  final VoiceHandler voiceHandler = VoiceHandler(); 
  var _isReplying = false;
  var _isListening = false;

  @override
  void initState() {
    voiceHandler.initSpeech();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sendTextMessage("Hai");
    });
  }

  @override
  void dispose() {
    _pesanController.dispose();
    // _chatbot.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _pesanController,
            onChanged: (value) {
              value.isNotEmpty
                  ? setInputMode(InputMode.text)
                  : setInputMode(InputMode.suara);
            },
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 06,
        ),
        ToggleButton(
          isListening: _isListening,
          isReplying: _isReplying,
          inputMode: _inputMode,
          kirimPesanText: () {
            final message = _pesanController.text;
            _pesanController.clear();
            sendTextMessage(message);
          },
          kirimPesanVoice: sendVoiceMessage,
        )
      ],
    );
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() async {
    if (!voiceHandler.isEnabled) {
      print('Not supported');
      return;
    }
    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setListeningState(false);
    } else {
      setListeningState(true);
      final result = await voiceHandler.startListening();
      setListeningState(false);
      sendTextMessage(result);
    }
  }

  void sendTextMessage(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.suara);
    final aiResponse = await _chatbot.getResponse(message);
    removeTyping();
    addToChatList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  void setReplyingState(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  void setListeningState(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void addToChatList(String message, bool iniUser, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: id,
      message: message,
      iniUser: iniUser,
    ));
  }
}