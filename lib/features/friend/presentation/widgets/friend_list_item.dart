import 'package:flutter/material.dart';
import '../../domain/entities/friend.dart';

class FriendListItem extends StatelessWidget {
  final Friend friend;
  final Function(int) onBlock;

  const FriendListItem({
    super.key,
    required this.friend,
    required this.onBlock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(friend.nom[0].toUpperCase()),
        ),
        title: Text('${friend.nom} ${friend.prenoms}'),
        subtitle: Text(
          'Ami depuis le ${friend.createdAt.toLocal().toString().split(' ')[0]}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'block') {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Bloquer cet ami ?'),
                  content: const Text(
                    'Cette personne ne pourra plus voir votre profil ni interagir avec vous.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () {
                        onBlock(friend.id);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Bloquer',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'block',
              child: Row(
                children: [
                  Icon(Icons.block, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Bloquer'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Naviguer vers le profil de l'ami
        },
      ),
    );
  }
}
