// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class UserModel {
  String Name;
  String UID;
  String Phone;
  String About;
  String Email;

  UserModel({
    required this.Name,
    required this.UID,
    required this.Phone,
    required this.About,
    required this.Email,
  });

  UserModel copyWith({
    String? Name,
    String? UID,
    String? Phone,
    String? About,
    String? Email,
  }) {
    return UserModel(
      Name: Name ?? this.Name,
      UID: UID ?? this.UID,
      Phone: Phone ?? this.Phone,
      About: About ?? this.About,
      Email: Email ?? this.Email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'UID': UID,
      'Phone': Phone,
      'About': About,
      'Email': Email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      Name: map['Name'] as String,
      UID: map['UID'] as String,
      Phone: map['Phone'] as String,
      About: map['About'] as String,
      Email: map['Email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(Name: $Name, UID: $UID, Phone: $Phone, About: $About, Email: $Email)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.Name == Name &&
        other.UID == UID &&
        other.Phone == Phone &&
        other.About == About &&
        other.Email == Email;
  }

  @override
  int get hashCode {
    return Name.hashCode ^
    UID.hashCode ^
    Phone.hashCode ^
    About.hashCode ^
    Email.hashCode;
  }
}
