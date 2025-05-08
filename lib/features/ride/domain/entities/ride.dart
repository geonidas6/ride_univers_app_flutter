import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/json_converters.dart';

part 'ride.g.dart';

@JsonSerializable()
class Ride extends Equatable {
  final String id;
  final String title;
  final String description;
  final double distance;
  final Duration duration;
  final double averageSpeed;
  final double maxSpeed;
  final int elevation;
  final List<latlong.LatLng> path;
  final DateTime startTime;
  final DateTime? endTime;
  final RideStatus status;
  final RideType type;
  final RideDifficulty difficulty;
  final List<String> participants;
  final int likes;
  final String userId;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Ride({
    required this.id,
    required this.title,
    required this.description,
    required this.distance,
    required this.duration,
    required this.averageSpeed,
    required this.maxSpeed,
    required this.elevation,
    required this.path,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.type,
    required this.difficulty,
    this.participants = const [],
    this.likes = 0,
    required this.userId,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

  Map<String, dynamic> toJson() => _$RideToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        distance,
        duration,
        averageSpeed,
        maxSpeed,
        elevation,
        path,
        startTime,
        endTime,
        status,
        type,
        difficulty,
        participants,
        likes,
        userId,
        imageUrl,
        createdAt,
        updatedAt,
      ];

  Ride copyWith({
    String? id,
    String? title,
    String? description,
    double? distance,
    Duration? duration,
    double? averageSpeed,
    double? maxSpeed,
    int? elevation,
    List<latlong.LatLng>? path,
    DateTime? startTime,
    DateTime? endTime,
    RideStatus? status,
    RideType? type,
    RideDifficulty? difficulty,
    List<String>? participants,
    int? likes,
    String? userId,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ride(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      elevation: elevation ?? this.elevation,
      path: path ?? this.path,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      participants: participants ?? this.participants,
      likes: likes ?? this.likes,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum RideType { road, mountain, gravel, urban, touring }

enum RideDifficulty { beginner, intermediate, advanced, expert }

enum RideStatus { planned, inProgress, completed, cancelled }
