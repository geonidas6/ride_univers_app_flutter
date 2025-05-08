import 'package:equatable/equatable.dart';

class Challenge extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String objectiveType;
  final double objectiveValue;
  final String creatorId;

  const Challenge({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.objectiveType,
    required this.objectiveValue,
    required this.creatorId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        objectiveType,
        objectiveValue,
        creatorId,
      ];

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      objectiveType: json['objective_type'] as String,
      objectiveValue: json['objective_value'] as double,
      creatorId: json['creator_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'objective_type': objectiveType,
      'objective_value': objectiveValue,
      'creator_id': creatorId,
    };
  }
}
