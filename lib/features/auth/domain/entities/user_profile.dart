import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends User {
  final String? discipline;
  final String? niveau;
  final String? ville;
  final double totalDistance;
  final int batteryLevel;
  final bool darkMode;
  final Map<String, dynamic>? settings;

  const UserProfile({
    required super.id,
    required super.email,
    required super.nom,
    required super.prenoms,
    super.avatar,
    super.bio,
    required super.friends,
    required super.friendRequests,
    required super.blockedUsers,
    required super.createdAt,
    required super.updatedAt,
    this.discipline,
    this.niveau,
    this.ville,
    required this.totalDistance,
    required this.batteryLevel,
    required this.darkMode,
    this.settings,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [
        ...super.props,
        discipline,
        niveau,
        ville,
        totalDistance,
        batteryLevel,
        darkMode,
        settings,
      ];
}
