import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ta_plus/core/constant/colors.dart';

import '../../../core/constant/app_dimensions.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    this.hint,
    required this.controller,
    this.inputType = TextInputType.text,
    this.submitHandler,
    this.tapHandler,
    this.changeHandler,
    this.focusNode,
    this.icon,
    this.textInputAction = TextInputAction.done,
    this.isPassword = false,
    this.contentPadding,
    this.isMultiLine = false,
    this.inputFormatters = const [],
    this.fieldIcon,
  });

  final String? hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final void Function(String)? submitHandler;
  final void Function()? tapHandler;
  final void Function(String)? changeHandler;
  final FocusNode? focusNode;
  final String? icon;
  final TextInputAction textInputAction;
  final bool isPassword;
  final EdgeInsetsGeometry? contentPadding;
  final bool isMultiLine;
  final List<TextInputFormatter> inputFormatters;
  final IconData? fieldIcon;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool showPassword;

  @override
  void initState() {
    showPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            blurRadius: AppDimension().kEightScreenPixel,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(
          AppDimension().kFortyEightScreenWidth,
        ),
      ),
      child: Stack(
        children: [
          TextField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            focusNode: widget.focusNode,
            controller: widget.controller,
            textInputAction: widget.isMultiLine ? null : widget.textInputAction,
            obscureText: showPassword,
            textAlign: TextAlign.left,
            // textAlign: widget.isMultiLine ? TextAlign.left : TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Theme.of(context).primaryColor,
            style: Theme.of(context).textTheme.bodyMedium,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    AppDimension().kFortyEightScreenWidth),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(AppDimension().defaultPadding),
                child: Icon(
                  widget.fieldIcon,
                ),
              ),
              filled: true,
              fillColor: kLightField,
              errorBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    AppDimension().kFortyEightScreenWidth),
                borderSide: BorderSide.none,
              ),
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.6),
                  ),
              contentPadding: widget.contentPadding ??
                  (widget.icon != null
                      ? EdgeInsets.only(
                          left: AppDimension().kSixteenScreenWidth,
                          right: AppDimension().kThirtyTwoScreenHeight,
                          top: AppDimension().kSixteenScreenHeight,
                          bottom: AppDimension().kSixteenScreenHeight,
                        )
                      : EdgeInsets.only(
                          left: AppDimension().kSixteenScreenWidth,
                          right: AppDimension().kThirtyTwoScreenHeight,
                          top: AppDimension().kSixteenScreenHeight,
                          bottom: AppDimension().kSixteenScreenHeight,
                        )),
            ),
            onSubmitted: widget.submitHandler,
            onTap: widget.tapHandler,
            onChanged: widget.changeHandler,
            keyboardType:
                widget.isMultiLine ? TextInputType.multiline : widget.inputType,
            maxLines: widget.isMultiLine ? null : 1,
          ),
          if (widget.icon != null)
            Positioned(
              top: 0,
              bottom: 0,
              right: AppDimension().kEightScreenWidth,
              child: GestureDetector(
                onTap: () {
                  if (widget.isPassword) {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  }
                },
                child: SvgPicture.asset(
                  widget.icon!,
                  color: Theme.of(context).colorScheme.surface,
                  width: AppDimension().kTwentyScreenPixel,
                  height: AppDimension().kTwentyScreenPixel,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
