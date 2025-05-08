// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      id: (json['id'] as num).toInt(),
      organizerId: (json['organizerId'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      maxParticipants: (json['maxParticipants'] as num).toInt(),
      participantsCount: (json['participantsCount'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      videoUrl: json['videoUrl'] as String?,
      isJoined: json['isJoined'] as bool,
      status: json['status'] as String,
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizerId': instance.organizerId,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'maxParticipants': instance.maxParticipants,
      'participantsCount': instance.participantsCount,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'videoUrl': instance.videoUrl,
      'isJoined': instance.isJoined,
      'status': instance.status,
      'participantIds': instance.participantIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
