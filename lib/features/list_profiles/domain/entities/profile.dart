class Profile {
  final int id;
  final String name;
  final String? imageUrl;
  final List<String>? natureType;
  final int? age;
  final String? sex;
  final DateTime? birthDate;
  final double? weight;
  final String? bloodType;
  final List<String>? classification;
  final String? rank;
  final String occupations;
  final List<String> affiliations;

  Profile({
    required this.id,
    required this.name,
    this.imageUrl,
    this.natureType,
    this.age,
    this.sex,
    this.birthDate,
    this.weight,
    this.bloodType,
    this.classification,
    this.rank,
    required this.occupations,
    required this.affiliations,
  });
}
