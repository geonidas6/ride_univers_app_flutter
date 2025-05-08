import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/challenge.dart';

abstract class ChallengeRepository {
  Future<Either<Failure, List<Challenge>>> getChallenges();
  Future<Either<Failure, Challenge>> getChallengeById(String id);
  Future<Either<Failure, Challenge>> createChallenge(Challenge challenge);
}
