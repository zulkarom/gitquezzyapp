import 'package:flutter/material.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';

class LevelBoard extends StatelessWidget {
  final int? info;
  const LevelBoard(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimension().kHundredFourScreenWidth,
      height: AppDimension().kEightyScreenWidth,
      // margin: EdgeInsets.all(AppDimension().kEightScreenWidth * 2),
      // padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      decoration: const BoxDecoration(
        color: kLightField,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   "assets/images/others/icons/lock.png",
          //   fit: BoxFit.cover,
          // ),
          Text(
            info.toString(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
