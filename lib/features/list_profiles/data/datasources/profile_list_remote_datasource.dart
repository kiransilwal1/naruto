import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naruto/core/common/error/exceptions.dart';
import 'package:naruto/features/list_profiles/data/models/profile_model.dart';

import '../../../../core/constants/constants.dart';

abstract interface class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getProfiles();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();
  @override
  Future<List<ProfileModel>> getProfiles() async {
    try {
      final response = await http.get(Uri.parse(Constants.dataUrl));
      final profilesJson = jsonDecode(response.body);
      List<ProfileModel> profiles = [];
      for (var profile in profilesJson["characters"]) {
        profiles.add(ProfileModel.fromMap(profile));
      }
      // List<ProfileModel> profiles = (profilesJson["characters"] as List)
      //     .map((json) => ProfileModel.fromMap(json))
      //     .toList();
      return profiles;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
