import 'package:flutter/foundation.dart';

import 'dart:convert';

import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required int id,
    required String name,
    String? imageUrl,
    List<String>? natureType,
    int? age,
    String? sex,
    DateTime? birthDate,
    double? weight,
    String? bloodType,
    List<String>? classification,
    String? rank,
    required String occupations,
    required List<String> affiliations,
  }) : super(
            id: id,
            name: name,
            imageUrl: imageUrl,
            natureType: natureType,
            age: age,
            sex: sex,
            birthDate: birthDate,
            weight: weight,
            bloodType: bloodType,
            classification: classification,
            rank: rank,
            occupations: occupations,
            affiliations: affiliations);

  ProfileModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    List<String>? natureType,
    int? age,
    String? sex,
    DateTime? birthDate,
    double? weight,
    String? bloodType,
    List<String>? classification,
    String? rank,
    String? occupations,
    List<String>? affiliations,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      natureType: natureType ?? this.natureType,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      birthDate: birthDate ?? this.birthDate,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
      classification: classification ?? this.classification,
      rank: rank ?? this.rank,
      occupations: occupations ?? this.occupations,
      affiliations: affiliations ?? this.affiliations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'images': imageUrl,
      'natureType': natureType,
      'age': age,
      'sex': sex,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'weight': weight,
      'bloodType': bloodType,
      'classification': classification,
      'rank': rank,
      'occupations': occupations,
      'affiliation': affiliations,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    bool checkKeyExists(Map map, String key) {
      if (map.containsKey('personal')) {
        if (map['personal'] is List) {
          return false;
        } else {
          if (map['personal'] is Map<String, dynamic>) {
            return (map['personal'] as Map).containsKey(key);
          }
        }
      }
      return false;
    }

    List<String> classification = [];
    List<String> affiliations = [];
    if (map['id'] == 12) {
      print(map['id']);
    }
    double weight = 0;
    if (checkKeyExists(map, 'classification')) {
      if (map['personal']['classification'] is List) {
        classification = (map['personal']['classification'] as List)
            .map((e) => e as String)
            .toList();
      } else {
        classification = ['Ninja'];
      }
    }
    if (checkKeyExists(map, 'affiliation')) {
      if (map['personal']['affiliation'] is List) {
        affiliations = (map['personal']['affiliation'] as List)
            .map((e) => e as String)
            .toList();
      } else {
        affiliations = ['Shinobi'];
      }
    }
    int? age;

    if (checkKeyExists(map, 'age')) {
      if ((map['personal']['age'] as Map).containsKey('Part I')) {
        age = int.parse(
            (map['personal']['age']['Part I'] as String).split('–')[0]);
      } else if ((map['personal']['age'] as Map).containsKey('Part II')) {
        age = int.parse(
            (map['personal']['age']['Part II'] as String).split('–')[0]);
      }
    }
    String? sex = checkKeyExists(map, 'sex') ? map['personal']['sex'] : null;
    String occupationString = 'Ninja';

    if (checkKeyExists(map, 'occupation')) {
      if (map['personal']['occupation'] is List) {
        occupationString = map['personal']['occupation'].join(' ');
      }
    }

    String? imageUrl;

    if (map['images'] is String) {
      imageUrl = map['images'];
    } else if (map['images'] is List && (map['images'] as List).isNotEmpty) {
      imageUrl = map['images'][0];
    }

    return ProfileModel(
        id: map['id'] as int,
        name: map['name'] as String,
        imageUrl: imageUrl,
        natureType: map['natureType'] != null
            ? List<String>.from((map['natureType'] as List))
            : null,
        age: age,
        sex: sex,
        birthDate: DateTime.now(),
        weight: checkKeyExists(map, 'weight')
            ? map['personal']['weight']['Part I'] != null
                ? double.parse(map['personal']['weight']['Part I']
                    .replaceAll('kg', '')
                    .split('-')[0])
                : map['personal']['weight']['Part II'] != null
                    ? double.parse(map['personal']['weight']['Part II']
                        .replaceAll('kg', '')
                        .split('-')[0])
                    : null
            : null,
        bloodType: checkKeyExists(map, 'bloodType')
            ? map['personal']['bloodType'] as String
            : null,
        classification: classification,
        rank:
            checkKeyExists(map, 'ninjaRank') && map['rank']['ninjaRank'] != null
                ? map['rank']['ninjaRank']['Part I'] ??
                    map['rank']['ninjaRank']['Part II']
                : null,
        occupations: occupationString,
        affiliations: affiliations);
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, images: $imageUrl, natureType: $natureType, age: $age, sex: $sex, birthDate: $birthDate, weight: $weight, bloodType: $bloodType, classification: $classification, rank: $rank, occupations: $occupations)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        listEquals(other.natureType, natureType) &&
        other.age == age &&
        other.sex == sex &&
        other.birthDate == birthDate &&
        other.weight == weight &&
        other.bloodType == bloodType &&
        listEquals(other.classification, classification) &&
        other.rank == rank &&
        other.occupations == occupations;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        natureType.hashCode ^
        age.hashCode ^
        sex.hashCode ^
        birthDate.hashCode ^
        weight.hashCode ^
        bloodType.hashCode ^
        classification.hashCode ^
        rank.hashCode ^
        occupations.hashCode;
  }
}
