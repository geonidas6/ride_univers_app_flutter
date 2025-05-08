import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final String location;
  final String type;
  final String creatorId;
  final List<String> participantIds;

  const Event({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.location,
    required this.type,
    required this.creatorId,
    this.participantIds = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        location,
        type,
        creatorId,
        participantIds,
      ];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      type: json['type'] as String,
      creatorId: json['creator_id'] as String,
      participantIds: (json['participant_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'type': type,
      'creator_id': creatorId,
      'participant_ids': participantIds,
    };
  }
}
