import 'package:json_annotation/json_annotation.dart';

part 'student_profile_response.g.dart';

@JsonSerializable()
class StudentProfileResponse {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final List<dynamic>? enrolledCourses;
  final List<dynamic>? certificates;
  final bool? isVerified;
  final bool? isInstructorVerified;
  final String? instructorApplicationStatus;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final StudentProfileSettings? settings;

  StudentProfileResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.enrolledCourses,
    this.certificates,
    this.isVerified,
    this.isInstructorVerified,
    this.instructorApplicationStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.settings,
  });

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StudentProfileResponseToJson(this);
}

@JsonSerializable()
class StudentProfileSettings {
  final String? language;

  StudentProfileSettings({this.language});

  factory StudentProfileSettings.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$StudentProfileSettingsToJson(this);
}
