import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/app_validator.dart';
import 'package:masarat/core/utils/constants/app_images.dart';
import 'package:masarat/core/utils/constants/text_styles.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/instructor/profile/data/models/instructor_profile_response.dart';
import 'package:masarat/features/instructor/profile/logic/cubit/instructor_profile_cubit.dart';
import 'package:masarat/features/instructor/profile/logic/cubit/instructor_profile_state.dart';

import '../../../../../core/widgets/loading_widget.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a new instance every time to ensure fresh state
    return BlocProvider.value(
      value: getIt<InstructorProfileCubit>(),
      child: const _InstructorProfileContent(),
    );
  }
}

class _InstructorProfileContent extends StatefulWidget {
  const _InstructorProfileContent({Key? key}) : super(key: key);

  @override
  State<_InstructorProfileContent> createState() =>
      _InstructorProfileContentState();
}

class _InstructorProfileContentState extends State<_InstructorProfileContent> {
  bool _isFirstLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This ensures we fetch every time the widget is mounted in the tree
    _fetchProfile();
  }

  void _fetchProfile() {
    if (!mounted) return;

    final cubit = context.read<InstructorProfileCubit>();
    // Only fetch if this is first load or we don't have profile data
    if (_isFirstLoad || cubit.profile == null) {
      _isFirstLoad = false;
      cubit.fetchProfile();
    }
  }

  @override
  void dispose() {
    _isFirstLoad = true; // Reset for next time
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_forward_ios_sharp,
            color: Theme.of(context).iconTheme.color,
            size: 20.sp,
          ),
        ),
      ],
      drawer: const CustomDrawer(),
      body: BlocConsumer<InstructorProfileCubit, InstructorProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            updateSuccess: (_) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تحديث الملف الشخصي بنجاح'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'حسناً',
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              _fetchProfile();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: state.maybeWhen(
                initial: () => const Center(
                  child: LoadingWidget(loadingState: true),
                ),
                loading: () {
                  final cubit = context.read<InstructorProfileCubit>();
                  final currentProfile = cubit.profile;

                  // If we have no profile yet and this is initial load
                  if (currentProfile == null && _isFirstLoad) {
                    return const Center(
                        child: LoadingWidget(loadingState: true));
                  }

                  // Show form with current data and overlay loader
                  return Stack(
                    children: [
                      _ProfileForm(
                        profile: currentProfile ?? InstructorProfileResponse(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                              child: LoadingWidget(loadingState: true))),
                    ],
                  );
                },
                loaded: (profile) {
                  final cubit = context.read<InstructorProfileCubit>();
                  final oldProfile = cubit.profile;

                  // Update the cubit's profile
                  cubit.profile = profile;

                  // Show success message only for updates, not initial load
                  if (oldProfile != null &&
                      oldProfile.updatedAt != profile.updatedAt) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'تم تحديث الملف الشخصي بنجاح، يمكنك متابعة التعديل'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    });
                  }

                  // Use a unique key that changes only on actual data updates
                  return _ProfileForm(
                    profile: profile,
                  );
                },
                error: (message) => SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(child: Text(message)),
                ),
                orElse: () => const Center(
                  child: LoadingWidget(loadingState: true),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  final InstructorProfileResponse profile;

  const _ProfileForm({Key? key, required this.profile}) : super(key: key);

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

// TODO: Add profileImageUrl to InstructorProfileResponse model and backend API if not present.
// TODO: Update InstructorProfileCubit, repository, and API service to support profilePicture file upload.
class _ProfileFormState extends State<_ProfileForm> {
  // Section title widget for form sections
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
      child: CustomText(
        text: title,
        style: TextStyles.font24BlackBold,
      ),
    );
  }

  Widget buildFormField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool enabled = true,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            style: TextStyles.font12GrayRegular,
          ),
          Gap(8.h),
          AppTextFormField(
            controller: controller,
            validator: validator,
            enabled: enabled,
            maxLines: maxLines,
            keyboardType: keyboardType,
            backgroundColor: Colors.white,
            hintText: label,
          ),
        ],
      ),
    );
  }

  late final TextEditingController firstNameController;
  late final TextEditingController emailController;
  late final TextEditingController contactNumberController;
  late final TextEditingController nationalityController;
  late final TextEditingController countryOfResidenceController;
  late final TextEditingController governorateController;
  late final TextEditingController academicDegreeController;
  late final TextEditingController specialtyController;
  late final TextEditingController jobTitleController;
  late final TextEditingController workEntityController;

  void _updateControllersWithProfile(InstructorProfileResponse profile) {
    debugPrint('updateProfile response: {\n'
        '  firstName: ${profile.firstName},\n'
        '  lastName: ${profile.lastName},\n'
        '  email: ${profile.email},\n'
        '  contactNumber: ${profile.contactNumber},\n'
        '  nationality: ${profile.nationality},\n'
        '  countryOfResidence: ${profile.countryOfResidence},\n'
        '  governorate: ${profile.governorate},\n'
        '  academicDegree: ${profile.academicDegree},\n'
        '  specialty: ${profile.specialty},\n'
        '  jobTitle: ${profile.jobTitle},\n'
        '  workEntity: ${profile.workEntity},\n'
        '}');
    firstNameController.text = profile.firstName ?? '';
    emailController.text = profile.email ?? '';
    contactNumberController.text = profile.contactNumber ?? '';
    nationalityController.text = profile.nationality ?? '';
    countryOfResidenceController.text = profile.countryOfResidence ?? '';
    governorateController.text = profile.governorate ?? '';
    academicDegreeController.text = profile.academicDegree ?? '';
    specialtyController.text = profile.specialty ?? '';
    jobTitleController.text = profile.jobTitle ?? '';
    workEntityController.text = profile.workEntity ?? '';
  }

  File? selectedProfileImage;

  @override
  void initState() {
    super.initState();
    firstNameController =
        TextEditingController(text: widget.profile.firstName ?? '');
    emailController = TextEditingController(text: widget.profile.email ?? '');
    contactNumberController =
        TextEditingController(text: widget.profile.contactNumber ?? '');
    nationalityController =
        TextEditingController(text: widget.profile.nationality ?? '');
    countryOfResidenceController =
        TextEditingController(text: widget.profile.countryOfResidence ?? '');
    governorateController =
        TextEditingController(text: widget.profile.governorate ?? '');
    academicDegreeController =
        TextEditingController(text: widget.profile.academicDegree ?? '');
    specialtyController =
        TextEditingController(text: widget.profile.specialty ?? '');
    jobTitleController =
        TextEditingController(text: widget.profile.jobTitle ?? '');
    workEntityController =
        TextEditingController(text: widget.profile.workEntity ?? '');
  }

  Future<void> pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedProfileImage = File(result.files.single.path!);
      });
    }
  }

  Widget buildStatusSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'حالة الحساب',
            style: TextStyles.font24BlackBold,
          ),
          const SizedBox(height: 10),
          buildStatusItem(
            (widget.profile.isVerified ?? false)
                ? 'تم التحقق من الحساب'
                : 'لم يتم التحقق من الحساب بعد',
            (widget.profile.isVerified ?? false)
                ? Icons.verified_user
                : Icons.pending,
            (widget.profile.isVerified ?? false) ? Colors.green : Colors.orange,
          ),
          buildStatusItem(
            (widget.profile.isInstructorVerified ?? false)
                ? 'تم التحقق كمدرب معتمد'
                : 'في انتظار التحقق كمدرب',
            (widget.profile.isInstructorVerified ?? false)
                ? Icons.school
                : Icons.school_outlined,
            (widget.profile.isInstructorVerified ?? false)
                ? Colors.green
                : Colors.orange,
          ),
          buildStatusItem(
            'حالة الطلب: ${widget.profile.instructorApplicationStatus ?? 'معلق'}',
            Icons.assignment,
            (widget.profile.instructorApplicationStatus ?? '') == 'approved'
                ? Colors.green
                : (widget.profile.instructorApplicationStatus ?? '') ==
                        'rejected'
                    ? Colors.red
                    : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget buildStatusItem(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InstructorProfileCubit>();
    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image and Edit Icon with upload
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: selectedProfileImage != null
                          ? FileImage(selectedProfileImage!)
                          : null, // TODO: Use correct field for profile image URL from InstructorProfileResponse
                      // TODO: Show network image if profile image URL is available
                      child: (selectedProfileImage == null)
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primary,
                            )
                          : null, // TODO: Add profileImageUrl to InstructorProfileResponse if not present
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: pickProfileImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            AppImage.editIcon,
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                                AppColors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              text:
                  '${widget.profile.firstName ?? ''} ${widget.profile.lastName ?? ''}',
              style: TextStyles.font24BlackBold,
            ),
            const SizedBox(height: 20),
            // Status Section
            buildStatusSection(),
            const SizedBox(height: 20),

            // Basic Information
            buildSectionTitle('المعلومات الأساسية'),
            buildFormField(
              label: 'الاسم بالكامل',
              controller: firstNameController,
              validator: AppValidator.emptyValidator,
              enabled: false,
            ),
            buildFormField(
              label: 'البريد الإلكتروني',
              controller: emailController,
              validator: AppValidator.emailValidator,
              enabled: false,
            ),
            buildFormField(
              label: 'رقم الهاتف',
              controller: contactNumberController,
              validator: AppValidator.phoneValidator,
            ),

            // Academic Information
            buildSectionTitle('المعلومات الأكاديمية'),
            buildFormField(
              label: 'الدرجة العلمية',
              controller: academicDegreeController,
              validator: AppValidator.emptyValidator,
            ),
            buildFormField(
              label: 'التخصص',
              controller: specialtyController,
              validator: AppValidator.emptyValidator,
            ),
            buildFormField(
              label: 'المسمى الوظيفي',
              controller: jobTitleController,
              validator: AppValidator.emptyValidator,
            ),
            buildFormField(
              label: 'جهة العمل',
              controller: workEntityController,
              validator: AppValidator.emptyValidator,
            ),

            // Location Information
            buildSectionTitle('معلومات الموقع'),
            buildFormField(
              label: 'الجنسية',
              controller: nationalityController,
              validator: AppValidator.emptyValidator,
            ),
            buildFormField(
              label: 'بلد الإقامة',
              controller: countryOfResidenceController,
              validator: AppValidator.emptyValidator,
            ),
            buildFormField(
              label: 'المحافظة',
              controller: governorateController,
              validator: AppValidator.emptyValidator,
            ),

            // Save Button
            BlocConsumer<InstructorProfileCubit, InstructorProfileState>(
              listener: (context, state) {
                state.maybeWhen(
                  updateSuccess: (profile) {
                    _updateControllersWithProfile(profile);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم تحديث الملف الشخصي بنجاح'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: CustomButton(
                    labelText: 'حفظ التغييرات',
                    onTap: isLoading
                        ? null
                        : () {
                            // Clear any previous error messages
                            ScaffoldMessenger.of(context).clearSnackBars();
                            // Validate all form fields
                            if (!cubit.formKey.currentState!.validate()) {
                              return;
                            }
                            String emptyToString(String value) =>
                                value.trim().isEmpty ? '' : value.trim();
                            final contactNumber =
                                emptyToString(contactNumberController.text);
                            final nationality =
                                emptyToString(nationalityController.text);
                            final countryOfResidence = emptyToString(
                                countryOfResidenceController.text);
                            final governorate =
                                emptyToString(governorateController.text);
                            final academicDegree =
                                emptyToString(academicDegreeController.text);
                            final specialty =
                                emptyToString(specialtyController.text);
                            final jobTitle =
                                emptyToString(jobTitleController.text);
                            final workEntity =
                                emptyToString(workEntityController.text);
                            final debugPayload = 'updateProfile payload: {\n'
                                '  firstName: ${widget.profile.firstName},\n'
                                '  lastName: ${widget.profile.lastName},\n'
                                '  email: ${widget.profile.email},\n'
                                '  contactNumber: $contactNumber,\n'
                                '  nationality: $nationality,\n'
                                '  countryOfResidence: $countryOfResidence,\n'
                                '  governorate: $governorate,\n'
                                '  academicDegree: $academicDegree,\n'
                                '  specialty: $specialty,\n'
                                '  jobTitle: $jobTitle,\n'
                                '  workEntity: $workEntity,\n'
                                '  profilePicture: ${selectedProfileImage?.path},\n'
                                '}';
                            debugPrint(debugPayload);
                            context
                                .read<InstructorProfileCubit>()
                                .updateProfile(
                                  firstName: widget.profile.firstName ?? '',
                                  lastName: widget.profile.lastName ?? '',
                                  email: widget.profile.email ?? '',
                                  contactNumber: contactNumber,
                                  nationality: nationality,
                                  countryOfResidence: countryOfResidence,
                                  governorate: governorate,
                                  academicDegree: academicDegree,
                                  specialty: specialty,
                                  jobTitle: jobTitle,
                                  workEntity: workEntity,
                                  profilePicture: selectedProfileImage,
                                );
                          },
                    buttonColor: AppColors.primary,
                  ),
                );
              },
            ),
            Gap(20.h),
            // Delete Account
            GestureDetector(
              onTap: () {
                // Handle account deletion
              },
              child: const Text(
                'حذف الحساب نهائياً',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
