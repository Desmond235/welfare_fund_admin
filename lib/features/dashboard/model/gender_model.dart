class GenderModel {
  final int numberOfFemales;
  final int numberOfMales;

  GenderModel({
    required this.numberOfFemales,
    required this.numberOfMales,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json){
    return GenderModel(
      numberOfFemales:json['count_gender'],
      numberOfMales: json['count_gender'],
    );
  }
}
