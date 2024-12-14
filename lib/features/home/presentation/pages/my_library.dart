import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/CustomDrawer.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/app_text_form_field.dart';
import 'package:masarat/core/widgets/custom_dropdown_Button_Form_Field.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:masarat/core/widgets/course_card_widget.dart';
class MyLibrary extends StatefulWidget {
  const MyLibrary({super.key});

  @override
  State<MyLibrary> createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  String? selectedOption; // Moved outside build to retain state

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      title: '',
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(  vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: CustomText(
                text: "مكتبـتــــــــــــي",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeightHelper.regular,
                ),
              ),
            ),
            Row(
                     children: [
                       // Search Field
                       Expanded(
                     flex: 4,
                         child: AppTextFormField(
                           hintText: 'بحث عن الدورات التدريبية ...',
                           validator: (value) {
                             return null; // Replace with your validation logic
                           },
                         ),
                       ),
                       SizedBox(width: 16.w), // Space between search and dropdown
                       // Dropdown
                       Expanded(
                         flex:2,
                         child: CustomDropdownButton(
  items: ["Item 1", "Item 2", "Item 3"],
  hintText: 'Select an Option',
  onChanged: (value) {
    print('Selected Value: $value');
  },
)

                       ),
                     ],
                   ),
            Gap(24.h), // Space after row
            Gap(16.h),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CourseCard(
                    title: 'مهارات أخصائي محاسبة',
                    hours: 'عدد الساعات : 7 ساعات',
                    lectures: 'عدد المحاضرات: 42',
                    progress: 0.6,
                    actions: [
                  Expanded(
                  child:     LinearProgressIndicator(
                  value: 0.6,
                    backgroundColor: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0.r),
                    minHeight: 10,
                    color: Colors.teal,
                  ),)],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
