import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';
import 'package:masarat/core/widgets/custom_button.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_cubit.dart';
import 'package:masarat/features/student/cart/logic/student_cart/student_cart_state.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_cubit.dart';
import 'package:masarat/features/student/courses/logic/training_courses/training_courses_state.dart';
import 'package:masarat/features/student/courses/presentation/widgets/level_filter_dropdown.dart';

class TrainingCoursesScreen extends StatefulWidget {
  const TrainingCoursesScreen({super.key});

  @override
  State<TrainingCoursesScreen> createState() => _TrainingCoursesScreenState();
}

class _TrainingCoursesScreenState extends State<TrainingCoursesScreen> {
  String? selectedOption; // Moved outside build to retain state
  final TextEditingController _searchController = TextEditingController();
  late StudentCartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = GetIt.instance<StudentCartCubit>();

    // Always load the cart data when the screen initializes
    // This ensures we have the latest cart state
    cartCubit.getCart().then((_) {
      // After loading cart data, examine its state
      cartCubit.state.maybeWhen(success: (cartData) {
        debugPrint('INIT: Cart loaded with ${cartData.items.length} items');
        // List all items in cart
        for (var item in cartData.items) {
          debugPrint(
              'INIT: Cart contains: ${item.course.id} - ${item.course.title}');
        }
      }, orElse: () {
        debugPrint(
            'INIT: Cart data not available, state is ${cartCubit.state.runtimeType}');
      });
    });

