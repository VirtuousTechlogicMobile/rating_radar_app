import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonWidgets {
  static Widget fromSvg({EdgeInsetsGeometry? margin, required String svgAsset, double? height, double? width, Color? color}) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SvgPicture.asset(
        svgAsset,
        height: height,
        fit: BoxFit.none,
        width: width,
        color: color,
      ),
    );
  }

  static Widget autoSizeText({
    required String text,
    required TextStyle textStyle,
    TextAlign? textAlign,
    required double minFontSize,
    required double maxFontSize,
    int? maxLines,
  }) {
    return AutoSizeText(
      text,
      softWrap: true,
      style: textStyle,
      textAlign: textAlign,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget autoSizeRichText({
    required List<TextSpan> textSpans,
    // required TextStyle textStyle,
    TextAlign? textAlign,
    required double minFontSize,
    required double maxFontSize,
    int? maxLines,
  }) {
    return AutoSizeText.rich(
      TextSpan(children: textSpans),
      softWrap: true,
      // style: textStyle,
      textAlign: textAlign,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
