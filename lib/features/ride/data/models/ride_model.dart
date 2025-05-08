import 'package:latlong2/latlong.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ride.dart';
import '../../../../core/utils/json_converters.dart';

part 'ride_model.g.dart';

@JsonSerializable()
class RideModel extends Ride {
  const RideModel({
    required String id,
    required String title,
    required String description,
    required double distance,
    required Duration duration,
    required double averageSpeed,
    required double maxSpeed,
    required int elevation,
    @LatLngListConverter() required List<LatLng> path,
    required DateTime startTime,
    DateTime? endTime,
    required RideStatus status,
    required RideType type,
    required RideDifficulty difficulty,
    List<String> participants = const [],
    int likes = 0,
    required String userId,
    String? imageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          distance: distance,
          duration: duration,
          averageSpeed: averageSpeed,
          maxSpeed: maxSpeed,
          elevation: elevation,
          path: path,
          startTime: startTime,
          endTime: endTime,
          status: status,
          type: type,
          difficulty: difficulty,
          participants: participants,
          likes: likes,
          userId: userId,
          imageUrl: imageUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory RideModel.fromJson(Map<String, dynamic> json) =>
      _$RideModelFromJson(json);

  Map<String, dynamic> toJson() => _$RideModelToJson(this);

  factory RideModel.fromEntity(Ride ride) {
    return RideModel(
      id: ride.id,
      title: ride.title,
      description: ride.description,
      distance: ride.distance,
      duration: ride.duration,
      averageSpeed: ride.averageSpeed,
      maxSpeed: ride.maxSpeed,
      elevation: ride.elevation,
      path: ride.path,
      startTime: ride.startTime,
      endTime: ride.endTime,
      status: ride.status,
      type: ride.type,
      difficulty: ride.difficulty,
      participants: ride.participants,
      likes: ride.likes,
      userId: ride.userId,
      imageUrl: ride.imageUrl,
      createdAt: ride.createdAt,
      updatedAt: ride.updatedAt,
    );
  }

  Ride toEntity() => this;
}