    // Debug print the current cart state
    debugPrint('Initial cart state: ${cartCubit.state.runtimeType}');
  }

  void _addToCart(BuildContext context, String courseId) {
    // Debug log before adding
    debugPrint(
        'Before adding - is course in cart: ${cartCubit.isCourseInCart(courseId)}');

    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('جاري إضافة الدورة إلى السلة...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Add to cart via cubit
    cartCubit.addToCart(courseId).then((success) {
      // Check current state after operation completes
      String? errorMessage;
      bool isErrorState = false;

      cartCubit.state.maybeWhen(
          error: (message) {
            errorMessage = message;
            isErrorState = true;
          },
          orElse: () {});

      if (isErrorState && errorMessage != null) {
        // Check if it's an "already in cart" type of message
        // We've already checked that errorMessage is not null
        final String nonNullMessage = errorMessage!; // Use non-null assertion
        final isAlreadyInCartMessage =
            nonNullMessage.contains('موجودة بالفعل') ||
                nonNullMessage.contains('already in') ||
                nonNullMessage.toLowerCase().contains('already in your cart');

        // Show the specific error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nonNullMessage),
            backgroundColor: isAlreadyInCartMessage || success
                ? Colors
                    .orange // Orange for "already in cart" or other warnings
                : Colors.red, // Red for actual errors
          ),
        );
      } else if (success) {
        // Normal success case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت إضافة الدورة إلى السلة بنجاح'),
            backgroundColor: Colors.green,
          ),
        );

        // Debug log after adding
        debugPrint(
            'After adding - Success: $success - is course in cart: ${cartCubit.isCourseInCart(courseId)}');

        // Get direct access to cart data
        cartCubit.state.maybeWhen(success: (cartData) {
          debugPrint('Direct cart access: ${cartData.items.length} items');
          final directCheck =
              cartData.items.any((item) => item.course.id == courseId);
          debugPrint('Direct check - Course $courseId in cart: $directCheck');

          // List all items in cart
          for (var item in cartData.items) {
            debugPrint(
                'Cart contains: ${item.course.id} - ${item.course.title}');
          }
        }, orElse: () {
          debugPrint(
              'Cannot directly access cart data, state is ${cartCubit.state.runtimeType}');
        });

        // Reload cart data to ensure we have the latest state
        cartCubit.getCart().then((_) {
          // Force UI update after cart is refreshed
          setState(() {
            debugPrint('UI updated after cart refresh');
          });
        });
      } else {
        // Generic failure case (shouldn't reach here if errors are properly handled)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل في إضافة الدورة إلى السلة'),
            backgroundColor: Colors.red,
          ),
        );

        // Debug log after failure
        debugPrint(
            'After failure - is course in cart: ${cartCubit.isCourseInCart(courseId)}');

        // Still refresh cart data to ensure UI consistency
        cartCubit.getCart();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentCartCubit, StudentCartState>(
      bloc: cartCubit,
      listener: (context, state) {
        // When cart state changes, force a rebuild of the screen
        state.maybeWhen(success: (cartData) {
          debugPrint(
              'BlocListener: Cart state updated with ${cartData.items.length} items');
          setState(() {});
        }, error: (message) {
          debugPrint('BlocListener: Cart state error: $message');
          setState(() {});
        }, orElse: () {
          debugPrint('BlocListener: Other cart state: ${state.runtimeType}');
        });
      },
      child: CustomScaffold(
        haveAppBar: true,
        backgroundColorAppColor: AppColors.background,
        backgroundColor: AppColors.background,
        drawerIconColor: AppColors.primary,
        drawer: const CustomDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
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
              Gap(16.h),
              BlocBuilder<TrainingCoursesCubit, TrainingCoursesState>(
                builder: (context, _) {
                  return Row(
                    children: [
                      // Search Field
                      Expanded(
                        flex: 4,
                        child: AppTextFormField(
                          controller: _searchController,
                          hintText: 'بحث عن الدورات التدريبية ...',
                          backgroundColor: AppColors.white,
                          validator: (value) {
                            return null; // Replace with your validation logic
                          },
                          onSubmit: (value) {
                            // Implement search functionality
                            context
                                .read<TrainingCoursesCubit>()
                                .searchCourses(value);
                            log('i want to search');
                          },
                        ),
                      ),
                      SizedBox(
                          width: 16.w), // Space between search and dropdown
                      // Dropdown
                      const Expanded(
                        flex: 2,
                        child: LevelFilterDropdown(),
                      ),
                    ],
                  );
                },
              ),
              Gap(24.h), // Space after row
              Expanded(
                child: BlocBuilder<TrainingCoursesCubit, TrainingCoursesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(
                        child: Text('ابدأ البحث عن الدورات'),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      success: (courses) {
                        if (courses.isEmpty) {
                          return const Center(
                            child: Text('لا توجد دورات متاحة'),
                          );
                        }
                        return ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return GestureDetector(
                              onTap: () {
                                context.goNamed(
                                  AppRoute.courseDetails,
                                  pathParameters: {'courseid': course.id},
                                  extra:
                                      course, // Pass the entire course object
                                );
                              },
                              child: CourseCard(
                                title: course.title,
                                hours:
                                    'عدد الساعات : ${course.durationEstimate}',
                                lectures:
                                    'عدد المحاضرات: ${course.lessons.length}',
                                image: course.coverImageUrl,
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BlocBuilder<StudentCartCubit,
                                            StudentCartState>(
                                          bloc: cartCubit,
                                          builder: (context, cartState) {
                                            // Check if the course is in cart
                                            final isInCart = cartCubit
                                                .isCourseInCart(course.id);

                                            // Debug: Log course status
                                            debugPrint(
                                                'Buy button - Course ${course.id}: isInCart = $isInCart');

                                            // TEMPORARY FIX: Force enable button
                                            return CustomButton(
                                              height: 27.h,
                                              radius: 58.r,
                                              labelText: isInCart
                                                  ? 'تم الإضافة ${course.price} ر.س'
                                                  : 'شــراء ${course.price} ر.س',
                                              buttonColor: isInCart
                                                  ? Colors.grey
                                                  : AppColors.primary,
                                              textColor: AppColors.white,
                                              onTap: () {
                                                // Force enable
                                                _addToCart(context, course.id);
                                              },
                                              textFontSize: 7.sp,
                                              fontWeight:
                                                  FontWeightHelper.light,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: BlocBuilder<StudentCartCubit,
                                            StudentCartState>(
                                          bloc: cartCubit,
                                          builder: (context, cartState) {
                                            // Check if the course is in cart
                                            final isInCart = cartCubit
                                                .isCourseInCart(course.id);

                                            // Debug: Log course status
                                            debugPrint(
                                                'Add to cart button - Course ${course.id}: isInCart = $isInCart');

                                            // TEMPORARY FIX: Force enable button
                                            return CustomButton(
                                              height: 27.h,
                                              labelText: isInCart
                                                  ? 'موجود في السلة'
                                                  : 'إضافة للسلة',
                                              radius: 58.r,
                                              buttonColor: isInCart
                                                  ? Colors.grey.shade300
                                                  : AppColors.background,
                                              textColor: isInCart
                                                  ? Colors.grey.shade700
                                                  : AppColors.yellow,
                                              onTap: () {
                                                // Force enable
                                                _addToCart(context, course.id);
                                              },
                                              textFontSize: 7.sp,
                                              borderColor: isInCart
                                                  ? Colors.grey.shade400
                                                  : AppColors.yellow,
                                              fontWeight:
                                                  FontWeightHelper.light,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                onSecondaryAction: () {},
                                secondaryActionText: 'مشاهدة أول محاضرة مجاناً',
                              ),
                            );
                          },
                        );
                      },
                      error: (message) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'حدث خطأ: $message',
                              textAlign: TextAlign.center,
                            ),
                            Gap(16.h),
                            CustomButton(
                              labelText: 'إعادة المحاولة',
                              onTap: () {
                                context
                                    .read<TrainingCoursesCubit>()
                                    .getCourses();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
