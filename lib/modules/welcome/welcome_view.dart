import 'package:RatingRadar_app/common/asset_image.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  Widget _buildBodyPart1(BuildContext context) {
    return SizedBox(
      width: Dimens.screenWidth,
      height: (Dimens.screenHeight * 0.6) - Dimens.twelve,
      child: NxAssetImage(
        imgAsset: AssetValues.group,
        width: Dimens.screenWidth,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: ColorValues.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBodyPart1(context),
            ],
          ),
        ),
      ),
    );
  }
}
