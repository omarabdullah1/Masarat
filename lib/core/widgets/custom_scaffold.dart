import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/utils/assets_mangment.dart';
import 'package:masarat/core/widgets/custom_text.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    super.key,
    this.title,
    this.backgroundColor,
    this.drawer,
    this.actions = const [],
    this.showBackButton = true,
    this.onTap,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.haveAppBar,
    this.backgroundColorAppColor,
    this.drawerIconColor,
    this.centerTitle = true,
    this.titleColor,
  });
  final Widget body;
  final String? title;
  final bool? haveAppBar;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? drawerIconColor;
  final Color? backgroundColorAppColor;
  final List<Widget>? actions;
  final Widget? drawer;
  final bool showBackButton;
  final bool centerTitle;
  final void Function()? onTap;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: haveAppBar != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(40.h),
              child: AppBar(
                elevation: 0,
                centerTitle: centerTitle,
                automaticallyImplyLeading: false,
                leading: _buildLeading(context, canGoBack),
                title: _buildTitle(context),
                actions: actions,
                backgroundColor: backgroundColorAppColor ?? Colors.white,
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: body,
        ),
      ),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  /// Builds the leading widget (drawer icon or back button).
  Widget? _buildLeading(BuildContext context, bool canGoBack) {
    if (drawer != null) {
      return Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            AppImage.menuIcon,
            height: 30.h,
            width: 30.w,
            colorFilter: drawerIconColor != null
                ? ColorFilter.mode(drawerIconColor!, BlendMode.srcIn)
                : null,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      );
    } else if (showBackButton || canGoBack) {
      return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).iconTheme.color,
          size: 20.sp,
        ),
      );
    }
    return null;
  }

  /// Builds the title widget with an optional tap effect.
  Widget? _buildTitle(BuildContext context) {
    if (title == null) return null;

    return GestureDetector(
      onTap: onTap,
      child: onTap != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: title!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down),
              ],
            )
          : Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
    );
  }
}
