// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PredictionResponse {
  String? classSkin;
  String? classColon;
  double? confidence;
  String? error;
  PredictionResponse({
    this.classSkin,
    this.classColon,
    this.confidence,
    this.error,
  });



  PredictionResponse copyWith({
    String? classSkin,
    String? classColon,
    double? confidence,
    String? error,
  }) {
    return PredictionResponse(
      classSkin: classSkin ?? this.classSkin,
      classColon: classColon ?? this.classColon,
      confidence: confidence ?? this.confidence,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'predicted_class': classSkin,
      'class': classColon,
      'confidence': confidence,
      'error': error,
    };
  }

  factory PredictionResponse.fromMap(Map<String, dynamic> map) {
    return PredictionResponse(
      classSkin: map['predicted_class'] != null ? map['predicted_class'] as String : null,
      classColon: map['class'] != null ? map['class'] as String : null,
      confidence: map['confidence'] != null ? map['confidence'] as double : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionResponse.fromJson(String source) => PredictionResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PredictionResponse(classSkin: $classSkin, classColon: $classColon, confidence: $confidence, error: $error)';
  }

  @override
  bool operator ==(covariant PredictionResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.classSkin == classSkin &&
      other.classColon == classColon &&
      other.confidence == confidence &&
      other.error == error;
  }

  @override
  int get hashCode {
    return classSkin.hashCode ^
      classColon.hashCode ^
      confidence.hashCode ^
      error.hashCode;
  }
}
