import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/core/bloc/language/language_bloc.dart';
import 'package:flutter_ta_plus/core/constant/app_dimensions.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_app_bar.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/custom_icon_button.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/default_app_bar.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                CustomAppBar(
                  title: 'Info Applikasi',
                  // title: statelg.language.name == 'eng'
                  //     ? widget.subjectItem.name_eng ?? ''
                  //     : widget.subjectItem.name_bm ?? '',
                  leading: [
                    Center(
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: AppDimension().kTwentyScreenPixel,
                          color: Theme.of(context)
                              .appBarTheme
                              .actionsIconTheme!
                              .color,
                        ),
                      ),
                    )
                  ],
                ),
                buildBody(context),
              ],
            ),
            // bottomNavigationBar: const NavBarBottom(
            //   tabIndex: 1,
            // ),
          );
        },
      ),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      // padding: AppDimension().kPagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppDimension().kTwentyScreenHeight,
          ),
          // Text(
          //   'Info Aplikasi',
          //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //         fontWeight: FontWeight.bold,
          //       ),
          // ),
          SizedBox(
            height: AppDimension().kTwentyScreenHeight,
          ),
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).canvasColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              'VERSION 1.0.0',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).canvasColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Text('TARIKH KEMASKINI: 01/10/2024',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).canvasColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
                '${'HAKCIPTA TERPELIHARA © 2023 - ${DateTime.now().year}'} SKYHINT DESIGN',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
          ),
          const SizedBox(height: 16),
          Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).canvasColor, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Text('SKYHINT DESIGN ENTERPRISE',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      )))
        ],
      ),
    );
  }
}
