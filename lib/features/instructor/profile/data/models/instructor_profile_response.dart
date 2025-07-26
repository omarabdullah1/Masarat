import 'package:json_annotation/json_annotation.dart';

part 'instructor_profile_response.g.dart';

@JsonSerializable()
class InstructorProfileResponse {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? role;
  final List<dynamic>? courses;
  final bool? isVerified;
  final bool? isInstructorVerified;
  final String? instructorApplicationStatus;
  final String? contactNumber;
  final String? nationalIdImageUrl;
  final String? nationality;
  final String? countryOfResidence;
  final String? governorate;
  final String? academicDegree;
  final String? specialty;
  final String? jobTitle;
  final String? workEntity;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final InstructorProfileSettings? settings;

  InstructorProfileResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.courses,
    this.isVerified,
    this.isInstructorVerified,
    this.instructorApplicationStatus,
    this.contactNumber,
    this.nationalIdImageUrl,
    this.nationality,
    this.countryOfResidence,
    this.governorate,
    this.academicDegree,
    this.specialty,
    this.jobTitle,
    this.workEntity,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.settings,
  });

  factory InstructorProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$InstructorProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorProfileResponseToJson(this);
}

@JsonSerializable()
class InstructorProfileSettings {
  final String? language;

  InstructorProfileSettings({this.language});

  factory InstructorProfileSettings.fromJson(Map<String, dynamic> json) =>
      _$InstructorProfileSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorProfileSettingsToJson(this);
}
