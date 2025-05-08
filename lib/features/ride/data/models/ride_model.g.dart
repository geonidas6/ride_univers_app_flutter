// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RideModel _$RideModelFromJson(Map<String, dynamic> json) => RideModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      distance: (json['distance'] as num).toDouble(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      averageSpeed: (json['averageSpeed'] as num).toDouble(),
      maxSpeed: (json['maxSpeed'] as num).toDouble(),
      elevation: (json['elevation'] as num).toInt(),
      path: const LatLngListConverter().fromJson(json['path'] as List),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: $enumDecode(_$RideStatusEnumMap, json['status']),
      type: $enumDecode(_$RideTypeEnumMap, json['type']),
      difficulty: $enumDecode(_$RideDifficultyEnumMap, json['difficulty']),
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      userId: json['userId'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RideModelToJson(RideModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'distance': instance.distance,
      'duration': instance.duration.inMicroseconds,
      'averageSpeed': instance.averageSpeed,
      'maxSpeed': instance.maxSpeed,
      'elevation': instance.elevation,
      'path': const LatLngListConverter().toJson(instance.path),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': _$RideStatusEnumMap[instance.status]!,
      'type': _$RideTypeEnumMap[instance.type]!,
      'difficulty': _$RideDifficultyEnumMap[instance.difficulty]!,
      'participants': instance.participants,
      'likes': instance.likes,
      'userId': instance.userId,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$RideStatusEnumMap = {
  RideStatus.planned: 'planned',
  RideStatus.inProgress: 'inProgress',
  RideStatus.completed: 'completed',
  RideStatus.cancelled: 'cancelled',
};

const _$RideTypeEnumMap = {
  RideType.road: 'road',
  RideType.mountain: 'mountain',
  RideType.gravel: 'gravel',
  RideType.urban: 'urban',
  RideType.touring: 'touring',
};

const _$RideDifficultyEnumMap = {
  RideDifficulty.beginner: 'beginner',
  RideDifficulty.intermediate: 'intermediate',
  RideDifficulty.advanced: 'advanced',
  RideDifficulty.expert: 'expert',
};
