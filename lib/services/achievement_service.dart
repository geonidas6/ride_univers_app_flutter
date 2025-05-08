import '../features/ride/domain/entities/ride.dart';

enum AchievementType {
  distanceTotal,
  vitesseMoyenne,
  nombreDeRides,
  deniveleTotal,
  premierRide,
  rideNocturne,
  rideLongueDistance,
  rideRapide,
}

class Achievement {
  final String id;
  final String titre;
  final String description;
  final AchievementType type;
  final int niveau;
  final bool debloque;
  final double progression;

  Achievement({
    required this.id,
    required this.titre,
    required this.description,
    required this.type,
    required this.niveau,
    this.debloque = false,
    this.progression = 0.0,
  });
}

class AchievementService {
  static List<Achievement> _achievements = [
    Achievement(
      id: 'first_ride',
      titre: 'Premier Pas',
      description: 'Complétez votre premier trajet',
      type: AchievementType.premierRide,
      niveau: 1,
    ),
    Achievement(
      id: 'distance_10',
      titre: 'Débutant de la Route',
      description: 'Parcourez 10 km au total',
      type: AchievementType.distanceTotal,
      niveau: 1,
    ),
    Achievement(
      id: 'distance_100',
      titre: 'Rouleur Confirmé',
      description: 'Parcourez 100 km au total',
      type: AchievementType.distanceTotal,
      niveau: 2,
    ),
    Achievement(
      id: 'speed_30',
      titre: 'Vitesse Éclair',
      description: 'Atteignez une vitesse moyenne de 30 km/h',
      type: AchievementType.vitesseMoyenne,
      niveau: 2,
    ),
    Achievement(
      id: 'rides_10',
      titre: 'Cycliste Régulier',
      description: 'Complétez 10 trajets',
      type: AchievementType.nombreDeRides,
      niveau: 1,
    ),
    Achievement(
      id: 'elevation_500',
      titre: 'Grimpeur',
      description: 'Accumulez 500m de dénivelé',
      type: AchievementType.deniveleTotal,
      niveau: 2,
    ),
  ];

  static List<Achievement> getAchievements() {
    return _achievements;
  }

  static void checkAchievements(List<Ride> rides) {
    double distanceTotale = 0;
    int nombreDeRides = rides.length;
    double deniveleTotal = 0;
    double vitesseMax = 0;

    for (var ride in rides) {
      distanceTotale += ride.distance;
      deniveleTotal += ride.elevation;
      if (ride.averageSpeed > vitesseMax) {
        vitesseMax = ride.averageSpeed;
      }
    }

    // Vérification des achievements
    _achievements = _achievements.map((achievement) {
      double progression = 0;
      bool debloque = false;

      switch (achievement.type) {
        case AchievementType.premierRide:
          debloque = nombreDeRides > 0;
          progression = nombreDeRides > 0 ? 1 : 0;
          break;
        case AchievementType.distanceTotal:
          if (achievement.id == 'distance_10') {
            progression = (distanceTotale / 10).clamp(0.0, 1.0);
            debloque = distanceTotale >= 10;
          } else if (achievement.id == 'distance_100') {
            progression = (distanceTotale / 100).clamp(0.0, 1.0);
            debloque = distanceTotale >= 100;
          }
          break;
        case AchievementType.vitesseMoyenne:
          progression = (vitesseMax / 30).clamp(0.0, 1.0);
          debloque = vitesseMax >= 30;
          break;
        case AchievementType.nombreDeRides:
          progression = (nombreDeRides / 10).clamp(0.0, 1.0);
          debloque = nombreDeRides >= 10;
          break;
        case AchievementType.deniveleTotal:
          progression = (deniveleTotal / 500).clamp(0.0, 1.0);
          debloque = deniveleTotal >= 500;
          break;
        default:
          break;
      }

      return Achievement(
        id: achievement.id,
        titre: achievement.titre,
        description: achievement.description,
        type: achievement.type,
        niveau: achievement.niveau,
        debloque: debloque,
        progression: progression,
      );
    }).toList();
  }

  static int getUnlockedAchievementsCount() {
    return _achievements.where((a) => a.debloque).length;
  }
}
