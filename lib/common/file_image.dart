import 'dart:io';

import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class NxFileImage extends StatelessWidget {
  const NxFileImage({
    super.key,
    required this.file,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.scale,
    this.fit,
  });

  final XFile? file;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;
  final double? scale;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    Future<Uint8List?> getImageBytes() async {
      return await file?.readAsBytes();
    }

    return Container(
      width: width ?? double.infinity,
      height: height,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? Dimens.screenWidth,
        maxHeight: maxHeight ?? Dimens.screenHeight,
      ),
      child: kIsWeb
          ? FutureBuilder<Uint8List?>(
              future: getImageBytes(),
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.done && imageSnapshot.hasData) {
                  return Image.memory(
                    imageSnapshot.data!,
                    fit: fit ?? BoxFit.cover,
                    errorBuilder: (ctx, url, err) => const Icon(
                      CupertinoIcons.info,
                      color: ColorValues.errorColor,
                    ),
                    width: width,
                    height: height,
                    scale: scale ?? 1.0,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
          : Image.file(
              File(file?.path ?? ''),
              fit: fit ?? BoxFit.cover,
              errorBuilder: (ctx, url, err) => const Icon(
                CupertinoIcons.info,
                color: ColorValues.errorColor,
              ),
              width: width,
              height: height,
              scale: scale ?? 1.0,
            ),
    );
  }
}
