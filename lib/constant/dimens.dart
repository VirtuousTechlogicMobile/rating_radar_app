import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Contains the dimensions and padding used
/// all over the application.
abstract class Dimens {
  static EdgeInsets edgeInsets16 = EdgeInsets.all(sixTeen);

  static EdgeInsets edgeInsets16_12 = EdgeInsets.symmetric(
    vertical: sixTeen,
    horizontal: twelve,
  );

  static double eight = 8.r;
  static double eighteen = 18.r;
  static double eighty = 80.r;
  static double eightyThree = 83.r;
  static double eightyFive = 85.r;
  static double eleven = 11.r;
  static double fifteen = 15.r;
  static double fifty = 50.r;
  static double fiftyFive = 55.r;
  static double fiftyFour = 54.r;
  static double fiftySix = 56.r;
  static double five = 5.r;
  static double four = 4.r;
  static double nine = 9.r;
  static double fourteen = 14.r;
  static double forty = 40.r;
  static double fortyFour = 44.r;
  static double fortyThree = 43.r;
  static double fortyFive = 45.r;
  static double fortySeven = 47.r;
  static double fortyEight = 48.r;
  static double hundred = 100.r;
  static double threeHundred = 300.r;
  static double oneHundredEightyTwo = 182.r;
  static double threeHundredSix = 306.r;
  static double threeHundredTwenty = 320.r;
  static double twoHundredFifty = 250.r;
  static double twoHundredEighty = 280.r;
  static double nineteen = 19.r;
  static double ninetyEight = 98.r;
  static double ninety = 90.r;
  static double ninetyFive = 95.r;
  static double one = 1.r;
  static double oneHundredFifty = 150.r;
  static double oneHundredFifteen = 115.r;
  static double oneHundredFortyFive = 145.r;
  static double oneHundredFiftyFive = 155.r;
  static double fourHundredEightySix = 480.r;
  static double oneHundredSixtyFive = 165.r;
  static double oneHundredSixtySeven = 167.r;
  static double oneHundredSixty = 160.r;
  static double oneHundredSeventy = 170.r;
  static double oneHundredEightyOne = 181.r;
  static double oneHundredTwenty = 120.r;
  static double threeHundredForty = 340.r;
  static double threeHundredSixtyThree = 365.r;
  static double twoHundredFortyFive = 245.r;
  static double threeHundredFiftyOne = 351.r;
  static double twoHundredTwenty = 220.r;
  static double twoHundredForty = 240.r;
  static double twoHundredNinety = 290.r;
  static double twoHundred = 200.r;
  static double twoHundredSeven = 207.r;
  static double oneHundredEightyFive = 185.r;
  static double oneHundredNinety = 190.r;
  static double oneHundredNine = 109.r;
  static double oneHundredNineteen = 119.r;
  static double pointEight = 0.8.r;
  static double pointFive = 0.5.r;
  static double pointFour = 0.4.r;
  static double pointNine = 0.9.r;
  static double pointOne = 0.1.r;
  static double pointSeven = 0.7.r;
  static double pointSix = 0.6.r;
  static double pointThree = 0.3.r;
  static double pointTwo = 0.2.r;
  static double screenHeight = Get.size.height;
  static double screenWidth = Get.size.width;
  static double seven = 7.r;
  static double seventy = 70.r;
  static double seventySix = 76.r;
  static double seventyEight = 78.r;
  static double six = 6.r;
  static double sixTeen = 16.r;
  static double sevenTeen = 17.r;
  static double sixty = 60.r;
  static double sixtyTwo = 62.r;
  static double sixtyFour = 64.r;
  static double sixtyFive = 65.r;
  static double sixtyNine = 69.r;
  static double ten = 10.r;
  static double thirteen = 13.r;
  static double thirty = 30.r;
  static double thirtyFive = 35.r;
  static double thirtyFour = 34.r;
  static double thirtyEight = 38.r;
  static double thirtyNine = 39.r;
  static double thirtySix = 36.r;
  static double thirtyOne = 31.r;
  static double thirtyTwo = 32.r;
  static double three = 3.r;
  static double twelve = 12.r;
  static double twenty = 20.r;
  static double twentySeven = 27.r;
  static double twentyEight = 28.r;
  static double twentyNine = 29.r;
  static double twentyFive = 25.r;
  static double twentyFour = 24.r;
  static double twentySix = 26.r;
  static double twentyThree = 23.r;
  static double twentyOne = 21.r;
  static double twentyTwo = 22.r;
  static double two = 2.r;
  static double zero = 0.r;
  static double screensHorizontalPadding = thirtyEight;

  /// Get the height with the percent value of the screen height.
  static double percentHeight(double percentValue) => percentValue.sh;

  /// Get the width with the percent value of the screen width.
  static double percentWidth(double percentValue) => percentValue.sw;
}
