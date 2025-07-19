import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/di/dependency_injection.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/core/widgets/loading_widget.dart';
import 'package:masarat/features/instructor/data/models/add_lesson/add_lesson_request_body.dart';
import 'package:masarat/features/instructor/data/models/lesson/lesson_model.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/add_lesson/add_lesson_state.dart';
import 'package:masarat/features/instructor/logic/delete_lesson/delete_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/delete_lesson/delete_lesson_state.dart';
import 'package:masarat/features/instructor/logic/get_lessons/get_lessons_cubit.dart';
import 'package:masarat/features/instructor/logic/get_lessons/get_lessons_state.dart';
import 'package:masarat/features/instructor/logic/update_lesson/update_lesson_cubit.dart';
import 'package:masarat/features/instructor/logic/update_lesson/update_lesson_state.dart';
import 'package:masarat/features/instructor/presentation/widgets/lessons_list_widget.dart';
import 'package:masarat/features/student/courses/presentation/widgets/add_lecture_button_widget.dart';
import 'package:masarat/features/student/courses/presentation/widgets/add_lecture_form_widget.dart';

class InstructorCourseManagementPage extends StatefulWidget {
  const InstructorCourseManagementPage({required this.courseId, super.key});
  final String courseId;

  @override
  State<InstructorCourseManagementPage> createState() =>
      _InstructorCourseManagementPageState();
}

class _InstructorCourseManagementPageState
    extends State<InstructorCourseManagementPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddLessonCubit>()),
        BlocProvider(create: (context) => getIt<DeleteLessonCubit>()),
        BlocProvider(
            create: (context) =>
                getIt<GetLessonsCubit>()..getLessons(widget.courseId)),
        BlocProvider(create: (context) => getIt<UpdateLessonCubit>()),
      ],
      child: _CourseManagementContent(courseId: widget.courseId),
    );
  }
}

class _CourseManagementContent extends StatefulWidget {
  const _CourseManagementContent({required this.courseId});
  final String courseId;

  @override
  State<_CourseManagementContent> createState() =>
      _CourseManagementContentState();
}

class _CourseManagementContentState extends State<_CourseManagementContent> {
  // State variables
  bool isAddingLecture = false;
  bool isEditingLesson = false;
  LessonModel? lessonBeingEdited;

  // Controllers for add mode
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  // Controllers for edit mode
  final TextEditingController editTitleController = TextEditingController();
  final TextEditingController editContentController = TextEditingController();
  final TextEditingController editContentTypeController =
      TextEditingController();
  final TextEditingController editOrderController = TextEditingController();
  final TextEditingController editDurationEstimateController =
      TextEditingController();
  bool isPreviewable = false;

  // Form key for validation
  final _editFormKey = GlobalKey<FormState>();

  PlatformFile? selectedFile;

  @override
  void dispose() {
    // Dispose add mode controllers
    courseNameController.dispose();
    contentController.dispose();
    sourceController.dispose();
    orderController.dispose();
    durationController.dispose();

    // Dispose edit mode controllers
    editTitleController.dispose();
    editContentController.dispose();
    editContentTypeController.dispose();
    editOrderController.dispose();
    editDurationEstimateController.dispose();
    super.dispose();
  }

  void _setupEditMode(LessonModel lesson) {
    setState(() {
      isEditingLesson = true;
      isAddingLecture = false;
      lessonBeingEdited = lesson;

      // Initialize controllers with lesson data
      editTitleController.text = lesson.title;
      editContentController.text = lesson.content;
      editContentTypeController.text = lesson.contentType;
      editOrderController.text = lesson.order.toString();
      editDurationEstimateController.text = lesson.durationEstimate;
      isPreviewable = lesson.isPreviewable;
    });
  }

