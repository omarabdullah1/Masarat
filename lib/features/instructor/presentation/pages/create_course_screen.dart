import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_cubit.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_state.dart';
import 'package:masarat/features/instructor/presentation/widgets/create_course_bloc_listener.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/category/category_model.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({Key? key}) : super(key: key);

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  late CreateCourseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CreateCourseCubit>();
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.read<CreateCourseCubit>();

    return CustomScaffold(
      haveAppBar: true,
      title: "إنشاء دورة جديدة",
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                _buildFormField(
                  label: 'عنوان الدورة',
                  hintText: 'أدخل عنوان الدورة',
                  controller: cubit.titleController,
                  validator: _requiredValidator,
                ),

                // Description
                _buildFormField(
                  label: 'وصف الدورة',
                  hintText: 'أدخل وصف الدورة',
                  controller: cubit.descriptionController,
                  validator: _requiredValidator,
                  maxLines: 3,
                ),

                // Category Dropdown
                _buildCategoryDropdown(),

                // Level
                _buildFormField(
                  label: 'المستوى',
                  hintText:
                      'أدخل مستوى الدورة (beginner, intermediate, advanced)',
                  controller: cubit.levelController,
                  validator: _levelValidator,
                ),

                // Duration Estimate
                _buildFormField(
                  label: 'تقدير المدة',
                  hintText: 'أدخل تقدير مدة الدورة (مثال: 40 ساعة)',
                  controller: cubit.durationEstimateController,
                  validator: _requiredValidator,
                ),

                // Price
                _buildFormField(
                  label: 'سعر الدورة',
                  hintText: 'أدخل سعر الدورة (مثال: 299.99)',
                  controller: cubit.priceController,
                  validator: _priceValidator,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),

                // Tags
                _buildFormField(
                  label: 'الكلمات المفتاحية',
                  hintText: 'أدخل الكلمات المفتاحية مفصولة بفواصل',
                  controller: cubit.tagsController,
                  validator: _requiredValidator,
                ),

                Gap(24.h),

                // Submit Button
                CustomButton(
                  onTap: _submitForm,
                  height: 45.h,
                  labelText: 'إنشاء الدورة',
                  textFontSize: 16.sp,
                  textColor: AppColors.white,
                ),

                // Add the BlocListener
                const CreateCourseBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          hintText: hintText,
          controller: controller,
          validator: validator,
          backgroundColor: AppColors.white,
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
        Gap(16.h),
      ],
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      log('Required validation failed for value: "$value"');
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  String? _levelValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      log('Level validation failed - empty value: "$value"');
      return 'هذا الحقل مطلوب';
    }
    if (!['beginner', 'intermediate', 'advanced']
        .contains(value.toLowerCase())) {
      log('Level validation failed - invalid level: "$value"');
      return 'المستوى يجب أن يكون beginner أو intermediate أو advanced';
    }
    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'يرجى إدخال سعر صحيح';
    }
    if (price < 0) {
      return 'السعر يجب أن يكون أكبر من أو يساوي الصفر';
    }
    return null;
  }

  void _submitForm() {
    log('Submit form called!'); // Debug log
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Submit the form
    cubit.createCourse();
    log('CreateCourse called!'); // Debug log
  }

  // New method to build category dropdown
  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'التصنيف',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        Gap(8.h),
        BlocBuilder<CreateCourseCubit, CreateCourseState>(
          buildWhen: (previous, current) =>
              current is LoadingCategories ||
              current is CategoriesLoaded ||
              current is CategoriesError ||
              previous is LoadingCategories,
          builder: (context, state) {
            return state.maybeWhen(
              loadingCategories: () => _buildLoadingCategoriesWidget(),
              categoriesLoaded: (categories) =>
                  _buildCategoryDropdownWidget(categories),
              categoriesError: (error) => _buildCategoryErrorWidget(error),
              orElse: () {
                // Access categories directly from cubit as a fallback
                final categories = cubit.categories;

                // Show loading if categories are empty (assuming they're being loaded)
                if (categories.isEmpty) {
                  return _buildLoadingCategoriesWidget();
                } else {
                  return _buildCategoryDropdownWidget(categories);
                }
              },
            );
          },
        ),
        Gap(16.h),
      ],
    );
  }

  Widget _buildCategoryErrorWidget(String error) {
    return InkWell(
      onTap: () {
        cubit.loadCategories();
      },
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.red.shade300),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'خطأ في تحميل التصنيفات. انقر لإعادة المحاولة',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.refresh,
              color: Colors.red,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCategoriesWidget() {
    return Skeletonizer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<CategoryModel>(
            isExpanded: true,
            hint: Text(
              'اختر التصنيف',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            value: cubit.selectedCategory,
            items: [].map<DropdownMenuItem<CategoryModel>>((category) {
              return DropdownMenuItem<CategoryModel>(
                value: category,
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              );
            }).toList(),
            onChanged: (CategoryModel? selectedCategory) {
              if (selectedCategory != null) {}
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdownWidget(List<CategoryModel> categories) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CategoryModel>(
          isExpanded: true,
          hint: Text(
            'اختر التصنيف',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          value: cubit.selectedCategory,
          items: categories.map<DropdownMenuItem<CategoryModel>>((category) {
            return DropdownMenuItem<CategoryModel>(
              value: category,
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            );
          }).toList(),
          onChanged: (CategoryModel? selectedCategory) {
            if (selectedCategory != null) {
              setState(() {
                cubit.setSelectedCategory(selectedCategory);
              });
            }
          },
        ),
      ),
    );
  }
}
