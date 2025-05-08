import 'package:flutter/material.dart';
import '../../domain/entities/conversation.dart';

class ConversationListItem extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationListItem({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(conversation.name),
      subtitle: Text(conversation.lastMessage),
      trailing: Text(
        conversation.lastMessageTime.toString(),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: onTap,
    );
  }
}
