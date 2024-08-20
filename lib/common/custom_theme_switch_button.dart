import 'package:RatingRadar_app/constant/colors.dart';
import 'package:flutter/material.dart';
import '../constant/dimens.dart';
import '../theme/theme_controller.dart';

class CustomThemeSwitchButton extends StatefulWidget {
  const CustomThemeSwitchButton({super.key});

  @override
  _CustomThemeSwitchButtonState createState() => _CustomThemeSwitchButtonState();
}

class _CustomThemeSwitchButtonState extends State<CustomThemeSwitchButton> with SingleTickerProviderStateMixin {
  bool isSwitchOn = AppThemeController.find.themeMode == kDarkMode;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<Color?> backgroundColorAnimation;
  late Animation<Color?> switchColorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(animationController);

    backgroundColorAnimation = ColorTween(
      begin: ColorValues.primaryColorBlue,
      end: ColorValues.deepBlackColor,
    ).animate(animationController);

    switchColorAnimation = ColorTween(
      begin: ColorValues.whiteColor,
      end: ColorValues.primaryColorYellow,
    ).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });
  }

  void toggleSwitch() {
    if (isSwitchOn) {
      animationController.reverse();
      AppThemeController.find.setThemeMode(kLightMode);
    } else {
      animationController.forward();
      AppThemeController.find.setThemeMode(kDarkMode);
    }
    setState(() {
      isSwitchOn = !isSwitchOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    isSwitchOn = Theme.of(context).brightness == Brightness.dark;
    if (isSwitchOn) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    return GestureDetector(
      onTap: toggleSwitch,
      onHorizontalDragUpdate: (details) {
        double dragPosition = details.localPosition.dx / Dimens.sixty;
        if (dragPosition < 0) dragPosition = 0;
        if (dragPosition > 1) dragPosition = 1;
        animationController.value = dragPosition;
      },
      onHorizontalDragEnd: (details) {
        if (animationController.value > 0.5) {
          animationController.forward();
          isSwitchOn = true;
        } else {
          animationController.reverse();
          isSwitchOn = false;
        }
      },
      child: Container(
        width: Dimens.eighty,
        height: Dimens.forty,
        margin: EdgeInsets.only(
          right: Dimens.twenty,
          bottom: Dimens.fifteen,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: backgroundColorAnimation.value,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              left: animation.value * Dimens.forty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: CircleAvatar(
                  radius: Dimens.fifteen,
                  backgroundColor: switchColorAnimation.value,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: Dimens.eight,
                      backgroundColor: backgroundColorAnimation.value,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
