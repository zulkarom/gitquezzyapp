import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/features/package/widgets/package_card.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';
import '../bloc/package_bloc.dart';
import '../controller/package_controller.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({super.key});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  // late Map studentId;
  late int? stdId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final studentId = ModalRoute.of(context)!.settings.arguments as Map;
    // stdId = studentId["studentId"];

    final studentId = ModalRoute.of(context)!.settings.arguments as Map;
    stdId = studentId.containsKey("studentId")
        ? studentId["studentId"]["id"]
        : null;

    PackageController(context: context).init();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: 'List Packages',
              leading: [
                Center(
                  child: CustomIconButton(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/package_selected",
                        (route) => false,
                        arguments: {"id": stdId},
                      );
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: AppDimension().kTwentyScreenPixel,
                      color:
                          Theme.of(context).appBarTheme.actionsIconTheme!.color,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<PackageBloc, PackageState>(
              builder: (context, state) {
                print("state.packageItem.length");
                print(state.packageItem.length);
                return Padding(
                  padding: EdgeInsets.all(AppDimension().kTwelveScreenWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text("Get your package now!",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                )),
                      ),
                      SizedBox(height: AppDimension().kSixteenScreenHeight),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 187,
                        child: ListView.builder(
                          itemCount: state.packageItem.length,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PackageCard(
                                      // imageUrl:
                                      //     state.packageItem[index].imageUrl,
                                      packageName:
                                          state.packageItem[index].name!,
                                      textName: "Add Now",
                                      image:
                                          state.packageItem[index].imageUrl !=
                                                  null
                                              ? Image.asset(
                                                  state.packageItem[index]
                                                      .imageUrl!,
                                                  width: AppDimension()
                                                      .kFortyEightScreenWidth,
                                                )
                                              : Image.asset(
                                                  "assets/images/categories/png/English.png",
                                                  width: AppDimension()
                                                      .kFortyEightScreenWidth,
                                                ),
                                      packageDescription:
                                          state.packageItem[index].description,
                                      onTap: () {
                                        PackageController(context: context)
                                            .asyncPostSubscribeData(
                                          stdId,
                                          state.packageItem[index].id,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * .02),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
