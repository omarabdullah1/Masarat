import 'package:json_annotation/json_annotation.dart';

part 'create_instructor_account_request_body.g.dart';

@JsonSerializable()
class CreateInstructorAccountRequestBody {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String? academicDegreePath;
  final String? idNumber;
  final String nationality;
  final String countryOfResidence;
  final String governorate;
  final String academicDegree;
  final String specialty;
  final String jobTitle;
  final String workEntity;
  final String? nationalIdImage;

  CreateInstructorAccountRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.academicDegreePath,
    this.idNumber,
    required this.nationality,
    required this.countryOfResidence,
    required this.governorate,
    required this.academicDegree,
    required this.specialty,
    required this.jobTitle,
    required this.workEntity,
    this.nationalIdImage,
  });

  Map<String, dynamic> toJson() =>
      _$CreateInstructorAccountRequestBodyToJson(this);

  factory CreateInstructorAccountRequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$CreateInstructorAccountRequestBodyFromJson(json);
}
