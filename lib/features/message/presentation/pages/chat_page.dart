import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/message_bloc.dart';
import '../widgets/message_bubble.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../../../core/presentation/widgets/loading_view.dart';

class ChatPage extends StatefulWidget {
  final String userId;

  const ChatPage({
    super.key,
    required this.userId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(LoadMessages(widget.userId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      context.read<MessageBloc>().add(
            SendMessage(
              receiverId: widget.userId,
              messageText: messageText,
              messageType: 'text',
            ),
          );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.userId), // TODO: Remplacer par le nom de l'utilisateur
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Afficher les options de conversation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessageBloc, MessageState>(
              listener: (context, state) {
                if (state is MessageSent) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
              builder: (context, state) {
                if (state is MessageLoading) {
                  return const LoadingView();
                } else if (state is MessageError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () {
                      context
                          .read<MessageBloc>()
                          .add(LoadMessages(widget.userId));
                    },
                  );
                } else if (state is MessagesLoaded) {
                  final messages = state.messages;
                  if (messages.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucun message',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == 'currentUserId';
                      return MessageBubble(
                        message: message,
                        isMe: isMe,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      // TODO: Implémenter l'envoi de fichiers
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Votre message...',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
