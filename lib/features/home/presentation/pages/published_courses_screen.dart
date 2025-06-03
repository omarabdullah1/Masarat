import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/theme/styles.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/courses/data/models/category_model.dart';
import 'package:masarat/features/instructor/instructor_home/data/models/course_model.dart';
import 'package:masarat/features/instructor/instructor_home/logic/cubit/published_courses_cubit.dart';
import 'package:masarat/features/instructor/instructor_home/logic/cubit/published_courses_state.dart';

import '../../../instructor/instructor_home/presentation/widgets/published_courses_bloc_listener.dart';

class PublishedCoursesScreen extends StatefulWidget {
  const PublishedCoursesScreen({super.key});

  @override
  State<PublishedCoursesScreen> createState() => _PublishedCoursesScreenState();
}

class _PublishedCoursesScreenState extends State<PublishedCoursesScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<String> levels = ['beginner', 'intermediate', 'advanced', 'all'];
  String? _selectedLevel;
  CategoryModel? _selectedCategory;
  List<CategoryModel> _categories = [];
  bool _isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    // Load courses when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<PublishedCoursesCubit>();
      cubit.getPublishedCourses();
      _loadCategories();
    });

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<PublishedCoursesCubit>();
      if (!cubit.isLoading && cubit.hasMoreData) {
        cubit.loadMoreCourses();
      }
    }
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoadingCategories = true;
    });

    // Fetch categories from the cubit
    final cubit = context.read<PublishedCoursesCubit>();

    setState(() {
      // Get the categories from the cubit
      _categories = cubit.categories;
      _isLoadingCategories = false;
      if (_categories.isNotEmpty) {
        _selectedCategory = _categories.first;
      }
    });
  }

  void _applyFilters() {
    final cubit = context.read<PublishedCoursesCubit>();
    final categoryId =
        _selectedCategory?.id == 'all' ? null : _selectedCategory?.id;
    final level = _selectedLevel == 'all' ? null : _selectedLevel;

    // Reset and fetch courses with the new filters
    cubit.resetAndFetchCourses(
      categoryId: categoryId,
      level: level,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      title: 'الدورات المنشورة',
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const PublishedCoursesBlocListener(),
          // Filter section
          _buildFiltersSection(),
          // Courses list
          Expanded(
            child: BlocBuilder<PublishedCoursesCubit, PublishedCoursesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (coursesResponse) {
                    if (coursesResponse.courses.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: 'لا توجد دورات منشورة',
                          style: TextStyles.font16greyBold,
                        ),
                      );
                    }
                    return _buildCoursesList(coursesResponse.courses);
                  },
                  error: (error) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: error,
                          style: TextStyles.font16greyBold,
                        ),
                        Gap(16.h),
                        CustomButton(
                          labelText: 'إعادة المحاولة',
                          radius: 8.r,
                          buttonColor: AppColors.primary,
                          textColor: AppColors.white,
                          onTap: () => _applyFilters(),
                          height: 40.h,
                          textFontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'تصفية الدورات',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: AppColors.primary,
            ),
          ),
          Gap(12.h),
          // Category filter
          Row(
            children: [
              CustomText(
                text: 'التصنيف:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: AppColors.gray,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: _isLoadingCategories
                    ? const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : _buildCategoryDropdown(),
              ),
            ],
          ),
          Gap(12.h),
          // Level filter
          Row(
            children: [
              CustomText(
                text: 'المستوى:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: AppColors.gray,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: _buildLevelDropdown(),
              ),
            ],
          ),
          Gap(16.h),
          // Apply filters button
          Center(
            child: CustomButton(
              labelText: 'تطبيق الفلتر',
              radius: 8.r,
              buttonColor: AppColors.primary,
              textColor: AppColors.white,
              onTap: _applyFilters,
              height: 40.h,
              textFontSize: 14.sp,
              icon: Icons.filter_alt,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lighterGray),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CategoryModel>(
          isExpanded: true,
          value: _selectedCategory,
          hint: const Text('اختر التصنيف'),
          items: _categories.map<DropdownMenuItem<CategoryModel>>((category) {
            return DropdownMenuItem<CategoryModel>(
              value: category,
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.gray,
                ),
              ),
            );
          }).toList(),
          onChanged: (CategoryModel? category) {
            if (category != null) {
              setState(() {
                _selectedCategory = category;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildLevelDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lighterGray),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedLevel,
          hint: const Text('اختر المستوى'),
          items: levels.map<DropdownMenuItem<String>>((level) {
            String displayName = level;
            if (level == 'beginner') displayName = 'مبتدئ';
            if (level == 'intermediate') displayName = 'متوسط';
            if (level == 'advanced') displayName = 'متقدم';
            if (level == 'all') displayName = 'الكل';

            return DropdownMenuItem<String>(
              value: level,
              child: Text(
                displayName,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.gray,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? level) {
            setState(() {
              _selectedLevel = level;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCoursesList(List<CourseModel> courses) {
    final cubit = context.read<PublishedCoursesCubit>();
    final bool isLoadingMore = cubit.isLoading && courses.isNotEmpty;

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(16.r),
          itemCount: courses.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == courses.length && isLoadingMore) {
              // Show loading indicator at the end
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: const CircularProgressIndicator(),
                ),
              );
            }
            if (index < courses.length) {
              return _CourseCard(
                course: courses[index],
                onTap: () => _navigateToCourseDetails(courses[index]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        // Pull to refresh indicator
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: RefreshIndicator(
            onRefresh: () async {
              _applyFilters();
            },
            child: const SizedBox(
              height: 100,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToCourseDetails(CourseModel course) {
    // Navigate to course details using GoRouter
    context.goNamed(
      AppRoute.courseDetails,
      pathParameters: {'courseid': course.id},
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback? onTap;

  const _CourseCard({required this.course, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: 16.h),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  course.coverImageUrl,
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 150.h,
                    width: double.infinity,
                    color: AppColors.lighterGray,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50.r,
                      color: AppColors.gray,
                    ),
                  ),
                ),
              ),
              Gap(12.h),
              CustomText(
                text: course.title,
                style: TextStyles.font18greyBold,
              ),
              Gap(8.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: course.category.name,
                      style: TextStyles.font12PrimaryRegular,
                    ),
                  ),
                  Gap(8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: _getArabicLevel(course.level),
                      style: TextStyles.font12GrayRegular,
                    ),
                  ),
                ],
              ),
              Gap(8.h),
              CustomText(
                text: course.description,
                style: TextStyles.font14greyRegular,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: '${course.price} ر.س',
                    style: TextStyles.font16PrimaryBold,
                  ),
                  CustomText(
                    text: 'المدة: ${course.durationEstimate}',
                    style: TextStyles.font14greyRegular,
                  ),
                ],
              ),
              Gap(8.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12.r,
                    backgroundImage:
                        course.instructor.profilePictureUrl != null &&
                                course.instructor.profilePictureUrl!.isNotEmpty
                            ? NetworkImage(course.instructor.profilePictureUrl!)
                            : null,
                    child: course.instructor.profilePictureUrl == null ||
                            course.instructor.profilePictureUrl!.isEmpty
                        ? Icon(Icons.person, size: 16.r)
                        : null,
                  ),
                  Gap(8.w),
                  CustomText(
                    text:
                        'المدرب: ${course.instructor.firstName} ${course.instructor.lastName}',
                    style: TextStyles.font12GrayRegular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getArabicLevel(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 'مبتدئ';
      case 'intermediate':
        return 'متوسط';
      case 'advanced':
        return 'متقدم';
      default:
        return level;
    }
  }
}
