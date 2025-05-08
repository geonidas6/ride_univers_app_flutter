// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
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
      discipline: json['discipline'] as String?,
      niveau: json['niveau'] as String?,
      ville: json['ville'] as String?,
      totalDistance: (json['totalDistance'] as num).toDouble(),
      batteryLevel: (json['batteryLevel'] as num).toInt(),
      darkMode: json['darkMode'] as bool,
      settings: json['settings'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
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
      'discipline': instance.discipline,
      'niveau': instance.niveau,
      'ville': instance.ville,
      'totalDistance': instance.totalDistance,
      'batteryLevel': instance.batteryLevel,
      'darkMode': instance.darkMode,
      'settings': instance.settings,
    };
