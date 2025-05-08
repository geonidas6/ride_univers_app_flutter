import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String email;
  final String nom;
  final String prenoms;
  final String? avatar;
  final String? bio;
  final List<String> friends;
  final List<String> friendRequests;
  final List<String> blockedUsers;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.nom,
    required this.prenoms,
    this.avatar,
    this.bio,
    required this.friends,
    required this.friendRequests,
    required this.blockedUsers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        nom,
        prenoms,
        avatar,
        bio,
        friends,
        friendRequests,
        blockedUsers,
        createdAt,
        updatedAt,
      ];
}
