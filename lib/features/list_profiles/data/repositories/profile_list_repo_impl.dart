import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/network/connection_checker.dart';
import 'package:naruto/features/list_profiles/data/models/profile_model.dart';
import 'package:naruto/features/list_profiles/domain/repositories/profile_list_repo.dart';

import '../../../../core/common/error/exceptions.dart';
import '../../../../core/constants/constants.dart';
import '../datasources/profile_list_remote_datasource.dart';

class ProfileListRepoImpl implements ProfileListRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ConnectionChecker connectionChecker;

  ProfileListRepoImpl(
      {required this.profileRemoteDataSource, required this.connectionChecker});
  @override
  Future<Either<Failure, List<ProfileModel>>> getProfiles() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final result = await profileRemoteDataSource.getProfiles();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on SocketException catch (e) {
      return left(Failure(e.message));
    }
  }
}
