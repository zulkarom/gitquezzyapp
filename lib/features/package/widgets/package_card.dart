import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_card.dart';

class PackageCard extends StatelessWidget {
  // final Location curLocation;
  final String packageName;
  final String textName;
  final Widget image;
  // final String? imageUrl;
  final String? packageDescription;
  final void Function()? onTap;

  const PackageCard({
    super.key,
    // required this.curLocation,
    required this.packageName,
    // required this.imageUrl,
    required this.image,
    required this.textName,
    this.packageDescription,
    required this.onTap(),
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: kLightField,
      width: double.infinity,
      padding: AppDimension().kCardPadding,
      child: Row(
        children: [
          Center(
            child: image,
          ),
          // Center(
          //   child: imageUrl != null
          //       ? Image(
          //           image: NetworkImage(imageUrl!),
          //         )
          //       : const Image(
          //           image: AssetImage(AppConstants.DEFAULT_PACKAGE_IMAGE),
          //         ),
          // ),
          SizedBox(width: AppDimension().kSixteenScreenWidth),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: AppDimension().kSixteenScreenWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    packageName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  Text(
                    packageDescription!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: AppDimension().kSixteenScreenWidth),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 100.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5.w),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(AppDimension().defaultPadding / 2),
                child: Center(
                    child: Text(
                  textName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                )),
              ),
            ),
          )
          // Expanded(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       onTap;
          //     }, // Replace 'Button Label' with the actual label for the button
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor:
          //           Theme.of(context).primaryColor, // Set the button color
          //     ),
          //     child: const Text('Add Now'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
