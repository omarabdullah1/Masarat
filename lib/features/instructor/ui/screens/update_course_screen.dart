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
import 'package:masarat/features/instructor/logic/update_course/update_course_cubit.dart';
import 'package:masarat/features/instructor/logic/update_course/update_course_state.dart';
import 'package:masarat/features/instructor/ui/widgets/update_course_bloc_listener.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../instructor/data/models/category/category_model.dart';

class UpdateCourseScreen extends StatefulWidget {
  const UpdateCourseScreen({
    Key? key,
    required this.courseId,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseLevel,
    required this.courseDurationEstimate,
    required this.courseTags,
    required this.coursePrice,
    required this.courseCategoryId,
    this.verificationStatus,
    this.isPublished,
  }) : super(key: key);

  final String courseId;
  final String courseTitle;
  final String courseDescription;
  final String courseLevel;
  final String courseDurationEstimate;
  final List<String> courseTags;
  final double coursePrice;
  final String courseCategoryId;
  final String? verificationStatus;
  final bool? isPublished;

  @override
  State<UpdateCourseScreen> createState() => _UpdateCourseScreenState();
}

class _UpdateCourseScreenState extends State<UpdateCourseScreen> {
  late UpdateCourseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<UpdateCourseCubit>();

    // Initialize the form with course data after a brief delay to ensure categories are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCourseData();
    });
  }

  void _initializeCourseData() {
    // If categories are already loaded, initialize immediately
    if (cubit.categories.isNotEmpty) {
      _setInitialData();
    } else {
      // Wait for categories to load
      _waitForCategoriesAndInitialize();
    }
  }

  void _waitForCategoriesAndInitialize() {
    // Listen for state changes to detect when categories are loaded
    final subscription = cubit.stream.listen((state) {
      state.when(
        initial: () {},
        loadingCategories: () {},
        categoriesLoaded: (categories) {
          _setInitialData();
        },
        categoriesError: (error) {},
        updating: () {},
        updateSuccess: (course) {},
        updateError: (error) {},
      );
    });

    // Cancel subscription after initialization
    Future.delayed(const Duration(seconds: 5), () {
      subscription.cancel();
    });
  }

  void _setInitialData() {
    cubit.initializeWithCourse(
      id: widget.courseId,
      title: widget.courseTitle,
      description: widget.courseDescription,
      level: widget.courseLevel,
      durationEstimate: widget.courseDurationEstimate,
      tags: widget.courseTags,
      price: widget.coursePrice,
      categoryId: widget.courseCategoryId,
      verificationStatus: widget.verificationStatus,
      isPublished: widget.isPublished,
    );
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.read<UpdateCourseCubit>();

    return CustomScaffold(
      haveAppBar: true,
      title: "تحديث الدورة",
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
                const UpdateCourseBlocListener(),
                _buildTitleField(),
                Gap(16.h),
                _buildDescriptionField(),
                Gap(16.h),
                _buildCategoryDropdown(),
                Gap(16.h),
                _buildLevelField(),
                Gap(16.h),
                _buildDurationField(),
                Gap(16.h),
                _buildTagsField(),
                Gap(16.h),
                _buildPriceField(),
                Gap(32.h),
                _buildUpdateButton(),
                Gap(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "عنوان الدورة",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          controller: cubit.titleController,
          hintText: "أدخل عنوان الدورة",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "عنوان الدورة مطلوب";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "وصف الدورة",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          controller: cubit.descriptionController,
          hintText: "أدخل وصف الدورة",
          maxLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "وصف الدورة مطلوب";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "فئة الدورة",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        BlocBuilder<UpdateCourseCubit, UpdateCourseState>(
          builder: (context, state) {
            return state.when(
              initial: () => _buildCategoryDropdownWidget(cubit.categories),
              loadingCategories: () => Skeletonizer(
                enabled: true,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              categoriesLoaded: (categories) =>
                  _buildCategoryDropdownWidget(categories),
              categoriesError: (error) => Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 20.sp),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        "خطأ في تحميل الفئات: $error",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              updating: () => _buildCategoryDropdownWidget(cubit.categories),
              updateSuccess: (course) =>
                  _buildCategoryDropdownWidget(cubit.categories),
              updateError: (error) =>
                  _buildCategoryDropdownWidget(cubit.categories),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryDropdownWidget(List<CategoryModel> categories) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CategoryModel>(
          isExpanded: true,
          value: cubit.selectedCategory,
          hint: Text(
            "اختر فئة الدورة",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.gray,
            ),
          ),
          items: categories.map((CategoryModel category) {
            return DropdownMenuItem<CategoryModel>(
              value: category,
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            );
          }).toList(),
          onChanged: (CategoryModel? newCategory) {
            cubit.updateSelectedCategory(newCategory);
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildLevelField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "مستوى الدورة",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          controller: cubit.levelController,
          hintText: "مثال: مبتدئ، متوسط، متقدم",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "مستوى الدورة مطلوب";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDurationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "المدة المقدرة (بالساعات)",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          controller: cubit.durationEstimateController,
          hintText: "أدخل المدة المقدرة",
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "المدة المقدرة مطلوبة";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTagsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الكلمات المفتاحية",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          controller: cubit.tagsController,
          hintText: "أدخل الكلمات المفتاحية مفصولة بفواصل",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "الكلمات المفتاحية مطلوبة";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "سعر الدورة",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.medium,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        AppTextFormField(
          controller: cubit.priceController,
          hintText: "أدخل سعر الدورة",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "سعر الدورة مطلوب";
            }
            final price = double.tryParse(value);
            if (price == null || price < 0) {
              return "أدخل سعرًا صحيحًا";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return BlocBuilder<UpdateCourseCubit, UpdateCourseState>(
      builder: (context, state) {
        final isLoading = state.when(
          initial: () => false,
          loadingCategories: () => false,
          categoriesLoaded: (categories) => false,
          categoriesError: (error) => false,
          updating: () => true,
          updateSuccess: (course) => false,
          updateError: (error) => false,
        );

        return CustomButton(
          onTap: isLoading
              ? null
              : () {
                  log('Update button pressed');
                  cubit.updateCourse();
                },
          labelText: isLoading ? "جاري التحديث..." : "تحديث الدورة",
          buttonColor: AppColors.primary,
          textColor: Colors.white,
        );
      },
    );
  }
}
