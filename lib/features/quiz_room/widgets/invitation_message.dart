import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constant/app_dimensions.dart';
import '../../../core/constant/colors.dart';

class InvitationMessage extends StatelessWidget {
  const InvitationMessage(
      {Key? key,
      required this.message,
      this.subMessage,
      this.acceptHandler,
      this.closeHandler,
      this.acceptText,
      this.closeText})
      : super(key: key);

  final String? message;
  final String? subMessage;
  final void Function()? acceptHandler;
  final void Function()? closeHandler;
  final String? acceptText;
  final String? closeText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: AppDimension().defaultPadding + 4,
                  right: AppDimension().defaultPadding - 10,
                ),
                child: Column(
                  children: [
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              subMessage != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, bottom: 10),
                          child: Text(
                            subMessage!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: GestureDetector(
                  onTap: acceptHandler,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: kLightAccent,
                        // borderRadius: BorderRadius.circular(5.w),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(1, 1))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimension().defaultVerticalPadding,
                      ),
                      child: Center(
                        child: Text(
                          acceptText!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10, // Adjust the top position for the close icon
          right: 10, // Adjust the right position for the close icon
          child: InkWell(
            onTap: closeHandler,
            child: const Icon(
              Icons.close,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
