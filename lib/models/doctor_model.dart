class DoctorResponse {
  final List<DoctorModel> doctors;

  DoctorResponse({required this.doctors});

  factory DoctorResponse.fromList(List<dynamic>? list) {
    if (list == null) return DoctorResponse(doctors: []);
    return DoctorResponse(
      doctors: list.map((item) => DoctorModel.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'doctors': doctors.map((doctor) => doctor.toJson()).toList(),
      };
}

class DoctorModel {
  final int id;
  final String name;
  final String specialty;
  final String location;
  final int experience;
  final String phone;
  final String imagePath;
  final String locationUrl;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.location,
    required this.experience,
    required this.phone,
    required this.imagePath,
    required this.locationUrl,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      location: json['location'] as String,
      experience: json['experience'] as int,
      phone: json['phone'] as String,
      imagePath: json['imagePath'] as String,
      locationUrl: json['locationUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'specialty': specialty,
        'location': location,
        'experience': experience,
        'phone': phone,
        'imagePath': imagePath,
        'locationUrl': locationUrl,
      };
}