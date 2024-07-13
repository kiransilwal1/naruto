import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/network/connection_checker.dart';
import 'package:naruto/features/list_profiles/data/datasources/profile_list_local_datasource.dart';
import 'package:naruto/features/list_profiles/data/models/profile_model.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';
import 'package:naruto/features/list_profiles/domain/repositories/profile_list_repo.dart';

import '../../../../core/common/error/exceptions.dart';
import '../../../../core/constants/constants.dart';
import '../datasources/profile_list_remote_datasource.dart';

class ProfileListRepoImpl implements ProfileListRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final ProfileLocalDatasource profileLocalDatasource;

  ProfileListRepoImpl(
      {required this.profileRemoteDataSource,
      required this.connectionChecker,
      required this.profileLocalDatasource});
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

  @override
  Future<Either<Failure, void>> addProfiles(Profile profile) async {
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
