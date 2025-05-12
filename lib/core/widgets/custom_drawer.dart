import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:masarat/config/app_route.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/customs_divider.dart';
import 'package:masarat/core/widgets/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ColoredBox(
        color: AppColors.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: SvgPicture.asset(
                    AppImage.menuIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.drawerIconColor,
                      BlendMode.srcIn,
                    ),
                    height: 30.h,
                    width: 30.w,
                  ),
                  onPressed: () => Scaffold.of(context).closeDrawer(),
                ),
              ),
            ),
            // Profile Page
            DrawerItem(
              title: 'الصـفحة الشخصــية',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.profile, extra: true);
              },
            ),
            _divider(),

            // Home Page
            DrawerItem(
              title: 'الرئـيســــــــــــية',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.home);
              },
            ),
            _divider(),

            // My Library Page
            DrawerItem(
              title: 'مكتبـتــــــــــــي',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.myLibrary);
              },
            ),
            _divider(),

            // Training Courses Page
            DrawerItem(
              title: 'الــدورات التدريبيــة',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.trainingCourses);
              },
            ),
            _divider(),

            // Shopping Cart Page
            DrawerItem(
              title: 'سلة المشتريـــــات',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.shoppingCart);
              },
            ),
            _divider(),
            // Career Guidance Page
            DrawerItem(
              title: 'الإرشــاد المهـــني',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.careerGuidance);
              },
            ),
            _divider(),
            // About Us Page
            DrawerItem(
              title: 'مــــن نـحــــــــن',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.aboutUs);
              },
            ),
            _divider(),
            // Contact Us (Placeholder for Future Implementation)
            DrawerItem(
              title: 'تواصـــــل معنــــا',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                // Navigate to Contact Us page (Add route later if required)
              },
            ),
            _divider(),
            // Policies Page
            DrawerItem(
              title: 'سيـاسـات التـطبيق',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.goNamed(AppRoute.policies);
              },
            ),
            _divider(),
            Gap(125.h),
            // Logout
            DrawerItem(
              title: 'تسجيل الخروج',
              onTap: () {
                Scaffold.of(context).closeDrawer();
                // Implement logout logic
              },
            ),
            _divider(),
          ],
        ),
      ),
    );
  }

  // Helper Method for Divider
  Widget _divider() => CustomsDivider(
        color: AppColors.withe,
        height: 1.h,
      );
}