  void _cancelEditMode() {
    setState(() {
      isEditingLesson = false;
      lessonBeingEdited = null;

      // Clear edit controllers
      editTitleController.clear();
      editContentController.clear();
      editContentTypeController.clear();
      editOrderController.clear();
      editDurationEstimateController.clear();
    });
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (!mounted) return;

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.first;
          // Update source controller with file name
          sourceController.text = selectedFile!.name;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم اختيار الملف: ${selectedFile!.name}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ في اختيار الملف: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void addLecture() {
    // Debug: log values to check what's empty
    log('Course name: ${courseNameController.text}');
    log('Content: ${contentController.text}');
    log('Order: ${orderController.text}');
    log('Duration: ${durationController.text}');

    // Improved validation with specific messages
    String errorMessage = '';

    if (courseNameController.text.trim().isEmpty) {
      errorMessage = 'يرجى إدخال عنوان الدرس';
    } else if (contentController.text.trim().isEmpty) {
      errorMessage = 'يرجى إدخال رابط المحتوى';
    } else if (orderController.text.trim().isEmpty) {
      errorMessage = 'يرجى إدخال ترتيب الدرس';
    } else if (int.tryParse(orderController.text.trim()) == null) {
      errorMessage = 'ترتيب الدرس يجب أن يكون رقمًا صحيحًا';
    } else if (durationController.text.trim().isEmpty) {
      errorMessage = 'يرجى إدخال مدة الدرس المقدرة';
    }

    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    // All fields are valid, create the add lesson request
    final requestBody = AddLessonRequestBody(
      title: courseNameController.text.trim(),
      contentType: 'video', // Default to video, can be made dynamic
      content: contentController.text.trim(),
      courseId: widget.courseId,
      order: int.tryParse(orderController.text.trim()) ?? 1,
      durationEstimate: durationController.text.trim(),
      isPreviewable: false, // Default to false, can be made dynamic
    ); // Call the BLoC to add the lesson
    context.read<AddLessonCubit>().addLesson(requestBody);
  }

  void _updateLesson() {
    if (_editFormKey.currentState?.validate() ?? false) {
      if (lessonBeingEdited == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطأ: لا يوجد درس للتعديل'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final int order =
          int.tryParse(editOrderController.text) ?? lessonBeingEdited!.order;

      context.read<UpdateLessonCubit>().updateLesson(
            lessonBeingEdited!.id,
            editTitleController.text.trim(),
            editContentTypeController.text.trim(),
            editContentController.text.trim(),
            order,
            editDurationEstimateController.text.trim(),
            isPreviewable,
          );
    }
  }

  Widget _buildEditLessonForm() {
    return Container(
      margin: EdgeInsets.all(8.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _editFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'تعديل الدرس',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _cancelEditMode,
                ),
              ],
            ),
            Divider(height: 16.h),
            Gap(8.h),

            // Title
            CustomText(
              text: 'عنوان الدرس',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                color: AppColors.black,
              ),
            ),
            Gap(8.h),
            AppTextFormField(
              controller: editTitleController,
              hintText: 'أدخل عنوان الدرس',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال عنوان الدرس';
                }
                return null;
              },
            ),
            Gap(16.h),

            // Content Type
            CustomText(
              text: 'نوع المحتوى',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                color: AppColors.black,
              ),
            ),
            Gap(8.h),
            AppTextFormField(
              controller: editContentTypeController,
              hintText: 'أدخل نوع المحتوى (فيديو، نص)',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال نوع المحتوى';
                }
                return null;
              },
            ),
            Gap(16.h),

            // Content
            CustomText(
              text: 'المحتوى',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                color: AppColors.black,
              ),
            ),
            Gap(8.h),
            AppTextFormField(
              controller: editContentController,
              hintText: 'أدخل محتوى الدرس',
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال محتوى الدرس';
                }
                return null;
              },
            ),
            Gap(16.h),

            // Order
            CustomText(
              text: 'ترتيب الدرس',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                color: AppColors.black,
              ),
            ),
            Gap(8.h),
            AppTextFormField(
              controller: editOrderController,
              hintText: 'أدخل ترتيب الدرس',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال ترتيب الدرس';
                }
                if (int.tryParse(value) == null) {
                  return 'يرجى إدخال رقم صحيح';
                }
                return null;
              },
            ),
            Gap(16.h),

            // Duration Estimate
            CustomText(
              text: 'المدة التقديرية',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                color: AppColors.black,
              ),
            ),
            Gap(8.h),
            AppTextFormField(
              controller: editDurationEstimateController,
              hintText: 'أدخل المدة التقديرية',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال المدة التقديرية';
                }
                return null;
              },
            ),
            Gap(16.h),

            // Is Previewable Switch
            Row(
              children: [
                Switch(
                  value: isPreviewable,
                  activeColor: AppColors.primary,
                  onChanged: (bool value) {
                    setState(() {
                      isPreviewable = value;
                    });
                  },
                ),
                Gap(8.w),
                CustomText(
                  text: 'متاح للمعاينة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.regular,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Gap(24.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                labelText: 'حفظ التعديلات',
                onTap: () => _updateLesson(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddLessonCubit, AddLessonState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (data) {
                // Hide form after successful lesson addition
                setState(() {
                  isAddingLecture = false;
                });

                // Clear controllers
                courseNameController.clear();
                contentController.clear();
                sourceController.clear();
                orderController.clear();
                durationController.clear();

                // Refresh lessons list
                context.read<GetLessonsCubit>().getLessons(widget.courseId);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إضافة الدرس بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              error: (error) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطأ في إضافة الدرس: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              orElse: () {},
            );
          },
        ),
        BlocListener<DeleteLessonCubit, DeleteLessonState>(
          listener: (context, state) {
            state.maybeWhen(
              success: () {
                // Refresh lessons list after successful deletion
                context.read<GetLessonsCubit>().getLessons(widget.courseId);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم حذف الدرس بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              error: (error) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطأ في حذف الدرس: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              orElse: () {},
            );
          },
        ),
        BlocListener<UpdateLessonCubit, UpdateLessonState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingWidget(
                    loadingState: true,
                    backgroundColor: AppColors.transparent,
                  ),
                );
              },
              success: (updatedLesson) {
                // Close loading dialog
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }

                // Close edit mode
                _cancelEditMode();

                // Refresh lessons list
                context.read<GetLessonsCubit>().getLessons(widget.courseId);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تعديل الدرس بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              error: (error) {
                // Close loading dialog
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }

                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطأ في تعديل الدرس: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: CustomScaffold(
        haveAppBar: true,
        backgroundColorAppColor: AppColors.background,
        backgroundColor: AppColors.background,
        drawerIconColor: AppColors.primary,
        showBackButton: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      text: 'الــدورات التدريبيــة',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22.sp,
                        fontWeight: FontWeightHelper.regular,
                      ),
                    ),
                  ),
                  Gap(15.h),

                  // Only show add lesson button if not in edit mode
                  if (!isEditingLesson)
                    AddLectureButtonWidget(
                      isAddingLecture: isAddingLecture,
                      toggleAddLecture: () {
                        setState(() {
                          isAddingLecture =
                              !isAddingLecture; // Toggle visibility
                        });
                      },
                    ),

                  // Show add lecture form if adding lecture and not editing
                  if (isAddingLecture && !isEditingLesson)
                    AddLectureFormWidget(
                      courseNameController: courseNameController,
                      contentController: contentController,
                      sourceController: sourceController,
                      orderController: orderController,
                      durationController: durationController,
                      addLecture: addLecture,
                      onUploadPressed: pickFile,
                    ),

                  // Show edit form if in edit mode
                  if (isEditingLesson) _buildEditLessonForm(),

                  SizedBox(height: 16.h),
                  BlocBuilder<GetLessonsCubit, GetLessonsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () => SizedBox(
                          height: 200.h,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        success: (lessons) => LessonsListWidget(
                          lessons: lessons,
                          onEditLesson: (lesson) {
                            // Setup edit mode with selected lesson
                            _setupEditMode(lesson);
                          },
                          onDeleteLesson: (lesson) {
                            // Show confirmation dialog before deleting
                            showDialog(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: const Text('تأكيد الحذف'),
                                content: Text(
                                    'هل أنت متأكد من حذف الدرس "${lesson.title}"؟'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    child: const Text('إلغاء'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                      // Call delete lesson cubit
                                      context
                                          .read<DeleteLessonCubit>()
                                          .deleteLesson(lesson.id);
                                    },
                                    child: const Text('حذف',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        error: (error) => SizedBox(
                          height: 200.h,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Error loading lessons: $error',
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<GetLessonsCubit>()
                                        .getLessons(widget.courseId);
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                  // Add some bottom padding to ensure content doesn't get cut off
                  SizedBox(height: 80.h),
                ],
              ),
            ),
            // Loading overlay
            BlocBuilder<AddLessonCubit, AddLessonState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => Container(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            // Delete lesson loading overlay
            BlocBuilder<DeleteLessonCubit, DeleteLessonState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => Container(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
