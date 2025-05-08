import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/message_bloc.dart';
import '../widgets/conversation_list_item.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../../../core/presentation/widgets/loading_view.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implémenter la recherche de conversations
            },
          ),
        ],
      ),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return const LoadingView();
          } else if (state is MessageError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<MessageBloc>().add(LoadConversations());
              },
            );
          } else if (state is ConversationsLoaded) {
            final conversations = state.conversations;
            if (conversations.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.message_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Aucune conversation',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Naviguer vers la recherche d'amis
                      },
                      child: const Text('Démarrer une conversation'),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationListItem(
                  conversation: conversation,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {
                        'userId': conversation.senderId == 'currentUserId'
                            ? conversation.receiverId
                            : conversation.senderId,
                      },
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Naviguer vers la recherche d'amis
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
