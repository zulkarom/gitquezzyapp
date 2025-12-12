import 'package:flutter/material.dart';
import 'package:quezzy_app/core/constant/constants.dart';

class CustomCardV1 extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? btnText;
  final void Function()? onTap;

  const CustomCardV1({
    super.key,
    this.imageUrl,
    this.title,
    this.description,
    this.btnText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Define the shape of the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      // Define how the card's content should be clipped
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // Define the child widget of the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add padding around the row widget
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add an image widget to display an image
                Image.asset(
                  imageUrl ?? AppConstants.DEFAULT_PACKAGE_IMAGE,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                // Add some spacing between the image and the text
                Container(width: 20),
                // Add an expanded widget to take up the remaining horizontal space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Add some spacing between the top of the card and the title
                      Container(height: 5),
                      // Add a title widget
                      Text(
                        title!,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                      // Add some spacing between the title and the subtitle
                      Container(height: 5),
                      // Add a subtitle widget
                      // Text(
                      //   "Sub title",
                      //   style: Theme.of(context)
                      //             .textTheme
                      //             .headlineSmall!
                      //             .copyWith(
                      //               fontWeight: FontWeight.bold,
                      //               color: Theme.of(context).primaryColor.withOpacity(5),
                      //             ),
                      // ),
                      // Add some spacing between the subtitle and the text
                      Container(height: 10),
                      // Add a text widget to display some text
                      Text(
                        description ?? '',
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
