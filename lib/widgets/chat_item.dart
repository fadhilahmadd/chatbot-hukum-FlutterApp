import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String text;
  final bool iniUser;
  const ChatItem({super.key, required this.text, required this.iniUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        mainAxisAlignment:
            iniUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!iniUser) ProfileContainer(iniUser: iniUser),
          if (!iniUser) const SizedBox(width: 15),
          Container(
            padding: EdgeInsets.all(15),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.60,
            ),
            decoration: BoxDecoration(
              color: iniUser
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(iniUser ? 15 : 0),
                bottomRight: Radius.circular(iniUser ? 0 : 15),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          if (iniUser)
            const SizedBox(
              width: 15,
            ),
          if (iniUser)
            ProfileContainer(
              iniUser: iniUser,
            )
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    required this.iniUser,
  });

  final bool iniUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iniUser
            ? Theme.of(context).colorScheme.secondary
            : Colors.grey.shade800,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: Radius.circular(iniUser ? 0 : 15),
          bottomRight: Radius.circular(iniUser ? 15 : 0),
        ),
      ),
      child: Icon(
        iniUser ? Icons.person : Icons.computer,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
