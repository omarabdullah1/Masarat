import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/helpers/shared_pref_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/features/student/profile/data/models/student_profile_response.dart';
import 'package:masarat/features/student/profile/logic/cubit/student_profile_cubit.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  // For image picking
  File? selectedProfileImage;

  // Move controllers to UI
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    // Fetch profile on first build, but only if still mounted
    // Fetch profile on first build, but only if still mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<StudentProfileCubit>();
        // Defensive: only call if cubit is not closed
        if (!cubit.isClosed) {
          cubit.fetchProfile();
        }
      }
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedProfileImage = File(result.files.single.path!);
      });
    }
  }

  void _updateControllersWithProfile(StudentProfileResponse profile) {
    // Only update if mounted to avoid using disposed controllers
    if (!mounted) return;
    firstNameController.text = profile.firstName ?? '';
    lastNameController.text = profile.lastName ?? '';
    emailController.text = profile.email ?? '';
    // Phone is not present in the response, so do not update phoneController
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentProfileCubit>();
    return Scaffold(
      body: BlocConsumer<StudentProfileCubit, StudentProfileState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (profile) {
              // No snackbar on initial load
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
            deleteSuccess: () async {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حذف الحساب بنجاح'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );

              // Clear all shared preferences and secured data
              await SharedPrefHelper.clearAllData();
              await SharedPrefHelper.clearAllSecuredData();

              // Navigate to onboarding screen
              if (context.mounted) {
                context.go(AppRoute.onboarding);
              }
            },
          );
        },
        builder: (context, state) {
          // Show loading indicator (Lottie)
          if (state.maybeWhen(loading: () => true, orElse: () => false)) {
            return const Center(child: LoadingWidget(loadingState: true));
          }
          // Show error UI like instructor
          if (state.maybeWhen(error: (msg) => true, orElse: () => false)) {
            final errorMsg = state.maybeWhen(
              error: (msg) => msg,
              orElse: () => 'حدث خطأ غير متوقع',
            );

            // Don't show error screen for delete account errors - let the listener handle it as toast
            if (errorMsg.contains('كلمة المرور غير صحيحة') ||
                errorMsg.contains('فشل في حذف الحساب') ||
                errorMsg.contains('Incorrect password') ||
                errorMsg.contains('Account deletion failed')) {
              // Return the normal form instead of error screen
              return _buildNormalForm(context, cubit, state);
            }

            return CustomScaffold(
              haveAppBar: true,
              backgroundColorAppColor: AppColors.background,
              backgroundColor: AppColors.background,
              drawerIconColor: AppColors.primary,
              drawer: const CustomDrawer(),
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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
                    Gap(16.h),
                    Text(
                      errorMsg,
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Gap(16.h),
                    CustomButton(
                      onTap: () => cubit.fetchProfile(),
                      labelText: 'إعادة المحاولة',
                      height: 45.h,
                      textFontSize: 16.sp,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            );
          }

          // Only update controllers if loaded and mounted, but NOT on updateSuccess
          state.maybeWhen(
            loaded: (profile) {
              if (mounted) _updateControllersWithProfile(profile);
            },
            // Do nothing on updateSuccess to keep form values
            updateSuccess: () {},
            orElse: () {},
          );

          return _buildNormalForm(context, cubit, state);
        },
      ),
    );
  }

  Widget _buildNormalForm(BuildContext context, StudentProfileCubit cubit,
      StudentProfileState state) {
    // Only update controllers if loaded and mounted, but NOT on updateSuccess
    state.maybeWhen(
      loaded: (profile) {
        if (mounted) _updateControllersWithProfile(profile);
      },
      // Do nothing on updateSuccess to keep form values
      updateSuccess: () {},
      orElse: () {},
    );

    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
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
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          await cubit.fetchProfile();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
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
                        radius: 50.r,
                        backgroundColor: Colors.white,
                        backgroundImage: selectedProfileImage != null
                            ? FileImage(selectedProfileImage!)
                            : null,
                        child: selectedProfileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primary,
                              )
                            : null,
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
                              'assets/icons/edit_icon.svg',
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
              Gap(16.h),
              // Name
              Center(
                child: Text(
                  '${firstNameController.text} ${lastNameController.text}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Gap(20.h),
              // Status Section (placeholder)
              // TODO: Implement buildStatusSection() if needed
              // buildStatusSection(),
              // Section Title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  'المعلومات الأساسية',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // ...existing code for form fields and buttons...
              AppTextFormField(
                controller: firstNameController,
                hintText: "الاسم الأول",
                validator: (value) =>
                    value?.isEmpty == true ? "الرجاء إدخال الاسم الأول" : null,
              ),
              Gap(20.h),
              AppTextFormField(
                controller: lastNameController,
                hintText: "اسم العائلة",
                validator: (value) =>
                    value?.isEmpty == true ? "الرجاء إدخال اسم العائلة" : null,
              ),
              Gap(20.h),
              AppTextFormField(
                controller: emailController,
                hintText: "البريد الإلكتروني",
                validator: (value) => value?.isEmpty == true
                    ? "الرجاء إدخال البريد الإلكتروني"
                    : null,
              ),
              Gap(20.h),
              // Phone field removed as it is not present in the response
              Gap(30.h),
              CustomButton(
                onTap: () {
                  cubit.updateProfile(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    profileImage: selectedProfileImage,
                  );
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تحديث الملف الشخصي بنجاح'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                height: 45.h,
                labelText: 'حفظ التعديلات',
                textFontSize: 16.sp,
                textColor: AppColors.white,
              ),
              Gap(20.h),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final passwordController = TextEditingController();
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('حذف الحساب'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                                'هل أنت متأكد من حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.'),
                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'كلمة المرور',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('إلغاء'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('حذف'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true &&
                        passwordController.text.isNotEmpty) {
                      cubit.deleteAccount(passwordController.text);
                    }
                  },
                  child: Text(
                    'حذف الحساب نهائياً',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
