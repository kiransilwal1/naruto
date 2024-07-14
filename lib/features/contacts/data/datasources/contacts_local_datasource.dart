import 'dart:convert';

import 'package:naruto/features/list_profiles/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/common/error/exceptions.dart';
import '../../../../core/constants/constants.dart';
import 'package:http/http.dart' as http;

abstract interface class ContactsLocalDatasource {
  Future<List<ProfileModel>> loadContacts();
  Future<ProfileModel> getContactById(String id);
}

class ContactsLocalDataSourceImpl implements ContactsLocalDatasource {
  final SharedPreferences sharedPreferences;

  ContactsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<ProfileModel>> loadContacts() async {
    try {
      final String contactsKey = 'profiles';

      final String? jsonString = sharedPreferences.getString(contactsKey);

      if (jsonString == null) {
        return [];
      }
      List<dynamic> jsonList = json.decode(jsonString);
      List<ProfileModel> contacts =
          jsonList.map((json) => ProfileModel.fromJson(json)).toList();

      return contacts;
    } catch (e) {
      throw Exception("Failed to load contacts: ${e.toString()}");
    }
  }

  @override
  Future<ProfileModel> getContactById(String id) async {
    try {
      final response = await http.get(Uri.parse('${Constants.dataById}$id'));
      final profilesJson = jsonDecode(response.body);
      ProfileModel? profile;
      profile = ProfileModel.fromMap(profilesJson);
      // List<ProfileModel> profiles = (profilesJson["characters"] as List)
      //     .map((json) => ProfileModel.fromMap(json))
      //     .toList();
      return profile;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
