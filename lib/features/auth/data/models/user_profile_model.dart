import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfile {
  const UserProfileModel({
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
    super.discipline,
    super.niveau,
    super.ville,
    required super.totalDistance,
    required super.batteryLevel,
    required super.darkMode,
    super.settings,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
