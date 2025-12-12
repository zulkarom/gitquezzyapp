import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quezzy_app/core/constant/colors.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_card.dart';

class TopicCard extends StatelessWidget {
  // final Location curLocation;
  final String topicName;
  final String? topicDesc;
  final Widget image;
  final double star;
  final double progress;

  const TopicCard({
    super.key,
    // required this.curLocation,
    required this.topicName,
    this.topicDesc,
    required this.image,
    required this.star,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomCard(
      color: kLightField,
      width: double.infinity,
      padding: AppDimension().kCardPadding,
      child: Row(
        children: [
          Center(
            child: image,
          ),
          SizedBox(width: AppDimension().kEightScreenWidth),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: AppDimension().kEightScreenWidth,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * .474,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            topicName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                        SizedBox(height: AppDimension().kFourScreenHeight),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: topicDesc != ""
                              ? Text(
                                  topicDesc!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(height: AppDimension().kFourScreenHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            3, // Assuming itemCount is 3
                            (starIndex) {
                              double starRating = star;
                              if (starIndex < starRating.floor()) {
                                // Fully filled star
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                );
                              } else if (starIndex == starRating.floor() &&
                                  starRating % 1 != 0) {
                                // Half-filled star
                                return const Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                  size: 30,
                                );
                              } else {
                                // Empty star
                                return const Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                  size: 30,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * .2, // Adjust width and height as needed
                    height: size.height * .092,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2, // Adjust border width as needed
                      ),
                    ),
                    padding:
                        const EdgeInsets.all(8), // Adjust padding as needed
                    child: Center(
                      child: Text(
                        "${progress.round()}%",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
