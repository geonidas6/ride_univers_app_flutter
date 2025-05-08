import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class UpdateProfileUseCase {
  final AuthRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Either<Failure, void>> call({
    String? nom,
    String? prenoms,
    String? bio,
    String? avatar,
    String? discipline,
    String? niveau,
    String? ville,
  }) async {
    return await _repository.updateProfile(
      nom: nom,
      prenoms: prenoms,
      bio: bio,
      avatar: avatar,
      discipline: discipline,
      niveau: niveau,
      ville: ville,
    );
  }
}
