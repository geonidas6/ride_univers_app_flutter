import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback? onDelete;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: post.authorAvatar != null
                  ? NetworkImage(post.authorAvatar!)
                  : null,
              child: post.authorAvatar == null
                  ? Text(post.authorName[0].toUpperCase())
                  : null,
            ),
            title: Text(post.authorName),
            subtitle: Text(post.createdAt.toString()),
            trailing: onDelete != null
                ? IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: onDelete,
                  )
                : null,
          ),
          if (post.imageUrl != null)
            Image.network(
              post.imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(post.content),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('${post.likesCount} J\'aime'),
                const SizedBox(width: 16),
                Text('${post.commentsCount} Commentaires'),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: onLike,
                icon: Icon(
                  post.likedByIds.contains('currentUserId')
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: post.likedByIds.contains('currentUserId')
                      ? Colors.red
                      : null,
                ),
                label: const Text('J\'aime'),
              ),
              TextButton.icon(
                onPressed: onComment,
                icon: const Icon(Icons.comment_outlined),
                label: const Text('Commenter'),
              ),
              TextButton.icon(
                onPressed: onShare,
                icon: const Icon(Icons.share_outlined),
                label: const Text('Partager'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
