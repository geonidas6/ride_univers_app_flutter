// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      id: (json['id'] as num).toInt(),
      nom: json['nom'] as String,
      prenoms: json['prenoms'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      ville: json['ville'] as String?,
      discipline: json['discipline'] as String?,
      niveau: json['niveau'] as String?,
      telephone: json['telephone'] as String?,
      followersCount: (json['followersCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
      postsCount: (json['postsCount'] as num).toInt(),
      totalDistance: (json['totalDistance'] as num).toDouble(),
      batteryLevel: (json['batteryLevel'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as String? ?? 'pending',
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenoms': instance.prenoms,
      'email': instance.email,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'ville': instance.ville,
      'discipline': instance.discipline,
      'niveau': instance.niveau,
      'telephone': instance.telephone,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'postsCount': instance.postsCount,
      'totalDistance': instance.totalDistance,
      'batteryLevel': instance.batteryLevel,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'status': instance.status,
    };
