import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masarat/core/utils/app_colors.dart';
import 'package:masarat/core/widgets/CustomScaffold.dart';
import 'package:masarat/core/widgets/custom_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class LectureDetailsScreen extends StatefulWidget {
 final String lectureId;
  const LectureDetailsScreen({Key? key,   required this.lectureId }) : super(key: key);

  @override
  State<LectureDetailsScreen> createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends State<LectureDetailsScreen> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'M7lc1UVf-VE', // Replace with your YouTube video ID
    )..addListener(listener);
    _playerState = PlayerState.unknown;
    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      haveAppBar: true,
      backgroundColorAppColor: AppColors.background,
      backgroundColor: AppColors.background,
      drawerIconColor: AppColors.primary,
    title:"المحاضرة الأولى: أساسيات المحاسبة" ,
      
      body: Column(
        children: [
          // YouTube Player
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.teal,
              progressColors: const ProgressBarColors(
                playedColor: Colors.teal,
                handleColor: Colors.tealAccent,
              ),
              onReady: () {
                setState(() {
                  _isPlayerReady = true;
                });
              },
              onEnded: (data) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Video has ended!'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Download Button
          ElevatedButton.icon(
            onPressed: () {
              // Add your download logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading resources...'),
                ),
              );
            },

            icon: const Icon(Icons.download),
            label:   Text("تحميل المصادر",style: TextStyle(fontSize: 12.sp),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.withe,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(  8.r),
                side: BorderSide(color:  AppColors.primary, width: 1.h),
              ),
              minimumSize:   Size(145.w, 40.h),
            ),
          ),
          const SizedBox(height: 10),
          // List of Lectures
          Expanded(
            child: ListView.builder(
              itemCount: 8, // Number of lectures
              itemBuilder: (context, index) {
                return  Padding(
                  padding:   EdgeInsets.symmetric(vertical: 4.0.h ,horizontal: 20.w),
                  child:  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: index == 0?AppColors.primary: Colors.grey[300]! ),
                      borderRadius: BorderRadius.circular(4.r),

                    ),
                    width: double.infinity,

                    height:32.h,
                    child:  Align(alignment: AlignmentDirectional.centerStart, child: Padding(
                      padding:   EdgeInsets.all(4.0.r),
                      child: CustomText(text: 'المحاضرة ${index + 1}: أساسيات المحاسبة', ),
                    )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}