import 'package:flutter/material.dart';
import '../../domain/entities/friend.dart';

class FriendRequestListItem extends StatelessWidget {
  final Friend friend;
  final Function(int) onAccept;
  final Function(int) onReject;

  const FriendRequestListItem({
    super.key,
    required this.friend,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(friend.nom[0].toUpperCase()),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${friend.nom} ${friend.prenoms}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Demande envoyée le ${friend.createdAt.toLocal().toString().split(' ')[0]}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => onReject(friend.id),
                  child: const Text('Refuser'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => onAccept(friend.id),
                  child: const Text('Accepter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
