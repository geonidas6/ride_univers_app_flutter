// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String,
      nom: json['nom'] as String,
      prenoms: json['prenoms'] as String,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      friendRequests: (json['friendRequests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      blockedUsers: (json['blockedUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nom': instance.nom,
      'prenoms': instance.prenoms,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'friends': instance.friends,
      'friendRequests': instance.friendRequests,
      'blockedUsers': instance.blockedUsers,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
