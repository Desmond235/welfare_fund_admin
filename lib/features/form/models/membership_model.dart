
// ignore_for_file: non_constant_identifier_names

class MembershipModel {
  final int id;
  final String full_name;
  final String date_of_birth;
  final String date_of_registration;
  final int amount_paid;
  final String amount_in_words;
  final String receipt_no;
  final int contact;
  final String house_number;
  final String place_of_abode;
  final String land_mark;
  final String home_town;
  final String region;
  final String marital_status;
  final String others;
  final String? name_of_spouse;
  final String? life_status;
  final int no_of_children;
  final String? names_of_children;
  final String occupation;
  final String fathers_name;
  final String father_life_status;
  final String mothers_name;
  final String mother_life_status;
  final String next_of_kin;
  final int next_of_kin_contact;
  final String class_leader;
  final int class_leader_contact;
  final String? organization_of_member;
  final int org_leader_contact;

  MembershipModel({
    required this.id,
    required this.full_name,
    required this.date_of_birth,
    required this.date_of_registration,
    required this.amount_paid,
    required this.amount_in_words,
    required this.receipt_no,
    required this.contact,
    required this.house_number,
    required this.place_of_abode,
    required this.land_mark,
    required this.home_town,
    required this.region,
    required this.marital_status,
    required this.others,
    required this.name_of_spouse,
    required this.life_status,
    required this.no_of_children,
    required this.names_of_children,
    required this.occupation,
    required this.fathers_name,
    required this.father_life_status,
    required this.mothers_name,
    required this.mother_life_status,
    required this.next_of_kin,
    required this.next_of_kin_contact,
    required this.class_leader,
    required this.class_leader_contact,
    required this.organization_of_member,
    required this.org_leader_contact,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json["id"] ?? 0 ,
      full_name: json['full_name'] ?? '',
      date_of_birth: json['date_of_birth']  ?? "",
      date_of_registration: json['date_of_registration'] ?? "",
      amount_paid: json['amount_paid'] as int? ?? 0,
      amount_in_words: json['amount_in_words'] ?? '',
      receipt_no: json['receipt_no'] ?? '',
      contact: json['contact'] as int,
      house_number: json['house_number'] ?? '',
      place_of_abode: json['place_of_abode'] ?? '',
      land_mark: json['land_mark'] ?? '',
      home_town: json['hom_town'] ?? '',
      region: json['region'] ?? '',
      marital_status: json['marital_status'] ?? '',
      others: json['others'] ?? '',
      name_of_spouse: json['name_of_spouse'],
      life_status: json['life_status'],
      no_of_children: json['no_of_children'] ?? 0,
      names_of_children: json['names_of_children'],
      occupation: json['occupation'] ?? '' ,
      fathers_name: json['fathers_name'] ?? '',
      father_life_status: json['father_life_status'] ?? '',
      mothers_name: json['mothers_name'] ?? '',
      mother_life_status: json['mother_life_status'] ?? '',
      next_of_kin: json['next_of_kin'] ?? '',
      next_of_kin_contact: json['next_of_kin_contact'] ?? 0,
      class_leader: json['class_leader'] ?? '',
      class_leader_contact: json['class_leader_contact'] ?? 0,
      organization_of_member: json['organization_of_member'],
      org_leader_contact: json['org_leader_contact'],
    );
  }
}

