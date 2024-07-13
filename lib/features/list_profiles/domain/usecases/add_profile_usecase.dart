import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/usecase/usecase.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';
import 'package:naruto/features/list_profiles/domain/repositories/profile_list_repo.dart';

class ProfileAddUseCase implements UseCase<void, Profile> {
  final ProfileListRepo profileListRepo;

  ProfileAddUseCase({required this.profileListRepo});
  @override
  Future<Either<Failure, void>> call(Profile profile) async {
    return await profileListRepo.addProfiles(profile);
  }
}
