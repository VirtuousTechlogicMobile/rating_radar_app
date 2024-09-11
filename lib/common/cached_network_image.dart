import 'dart:developer';

import 'package:RatingRadar_app/common/custom_colored_box.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class NxNetworkImage extends StatelessWidget {
  const NxNetworkImage({
    super.key,
    required this.imageUrl,
    this.borderRadius,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.imageFit,
  });

  final String imageUrl;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final BoxFit? imageFit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Dimens.screenWidth,
      height: height,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? Dimens.screenWidth,
        maxHeight: maxHeight ?? Dimens.screenHeight,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: imageFit ?? BoxFit.cover,
          placeholder: (ctx, url) => NxColoredBox(
            width: width,
            height: height,
          ),
          errorWidget: (ctx, url, err) {
            log("image error : $err");
            return const Icon(
              CupertinoIcons.info,
              color: ColorValues.errorColor,
            );
          },
        ),
      ),
    );
  }
}
