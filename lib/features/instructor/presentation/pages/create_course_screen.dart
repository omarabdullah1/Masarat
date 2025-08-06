import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
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
import 'package:masarat/features/instructor/data/apis/instructor_api_constants.dart';
import 'package:masarat/features/instructor/data/models/course/course_model.dart'
    as instructor;
import 'package:masarat/features/instructor/logic/create_course/create_course_cubit.dart';
import 'package:masarat/features/instructor/logic/create_course/create_course_state.dart';
import 'package:masarat/features/instructor/presentation/widgets/create_course_bloc_listener.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../data/models/category/category_model.dart';

class CreateCourseScreen extends StatefulWidget {
  final instructor.CourseModel? course;
  const CreateCourseScreen({Key? key, this.course}) : super(key: key);

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  late CreateCourseCubit cubit;
  PlatformFile? _coverImage;
  late TextfieldTagsController<String> _tagsController;
  List<String> get _tags => _tagsController.getTags ?? [];
  final List<String> _levels = ['beginner', 'intermediate', 'advanced'];
  String? _selectedLevel;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CreateCourseCubit>();
    _selectedLevel = _levels.first;
    _tagsController = TextfieldTagsController<String>();
    _tagsController.addListener(() {
      setState(() {}); // Rebuild to reflect tag changes
    });

