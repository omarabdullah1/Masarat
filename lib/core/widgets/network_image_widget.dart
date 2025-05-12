import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key,
    this.imageUrl,
    this.imageHash,
    this.boxFit,
    this.padding,
    this.height,
    this.width,
  });
  final String? imageUrl;
  final String? imageHash;
  final BoxFit? boxFit;
  final double? padding;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      // Display error animation if no image URL is provided
      return const Center(
        child: Icon(Icons.error_outline),
      );
    }

    // If image hash is provided, use BlurHash
    if (imageHash != null) {
      return BlurHash(
        image: imageUrl,
        hash: imageHash!,
        imageFit: boxFit ?? BoxFit.cover,
      );
    }

    // Check if the image is SVG
    if (imageUrl!.contains('.svg')) {
      return SvgPicture.network(
        imageUrl!,
        fit: boxFit ?? BoxFit.fill,
      );
    }

    // Otherwise, use CachedNetworkImage
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl!,
      fit: boxFit ?? BoxFit.fill,
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(padding ?? 25.w),
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: EdgeInsets.all(padding ?? 0.w),
        child: const Center(
          child: Icon(Icons.error_outline),
        ),
      ),
    );
  }
}
