// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cancer_shield/models/user_model.dart';

class ColonModel {
  int? scanId;
    int? userId;
    String? imagePath;
    bool? cancerDetected;
    int? cancerLevel;
    String? diagnosisDate;
    UserModel? user;
  ColonModel({
    this.scanId,
    this.userId,
    this.imagePath,
    this.cancerDetected,
    this.cancerLevel,
    this.diagnosisDate,
    this.user,
  });

  ColonModel copyWith({
    int? scanId,
    int? userId,
    String? imagePath,
    bool? cancerDetected,
    int? cancerLevel,
    String? diagnosisDate,
    UserModel? user,
  }) {
    return ColonModel(
      scanId: scanId ?? this.scanId,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      cancerDetected: cancerDetected ?? this.cancerDetected,
      cancerLevel: cancerLevel ?? this.cancerLevel,
      diagnosisDate: diagnosisDate ?? this.diagnosisDate,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scanId': scanId,
      'userId': userId,
      'imagePath': imagePath,
      'cancerDetected': cancerDetected,
      'cancerLevel': cancerLevel,
      'diagnosisDate': diagnosisDate,
      'user': user?.toMap(),
    };
  }

  factory ColonModel.fromMap(Map<String, dynamic> map) {
    return ColonModel(
      scanId: map['scanId'] != null ? map['scanId'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      cancerDetected: map['cancerDetected'] != null ? map['cancerDetected'] as bool : null,
      cancerLevel: map['cancerLevel'] != null ? map['cancerLevel'] as int : null,
      diagnosisDate: map['diagnosisDate'] != null ? map['diagnosisDate'] as String : null,
      user: map['user'] != null ? UserModel.fromMap(map['user'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColonModel.fromJson(String source) => ColonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ColonModel(scanId: $scanId, userId: $userId, imagePath: $imagePath, cancerDetected: $cancerDetected, cancerLevel: $cancerLevel, diagnosisDate: $diagnosisDate, user: $user)';
  }

  @override
  bool operator ==(covariant ColonModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.scanId == scanId &&
      other.userId == userId &&
      other.imagePath == imagePath &&
      other.cancerDetected == cancerDetected &&
      other.cancerLevel == cancerLevel &&
      other.diagnosisDate == diagnosisDate &&
      other.user == user;
  }

  @override
  int get hashCode {
    return scanId.hashCode ^
      userId.hashCode ^
      imagePath.hashCode ^
      cancerDetected.hashCode ^
      cancerLevel.hashCode ^
      diagnosisDate.hashCode ^
      user.hashCode;
  }
}
