// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SkinModel {
  int? scanId;
  int? userId;
  String? imagePath;
  String? diseaseType;
  String? diagnosisDate;
  SkinModel({
    this.scanId,
    this.userId,
    this.imagePath,
    this.diseaseType,
    this.diagnosisDate,
  });

  SkinModel copyWith({
    int? scanId,
    int? userId,
    String? imagePath,
    String? diseaseType,
    String? diagnosisDate,
  }) {
    return SkinModel(
      scanId: scanId ?? this.scanId,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      diseaseType: diseaseType ?? this.diseaseType,
      diagnosisDate: diagnosisDate ?? this.diagnosisDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scanId': scanId,
      'userId': userId,
      'imagePath': imagePath,
      'diseaseType': diseaseType,
      'diagnosisDate': diagnosisDate,
    };
  }

  factory SkinModel.fromMap(Map<String, dynamic> map) {
    return SkinModel(
      scanId: map['scanId'] != null ? map['scanId'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      diseaseType: map['diseaseType'] != null ? map['diseaseType'] as String : null,
      diagnosisDate: map['diagnosisDate'] != null ? map['diagnosisDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SkinModel.fromJson(String source) => SkinModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SkinModel(scanId: $scanId, userId: $userId, imagePath: $imagePath, diseaseType: $diseaseType, diagnosisDate: $diagnosisDate)';
  }

  @override
  bool operator ==(covariant SkinModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.scanId == scanId &&
      other.userId == userId &&
      other.imagePath == imagePath &&
      other.diseaseType == diseaseType &&
      other.diagnosisDate == diagnosisDate;
  }

  @override
  int get hashCode {
    return scanId.hashCode ^
      userId.hashCode ^
      imagePath.hashCode ^
      diseaseType.hashCode ^
      diagnosisDate.hashCode;
  }
}
