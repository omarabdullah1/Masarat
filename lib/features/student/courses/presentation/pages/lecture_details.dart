import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/custom_scaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class LectureDetailsScreen extends StatefulWidget {
  const LectureDetailsScreen({required this.lectureId, super.key});
  final String lectureId;

  @override
  State<LectureDetailsScreen> createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends State<LectureDetailsScreen> {
  // Video player controllers
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;
  String videoTitle = "Introduction to Accounting";

  // Sample M3U playlist URL - replace with your actual M3U links in production
  String _m3uUrl =
      'https://raw.githubusercontent.com/benmoose39/YouTube_to_m3u/main/assets/moose_na.m3u';

  // Method to fetch real M3U URL based on lecture ID
  // In production, you would fetch this from your API
  String _getM3uUrl(String lectureId) {
    // This is a placeholder. In a real implementation, you would
    // fetch the URL from your API based on the lecture ID
    Map<String, String> lectureVideoMap = {
      // Using publicly available sample M3U playlists
      'lec1':
          'https://raw.githubusercontent.com/benmoose39/YouTube_to_m3u/main/assets/moose_na.m3u',
      'lec2':
          'https://raw.githubusercontent.com/iptv-org/iptv/master/streams/sa.m3u',
      'lec3':
          'https://raw.githubusercontent.com/iptv-org/iptv/master/streams/eg.m3u',
    };
    return lectureVideoMap[lectureId] ?? _m3uUrl;
  }

  @override
  void initState() {
    super.initState();
    // Get M3U URL based on the lecture ID
    _m3uUrl = _getM3uUrl(widget.lectureId);
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(_m3uUrl),
      );

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: false,
        allowPlaybackSpeedChanging: true,
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 30.sp,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: 'فشل تحميل الفيديو',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      debugPrint('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  // Function to change the video source
  Future<void> changeVideoSource(String url) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Dispose previous controllers
    _chewieController?.dispose();
    await _videoPlayerController.dispose();

    try {
      // Initialize new controllers
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: false,
        allowPlaybackSpeedChanging: true,
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return _buildVideoErrorWidget();
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      debugPrint('Error changing video source: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
      title: 'المحاضرة الأولى: أساسيات المحاسبة',
      body: Column(
        children: [
          // M3U Video Player
          Container(
            height: 220.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8.r),
            ),
            clipBehavior: Clip.hardEdge,
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                            color: AppColors.primary),
                        SizedBox(height: 16.h),
                        CustomText(
                          text: 'جاري تحميل الفيديو...',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  )
                : _hasError
                    ? _buildVideoErrorWidget()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : _buildVideoErrorWidget(),
                      ),
          ),

          // Lecture Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'محتوى المحاضرة',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text100,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text:
                        'تتناول هذه المحاضرة المفاهيم الأساسية للمحاسبة وتشمل:',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.text100,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildListItem('مبادئ المحاسبة الأساسية'),
                  _buildListItem('أنواع الحسابات والدفاتر المحاسبية'),
                  _buildListItem('معادلة الميزانية العمومية'),
                  _buildListItem('مفهوم القيد المزدوج'),
                  SizedBox(height: 24.h),
                  CustomText(
                    text: 'المرفقات والموارد',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text100,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAttachmentItem(
                      'ملخص المحاضرة (PDF)', Icons.picture_as_pdf),
                  _buildAttachmentItem('أوراق العمل (XLSX)', Icons.table_chart),
                  _buildAttachmentItem('تمارين تطبيقية', Icons.assignment),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8.sp, color: AppColors.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              text: text,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.text100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24.sp, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(
            child: CustomText(
              text: title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.text100,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.download, size: 20.sp, color: AppColors.gray),
        ],
      ),
    );
  }

  Widget _buildVideoErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 40.sp,
            color: Colors.white70,
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: 'فشل تحميل الفيديو',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: _initializePlayer,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
            child: const CustomText(
              text: 'إعادة المحاولة',
            ),
          ),
        ],
      ),
    );
  }
}
