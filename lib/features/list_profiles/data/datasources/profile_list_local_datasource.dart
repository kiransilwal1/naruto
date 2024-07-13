import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/profile.dart';

abstract interface class ProfileLocalDatasource {
  Future<void> addProfiles(Profile profile);
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDatasourceImpl({required this.sharedPreferences});
  @override
  Future<void> addProfiles(Profile profile) {
    // TODO: implement addProfiles
    throw UnimplementedError();
  }
}
