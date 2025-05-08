import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String email,
    required String nom,
    required String prenoms,
    String? avatar,
    String? bio,
    required List<String> friends,
    required List<String> friendRequests,
    required List<String> blockedUsers,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          email: email,
          nom: nom,
          prenoms: prenoms,
          avatar: avatar,
          bio: bio,
          friends: friends,
          friendRequests: friendRequests,
          blockedUsers: blockedUsers,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      nom: json['nom'],
      prenoms: json['prenoms'],
      avatar: json['avatar'],
      bio: json['bio'],
      friends: List<String>.from(json['friends'] ?? []),
      friendRequests: List<String>.from(json['friend_requests'] ?? []),
      blockedUsers: List<String>.from(json['blocked_users'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nom': nom,
      'prenoms': prenoms,
      'avatar': avatar,
      'bio': bio,
      'friends': friends,
      'friend_requests': friendRequests,
      'blocked_users': blockedUsers,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      nom: user.nom,
      prenoms: user.prenoms,
      avatar: user.avatar,
      bio: user.bio,
      friends: user.friends,
      friendRequests: user.friendRequests,
      blockedUsers: user.blockedUsers,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
