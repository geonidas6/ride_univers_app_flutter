import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../widgets/post_card.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../../../core/presentation/widgets/loading_view.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(LoadPosts());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fil d\'actualité'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implémenter le filtrage des posts
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PostBloc>().add(LoadPosts());
        },
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const LoadingView();
            } else if (state is PostError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<PostBloc>().add(LoadPosts());
                },
              );
            } else if (state is PostsLoaded) {
              final posts = state.posts;
              if (posts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.article_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Aucun post à afficher',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/create-post');
                        },
                        child: const Text('Créer un post'),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(
                    post: post,
                    onLike: () {
                      if (post.likedByIds.contains('currentUserId')) {
                        context.read<PostBloc>().add(UnlikePost(post.id));
                      } else {
                        context.read<PostBloc>().add(LikePost(post.id));
                      }
                    },
                    onComment: () {
                      // TODO: Naviguer vers la page des commentaires
                    },
                    onShare: () {
                      // TODO: Implémenter le partage de post
                    },
                    onDelete: post.authorId == 'currentUserId'
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Supprimer le post ?'),
                                content: const Text(
                                  'Cette action est irréversible.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<PostBloc>()
                                          .add(DeletePost(post.id));
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Supprimer',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        : null,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
