import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament.g.dart';

@JsonSerializable()
class Tournament extends Equatable {
  final int id;
  final int organizerId;
  final String? title;
  final String? description;
  final DateTime date;
  final int maxParticipants;
  final int participantsCount;
  final double latitude;
  final double longitude;
  final String? videoUrl;
  final bool isJoined;
  final String status;
  final List<String> participantIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tournament({
    required this.id,
    required this.organizerId,
    required this.title,
    required this.description,
    required this.date,
    required this.maxParticipants,
    required this.participantsCount,
    required this.latitude,
    required this.longitude,
    this.videoUrl,
    required this.isJoined,
    required this.status,
    required this.participantIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentToJson(this);

  @override
  List<Object?> get props => [
        id,
        organizerId,
        title,
        description,
        date,
        maxParticipants,
        participantsCount,
        latitude,
        longitude,
        videoUrl,
        isJoined,
        status,
        participantIds,
        createdAt,
        updatedAt,
      ];
}
