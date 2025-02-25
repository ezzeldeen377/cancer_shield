// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? userID;
  String? fullName;
  String? email;
  String? createdAt;
  String? resetToken;
  String? resetTokenExpiry;
  UserModel({
    this.userID,
    this.fullName,
    this.email,
    this.createdAt,
    this.resetToken,
    this.resetTokenExpiry,
  });

  UserModel copyWith({
    int? userID,
    String? fullName,
    String? email,
    String? createdAt,
    String? resetToken,
    String? resetTokenExpiry,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      resetToken: resetToken ?? this.resetToken,
      resetTokenExpiry: resetTokenExpiry ?? this.resetTokenExpiry,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt,
      'resetToken': resetToken,
      'resetTokenExpiry': resetTokenExpiry,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] != null ? map['userID'] as int : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      resetToken: map['resetToken'] != null ? map['resetToken'] as String : null,
      resetTokenExpiry: map['resetTokenExpiry'] != null ? map['resetTokenExpiry'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userID: $userID, fullName: $fullName, email: $email, createdAt: $createdAt, resetToken: $resetToken, resetTokenExpiry: $resetTokenExpiry)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userID == userID &&
      other.fullName == fullName &&
      other.email == email &&
      other.createdAt == createdAt &&
      other.resetToken == resetToken &&
      other.resetTokenExpiry == resetTokenExpiry;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      resetToken.hashCode ^
      resetTokenExpiry.hashCode;
  }
}
