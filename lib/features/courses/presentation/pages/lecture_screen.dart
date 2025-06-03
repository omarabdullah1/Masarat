import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class LectureScreen extends StatelessWidget {
  const LectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and title
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://images.pexels.com/photos/29090307/pexels-photo-29090307/free-photo-of-cyclist-riding-past-parisian-building-facade.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const Text(
                      'مهارات أخصائي محاسبة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    const Text(
                      'عدد الساعات: 7 ساعات',
                      style: TextStyle(color: AppColors.gray),
                    ),
                    SizedBox(height: 4.h),
                    const Text(
                      'تم مشاهدة: 1/42',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Lecture buttons
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8, // Number of lectures
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.goNamed(
                        AppRoute.lectureDetails,
                        pathParameters: {
                          'courseid': '123', // Example course ID
                          'lectureid': '456', // Example lecture ID
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: index == 0
                                ? AppColors.primary
                                : Colors.grey[300]!,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                          color: index == 0 ? Colors.white : Colors.grey[300],
                        ),
                        width: double.infinity,
                        height: 32.h,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsets.all(4.0.r),
                            child: CustomText(
                              text: 'المحاضرة ${index + 1}: أساسيات المحاسبة',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
