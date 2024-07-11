import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/usecase/usecase.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';
import 'package:naruto/features/list_profiles/domain/repositories/profile_list_repo.dart';

class ProfileListUseCase implements UseCase<List<Profile>, NoParams> {
  final ProfileListRepo profileListRepo;

  ProfileListUseCase({required this.profileListRepo});
  @override
  Future<Either<Failure, List<Profile>>> call(NoParams params) async {
    return await profileListRepo.getProfiles();
  }
}
