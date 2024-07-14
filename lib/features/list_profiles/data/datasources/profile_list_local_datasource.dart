import 'dart:convert';

import 'package:naruto/core/common/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

abstract interface class ProfileLocalDatasource {
  Future<void> addProfiles(ProfileModel profile);
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final SharedPreferences sharedPreferences;

  ProfileLocalDatasourceImpl({required this.sharedPreferences});
  @override
  Future<void> addProfiles(ProfileModel profile) async {
    try {
      const String profilesKey = 'profiles';
      // sharedPreferences.clear();

      final String? jsonString = sharedPreferences.getString(profilesKey);

      List<ProfileModel> profiles = [];

      if (jsonString != null) {
        List<dynamic> jsonList = json.decode(jsonString);

        profiles = jsonList.map((json) => ProfileModel.fromJson(json)).toList();
      }

      profiles.add(profile);
      final profileEncoded = profile.toJson();
      print(profileEncoded);
      String updatedJsonString =
          json.encode(profiles.map((profile) => profile.toJson()).toList());

      // Save the updated list back to SharedPreferences
      await sharedPreferences.setString(profilesKey, updatedJsonString);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
