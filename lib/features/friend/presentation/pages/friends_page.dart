import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/friend_bloc.dart';
import '../widgets/friend_list_item.dart';
import '../widgets/friend_request_list_item.dart';
import '../../../../core/presentation/widgets/error_view.dart';
import '../../../../core/presentation/widgets/loading_view.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Amis'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Mes Amis'),
              Tab(text: 'Demandes'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                // TODO: Implémenter la recherche d'amis
              },
            ),
          ],
        ),
        body: BlocBuilder<FriendBloc, FriendState>(
          builder: (context, state) {
            if (state is FriendLoading) {
              return const LoadingView();
            } else if (state is FriendError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<FriendBloc>().add(LoadFriends());
                },
              );
            } else if (state is FriendsLoaded) {
              final friends = state.friends;
              final pendingRequests =
                  friends.where((f) => f.status == 'pending').toList();
              final acceptedFriends =
                  friends.where((f) => f.status == 'accepted').toList();

              return TabBarView(
                children: [
                  // Onglet Mes Amis
                  acceptedFriends.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.people_outline,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Vous n\'avez pas encore d\'amis',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // TODO: Implémenter la recherche d'amis
                                },
                                child: const Text('Trouver des amis'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: acceptedFriends.length,
                          itemBuilder: (context, index) {
                            return FriendListItem(
                              friend: acceptedFriends[index],
                              onBlock: (friendId) {
                                context
                                    .read<FriendBloc>()
                                    .add(BlockFriend(friendId));
                              },
                            );
                          },
                        ),

                  // Onglet Demandes
                  pendingRequests.isEmpty
                      ? const Center(
                          child: Text(
                            'Aucune demande d\'ami en attente',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: pendingRequests.length,
                          itemBuilder: (context, index) {
                            return FriendRequestListItem(
                              friend: pendingRequests[index],
                              onAccept: (friendId) {
                                context
                                    .read<FriendBloc>()
                                    .add(AcceptFriendRequest(friendId));
                              },
                              onReject: (friendId) {
                                context
                                    .read<FriendBloc>()
                                    .add(RejectFriendRequest(friendId));
                              },
                            );
                          },
                        ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
