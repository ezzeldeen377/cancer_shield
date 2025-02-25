// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
class DoctorResponse {
  List<DoctorModel>? doctors;
  DoctorResponse({
    this.doctors,
  });

  DoctorResponse copyWith({
    List<DoctorModel>? doctors,
  }) {
    return DoctorResponse(
      doctors: doctors ?? this.doctors,
    );
  }
    factory DoctorResponse.fromList(List<dynamic> list) {
    return DoctorResponse(
      doctors: list.map((doctor) => DoctorModel.fromMap(doctor as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctors': doctors?.map((x) => x.toMap()).toList(),
    };
  }

  factory DoctorResponse.fromMap(Map<String, dynamic> map) {
    return DoctorResponse(
      doctors: map['doctors'] != null ? List<DoctorModel>.from((map['doctors'] as List<int>).map<DoctorModel?>((x) => DoctorModel.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorResponse.fromJson(String source) => DoctorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DoctorReponse(doctors: $doctors)';

  @override
  bool operator ==(covariant DoctorResponse other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.doctors, doctors);
  }

  @override
  int get hashCode => doctors.hashCode;
}
class DoctorModel {
   int? id;
  String? name;
  String? specialty;
  String? location;
  int? experience;
  String? phone;
  DoctorModel({
    this.id,
    this.name,
    this.specialty,
    this.location,
    this.experience,
    this.phone,
  });

  DoctorModel copyWith({
    int? id,
    String? name,
    String? specialty,
    String? location,
    int? experience,
    String? phone,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      location: location ?? this.location,
      experience: experience ?? this.experience,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'specialty': specialty,
      'location': location,
      'experience': experience,
      'phone': phone,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      specialty: map['specialty'] != null ? map['specialty'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      experience: map['experience'] != null ? map['experience'] as int : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) => DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, specialty: $specialty, location: $location, experience: $experience, phone: $phone)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.specialty == specialty &&
      other.location == location &&
      other.experience == experience &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      specialty.hashCode ^
      location.hashCode ^
      experience.hashCode ^
      phone.hashCode;
  }
}
