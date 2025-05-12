// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:masarat/core/theme/font_weight_helper.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/custom_drawer.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class CareerGuidanceScreen extends StatelessWidget {
  const CareerGuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stars = <String>[
      AppImage.starBeginner,
      AppImage.twoStar,
      AppImage.threeStar,
    ];
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Center(
            child: CustomText(
              text: 'الإرشاد المهني',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 22.sp,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
          ),
          Gap(16.h),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  context.go('/careerGuidance/pricing');
                },
                child: CareerPackageCard(
                  title: 'باقات مبتدئ الخبرة',
                  description: 'هذه الباقات مخصصة للخبرة التي تتراوح بين سنة '
                      'وخمسة سنوات خبرة',
                  stars: stars[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CareerPackageCard extends StatelessWidget {
  const CareerPackageCard({
    required this.title,
    required this.description,
    required this.stars,
    super.key,
  });
  final String title;
  final String description;
  final String stars;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withAlpha((0.2 * 255).toInt())),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SvgPicture.asset(stars),
        ],
      ),
    );
  }
}
