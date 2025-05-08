import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend extends Equatable {
  final int id;
  final String nom;
  final String prenoms;
  final String email;
  final String? avatar;
  final String? bio;
  final String? ville;
  final String? discipline;
  final String? niveau;
  final String? telephone;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final double totalDistance;
  final int batteryLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;

  const Friend({
    required this.id,
    required this.nom,
    required this.prenoms,
    required this.email,
    this.avatar,
    this.bio,
    this.ville,
    this.discipline,
    this.niveau,
    this.telephone,
    required this.followersCount,
    required this.followingCount,
    required this.postsCount,
    required this.totalDistance,
    required this.batteryLevel,
    required this.createdAt,
    required this.updatedAt,
    this.status = 'pending',
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);

  @override
  List<Object?> get props => [
        id,
        nom,
        prenoms,
        email,
        avatar,
        bio,
        ville,
        discipline,
        niveau,
        telephone,
        followersCount,
        followingCount,
        postsCount,
        totalDistance,
        batteryLevel,
        createdAt,
        updatedAt,
        status,
      ];
}
