import 'package:flutter/material.dart';

import '../../../core/constant/app_dimensions.dart';

class DialogMessage extends StatelessWidget {
  const DialogMessage(
      {Key? key,
      required this.message,
      this.subMessage,
      this.leftHandler,
      this.rightHandler,
      this.leftText,
      this.rightText})
      : super(key: key);

  final String? message;
  final String? subMessage;
  final void Function()? leftHandler;
  final void Function()? rightHandler;
  final String? leftText;
  final String? rightText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppDimension().defaultPadding + 4,
              right: AppDimension().defaultPadding - 10,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimension().defaultPadding,
                  ),
                  child: Text(
                    message!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              ],
            ),
          ),
          subMessage != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, bottom: 10),
                      child: Text(
                        subMessage!,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimension().defaultVerticalPadding,
                    ),
                    child: GestureDetector(
                      onTap: leftHandler,
                      child: Text(
                        leftText!,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppDimension().kSixteenScreenWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimension().defaultVerticalPadding,
                    ),
                    child: GestureDetector(
                      onTap: rightHandler,
                      child: Text(
                        rightText!,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppDimension().kEightScreenWidth,
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
