import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';

import '../entities/profile.dart';

abstract interface class ProfileListRepo {
  Future<Either<Failure, List<Profile>>> getProfiles();
  Future<Either<Failure, void>> addProfiles();
}
