import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/constants/validators.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.isTrainer, super.key});
  final bool isTrainer;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isPasswordObscured = true;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Image and Edit Icon
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150', // Replace with actual image URL
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.teal,
                    child: SvgPicture.asset(
                      AppImage.editIcon,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const CustomText(
              text: 'عبدالله محمد جبريل',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Input Fields
            _buildFormField(
              label: 'الاسم بالكامل',
              hintText: 'أدخل الاسم الكامل',
              validator: AppValidator.emptyValidator,
            ),
            _buildFormField(
              label: 'رقم التواصل',
              hintText: 'أدخل رقم التواصل',
              validator: AppValidator.phoneValidator,
            ),

            _buildFormField(
              label: 'البريد الإلكتروني',
              hintText: 'Example@gmail.com',
              validator: AppValidator.emailValidator,
            ),
            if (widget.isTrainer) ...[
              _buildFormField(
                label: 'رقم التواصل',
                hintText: 'أدخل رقم التواصل',
                validator: AppValidator.phoneValidator,
              ),
              _buildFormField(
                label: 'الجنسية',
                hintText: 'أدخل الجنسية',
                validator: AppValidator.emptyValidator,
              ),
              _buildFormField(
                label: 'الدولة التي تعيش بها',
                hintText: 'أدخل الدولة التي تعيش بها',
                validator: AppValidator.emptyValidator,
              ),
              _buildFormField(
                label: 'المحافظة',
                hintText: 'أدخل المحافظة',
                validator: AppValidator.emptyValidator,
              ),
              _buildFormField(
                label: 'المؤهل العلمي',
                hintText: 'أدخل المؤهل العلمي',
                validator: AppValidator.emptyValidator,
              ),
              _buildFormField(
                label: 'التخصص',
                hintText: 'أدخل التخصص',
                validator: AppValidator.emptyValidator,
              ),
              _buildFormField(
                label: 'الجهه التي تعمل بها',
                hintText: 'أدخل الجهه التي تعمل بها',
                validator: AppValidator.emptyValidator,
              ),
            ] else ...[
              _buildFormField(
                label: 'المؤهل العلمي',
                hintText: 'أدخل الدرجة العلمية',
                validator: AppValidator.emptyValidator,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.upload),
                ),
                enabled: false,
              ),
            ],

            _buildPasswordField(),
            Gap(20.h),
            // Save Button
            _buildSignUpButton(),
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
          ],
        ),
      ),
    );
  }

  // Reusable Input Field Widget
  Widget buildTextField(
    String label,
    String placeholder, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.teal),
            ),
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required String? Function(String?) validator,
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
            backgroundColor: AppColors.withe,
            isObscureText: isObscureText,
            suffixIcon: suffixIcon,
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
            backgroundColor: AppColors.withe,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              child: Icon(
                isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomButton(
        onTap: () {
          // Handle sign-up logic
        },
        height: 45.h,
        labelText: 'حفظ التعديلات',
        textFontSize: 16.sp,
        textColor: AppColors.withe,
      ),
    );
  }
}