    if (isEditMode) {
      cubit.loadCategories();
    } else {
      cubit.loadCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.read<CreateCourseCubit>();

    return BlocListener<CreateCourseCubit, CreateCourseState>(
      listenWhen: (previous, current) =>
          current is CategoriesLoaded && isEditMode,
      listener: (context, state) {
        state.maybeWhen(
          categoriesLoaded: (categories) {
            _populateFields();
          },
          orElse: () {},
        );
      },
      child: CustomScaffold(
        haveAppBar: true,
        title: isEditMode ? "تعديل الدورة" : "إنشاء دورة جديدة",
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
                  // Cover Image Picker
                  _buildCoverImagePicker(),

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
                    maxLines: 6,
                  ),

                  // Category Dropdown
                  _buildCategoryDropdown(),

                  // Level Dropdown
                  _buildLevelDropdown(),

                  // Duration Estimate
                  _buildFormField(
                    label: 'تقدير المدة',
                    hintText: 'أدخل تقدير مدة الدورة (مثال: 40 ساعة)',
                    controller: cubit.durationEstimateController,
                    validator: _requiredValidator,
                    keyboardType: TextInputType.number,
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

                  // Tags Input
                  _buildTagsInput(),

                  Gap(24.h),

                  // Submit Button
                  CustomButton(
                    onTap: _submitForm,
                    height: 45.h,
                    labelText: isEditMode ? 'تحديث الدورة' : 'إنشاء الدورة',
                    textFontSize: 16.sp,
                    textColor: AppColors.white,
                    buttonColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    fontWeight: FontWeightHelper.bold,
                  ),

                  // Add the BlocListener
                  CreateCourseBlocListener(isEditMode: isEditMode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _populateFields() {
    final course = widget.course!;
    cubit.titleController.text = course.title;
    cubit.descriptionController.text = course.description;
    cubit.durationEstimateController.text = course.durationEstimate;
    cubit.priceController.text = course.price.toString();
    cubit.levelController.text = course.level;
    _selectedLevel = course.level.toLowerCase();
    // Set tags in both Cubit and UI
    if (course.tags.isNotEmpty) {
      cubit.tagsController.text = course.tags.join(',');
      _tagsController.clearTags();
      for (final tag in course.tags) {
        _tagsController.addTag(tag);
      }
    }
    // Set selected category after categories are loaded
    if (cubit.categories.isNotEmpty) {
      final match = cubit.categories.firstWhereOrNull(
        (cat) => cat.id == course.category.id,
      );
      if (match != null) {
        cubit.setSelectedCategory(match);
      } else {
        cubit.setSelectedCategory(cubit.categories.first);
      }
    }
    setState(() {});
  }

  Widget _buildCoverImagePicker() {
    log('Building cover image picker. isEditMode: $isEditMode, coverImageUrl: ${widget.course?.coverImageUrl}');
    if (isEditMode && widget.course?.coverImageUrl != null) {
      log('Image URL: ${InstructorApiConstants.imageUrl(widget.course!.coverImageUrl)}');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'صورة الغلاف',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        Gap(8.h),
        InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.image,
              withData: true,
            );
            if (result != null && result.files.isNotEmpty) {
              setState(() {
                _coverImage = result.files.first;
              });
            }
          },
          child: Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: AppColors.primary.withAlpha((0.2 * 255).toInt())),
            ),
            child: _coverImage == null
                ? (isEditMode && widget.course?.coverImageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: InstructorApiConstants.imageUrl(
                              widget.course!.coverImageUrl),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120.h,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : Center(
                        child: Icon(Icons.add_a_photo,
                            color: Colors.grey, size: 32.sp),
                      ))
                : (_coverImage?.bytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.memory(
                          _coverImage!.bytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120.h,
                        ),
                      )
                    : Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.red, size: 32.sp),
                      )),
          ),
        ),
        Gap(16.h),
      ],
    );
  }

  Widget _buildTagsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'الكلمات المفتاحية',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        Gap(8.h),
        TextFieldTags<String>(
          textfieldTagsController: _tagsController,
          textSeparators: const [',', ' '],
          validator: (String tag) {
            if (tag.isEmpty) {
              return 'لا يمكن أن تكون الكلمة فارغة';
            }
            if (_tags.where((t) => t == tag).isNotEmpty) {
              return 'تمت إضافة هذه الكلمة مسبقاً';
            }
            return null;
          },
          inputFieldBuilder: (context, inputFieldValues) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: AppColors.primary.withAlpha((0.2 * 255).toInt())),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ..._tags
                              .map((tag) => Chip(
                                    label: Text(tag),
                                    onDeleted: () {
                                      setState(() {
                                        _tagsController.removeTag(tag);
                                      });
                                    },
                                  ))
                              .toList(),
                          Container(
                            width: 150,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withAlpha((0.08 * 255).toInt()),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.primary
                                      .withAlpha((0.2 * 255).toInt())),
                            ),
                            child: TextField(
                              controller:
                                  inputFieldValues.textEditingController,
                              focusNode: inputFieldValues.focusNode,
                              decoration: InputDecoration(
                                hintText: 'أدخل كلمة مفتاحية',
                                errorText: inputFieldValues.error,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty &&
                                    (value.endsWith(' ') ||
                                        value.endsWith(','))) {
                                  final tag = value
                                      .substring(0, value.length - 1)
                                      .trim();
                                  if (tag.isNotEmpty && !_tags.contains(tag)) {
                                    setState(() {
                                      _tagsController.addTag(tag);
                                      inputFieldValues.textEditingController
                                          .clear();
                                    });
                                  }
                                }
                              },
                              onSubmitted: (_) {
                                final tag = inputFieldValues
                                    .textEditingController.text
                                    .trim();
                                if (tag.isNotEmpty && !_tags.contains(tag)) {
                                  setState(() {
                                    _tagsController.addTag(tag);
                                    inputFieldValues.textEditingController
                                        .clear();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        Gap(16.h),
      ],
    );
  }

  Widget _buildLevelDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'المستوى',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        Gap(8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedLevel,
              items: _levels.map((level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(
                    level,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedLevel = value;
                });
              },
            ),
          ),
        ),
        Gap(16.h),
      ],
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
    log('Submit form called! isEditMode: $isEditMode');
    FocusScope.of(context).unfocus();
    if (!cubit.formKey.currentState!.validate()) return;

    // Set level and tags in cubit before submitting
    cubit.levelController.text = _selectedLevel ?? '';
    cubit.tagsController.text = _tags.join(',');

    if (isEditMode) {
      // In edit mode, ensure we're using the update endpoint with the course ID
      log('Updating existing course with ID: ${widget.course!.id}');
      cubit.updateCourse(courseId: widget.course!.id, coverImage: _coverImage);
    } else {
      // In create mode, use the create endpoint
      log('Creating new course');
      cubit.createCourse(coverImage: _coverImage);
    }
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
          builder: (context, state) {
            return state.maybeWhen(
              loadingCategories: () {
                log('Category State: loadingCategories');
                return _buildLoadingCategoriesWidget();
              },
              categoriesLoaded: (categories) {
                log('Category State: categoriesLoaded');
                return _buildCategoryDropdownWidget(categories);
              },
              categoriesError: (error) {
                log('Category State: categoriesError');
                return _buildCategoryErrorWidget(error);
              },
              orElse: () {
                log('Category State: fallback orElse');
                final categories = cubit.categories;
                if (categories.isEmpty) {
                  log('Category State: fallback loading (categories empty)');
                  return _buildLoadingCategoriesWidget();
                } else {
                  log('Category State: fallback loaded (categories present)');
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
            value: null,
            items: [
              // Placeholder item for skeleton loading
              DropdownMenuItem<CategoryModel>(
                value: null,
                child: Text(
                  'جاري التحميل...',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
            onChanged: null, // Disabled during loading
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdownWidget(List<CategoryModel> categories) {
    log('Building category dropdown. Categories: $categories, Selected: ${cubit.selectedCategory}');
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

  bool get isEditMode => widget.course != null;
}
