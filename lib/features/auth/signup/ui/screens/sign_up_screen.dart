import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/constants/validators.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/auth/signup/logic/cubit/register_cubit.dart';
import 'package:masarat/features/auth/signup/logic/cubit/register_state.dart';

import '../../../../../core/widgets/loading_widget.dart';

class SignUpScreen extends StatefulWidget {
  final bool isTrainer;

  const SignUpScreen({super.key, this.isTrainer = false});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordObscured = true;
  late RegisterCubit cubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.read<RegisterCubit>();
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            // Show loading indicator
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: LoadingWidget(
                  loadingState: true,
                  backgroundColor: AppColors.white,
                ),
              ),
            );
          },
          success: (response) {
            // Close loading dialog if open
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.isTrainer
                    ? 'تم إنشاء حساب المدرب بنجاح'
                    : 'تم إنشاء حساب المتعلم بنجاح'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to login screen after successful registration
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                GoRouter.of(context).goNamed(AppRoute.login);
              }
            });
          },
          error: (error) {
            // Close loading dialog if it's open
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }

            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
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
          orElse: () {}, // Do nothing for other states
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl, // Arabic RTL support
        child: CustomScaffold(
          backgroundColor: AppColors.background,
          haveAppBar: true,
          body: Column(
            children: [
              // Fixed Header
              _buildHeader(),
              // Scrollable Form
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Gap(20.h),
                          _buildFormFields(),
                          Gap(20.h),
                          _buildEditButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Gap(30.h),
        SvgPicture.asset(
          AppImage.iconAppWithTextGreen,
          height: 60.h,
          semanticsLabel: 'Professional Tracks Logo',
        ),
        Gap(20.h),
        CustomText(
          text: widget.isTrainer ? 'تسجيل كمدرب' : 'تسجيل كمتعلم',
          style: TextStyles.font24GreenBold,
          textAlign: TextAlign.center,
        ),
        Gap(10.h),
        CustomText(
          text: 'من فضلك قم بإدخال جميع البيانات\n'
              'المطلوبة حتى تتمكن من إنشاء حساب بنجاح',
          style: TextStyles.font12GrayLight,
          textAlign: TextAlign.center,
        ),
        Gap(5.h),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildFormField(
          label: 'الاسم بالكامل',
          hintText: 'أدخل الاسم الكامل',
          validator: AppValidator.emptyValidator,
          controller: cubit.fullNameController,
        ),
        _buildFormField(
          label: 'البريد الإلكتروني',
          hintText: 'أدخل البريد الإلكتروني',
          validator: AppValidator.emailValidator,
          controller: cubit.emailController,
        ),
        _buildFormField(
          label: 'رقم التواصل',
          hintText: 'أدخل رقم التواصل',
          validator: AppValidator.phoneValidator,
          controller: cubit.phoneController,
        ),
        // Conditional fields for instructor
        if (widget.isTrainer) ...[
          _buildFormField(
            label: 'الجنسية',
            hintText: 'أدخل الجنسية',
            validator: AppValidator.emptyValidator,
            controller: cubit.nationalityController,
          ),
          _buildFormField(
            label: 'بلد الإقامة',
            hintText: 'أدخل بلد الإقامة',
            validator: AppValidator.emptyValidator,
            controller: cubit.countryOfResidenceController,
          ),
          _buildFormField(
            label: 'المحافظة',
            hintText: 'أدخل المحافظة',
            validator: AppValidator.emptyValidator,
            controller: cubit.governorateController,
          ),
          _buildFormField(
            label: 'الدرجة العلمية',
            hintText: 'أدخل الدرجة العلمية',
            validator: AppValidator.emptyValidator,
            controller: cubit.academicDegreeTextController,
          ),
          _buildFormField(
            label: 'التخصص',
            hintText: 'أدخل التخصص',
            validator: AppValidator.emptyValidator,
            controller: cubit.specialtyController,
          ),
          _buildFormField(
            label: 'المسمى الوظيفي',
            hintText: 'أدخل المسمى الوظيفي',
            validator: AppValidator.emptyValidator,
            controller: cubit.jobTitleController,
          ),
          _buildFormField(
            label: 'جهة العمل',
            hintText: 'أدخل جهة العمل',
            validator: AppValidator.emptyValidator,
            controller: cubit.workEntityController,
          ),
          _buildFormField(
            label: 'الهوية',
            hintText: 'أدخل رقم الهوية',
            validator: AppValidator.emptyValidator,
            controller: cubit.idController,
          ),
          _buildAcademicDegreeField(),
        ],

        _buildPasswordField(),
        _buildPasswordConfirmationField(),
        // _buildFormField(
        //   label: 'تأكيد كلمة السر',
        //   hintText: 'أعد إدخال كلمة السر',
        //   isObscureText: true,
        //   validator: AppValidator.passwordValidator,
        //   controller: cubit.confirmPasswordController,
        // ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required String? Function(String?) validator,
    required TextEditingController? controller,
    Widget? suffixIcon,
    bool? enabled,
    bool isObscureText = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: label,
              style: TextStyles.font12GrayRegular,
            ),
          ),
          Gap(5.h),
          AppTextFormField(
            hintText: hintText,
            validator: validator,
            enabled: enabled,
            backgroundColor: AppColors.white,
            isObscureText: isObscureText,
            suffixIcon: suffixIcon,
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicDegreeField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: 'الدرجة العلمية',
              style: TextStyles.font12GrayRegular,
            ),
          ),
          Gap(5.h),
          // Use a Stack to place the icon over the disabled field
          Stack(
            alignment: Alignment
                .centerLeft, // For RTL, this is actually the right side
            children: [
              // The disabled text field
              AppTextFormField(
                hintText: 'أدخل الدرجة العلمية (اختياري)',
                validator: (value) => null, // Make it optional
                backgroundColor: AppColors.white,
                enabled: false,
                controller: cubit.academicDegreeController,
              ),
              // The clickable icon placed over the field
              Positioned(
                left: 0.0, // Adjust position as needed for RTL
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // print("Icon tapped independently");
                      _selectAcademicDegreeFile();
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.upload_file,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: 'كلمة السر',
              style: TextStyles.font12GrayRegular,
            ),
          ),
          Gap(5.h),
          AppTextFormField(
            hintText: 'أدخل كلمة السر',
            isObscureText: isPasswordObscured,
            validator: AppValidator.passwordValidator,
            backgroundColor: AppColors.white,
            controller: cubit.passwordController,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              child: Icon(
                isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordConfirmationField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: 'تأكيد كلمة السر',
              style: TextStyles.font12GrayRegular,
            ),
          ),
          Gap(5.h),
          AppTextFormField(
            hintText: 'أعد إدخال كلمة السر',
            isObscureText: isPasswordObscured,
            validator: AppValidator.passwordValidator,
            backgroundColor: AppColors.white,
            controller: cubit.confirmPasswordController,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              child: Icon(
                isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomButton(
        onTap: _submitForm,
        height: 45.h,
        labelText: 'إنشاء الحساب',
        textFontSize: 16.sp,
        textColor: AppColors.white,
      ),
    );
  }

  void _submitForm() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Validate the form
    if (_formKey.currentState!.validate()) {
      // Check required fields
      if (cubit.fullNameController.text.isEmpty) {
        _showErrorSnackBar('يرجى إدخال الاسم الكامل');
        return;
      }

      if (cubit.emailController.text.isEmpty) {
        _showErrorSnackBar('يرجى إدخال البريد الإلكتروني');
        return;
      }

      if (cubit.phoneController.text.isEmpty) {
        _showErrorSnackBar('يرجى إدخال رقم التواصل');
        return;
      }

      // Check if password and confirm password match
      if (cubit.passwordController.text !=
          cubit.confirmPasswordController.text) {
        _showErrorSnackBar('كلمة المرور غير متطابقة');
        return;
      }

      // Additional validation for instructor fields
      if (widget.isTrainer) {
        if (cubit.nationalityController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال الجنسية');
          return;
        }

        if (cubit.countryOfResidenceController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال بلد الإقامة');
          return;
        }

        if (cubit.governorateController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال المحافظة');
          return;
        }

        if (cubit.academicDegreeTextController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال الدرجة العلمية');
          return;
        }

        if (cubit.specialtyController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال التخصص');
          return;
        }

        if (cubit.jobTitleController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال المسمى الوظيفي');
          return;
        }

        if (cubit.workEntityController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال جهة العمل');
          return;
        }

        if (cubit.idController.text.isEmpty) {
          _showErrorSnackBar('يرجى إدخال رقم الهوية');
          return;
        }
      }

      // Academic degree file is optional for now since the upload endpoint seems to be missing
      // if (cubit.academicDegreeFilePath == null) {
      //   _showErrorSnackBar('يرجى اختيار ملف الدرجة العلمية');
      //   return;
      // }

      // Submit the registration form
      cubit.emitRegisterStates(
        fullName: cubit.fullNameController.text,
        password: cubit.passwordController.text,
        phone: cubit.phoneController.text,
        email: cubit.emailController.text,
        idNumber: widget.isTrainer ? cubit.idController.text : '',
      );
    }
  }

  void _showErrorSnackBar(String message) {
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
  }

  // New simplified file picker function
  Future<void> _selectAcademicDegreeFile() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        final file = result.files.first;
        cubit.setAcademicDegreeFile(file.path!, file.name);

        // Show success message
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم اختيار الملف: ${file.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ أثناء اختيار الملف'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
